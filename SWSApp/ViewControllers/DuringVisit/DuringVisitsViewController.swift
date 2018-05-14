//
//  DuringVisitsViewController.swift
//  SWSApp
//
//  Created by r.a.jantakal on 27/04/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation
import UIKit
import IQKeyboardManagerSwift


enum LoadThePersistantMenuScreen : Int{
    case contacts = 0
    case chatter
    case actionItems
    case notifications
}

protocol NavigateToAccountVisitSummaryDelegate {
    func NavigateToAccountVisitSummary(data : LoadThePersistantMenuScreen)
    func navigateToAccountVisitingScreen()
}

class  DuringVisitsViewController : UIViewController {
    
    @IBOutlet weak var containerView : UIView?
    @IBOutlet weak var btnBack : UIButton?
    
    @IBOutlet weak var imgDiscussion : UIImageView?
    @IBOutlet weak var imgInsights : UIImageView?
    
    @IBOutlet weak var btnDiscussion : UIButton?
    @IBOutlet weak var btnInsights : UIButton?
    
    @IBOutlet weak var btnEditAccountStrategy : UIButton?
    @IBOutlet weak var btnSaveContinueComplete : UIButton?
    
    var visitObject: Visit?
    
    var delegate : NavigateToAccountVisitSummaryDelegate?
    
    var tableViewRowDetails = NSMutableArray()
    
    let strategyQAViewModel = StrategyQAViewModel()
    let strategyQuestionsViewModel = StrategyQuestionsViewModel()
    let strategyAnswersViewModel = StrategyAnswersViewModel()
    
    
    private var activeViewController: UIViewController? {
        didSet {
            removeInactiveViewController(inactiveViewController: oldValue)
            updateActiveViewController()
        }
    }
    
    private func removeInactiveViewController(inactiveViewController: UIViewController?) {
        if let inActiveVC = inactiveViewController {
            // call before removing child view controller's view from hierarchy
            inActiveVC.willMove(toParentViewController: nil)
            
            inActiveVC.view.removeFromSuperview()
            
            // call after removing child view controller's view from hierarchy
            inActiveVC.removeFromParentViewController()
        }
    }
    
    private func updateActiveViewController() {
        if let activeVC = activeViewController {
            // call before adding child view controller's view as subview
            addChildViewController(activeVC)
            
            activeVC.view.frame = (containerView?.bounds)!
            containerView?.addSubview(activeVC.view)
            
            // call before adding child view controller's view as subview
            activeVC.didMove(toParentViewController: self)
        }
    }
    
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnInsights?.setTitle("", for: .normal)
        
        let storyboard = UIStoryboard.init(name: "DuringVisit", bundle: nil)
        let duringVisitVC: DuringVisitsTopicsViewController = storyboard.instantiateViewController(withIdentifier: "DuringVisitsTopicsViewControllerID") as! DuringVisitsTopicsViewController
        
        duringVisitVC.visitObject = visitObject
        
        activeViewController = duringVisitVC
        
        IQKeyboardManager.shared.enable = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let accountId = PlanVistManager.sharedInstance.visit?.accountId
        AccountId.selectedAccountId = accountId!
        
        self.loadTheDataFromStrategyQA()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        
    }
    
    
    
    
    func loadTheDataFromStrategyQA(){
        
        //
        
        // let json:[String:Any] = [ "SGWS_Account__c":ary[2],"Id":ary[0], "SGWS_Question_Sub_Type__c":ary[4], "SGWS_Question__c":ary[3], "SGWS_Answer_Description_List__c":ary[1],"SGWS_Notes__c":ary[5]]
        
        let data = strategyQAViewModel.fetchStrategy(acc: AccountId.selectedAccountId)
        
        let question = strategyQuestionsViewModel.getStrategyQuestions(accountId: AccountId.selectedAccountId)
        
        //        //If no surveys for this account disbale the edit strategy button
        if question.count == 0{
            //            editIcon?.isHidden = true
            //            lblNoData?.isHidden = false
            //            lblNoData?.text = "No Survey assigned for this Account."
            btnEditAccountStrategy?.isHidden = true
        }else{
            //            if StrategyScreenLoadFrom.isLoadFromStrategy == "0" {
            //                editIcon?.isHidden = false
            //            }else{
            //                editIcon?.isHidden = true
            btnEditAccountStrategy?.isHidden = false
        }
        //
        //            lblNoData?.text = "The Account Strategy for this account has not been completed yet. Click ‘Edit’ to fill out the Account Strategy now."
        //            lblNoData?.isHidden = true
        //
        //        }
        // let data = strategyQAViewModel.getStrategyQuestionAnswer()
        
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
                
                //                let myVar = "c"
                //                let myDict: [String: Int] = ["a": 0, "b": 1, "c": 2]
                //                if myDict.keys.contains(myVar) {
                //                    print(myVar)
                //                }
                //let arrayOfSetValues = answerListArray
                
                let answerListString = answerArrayStr.componentsJoined(by: ",")
                dict.setValue(answerListString, forKey: "answerStrings")
                dict.setValue(answerArray, forKey: "answers") //Added Answers for Subheader
                
                tableViewData.add(dict)
            }
        }
        //print(tableViewData)
        
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
            print("infinity3")
            
        }
        
        self.loadDateAndLastMOdifiedDate(data: data, modifiedArray: modifiedArray)
    }
    
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
            
            //let lastModifiedDate = data.first?.LastModifiedDate
            //print(lastModifiedDate!)
            
            //            let dateFormatter = DateFormatter()
            //            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000+0000"
            //            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
            //
            //            let newModifiedDate = dateFormatter.date(from: modifiedDate!)
            //            dateFormatter.dateFormat = "MMM dd, YYYY"
            //            let formattedDate = dateFormatter.string(from: newModifiedDate!)
            //            lblLastModifiedDate?.text = "Account Strategy Lasy Updated on " + formattedDate
            
        }
        
        //Assign the data to Array and reload the data
        tableViewRowDetails = modifiedArray
        
        //Hide the Label
        //        if tableViewRowDetails!.count > 0 {
        //            self.lblNoData?.isHidden = true
        //            self.lblLastModifiedDate?.isHidden = false
        //        }else{
        //            self.lblNoData?.isHidden = false
        //            self.lblLastModifiedDate?.isHidden = true
        //        }
    }
    
    
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
        //print(headerArray)
        return headerArray
    }
    
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
    
    
    
    
    //MARK:- IBAction Methods
    @IBAction func closeButtonClicked(sender : UIButton){
        
        AlertUtilities.showAlertMessageWithTwoActionsAndHandler("Any changes will not be saved", errorMessage: "Are you sure you want to close?", errorAlertActionTitle: "Yes", errorAlertActionTitle2: "No", viewControllerUsed: self, action1: {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshAccountVisitList"), object:nil)
            self.dismiss(animated: true, completion: nil)
            
        }) {
            print("No")
        }
        
    }
    
    @IBAction func transactionClicked(sender : UIButton){
        UIApplication.shared.open(URL(string : "http://www.google.com")!, options: [:], completionHandler: { (status) in
            
        })
    }
    
    @IBAction func goSpotClicked(sender : UIButton){
        
        UIApplication.shared.open(URL(string : "http://www.google.com")!, options: [:], completionHandler: { (status) in
            
        })
    }
    
    @IBAction func backButtonClicked(sender : UIButton){
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshAccountVisitList"), object:nil)
        btnBack?.isHidden = true
        imgDiscussion?.image = UIImage(named: "selectedButton")
        imgInsights?.image = UIImage(named: "selectedGrey")
        
        btnDiscussion?.setTitle("Discussion", for: .normal)
        btnInsights?.setTitle("", for: .normal)
        btnSaveContinueComplete?.setTitle("Save and Continue", for: .normal)
        
        
        let storyboard = UIStoryboard.init(name: "DuringVisit", bundle: nil)
        let duringVisitVC: DuringVisitsTopicsViewController = storyboard.instantiateViewController(withIdentifier: "DuringVisitsTopicsViewControllerID") as! DuringVisitsTopicsViewController
        duringVisitVC.visitObject = visitObject
        activeViewController = duringVisitVC
    }
    
    @IBAction func saveContinueAndComplete(sender : UIButton){
        
        if btnSaveContinueComplete?.titleLabel?.text == "Save and Continue"{
            PlanVistManager.sharedInstance.visit?.status = "In-Progress"
            //Save the data in DB
            let status = PlanVistManager.sharedInstance.editAndSaveVisit()
        }
        else if btnSaveContinueComplete?.titleLabel?.text == "Complete"{
            PlanVistManager.sharedInstance.visit?.status = "Completed"
            DispatchQueue.main.async{
                self.dismiss(animated: true, completion: nil)
            }
            
            //Save the data in DB
            let status = PlanVistManager.sharedInstance.editAndSaveVisit()
            delegate?.navigateToAccountVisitingScreen()
            return
        }
        
        btnBack?.isHidden = false
        imgDiscussion?.image = UIImage(named: "Small Status Good")
        imgInsights?.image = UIImage(named: "selectedButton")
        
        btnDiscussion?.setTitle("", for: .normal)
        btnInsights?.setTitle("Insights", for: .normal)
        btnSaveContinueComplete?.setTitle("Complete", for: .normal)
        
        let storyboard = UIStoryboard.init(name: "DuringVisit", bundle: nil)
        let duringVisitVC: DuringVisitsInsightsViewController = storyboard.instantiateViewController(withIdentifier: "DuringVisitsInsightsViewControllerID") as! DuringVisitsInsightsViewController
        activeViewController = duringVisitVC
    }
    
    @IBAction func loadEditAccountStrategy(sender : UIButton){
        let storyboard: UIStoryboard = UIStoryboard(name: "Strategy", bundle: nil)
        let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: "EditAccountStrategyViewControllerID") as! EditAccountStrategyViewController
        vc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        (vc as! EditAccountStrategyViewController).strategyArray = tableViewRowDetails
        DispatchQueue.main.async {
            self.present(vc, animated: true, completion: nil)
        }
        (vc as! EditAccountStrategyViewController).delegate = self
        
    }
    
    @IBAction func contactsClicked(sender : UIButton){
        DispatchQueue.main.async {
            AlertUtilities.showAlertMessageWithTwoActionsAndHandler("Any changes will not be saved", errorMessage: "Are you sure you want to close?", errorAlertActionTitle: "Yes", errorAlertActionTitle2: "No", viewControllerUsed: self, action1: {                
                self.dismiss(animated: false, completion: nil)
                self.delegate?.NavigateToAccountVisitSummary(data: .contacts)
            }) {
                print("No")
            }
        }
    }
    
    @IBAction func chatterClicked(sender : UIButton){
        AlertUtilities.showAlertMessageWithTwoActionsAndHandler("Any changes will not be saved", errorMessage: "Are you sure you want to close?", errorAlertActionTitle: "Yes", errorAlertActionTitle2: "No", viewControllerUsed: self, action1: {
            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: nil)
                self.delegate?.NavigateToAccountVisitSummary(data: .chatter)
            }
        }) {
            
        }
    }
    
    @IBAction func actionItemsClicked(sender : UIButton){
        AlertUtilities.showAlertMessageWithTwoActionsAndHandler("Any changes will not be saved", errorMessage: "Are you sure you want to close?", errorAlertActionTitle: "Yes", errorAlertActionTitle2: "No", viewControllerUsed: self, action1: {
            self.dismiss(animated: true, completion: nil)
            self.delegate?.NavigateToAccountVisitSummary(data: .actionItems)
        }) {
            
        }
    }
    
    @IBAction func notificationsClicked(sender : UIButton){
        AlertUtilities.showAlertMessageWithTwoActionsAndHandler("Any changes will not be saved", errorMessage: "Are you sure you want to close?", errorAlertActionTitle: "Yes", errorAlertActionTitle2: "No", viewControllerUsed: self, action1: {
            self.dismiss(animated: true, completion: nil)
            self.delegate?.NavigateToAccountVisitSummary(data: .notifications)
            
        }) {
            
        }
    }
}


//MARK:- RefreshStrategyScreen Delegate
extension DuringVisitsViewController : RefreshStrategyScreenDelegate{
    
    func refreshStrategyScreenToLoadNewData(){
        self.loadTheDataFromStrategyQA()
    }
}



