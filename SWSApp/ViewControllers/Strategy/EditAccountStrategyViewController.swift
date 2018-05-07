//
//  AccountStrategyViewController.swift
//  SWSApp
//
//  Created by r.a.jantakal on 23/04/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation
import UIKit
import IQKeyboardManagerSwift
import SmartSync

class EditAccountStrategyViewController: UIViewController {
    
    var tableViewRowDetails : NSMutableArray?
    let strategyQuestionsViewModel = StrategyQuestionsViewModel()
    let strategyAnswersViewModel = StrategyAnswersViewModel()
    var strategyQAViewModel = StrategyQAViewModel()
    
    
    @IBOutlet weak var collectionView : UICollectionView?

    
    
    var textViewWidth = 0.0
    var collectionViewWidth = 0.0
    
    
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        createStrategy()
        IQKeyboardManager.shared.enable = true
        
        if self.view.frame.size.width == 1112.0{
            textViewWidth = 1105
            collectionViewWidth = 525
        }else if self.view.frame.size.width == 1024.0{
            textViewWidth = 1015
            collectionViewWidth = 480
        }else if self.view.frame.size.width == 1366.0{
            textViewWidth = 1360
            collectionViewWidth = 650
        }
        
//        let plistPath = Bundle.main.path(forResource: "EditAccountStrategy", ofType: ".plist", inDirectory: nil)
//        let dictionary = NSMutableDictionary(contentsOfFile: plistPath!)
//        tableViewRowDetails = dictionary!["New item"] as? NSMutableArray
//        print(dictionary!)
        
        let question = strategyQuestionsViewModel.getStrategyQuestions()
        let answer = strategyAnswersViewModel.getStrategyAnswers()
        
        
        
        let tableViewData = NSMutableArray()
        
        //Get the questions based on survey ID
        
        var headerCheck = false
        
        //Write a func to get header Count
        for header in self.getHeader(){

            for questionData in question{
                
                let dict = NSMutableDictionary()
                
                //execute only for account situation (headers only)
                if questionData.SGWS_Question_Type__c != header {
                    continue
                }
                
                //Used to keep Header only once
                for q in tableViewData{
                    
                    let dictionary = q as! NSDictionary
                    print(dictionary)
                    
                    let header = dictionary["header"] as? String
                    
                    if questionData.SGWS_Question_Type__c == header{
                        
                        headerCheck = true

                    }
                }
                
                if !headerCheck{
                    dict.setValue(questionData.SGWS_Question_Type__c, forKey: "header") //Main Header
                }else{
                    dict.setValue("", forKey: "header")
                }
                
                headerCheck = false
                
                dict.setValue(questionData.SGWS_Question_Description__c, forKey: "subHeader") //Added Subheader
                dict.setValue(questionData.Id, forKey: "id")
                
                let answerArray = NSMutableArray()
                for answerData in answer{
                    
                    if answerData.SGWS_Question__c == questionData.Id{
                        
                        let answerTemp = answerData.SGWS_Answer_Description__c
                        
                        let answerTempArray = answerTemp.components(separatedBy: ",")
                        print(answerTempArray.count)
                        
                        if answerTempArray.count > 0{
                            
                            for ans in answerTempArray{
                                
                                let answerDict = NSMutableDictionary()
                                answerDict.setValue(ans, forKey: "answerText")
                                answerDict.setValue(answerData.Id, forKey: "answerId")
                                
                                answerDict.setValue("NO", forKey: "isSelected")
                                //answerDict.setValue(answerData.OwnerId, forKey: "ownerId")
                                
                                answerArray.add(answerDict)
                            }
                        }
                        dict.setValue(answerArray, forKey: "answers") //Added Answers for Subheader
                    }
                }
                tableViewData.add(dict)
            }
        }
        
        print(tableViewData)
        tableViewRowDetails = tableViewData
        

        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showAlert(){
        
        AlertUtilities.showAlertMessageWithTwoActionsAndHandler("Any changes will not be saved", errorMessage: "Are you sure you want to close?", errorAlertActionTitle: "Yes", errorAlertActionTitle2: "No", viewControllerUsed: self, action1: {
            
            self.dismiss(animated: true, completion: nil)
            
        }) {
            print("No")
        }
    }
    

    func validateAllFields()-> Bool{
        
        for index in tableViewRowDetails!{
            
            let tableData = index as! NSDictionary
            let tableContent = tableData["answers"] as! NSMutableArray
            
            let namePredicate = NSPredicate(format: "isSelected = %@","NO");
            
            let filteredArray = tableContent.filter { namePredicate.evaluate(with: $0) };
            
            
            for isSelectedDict in filteredArray{
                
                let selectedKey = isSelectedDict as! NSMutableDictionary
                
                let data = selectedKey["isSelected"] as! String
                
                if data == "NO"{
                    return false
                }
            }
       }
        return true
    }
    
    
    
    func getHeader()-> [String]{
        var headerArray = [String]()
    
        //Get unique headernames once
        let question = strategyQuestionsViewModel.getStrategyQuestions()
        
        for questionHeaders in question{
            
           let que = questionHeaders.SGWS_Question_Type__c
            
            if !(headerArray.contains(que)){
                headerArray.append(que)
            }
        }
        
        print(headerArray)
        
        return headerArray
    }
    
    
    
    
    
    //MARK:- Button Actions
    @IBAction func saveButtonAction(sender : UIButton){
        print("Save button Clicked")
        
        let validateFields = self.validateAllFields()
        
        if validateFields{
            
            print("Success")
            
        }else{
            
            
            AlertUtilities.showAlertMessageWithTwoActionsAndHandler("", errorMessage: "Please Enter required fields", errorAlertActionTitle: "Ok", errorAlertActionTitle2: nil, viewControllerUsed: self, action1: {
                
            }, action2: {
                
            })
        }
    }
    
    @IBAction func cancelButtonAction(sender : UIButton){
        print("Cancel button Clicked")
        
        self.showAlert()
    }
    
    @IBAction func closeButtonAction(sender : UIButton){
        print("Close button Clicked")
        
        self.showAlert()
        
    }
}


//MARK:- UICollectionView DataSource
extension EditAccountStrategyViewController : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if (tableViewRowDetails!.count > 0 || tableViewRowDetails != nil) {
            return (tableViewRowDetails?.count)! + 1//used to display the TectView in the Last Cell
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView{
        
        if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "editAccountStrategyHeaderCell", for: indexPath) as? EditAccountStrategyCollectionReusableView{
            
            if  indexPath.section < (tableViewRowDetails?.count)! {
                sectionHeader.displayHeaderViewData(data: tableViewRowDetails!, indexPath: indexPath)
                return sectionHeader
            }
            sectionHeader.isHidden = true
            return sectionHeader
        }
        
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section < (tableViewRowDetails?.count)!{
            let tableData = tableViewRowDetails![section] as! NSDictionary
            let tableContent = tableData["answers"] as! NSMutableArray
            return tableContent.count
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell1 : UICollectionViewCell?
        
        if indexPath.section == tableViewRowDetails?.count{
            cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "editAccountStrategyNotesCell", for: indexPath) as! EditAccountStrategyCollectionViewCell
            (cell1 as! EditAccountStrategyCollectionViewCell).bottomView?.layer.borderColor = UIColor.lightGray.cgColor
        }else{
            let tableData = tableViewRowDetails![indexPath.section] as! NSMutableDictionary
            let tableContent = tableData["answers"] as! NSMutableArray
            let questions = tableContent[indexPath.row] as! NSMutableDictionary
            
            cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "editAccountStrategyCell", for: indexPath) as! EditAccountStrategyCollectionViewCell
            (cell1 as! EditAccountStrategyCollectionViewCell).displayCellData(data: questions)
        }
        return cell1!
    }
}

//MARK:- UICollectionView Delegate
extension EditAccountStrategyViewController : UICollectionViewDelegate , UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
        
        if indexPath.section < (tableViewRowDetails?.count)!{
            
            let tableData = tableViewRowDetails![indexPath.section] as! NSMutableDictionary
            let tableContent = tableData["answers"] as! NSMutableArray
            
            let questions = tableContent[indexPath.row] as! NSMutableDictionary
            
            //Used for Single selection = 1 or Multiselection = 2
            //if (tableData["selectionType"] as! String) == "1"{
            //    for setData in tableContent{
            //        let data = setData as! NSMutableDictionary
            //        data.setValue("NO", forKey: "isSelected")
            //    }
            //    questions.setValue("YES", forKey: "isSelected")
            //}else{
                if (questions["isSelected"] as! String) == "NO"{
                    questions.setValue("YES", forKey: "isSelected")
                }else{
                    questions.setValue("NO", forKey: "isSelected")
                }
            //}
            collectionView.reloadData()
        }
    }
    
    //Used for Collection view Cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == tableViewRowDetails?.count{
            return CGSize(width: textViewWidth, height: 410)
        }
        return CGSize(width: collectionViewWidth, height: 70)
    }
    
    //Used to set width and height of HeaderView
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == tableViewRowDetails?.count{
            return CGSize(width: 0.0  , height: 30.0)
        }
        return CGSize(width: 50.0, height: 110)
    }
    
    
    func createStrategy() {
        
        let new_Strategy = StrategyQA(for: "NewStrategy")
        new_Strategy.Id = ""
        new_Strategy.OwnerId = "005m0000002pSmiAAE"
        new_Strategy.SGWS_Account__c = "001m000000cHLa7AAG"
        new_Strategy.SGWS_Answer_Description_List__c = "Testing with syncup,Coca Cola"
        new_Strategy.SGWS_Answer_Options__r_Id = ""
        new_Strategy.SGWS_Notes__c = "I like to eat chips"
        new_Strategy.SGWS_Question__r_Id = ""
        let attributeDict = ["type":"SGWS_Response__c"]
        
        let addNewDict: [String:Any] = [
            StrategyQA.StrategyQAFields[0]:new_Strategy.Id,
            StrategyQA.StrategyQAFields[1]:new_Strategy.OwnerId,
            StrategyQA.StrategyQAFields[2]:new_Strategy.SGWS_Account__c,
            StrategyQA.StrategyQAFields[3]:new_Strategy.SGWS_Answer_Description_List__c,
            StrategyQA.StrategyQAFields[4]:new_Strategy.SGWS_Answer_Options__r_Id,
            StrategyQA.StrategyQAFields[5]:new_Strategy.SGWS_Notes__c,
            StrategyQA.StrategyQAFields[6]:new_Strategy.SGWS_Question__r_Id,
            
            kSyncTargetLocal:true,
            kSyncTargetLocallyCreated:true,
            kSyncTargetLocallyUpdated:false,
            kSyncTargetLocallyDeleted:false,
            "attributes":attributeDict]
        
        let success = strategyQAViewModel.createNewStrategyQALocally(fields: addNewDict)
        print("Success is here \(success)")
        
        
        //        if success == true{
        //
        //            let fields: [String] = StrategyQA.StrategyQAFields
        //            strategyQAViewModel.uploadStrategyQAToServer(fields: fields, completion: { error in
        //                if error != nil {
        //                    print("Upload StrategyQA to Server " + (error?.localizedDescription)!)
        //                }
        //            })
        //
        //        }
        
        
        
        
    }
    
}


