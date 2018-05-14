//
//  AccountStrategyViewControllerr.swift
//  SWSApp
//
//  Created by r.a.jantakal on 23/04/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation
import UIKit

struct StrategyScreenLoadFrom {
    static var isLoadFromStrategy = "0"
}

class AccountStrategyViewController : UIViewController{
    
    @IBOutlet weak var collectionView : UICollectionView?
    @IBOutlet weak var lblLastModifiedDate : UILabel?
    @IBOutlet weak var lblNoData : UILabel?
    @IBOutlet weak var editIcon : UIButton?
    @IBOutlet weak var closeIcon : UIButton?
    
    let strategyQAViewModel = StrategyQAViewModel()
    let strategyQuestionsViewModel = StrategyQuestionsViewModel()
    let strategyAnswersViewModel = StrategyAnswersViewModel()
    var tableViewRowDetails : NSMutableArray?
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Account Strategy Screen Loaded")
        
        //        let plistPath = Bundle.main.path(forResource: "AccountStrategy", ofType: ".plist", inDirectory: nil)
        //        let dictionary = NSMutableDictionary(contentsOfFile: plistPath!)
        //        tableViewRowDetails = dictionary!["New item"] as? NSMutableArray
        //        print(dictionary!)
        
        if StrategyScreenLoadFrom.isLoadFromStrategy == "0" {
            editIcon?.isHidden = false
            closeIcon?.isHidden = true
        }else{
            editIcon?.isHidden = true
            closeIcon?.isHidden = false
        }
        
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            //flowLayout.estimatedItemSize = CGSize(width: 1024, height: 200)//CGSizeMake(1, 1)
            flowLayout.sectionInset = UIEdgeInsetsMake(1, 1, 1, 1)
        }
        self.loadTheDataFromStrategyQA()
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
    
    //Get the necessary data to Load Strategy_Response__C
    func loadTheDataFromStrategyQA(){
        
        // let json:[String:Any] = [ "SGWS_Account__c":ary[2],"Id":ary[0], "SGWS_Question_Sub_Type__c":ary[4], "SGWS_Question__c":ary[3], "SGWS_Answer_Description_List__c":ary[1],"SGWS_Notes__c":ary[5]]
        
        let data = strategyQAViewModel.fetchStrategy(acc: AccountId.selectedAccountId)
        
        let question = strategyQuestionsViewModel.getStrategyQuestions(accountId: AccountId.selectedAccountId)
        
        //If no surveys for this account disbale the edit strategy button
        if question.count == 0{
            editIcon?.isHidden = true
            lblNoData?.isHidden = false
            lblNoData?.text = "No Survey assigned for this Account."
        }else{
            if StrategyScreenLoadFrom.isLoadFromStrategy == "0" {
                editIcon?.isHidden = false
            }else{
                editIcon?.isHidden = true
            }
            
            lblNoData?.text = "The Account Strategy for this account has not been completed yet. Click ‘Edit’ to fill out the Account Strategy now."
            lblNoData?.isHidden = true
        }
        
        let tableViewData = NSMutableArray()
        var dict : NSMutableDictionary!
        
        var headerCheck = false
        //Write a func to get header Count
        for header in self.getHeader(data:data){
            
            for queAndAns in data{
                
                dict = NSMutableDictionary()
                //execute only for account situation (headers only)
                if queAndAns.SGWS_Question__c != header {
                    continue
                }
                
                //Used to keep Header only once
                for q in tableViewData{
                    
                    let dictionary = q as! NSDictionary
                    let header = dictionary["header"] as? String
                    if queAndAns.SGWS_Question__c == header!{
                        headerCheck = true
                    }
                }
                
                //Prevent the Subheader inserting Again
                if !headerCheck{
                    dict.setValue(queAndAns.SGWS_Question__c, forKey: "header") //Main Header
                }else{
                    dict.setValue("", forKey: "header")
                }
                
                headerCheck = false
                dict.setValue(queAndAns.SGWS_Question_Sub_Type__c, forKey: "subHeader")    //Added Subheader
                dict.setValue(queAndAns.Id, forKey: "id")
                
                let answerArray = NSMutableArray()
                let answerArrayStr = NSMutableArray()
                let answerListArray = queAndAns.SGWS_Answer_Description_List__c.components(separatedBy: ",")
                
                if queAndAns.SGWS_Answer_Description_List__c.count > 0 {
                    
                    for ans in answerListArray{
                        if !(answerArrayStr.contains(ans)){
                            answerArrayStr.add(ans)
                            let answerDict = NSMutableDictionary()
                            answerDict.setValue(ans, forKey: "answerText")
                            answerArray.add(answerDict)
                        }
                    }
                }
                let answerListString = answerArrayStr.componentsJoined(by: ",")
                dict.setValue(answerListString, forKey: "answerStrings")
                dict.setValue(answerArray, forKey: "answers") //Added Answers for Subheader
                
                tableViewData.add(dict)
            }
        }
        self.loadTheSubheaders(data: data, tableViewData: tableViewData)
    }
    
    //Used to load the Strategy Subheader Questions
    func loadTheSubheaders(data : [StrategyQA] , tableViewData : NSMutableArray){
        
        let modifiedArray = NSMutableArray()
        
        for subHeaders in self.getSubHeader(data:data){
            
            //Get the Subheader filtered in a loop
            let namePredicate = NSPredicate(format: "subHeader = %@",subHeaders);
            let filteredArray = tableViewData.filter { namePredicate.evaluate(with: $0) };
            
            if(filteredArray.count == 0){
                return
            }
            print(filteredArray)
            
            let newArray = NSMutableArray()
            let stringArray = NSMutableArray()
            
            for item in filteredArray{
                
                let tempDict = item as! NSMutableDictionary
                let ary = tempDict["answers"] as! NSMutableArray
                
                for data in ary{
                    let dic = data as! NSMutableDictionary
                    newArray.add(dic)
                    
                    let text = dic["answerText"] as! String
                    stringArray.add(text)
                }
            }
            let dictionary = NSMutableDictionary()
            dictionary.setValue(newArray, forKey: "answers")
            
            let text = stringArray.componentsJoined(by: ",")
            let data1 = filteredArray[0] as! NSMutableDictionary
            let head1 = data1["header"] as! String
            let subHead1 = data1["subHeader"] as! String
            let id = data1["id"] as! String
            
            dictionary.setValue(head1, forKey: "header")
            dictionary.setValue(subHead1, forKey: "subHeader")
            dictionary.setValue(text, forKey: "answerStrings")
            dictionary.setValue(id, forKey: "id")
            
            modifiedArray.add(dictionary)
        }
        self.loadDateAndLastMOdifiedDate(data: data, modifiedArray: modifiedArray)
    }
    
    //Get the Last Modified date and Last Updtaed Notes to Display in UI
    func loadDateAndLastMOdifiedDate(data :[StrategyQA] , modifiedArray : NSMutableArray ){
        
        //USED TO SHOW THE NOTES
        if data.count > 0 {
            
            let strategyNotes = (data.first?.SGWS_Notes__c)!
            //StrategyScreenLoadFrom.strategyNotes = strategyNotes
            
            //if strategyNotes != "" {
            let dict = NSMutableDictionary()
            dict.setValue("Account Strategy Notes", forKey: "header")
            dict.setValue("", forKey: "subHeader")
            let notesArray = NSMutableArray()
            let notesAnswerDict = NSMutableDictionary()
            notesAnswerDict.setValue(strategyNotes, forKey: "answerText")
            notesArray.add(notesAnswerDict)
            dict.setValue(notesArray, forKey: "answers")
            modifiedArray.add(dict)
            //}
            
            print(modifiedArray)
            
            let lastModifiedDate = data.first?.LastModifiedDate
            print(lastModifiedDate!)
            
            if(lastModifiedDate != ""){
                let getTime = DateTimeUtility.convertUtcDatetoReadableDateLikeStrategy(dateString: lastModifiedDate)
                var dateTime = getTime.components(separatedBy: ",")
                
                if(dateTime.count > 0){
                    let firstPart  = dateTime[0]
                    let lastPart = dateTime[1]
                    self.lblLastModifiedDate?.text = "Account Strategy last updated on " + firstPart + ", " + lastPart
                }
            }
        }
        
        //Assign the data to Array and reload the data
        tableViewRowDetails = modifiedArray
        
        //Hide the Label
        if tableViewRowDetails!.count > 0 {
            self.lblNoData?.isHidden = true
            self.lblLastModifiedDate?.isHidden = false
        }else{
            self.lblNoData?.isHidden = false
            self.lblLastModifiedDate?.isHidden = true
        }
    }
    
    //Get the Unique Header for the Questions
    func getHeader(data:[StrategyQA])-> [String]{
        var headerArray = [String]()
        //Get unique headernames once
        //let data = strategyQAViewModel.getStrategyQuestionAnswer()
        for questionHeaders in data{
            
            let que = questionHeaders.SGWS_Question__c
            if que != "" {
                if !(headerArray.contains(que)){
                    headerArray.append(que)
                }
            }
        }
        return headerArray
    }
    
    //Get the Unique SubHeader for the Questions
    func getSubHeader(data:[StrategyQA])-> [String]{
        var subHeaderArray = [String]()
        //Get unique headernames once
        // let data = strategyQAViewModel.getStrategyQuestionAnswer()
        for questionHeaders in data{
            
            let que = questionHeaders.SGWS_Question_Sub_Type__c
            if que != "" {
                if !(subHeaderArray.contains(que)){
                    subHeaderArray.append(que)
                }
            }
        }
        return subHeaderArray
    }
    
    //MARK:- Segue Methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "editStrategySegue") {
            let editStrategy = segue.destination as? EditAccountStrategyViewController
            editStrategy?.strategyArray = tableViewRowDetails!
            editStrategy?.delegate = self
        }
    }
    
    //MARK:- Button Actions
    @IBAction func editButtonClicked(sender : UIButton){
        
        if StrategyScreenLoadFrom.isLoadFromStrategy == "0" {
            performSegue(withIdentifier: "editStrategySegue", sender: nil)
            
        }else{
            //Used Same method to Dismiss the Strategy
            StrategyScreenLoadFrom.isLoadFromStrategy = "0"
            self.dismiss(animated: true, completion: nil)
        }
    }
}

//MARK:- RefreshStrategyScreenDelegate
extension AccountStrategyViewController : RefreshStrategyScreenDelegate{
    
    func refreshStrategyScreenToLoadNewData() {
        tableViewRowDetails?.removeAllObjects()
        
        self.loadTheDataFromStrategyQA()
        
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
        }
    }
}

//MARK:- UICollectionView DataSource
extension AccountStrategyViewController : UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return (tableViewRowDetails?.count)!
        //return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let tableData = tableViewRowDetails![section] as! NSDictionary
        let tableContent = tableData["answers"] as! NSMutableArray
        return tableContent.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView{
        
        if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "accountStrategyHeaderCell", for: indexPath) as? AccountStrategyCollectionReusableView{
            sectionHeader.displayHeaderViewData(data: tableViewRowDetails!, indexPath: indexPath)
            return sectionHeader
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == (tableViewRowDetails?.count)! - 1 {//Used to make the Additional notes Dynamic
            
            let tableData = tableViewRowDetails![indexPath.section] as! NSMutableDictionary
            let tableContent = tableData["answers"] as! NSMutableArray
            let questions = tableContent[indexPath.row] as! NSMutableDictionary
            
            let data = (questions["answerText"] as! String)
            
            if data.count > 115{
                if data != ""{
                    let constraintRect = CGSize(width: self.collectionView!.bounds.size.width, height: CGFloat.greatestFiniteMagnitude)
                    let attString = NSAttributedString(string: data, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 18.0)])
                    let dynamicSize: CGRect = attString.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
                    return dynamicSize.size
                }
            }else{
                return CGSize(width: (self.collectionView?.frame.size.width)!, height: 25)
            }
        }
        return CGSize(width: (self.collectionView?.frame.size.width)!, height: 25)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let tableData = tableViewRowDetails![indexPath.section] as! NSMutableDictionary
        let tableContent = tableData["answers"] as! NSMutableArray
        let questions = tableContent[indexPath.row] as! NSMutableDictionary
        
        let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "accountStrategyCell", for: indexPath) as! AccountStrategyCollectionViewCell
        cell1.contentView.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
        cell1.displayCellData(data: questions , indexPath: indexPath, arrayData: tableViewRowDetails!)
        //cell1.lblTitleText?.preferredMaxLayoutWidth = 50//.preferredMaxLayoutWidth = 50
        return cell1
        
    }
    
    //Used to set width and height of HeaderView
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: collectionView.frame.size.width, height: 75)
    }
}


