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

protocol RefreshStrategyScreenDelegate {
    func refreshStrategyScreenToLoadNewData()
}

class EditAccountStrategyViewController: UIViewController {
    
    var tableViewRowDetails : NSMutableArray?
    let strategyQuestionsViewModel = StrategyQuestionsViewModel()
    let strategyAnswersViewModel = StrategyAnswersViewModel()
    var strategyQAViewModel = StrategyQAViewModel()
    
    var delegate : RefreshStrategyScreenDelegate?
    
    @IBOutlet weak var collectionView : UICollectionView?
    
    var strategyArray = NSMutableArray()
    
    
    var textViewWidth = 0.0
    var collectionViewWidth = 0.0
    var strategyQAResponse:[StrategyQA] = []
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //createStrategy()
        
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
        
        let question = strategyQuestionsViewModel.getStrategyQuestions(accountId: AccountId.selectedAccountId)
        
        //If no surveys for this account disbale the edit strategy button
        if question.count == 0{
            
        }
        let answer = strategyAnswersViewModel.getStrategyAnswers()
        
        strategyQAResponse = strategyQAViewModel.fetchStrategy(acc: AccountId.selectedAccountId)
        
        
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
                    // print(dictionary)
                    
                    let header = dictionary["header"] as? String
                    
                    if questionData.SGWS_Question_Type__c == header!{
                        
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
                dict.setValue(questionData.SGWS_Question_Sub_Type__c, forKey: "subHeaderStrategy")
                
                dict.setValue(questionData.Id, forKey: "id")
                
                let answerArray = NSMutableArray()
                
                for answerData in answer{
                    
                    if answerData.SGWS_Question__c == questionData.Id{
                        
                        let answerTemp = answerData.SGWS_Answer_Description__c
                        
                        let answerTempArray = answerTemp.components(separatedBy: ",")
                        print(answerTempArray)
                        
                        if answerTempArray.count > 0{
                            
                            for ans in answerTempArray{
                                
                                //Check for Response__C if the Anwer matched isSelected YES
                                
                                let answerDict = NSMutableDictionary()
                                answerDict.setValue(ans, forKey: "answerText")
                                answerDict.setValue(answerData.Id, forKey: "answerId")
                                
                                answerDict.setValue("NO", forKey: "isSelected")
                                //answerDict.setValue(answerData.OwnerId, forKey: "ownerId")
                                
                                answerArray.add(answerDict)
                            }
                        }
                        
                        dict.setValue(answerArray, forKey: "answers") //Added Answers for Subheader
                        
                        let answersDescription = answerArray.componentsJoined(by: ",")
                        dict.setValue(answersDescription, forKey: "answerStrings")
                    }
                }
                tableViewData.add(dict)
            }
        }
        
        // print(tableViewData)
        tableViewRowDetails = tableViewData
        
            
            //Write a logic to show the UI that particular Answer is selected
            if strategyArray != nil {
                
                for strategy in strategyArray{
                    
                    let strategyDict = strategy as! NSMutableDictionary
                    let strategyArray = strategyDict["answers"] as! NSMutableArray
                    var answerText = ""
                    
                    for answer in strategyArray{
                        let answerDict = answer as! NSMutableDictionary
                        answerText = answerDict["answerText"] as! String
                        
                        for editStrategy in tableViewRowDetails!{
                            
                            let editStrategyDict = editStrategy as! NSMutableDictionary
                            let editStrategyArray = editStrategyDict["answers"] as! NSMutableArray
                            
                            for answer in editStrategyArray{
                                let answerDict = answer as! NSMutableDictionary
                                let editAnswerText = answerDict["answerText"] as! String
                                
                                if answerText == editAnswerText{
                                    
                                    answerDict.setValue("YES", forKey: "isSelected")
                                    break
                                }
                            }
                        }
                    }
                }
            }
        
        
        //Write a logic to show the UI that particular Answer is selected
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //StrategyNotes.accountStrategyNotes = ""
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showAlert(){
        
        //AlertUtilities.showAlertMessageWithTwoActionsAndHandler("Any changes will not be saved", errorMessage: "Are you sure you want to close?", errorAlertActionTitle: "Yes", errorAlertActionTitle2: "No", viewControllerUsed: self, action1: {
        
        self.dismiss(animated: true, completion: nil)
        
        //}) {
        //   print("No")
        // }
    }
    
    //Validation for any 1 answer has to be Selected for a question
    func validateAllFields()-> Bool{
        var oneAnswerSelected = false
        
        for index in tableViewRowDetails!{
            oneAnswerSelected = false
            let tableData = index as! NSDictionary
            let tableContent = tableData["answers"] as! NSMutableArray
            
            for data in tableContent{
                
                let selectedKey = data as! NSMutableDictionary
                
                let data = selectedKey["isSelected"] as! String
                
                if data == "YES"{
                    
                    oneAnswerSelected = true
                    
                }
            }
        }
        return oneAnswerSelected
    }
    
    
    func getHeader()-> [String]{
        var headerArray = [String]()
        
        //Get unique headernames once
        let question = strategyQuestionsViewModel.getStrategyQuestions(accountId: AccountId.selectedAccountId)
        
        for questionHeaders in question{
            
            let que = questionHeaders.SGWS_Question_Type__c
            
            if !(headerArray.contains(que)){
                headerArray.append(que)
            }
        }
        return headerArray
    }
    
    
    //MARK:- Button Actions
    @IBAction func saveButtonAction(sender : UIButton){
        print("Save button Clicked")
        
        //createStrategy()
        
        
        //VALIDATION IS NEEDED HERE 
        
        let validateFields = self.validateAllFields()
        
        if validateFields{
            print("Success")
            
            // Have i edited or created new Strategy
            
            //if(strategyQAResponse.count > 0){
            
            
            
            //} else {
            
            createStrategy()
            
            //}
            
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
            (cell1 as! EditAccountStrategyCollectionViewCell).textView?.text = StrategyScreenLoadFrom.strategyNotes
            
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
        
        //let responseChange = false
        
        let new_Strategy = StrategyQA(for: "NewStrategy")
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        new_Strategy.OwnerId = (appDelegate.loggedInUser?.userId)!
        
        new_Strategy.SGWS_Account__c = AccountId.selectedAccountId
        new_Strategy.SGWS_Notes__c = StrategyNotes.accountStrategyNotes
        
        //print()
        
        // let answersSelected = NSMutableArray()
        //one object of tableViewRowDetails is linked to which response object
        for q in 0...tableViewRowDetails!.count - 1{
            
            if strategyArray.count > 0{
                
                for i in 0...strategyArray.count - 1{//r in strategyArray{
                    let response : NSMutableDictionary
                    print("This is the Index %@",q)
                    if q < strategyArray.count - 1{
                        response = strategyArray[q] as! NSMutableDictionary
                        
                    }else{
                        break
                    }
                    
                    //let response = i as! NSMutableDictionary
                    let ansStr = response["answerStrings"] as! String
                    let responseId = response["id"] as! String
                    
                    let item = tableViewRowDetails![q] as! NSMutableDictionary
                    //let item = q as! NSMutableDictionary
                    
                    let dict = item["answers"] as! NSMutableArray
                    
                    //let ansStr1 = item["answerStrings"] as! String
                    
                    let questionId = item["id"] as! String //Question Id
                    
                    
                    let questionSubType = item["subHeaderStrategy"] as! String //Question Subtype
                    
                    
                    let answersCommaSeperated = NSMutableArray()
                    
                    for answers in dict{
                        
                        let answerDict = answers as! NSMutableDictionary
                        
                        let isSelected = answerDict["isSelected"] as! String
                        
                        if isSelected == "YES"{
                            let answer = answerDict["answerText"] as! String
                            
                            if(!answersCommaSeperated.contains(answer)){
                                answersCommaSeperated.add(answer)
                            }
                        }
                    }
                    
                    //answersSelected are answers selected bu user for this Question Id
                    
                    // I can say i can write my response to DB
                    
                    let answerSelectedFormatted  =  answersCommaSeperated.componentsJoined(by: ",")
                    
                    
                    
                    new_Strategy.SGWS_Answer_Description_List__c = answerSelectedFormatted
                    //    new_Strategy.SGWS_Answer_Options__r_Id = ""
                    new_Strategy.SGWS_Question__c =  questionId
                    
                    new_Strategy.SGWS_Question_Sub_Type__c = questionSubType
                    
                    
                    
                    //       let json:[String:Any] = [ "SGWS_Account__c":ary[2],"Id":ary[0], "SGWS_Question_Sub_Type__c":ary[4], "SGWS_Question__c":ary[3], "SGWS_Answer_Description_List__c":ary[1],"SGWS_Notes__c":ary[5]]
                    
                    let attributeDict = ["type":"SGWS_Response__c"]
                    let localId = AlertUtilities.generateRandomIDForNewEntry()
                    
                    let addNewDict: [String:Any] = [
                        StrategyQA.StrategyQAFields[0]:localId,
                        StrategyQA.StrategyQAFields[7]:new_Strategy.OwnerId,
                        StrategyQA.StrategyQAFields[1]:new_Strategy.SGWS_Account__c,
                        StrategyQA.StrategyQAFields[8]:new_Strategy.SGWS_Answer_Description_List__c,
                        StrategyQA.StrategyQAFields[4]:new_Strategy.SGWS_Notes__c,
                        StrategyQA.StrategyQAFields[3]:new_Strategy.SGWS_Question__c,
                        StrategyQA.StrategyQAFields[2]:new_Strategy.SGWS_Question_Sub_Type__c,
                        
                        
                        kSyncTargetLocal:true,
                        kSyncTargetLocallyCreated:true,
                        kSyncTargetLocallyUpdated:false,
                        kSyncTargetLocallyDeleted:false,
                        "attributes":attributeDict]
                    
                    // Are there any change in Answers
                    if ansStr != answerSelectedFormatted {
                        
                        let success = self.editStrategy(strategyQAResponse: new_Strategy, reponseObjectId: responseId)
                        print("Edit Success is here \(success)")
                        
                    }// Are there any change in Answers
                    else if (StrategyNotes.accountStrategyNotes == new_Strategy.SGWS_Notes__c){
                        
                        let success = self.editStrategy(strategyQAResponse: new_Strategy, reponseObjectId: responseId)
                        print("Edit Success is here \(success)")
                    }//
                    else if (strategyQAResponse.count == 0){
                        
                        print("")
                    }
                    else{
                        
                        //let success = strategyQAViewModel.createNewStrategyQALocally(fields: addNewDict)
                        //                        print("New Success is here \(success)")
                    }

                    break
                }
                
            }else{
                
                let item = tableViewRowDetails![q] as! NSMutableDictionary
                //let item = q as! NSMutableDictionary
                
                let dict = item["answers"] as! NSMutableArray
                
                let ansStr1 = item["answerStrings"] as! String
                
                
                let questionId = item["id"] as! String //Question Id
                
                let answersCommaSeperated = NSMutableArray()
                
                for answers in dict{
                    
                    let answerDict = answers as! NSMutableDictionary
                    
                    let isSelected = answerDict["isSelected"] as! String
                    
                    if isSelected == "YES"{
                        let answer = answerDict["answerText"] as! String
                        
                        if(!answersCommaSeperated.contains(answer)){
                            answersCommaSeperated.add(answer)
                        }
                    }
                }
                
                //answersSelected are answers selected bu user for this Question Id
                
                // I can say i can write my response to DB
                let answerSelectedFormatted  =  answersCommaSeperated.componentsJoined(by: ",")
                
                
                new_Strategy.SGWS_Answer_Description_List__c = answerSelectedFormatted
                //    new_Strategy.SGWS_Answer_Options__r_Id = ""
                new_Strategy.SGWS_Question__c =  questionId
                
                
                
                
                let attributeDict = ["type":"SGWS_Response__c"]
                let localId = AlertUtilities.generateRandomIDForNewEntry()
                
                let addNewDict: [String:Any] = [
                    StrategyQA.StrategyQAFields[0]:localId,
                    StrategyQA.StrategyQAFields[1]:new_Strategy.SGWS_Account__c,
                    StrategyQA.StrategyQAFields[8]:new_Strategy.SGWS_Answer_Description_List__c,
                    StrategyQA.StrategyQAFields[4]:new_Strategy.SGWS_Notes__c,
                    StrategyQA.StrategyQAFields[3]:new_Strategy.SGWS_Question__c,
                    
                    
                    StrategyQA.StrategyQAFields[2]:new_Strategy.SGWS_Question_Sub_Type__c,
                    
                    
                    
                    
                    kSyncTargetLocal:true,
                    kSyncTargetLocallyCreated:true,
                    kSyncTargetLocallyUpdated:false,
                    kSyncTargetLocallyDeleted:false,
                    "attributes":attributeDict]
                
                
                // if ansStr == ansStr1 {
                
                //      let success = self.editStrategy(strategyQAResponse: new_Strategy, reponseObjectId: responseId)
                //        print("Edit Success is here \(success)")
                
                //  }else{
                let success = strategyQAViewModel.createNewStrategyQALocally(fields: addNewDict)
                print("New Success is here \(success)")
                
                // }
                
                
                //AlertUtilities.showAlertMessageWithTwoActionsAndHandler("Save Complete", errorMessage: "Your Data is Saved, Sync up later", errorAlertActionTitle: "ok", errorAlertActionTitle2: nil, viewControllerUsed: self, action1: {
                
                
                
                // }, action2: {
                
                // })
                
            }
            
        }
        
        self.dismiss(animated: true, completion: nil)
        self.delegate?.refreshStrategyScreenToLoadNewData()
    }
    
    func editStrategy(strategyQAResponse : StrategyQA, reponseObjectId: String){
        
        //answersSelected are answers selected bu user for this Question Id
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let editStrategy = StrategyQA(for: "NewStrategy")
        
        //Use ths same ID of the data base row that we are modifying
        editStrategy.Id = reponseObjectId
        editStrategy.OwnerId = (appDelegate.loggedInUser?.userId)!
        editStrategy.SGWS_Account__c = AccountId.selectedAccountId
        editStrategy.SGWS_Notes__c = strategyQAResponse.SGWS_Notes__c
        // I can say i can write my response to DB
        
        editStrategy.SGWS_Answer_Description_List__c = strategyQAResponse.SGWS_Answer_Description_List__c
        //    new_Strategy.SGWS_Answer_Options__r_Id = ""
        editStrategy.SGWS_Question__c =  strategyQAResponse.SGWS_Question__c
        
        editStrategy.SGWS_Question_Sub_Type__c = strategyQAResponse.SGWS_Question_Sub_Type__c
        
        
        
        let attributeDict = ["type":"SGWS_Response__c"]
        
        
        let addNewDict: [String:Any] = [
            StrategyQA.StrategyQAFields[0]:editStrategy.Id,
            StrategyQA.StrategyQAFields[7]:editStrategy.OwnerId,
            StrategyQA.StrategyQAFields[1]:editStrategy.SGWS_Account__c,
            StrategyQA.StrategyQAFields[8]:editStrategy.SGWS_Answer_Description_List__c,
            StrategyQA.StrategyQAFields[4]:editStrategy.SGWS_Notes__c,
            StrategyQA.StrategyQAFields[3]:editStrategy.SGWS_Question__c,
            StrategyQA.StrategyQAFields[2]:editStrategy.SGWS_Question_Sub_Type__c,
            
            
            
            kSyncTargetLocal:true,
            kSyncTargetLocallyCreated:false,
            kSyncTargetLocallyUpdated:true,
            kSyncTargetLocallyDeleted:false,
            "attributes":attributeDict]
        
        let success = strategyQAViewModel.editStrategyQALocally(fields: addNewDict)
        print("Edit strategy Success is here \(success)")
        
        
    }
}


