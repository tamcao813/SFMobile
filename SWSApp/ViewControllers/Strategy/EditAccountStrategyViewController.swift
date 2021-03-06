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

//Used to maintain the Required Text hidden or not
struct validateTheReguiredVield {
    static var isSaveClicked = "0"
    static var isValidated = "0"
    static var showRedForQuestionHeader = [0]
}

//Used to send a delegate back to the ViewController to reload the Selected Answers
protocol RefreshStrategyScreenDelegate {
    func refreshStrategyScreenToLoadNewData()
}

class EditAccountStrategyViewController: UIViewController {
    
    var tableViewRowDetails : NSMutableArray?
    let strategyQuestionsViewModel = StrategyQuestionsViewModel()
    let strategyAnswersViewModel = StrategyAnswersViewModel()
    var strategyQAViewModel = StrategyQAViewModel()
    var delegate : RefreshStrategyScreenDelegate?
    var strategyArray = NSMutableArray()
    var textViewWidth = 0.0
    var collectionViewWidth = 0.0
    var strategyQAResponse:[StrategyQA] = []
    var strategyNotes = ""
    var isFirstTimeLoad = true
    var selectionType = "Single"
    
    @IBOutlet weak var collectionView : UICollectionView?
    

    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //createStrategy()
        
        IQKeyboardManager.shared.enable = true
        
        if self.view.frame.size.width == 1112{
            textViewWidth = 1105
            collectionViewWidth = 525
        }else if self.view.frame.size.width == 1024{
            textViewWidth = 1015
            collectionViewWidth = 480
        }else if self.view.frame.size.width == 1366{
            textViewWidth = 1360
            collectionViewWidth = 650
        }
        
        self.getEditStrategyData()
        
        //Clearing model for 1st time load
        validateTheReguiredVield.showRedForQuestionHeader.removeAll()
        validateTheReguiredVield.isSaveClicked = "0"
        
        isFirstTimeLoad = true
        StrategyNotes.isCellClicked = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        StrategyNotes.isCellClicked = false
    }
    
    //MARK:-
    //Get the Strategy Data from Questions, Answers and esponse
    func getEditStrategyData(){
        let question = strategyQuestionsViewModel.getStrategyQuestions(accountId: AccountId.selectedAccountId)
        
        //If no surveys for this account disbale the edit strategy button
        if question.count == 0{
            
        }
        let answer = strategyAnswersViewModel.getStrategyAnswers()
        print(AccountId.selectedAccountId)
        strategyQAResponse = strategyQAViewModel.fetchStrategy(acc: AccountId.selectedAccountId)
        
        if strategyQAResponse.count > 0{
            strategyNotes = (strategyQAResponse.first?.SGWS_Notes__c)!
        }
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
                for headerItem in tableViewData{
                    
                    let dictionary = headerItem as! NSDictionary
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
                if questionData.SGWS_Answer_Type__c == selectionType{
                    dict.setValue(questionData.SGWS_Answer_Type__c, forKey: "selectionType")
                }else{
                    dict.setValue("Multi", forKey: "selectionType")
                }
                
                self.createAnswersWithIsSelectedKey(answer : answer , questionData : questionData , dict : dict , tableViewData : tableViewData)
            }
        }
        //Assign the last Modified Data to TableViewRow Details Array
        tableViewRowDetails = tableViewData
        
        self.handleUiBasedOnStrategyScreen()
    }
    
    //Create a set of dictionary to create arrays of answers
    func createAnswersWithIsSelectedKey(answer : [StrategyAnswers] , questionData : StrategyQuestions , dict : NSMutableDictionary ,tableViewData : NSMutableArray ){
        
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
            }
        }
        tableViewData.add(dict)
    }
    
    //logic to show the UI that particular Answer is selected
    func handleUiBasedOnStrategyScreen(){
        
        if strategyArray.count > 0 {
            
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
    }
    
    //Show an alert with appropriate text
    func showAlert(){
        
        AlertUtilities.showAlertMessageWithTwoActionsAndHandler(StringConstants.changesWillNotBeSavedMessage, errorMessage: StringConstants.closingMessage, errorAlertActionTitle: "Yes", errorAlertActionTitle2: "No", viewControllerUsed: self, action1: {
            
            self.dismiss(animated: true, completion: nil)
        }){
            
        }
    }
    
    //Validation for any 1 answer has to be Selected for a question
    func validateAllFields()-> Bool{
        var oneAnswerSelected = false
        
        validateTheReguiredVield.showRedForQuestionHeader.removeAll()
        
        for index in 0...tableViewRowDetails!.count - 1{
            oneAnswerSelected = false
            let tableData = tableViewRowDetails![index] as! NSDictionary
            let tableContent = tableData["answers"] as! NSArray
            
            //Apply predicate to select any 1 answer in Array
            let namePredicate = NSPredicate(format: "isSelected = %@","YES");
            let filteredArray = tableContent.filter { namePredicate.evaluate(with: $0) };
            
            if filteredArray.count > 0 {
                oneAnswerSelected = true
            }else if filteredArray.count == 0{
                
                if !(validateTheReguiredVield.showRedForQuestionHeader.contains(index)){
                    validateTheReguiredVield.showRedForQuestionHeader.append(index)
                }
                oneAnswerSelected = false
                return oneAnswerSelected
            }
        }
        return oneAnswerSelected
    }
    
    //Used to get the Unique set of Headers
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
    
    //Create a new Entry or Update the existing record in the DB
    func createStrategy() {
        
        let new_Strategy = StrategyQA(for: "NewStrategy")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let loggedInuserid: String = (UserViewModel().loggedInUser?.userId)!
        let currentSelectedUSerId = (UIApplication.shared.delegate as! AppDelegate).currentSelectedUserId
        
        if loggedInuserid == currentSelectedUSerId{
            new_Strategy.OwnerId = (appDelegate.loggedInUser?.userId)!
        }else{
            new_Strategy.OwnerId = currentSelectedUSerId
        }
        
        //new_Strategy.OwnerId = (appDelegate.loggedInUser?.userId)!
        new_Strategy.SGWS_Account__c = AccountId.selectedAccountId
        new_Strategy.SGWS_Notes__c = StrategyNotes.accountStrategyNotes
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000+0000"
        let timeStamp = dateFormatter.string(from: date)
        
        new_Strategy.LastModifiedDate = timeStamp
        
        // let answersSelected = NSMutableArray()
        //one object of tableViewRowDetails is linked to which response object
        for q in 0...tableViewRowDetails!.count - 1{
            
            //if strategyArray is > 0 its an Edit Operation
            if strategyArray.count > 0{
                
                for _ in 0...strategyArray.count - 1{//r in strategyArray{
                    let response : NSMutableDictionary
                    print("This is the Index %@",q)
                    
                    if q <= strategyArray.count - 1{
                        response = strategyArray[q] as! NSMutableDictionary
                        
                        self.checkAnswerSelectedForTheQuestionaires(response: response, q: q, new_Strategy: new_Strategy)
                    }else{
                        //Insert new entry into DB
                        self.createNewStrategyAnswers(q: q, new_Strategy: new_Strategy)
                    }
                    
                    break
                }
                
            }else{
                //Insert new entry into DB
                self.createNewStrategyAnswers(q: q, new_Strategy: new_Strategy)
            }
        }

        self.dismiss(animated: true, completion: nil)
        self.delegate?.refreshStrategyScreenToLoadNewData()
    }
    
    //Check for answer selected in questionaire
    func checkAnswerSelectedForTheQuestionaires(response : NSMutableDictionary , q : Int , new_Strategy : StrategyQA){
        
        //let response = i as! NSMutableDictionary
        let ansStr = response["answerStrings"] as! String
        let responseId = response["id"] as! String
        
        let item = tableViewRowDetails![q] as! NSMutableDictionary
        
        let dict = item["answers"] as! NSMutableArray
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
        
        //answersSelected are answers selected by user for this Question Id
        
        // I can say i can write my response to DB
        let answerSelectedFormatted  =  answersCommaSeperated.componentsJoined(by: ",")
        
        new_Strategy.SGWS_Answer_Description_List__c = answerSelectedFormatted
        //    new_Strategy.SGWS_Answer_Options__r_Id = ""
        new_Strategy.SGWS_Question__c =  questionId
        new_Strategy.SGWS_Question_Sub_Type__c = questionSubType
        
        // Are there any change in Answers
        if ansStr != answerSelectedFormatted {
            
            self.editStrategy(strategyQAResponse: new_Strategy, reponseObjectId: responseId)
            print("Edit Success is here")
            
        }// Are there any change in Answers
        else if (StrategyNotes.accountStrategyNotes == new_Strategy.SGWS_Notes__c){

            self.editStrategy(strategyQAResponse: new_Strategy, reponseObjectId: responseId)
            print("Edit Note Success is here")
        }
    }
    
    //Create a new Entry into the DB
    func createNewStrategyAnswers(q : Int, new_Strategy : StrategyQA){
        
        let item = tableViewRowDetails![q] as! NSMutableDictionary
        let dict = item["answers"] as! NSMutableArray
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
        
        // I can say i can write my response to DB
        let answerSelectedFormatted  =  answersCommaSeperated.componentsJoined(by: ",")
        new_Strategy.SGWS_Answer_Description_List__c = answerSelectedFormatted
        
        //    new_Strategy.SGWS_Answer_Options__r_Id = ""
        new_Strategy.SGWS_Question__c =  questionId
        new_Strategy.SGWS_Question_Sub_Type__c = questionSubType
        
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
            StrategyQA.StrategyQAFields[6]:new_Strategy.LastModifiedDate,
            
            kSyncTargetLocal:true,
            kSyncTargetLocallyCreated:true,
            kSyncTargetLocallyUpdated:false,
            kSyncTargetLocallyDeleted:false,
            "attributes":attributeDict]
        
        let success = strategyQAViewModel.createNewStrategyQALocally(fields: addNewDict)
        print("New Success is here \(success)")
        
    }
    
    //Update the existing Values in the DB
    func editStrategy(strategyQAResponse : StrategyQA, reponseObjectId: String){
        
        //answersSelected are answers selected bu user for this Question Id
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let editStrategy = StrategyQA(for: "NewStrategy")
        
        //Use ths same ID of the data base row that we are modifying
        editStrategy.Id = reponseObjectId
        editStrategy.OwnerId = (appDelegate.loggedInUser?.userId)!
        editStrategy.SGWS_Account__c = AccountId.selectedAccountId
        editStrategy.SGWS_Notes__c = strategyQAResponse.SGWS_Notes__c
        
        editStrategy.LastModifiedDate = strategyQAResponse.LastModifiedDate
        // I can say i can write my response to DB
        
        editStrategy.SGWS_Answer_Description_List__c = strategyQAResponse.SGWS_Answer_Description_List__c
        //    new_Strategy.SGWS_Answer_Options__r_Id = ""
        editStrategy.SGWS_Question__c =  strategyQAResponse.SGWS_Question__c
        
        editStrategy.SGWS_Question_Sub_Type__c = strategyQAResponse.SGWS_Question_Sub_Type__c
        
        let attributeDict = ["type":"SGWS_Response__c"]
        
        let addNewDict: [String:Any] = [
            StrategyQA.StrategyQAFields[0]:editStrategy.Id,
            //StrategyQA.StrategyQAFields[7]:editStrategy.OwnerId,
            StrategyQA.StrategyQAFields[1]:editStrategy.SGWS_Account__c,
            StrategyQA.StrategyQAFields[8]:editStrategy.SGWS_Answer_Description_List__c,
            StrategyQA.StrategyQAFields[4]:editStrategy.SGWS_Notes__c,
            StrategyQA.StrategyQAFields[3]:editStrategy.SGWS_Question__c,
            StrategyQA.StrategyQAFields[2]:editStrategy.SGWS_Question_Sub_Type__c,
            StrategyQA.StrategyQAFields[6]:editStrategy.LastModifiedDate,
            
            kSyncTargetLocal:true,
            kSyncTargetLocallyCreated:false,
            kSyncTargetLocallyUpdated:true,
            kSyncTargetLocallyDeleted:false,
            "attributes":attributeDict]
        
        let success = strategyQAViewModel.editStrategyQALocally(fields: addNewDict)
        print("Edit strategy Success is here \(success)")
        
    }
    
    //MARK:- IBActions
    //Save button Clicked
    @IBAction func saveButtonAction(sender : UIButton){
        print("Save button Clicked")
        validateTheReguiredVield.isSaveClicked = "1"
        
        let validateFields = self.validateAllFields()
        
        if validateFields{
            print("Success")
            validateTheReguiredVield.isValidated = "1"
            createStrategy()
            
        }else{
            validateTheReguiredVield.isValidated = "0"
            self.collectionView?.reloadData()
        }
    }
    
    //Cancel button Clicked
    @IBAction func cancelButtonAction(sender : UIButton){
        print("Cancel button Clicked")
        
        if StrategyNotes.isCellClicked{
            self.showAlert()
        }else{
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    //Close Button Clicked
    @IBAction func closeButtonAction(sender : UIButton){
        print("Close button Clicked")
        
        if StrategyNotes.isCellClicked{
            self.showAlert()
        }else{
            self.dismiss(animated: true, completion: nil)
        }
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
            
            //Used to Hide or Unhide the Required Field Label
            if validateTheReguiredVield.isSaveClicked == "1"{
                if validateTheReguiredVield.isValidated == "1"{
                    (cell1 as! EditAccountStrategyCollectionViewCell).lblReguiredFields?.isHidden = true
                }else{
                    (cell1 as! EditAccountStrategyCollectionViewCell).lblReguiredFields?.isHidden = false
                }
            }else{
                (cell1 as! EditAccountStrategyCollectionViewCell).lblReguiredFields?.isHidden = true
            }
            
            if isFirstTimeLoad == true{
                isFirstTimeLoad = false
                (cell1 as! EditAccountStrategyCollectionViewCell).textView?.text = strategyNotes
                StrategyNotes.accountStrategyNotes = strategyNotes
            }
            
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
            
            StrategyNotes.isCellClicked = true
            
            let tableData = tableViewRowDetails![indexPath.section] as! NSMutableDictionary
            let tableContent = tableData["answers"] as! NSMutableArray
            
            let questions = tableContent[indexPath.row] as! NSMutableDictionary
            
            //Used for Single selection = 1 or Multiselection = 2
            if (tableData["selectionType"] as! String) == selectionType{
                for setData in tableContent{
                    let data = setData as! NSMutableDictionary
                    data.setValue("NO", forKey: "isSelected")
                }
                questions.setValue("YES", forKey: "isSelected")
            }else{
                if (questions["isSelected"] as! String) == "NO"{
                    questions.setValue("YES", forKey: "isSelected")
                }else{
                    questions.setValue("NO", forKey: "isSelected")
                }
            }
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
}

extension EditAccountStrategyViewController: UITextViewDelegate{
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return AlertUtilities.disableEmojis(text: text)
    }
}


