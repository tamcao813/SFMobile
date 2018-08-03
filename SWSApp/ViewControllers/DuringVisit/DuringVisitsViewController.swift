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
import CoreLocation
import SmartSync

struct AccountObject {
    static var account : Account?
}

enum LoadThePersistantMenuScreen : Int{
    case contacts = 0
    case chatter
    case actionItems
    case notifications
}

struct LoadThePersistantMenuScreenItem {
    static var loadItemScreen = 0
}

protocol NavigateToAccountVisitSummaryDelegate {
    func NavigateToAccountVisitSummary(data : LoadThePersistantMenuScreen)
    func NavigateToAccountVisitSummaryActionItems(data : LoadThePersistantMenuScreen)
    func navigateToAccountVisitingScreen()
}

class  DuringVisitsViewController : UIViewController,CLLocationManagerDelegate {
    
    @IBOutlet weak var containerView : UIView?
    @IBOutlet weak var btnBack : UIButton?
    @IBOutlet weak var imgDiscussion : UIImageView?
    @IBOutlet weak var imgInsights : UIImageView?
    @IBOutlet weak var btnDiscussion : UIButton?
    @IBOutlet weak var btnInsights : UIButton?
    @IBOutlet weak var btnEditAccountStrategy : UIButton?
    @IBOutlet weak var btnSaveContinueComplete : UIButton?
    @IBOutlet weak var btnCreateActionItem : UIButton?
    
    //MARK: LOCATION
    var locationManager = CLLocationManager()
    
    func setLocationManager(){
        locationManager.distanceFilter  = kCLLocationAccuracyNearestTenMeters;
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.delegate = self
    }
    
    func startUpdatingLocationAlerts() {
        // 1. status is not determined
        if CLLocationManager.authorizationStatus() == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        }
            // 2. authorization were denied
        else if CLLocationManager.authorizationStatus() == .denied {
            print("Location services were previously denied. Please enable location services for this app in Settings.")
        }
            // 3. we do have authorization
        else if CLLocationManager.authorizationStatus() == .authorizedAlways {
            locationManager.delegate = self
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        locationManager.stopUpdatingLocation()
        
        geoLocationForVisit.endLatitude = userLocation.coordinate.latitude
        geoLocationForVisit.endLongitude = userLocation.coordinate.longitude
        
        //        geoLocationForVisit.didReceiveLocation = true
        //        _ = PlanVisitManager.sharedInstance.editAndSaveVisit({ error in
        //            //print(error!)
        //        })
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        locationManager.stopUpdatingLocation()
        print("The error is in location \(error)")
//        _ = PlanVisitManager.sharedInstance.editAndSaveVisit({ error in
//            //print(error!)
//        })
    }
    
//    /// fetchLocationTill will block the Save button till location is received
//    func fetchLocationTill(){
//        var count = 4
//        while geoLocationForVisit.didReceiveLocation == false && count > 0{
//            sleep(5)
//            count = count - 1
//        }
//        _ = PlanVisitManager.sharedInstance.editAndSaveVisit()
//        geoLocationForVisit.didReceiveLocation = false
//    }
    
    var visitObject: WorkOrderUserObject?
    
    var delegate : NavigateToAccountVisitSummaryDelegate?
    var tableViewRowDetails = NSMutableArray()
    let strategyQAViewModel = StrategyQAViewModel()
    let strategyQuestionsViewModel = StrategyQuestionsViewModel()
    let strategyAnswersViewModel = StrategyAnswersViewModel()
    var tableViewData : NSMutableArray?
    
    //Present Active ViewController
    private var activeViewController: UIViewController? {
        didSet {
            removeInactiveViewController(inactiveViewController: oldValue)
            updateActiveViewController()
        }
    }
    
    //Remove Inactive ViewController
    private func removeInactiveViewController(inactiveViewController: UIViewController?) {
        if let inActiveVC = inactiveViewController {
            // call before removing child view controller's view from hierarchy
            inActiveVC.willMove(toParentViewController: nil)
            
            inActiveVC.view.removeFromSuperview()
            
            // call after removing child view controller's view from hierarchy
            inActiveVC.removeFromParentViewController()
        }
    }
    
    //Update Active ViewController
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
        self.setLocationManager()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let accountId = PlanVisitManager.sharedInstance.visit?.accountId
        AccountId.selectedAccountId = accountId!
        
        self.loadTheDataFromStrategyQA()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.startUpdatingLocationAlerts()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        locationManager.stopUpdatingLocation()
        geoLocationForVisit.startLatitude = 0.0
        geoLocationForVisit.startLongitude = 0.0
        geoLocationForVisit.startTime = ""
        geoLocationForVisit.endLatitude = 0.0
        geoLocationForVisit.endLongitude = 0.0
        geoLocationForVisit.endTime = ""
    }
    
    //MARK:-
    //Get the necessary data to Load Strategy_Response__C
    func loadTheDataFromStrategyQA(){
        let data = strategyQAViewModel.fetchStrategy(acc: AccountId.selectedAccountId)
        
        let question = strategyQuestionsViewModel.getStrategyQuestions(accountId: AccountId.selectedAccountId)
        
        //If no surveys for this account disbale the edit strategy button
        if question.count == 0{
            btnEditAccountStrategy?.isHidden = true
        }else{
            btnEditAccountStrategy?.isHidden = false
        }

        tableViewData = NSMutableArray()
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
                for headerText in tableViewData!{
                    
                    let dictionary = headerText as! NSDictionary
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
                
                self.createAnswerStrings(dict: dict, queAndAns: queAndAns, tableviewData: tableViewData!)
            }
        }
        self.loadTheSubheaders(data: data, tableViewData: tableViewData!)
    }
    
    
    //Create Array of Dictionaries for Answers and add to MutableArray
    func createAnswerStrings(dict : NSMutableDictionary, queAndAns : StrategyQA, tableviewData : NSMutableArray){
        
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
        
        tableviewData.add(dict)
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
    
    //Get Last Updtaed Notes to Display in UI
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
            
        }
        //Assign the data to Array and reload the data
        tableViewRowDetails = modifiedArray
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
    
    //MARK:- IBAction Methods
    //Close Button Clicked
    @IBAction func closeButtonClicked(sender : UIButton){
        
        AlertUtilities.showAlertMessageWithTwoActionsAndHandler("Any changes will not be saved", errorMessage: "Are you sure you want to close?", errorAlertActionTitle: "Yes", errorAlertActionTitle2: "No", viewControllerUsed: self, action1: {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshAccountVisitList"), object:nil)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshVisitEventList"), object:nil)
            self.dismiss(animated: true, completion: nil)
            
        }) {
            print("No")
        }
    }
    
    //Transaction button clicked
    @IBAction func transactionClicked(sender : UIButton){
        
        DispatchQueue.main.async {
            if let url = URL(string: StringConstants.topazUrl)
            {
                if UIApplication.shared.canOpenURL(url)
                {
                    UIApplication.shared.open(url)
                }
                else
                {
                    let alert = UIAlertController(title: "Alert", message: StringConstants.topazAlertMessage, preferredStyle: .alert)

                    let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)

                    alert.addAction(cancelAction)
                    self.present(alert, animated: true, completion: nil)                }
            }
        }
    }
    
    //GoSpot Button Clicked
    @IBAction func goSpotClicked(sender : UIButton){
        
        DispatchQueue.main.async {
            if let url = URL(string: StringConstants.gospotcheckUrl)
            {
                if UIApplication.shared.canOpenURL(url)
                {
                    UIApplication.shared.open(url)
                }
                else
                {
                    let url  = URL(string: StringConstants.gospotItuneUrl)
                    
                    if UIApplication.shared.canOpenURL(url!) {
                        UIApplication.shared.open(url!)
                    }
                }
            }
        }
    }
    
    // Create Action Item Button clicked
    @IBAction func createActionItemButtonClicked(_ sender: UIButton) {
        
        btnCreateActionItem?.isHidden = false
            let createActionItemViewController = UIStoryboard(name: "ActionItem", bundle: nil).instantiateViewController(withIdentifier :"CreateNewActionItemViewController") as! CreateNewActionItemViewController
            createActionItemViewController.isEditingMode = false
            createActionItemViewController.selectedAccount = AccountObject.account
            self.present(createActionItemViewController, animated: false)
    }
    
    //Back Button Clicked
    @IBAction func backButtonClicked(sender : UIButton){
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshAccountVisitList"), object:nil)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshVisitEventList"), object:nil)
        btnBack?.isHidden = true
        btnCreateActionItem?.isHidden = false
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
    
    @IBAction func insightsButtonClicked(sender : UIButton){
        let accountStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let accountVisitListVC = accountStoryboard.instantiateViewController(withIdentifier: "InsightsModelViewControllerID") as! InsightsModelViewController
        self.present(accountVisitListVC, animated: true, completion: nil)
    }
    
    //Save button Clicked
    @IBAction func saveContinueAndComplete(sender : UIButton){
        
        if btnSaveContinueComplete?.titleLabel?.text == "Save and Continue" {
            geoLocationForVisit.lastVisitStatus = (PlanVisitManager.sharedInstance.visit?.status)!
            PlanVisitManager.sharedInstance.visit?.status = "In-Progress"
            
            //if geoLocationForVisit.startTime == "FromContinueVisit" do not save s it ws done previously
            if(geoLocationForVisit.startTime != "FromContinueVisit") {
                if  geoLocationForVisit.lastVisitStatus == "Scheduled" ||
                    geoLocationForVisit.lastVisitStatus == "Planned"{
                    //Get time on button clicked
                    geoLocationForVisit.startTime = DateTimeUtility.getCurrentTimeStampInUTCAsString()
                    _ = PlanVisitManager.sharedInstance.editAndSaveVisit({ error in
                        //print(error!)
                    })
                }
            }
        }
        else if btnSaveContinueComplete?.titleLabel?.text == "Complete"{
            //location related code
            //self.startUpdatingLocationAlerts()
            geoLocationForVisit.endTime = DateTimeUtility.getCurrentTimeStampInUTCAsString()
            PlanVisitManager.sharedInstance.visit?.status = "Completed"

            self.saveOpportunityCommitValuesLocally()
            self.saveOutcomeToWorkOrderOpportunityLocally()
            delegate?.navigateToAccountVisitingScreen()
            //Must dismiss at last
            DispatchQueue.main.async{
                _ = PlanVisitManager.sharedInstance.editAndSaveVisit({ error in
                    //self.locationManager.stopUpdatingLocation()
                    //print(error!)
                })
                self.dismiss(animated: true, completion: nil)
            }
            return
        }
        
        btnBack?.isHidden = false
        btnCreateActionItem?.isHidden = true
        imgDiscussion?.image = UIImage(named: "Small Status Good")
        imgInsights?.image = UIImage(named: "selectedButton")
        
        btnDiscussion?.setTitle("", for: .normal)
        btnInsights?.setTitle("Insights", for: .normal)
        btnSaveContinueComplete?.setTitle("Complete", for: .normal)
        
        let storyboard = UIStoryboard.init(name: "DuringVisit", bundle: nil)
        let duringVisitVC: DuringVisitsInsightsViewController = storyboard.instantiateViewController(withIdentifier: "DuringVisitsInsightsViewControllerID") as! DuringVisitsInsightsViewController
        duringVisitVC.visitInformation = visitObject
        activeViewController = duringVisitVC
        activeViewController = duringVisitVC
    }
    
    //Account strategy Clicked
    @IBAction func loadStrategyViewController(sender : UIButton){
        let storyboard: UIStoryboard = UIStoryboard(name: "Strategy", bundle: nil)
        let vc: AccountStrategyViewController = storyboard.instantiateViewController(withIdentifier: "AccountStrategyViewControllerID") as! AccountStrategyViewController
        StrategyScreenLoadFrom.isLoadFromStrategy = "1"
        (vc as AccountStrategyViewController).modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.present(vc, animated: true, completion: nil)
        (vc as AccountStrategyViewController).delegate = self
    }
    
    //Edit Account strategy Clicked
    @IBAction func loadEditAccountStrategy(sender : UIButton){
        let storyboard: UIStoryboard = UIStoryboard(name: "Strategy", bundle: nil)
        let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: "EditAccountStrategyViewControllerID") as! EditAccountStrategyViewController
        vc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        (vc as! EditAccountStrategyViewController).strategyArray = tableViewData!
        DispatchQueue.main.async {
            self.present(vc, animated: true, completion: nil)
        }
        (vc as! EditAccountStrategyViewController).delegate = self
    }
    
    //Contact button Clicked
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
    
    //Chatter Button Clicked
    @IBAction func chatterClicked(sender : UIButton){
        AlertUtilities.showAlertMessageWithTwoActionsAndHandler("Any changes will not be saved", errorMessage: "Are you sure you want to close?", errorAlertActionTitle: "Yes", errorAlertActionTitle2: "No", viewControllerUsed: self, action1: {
            DispatchQueue.main.async {
                //self.dismiss(animated: true, completion: nil)
                //self.delegate?.NavigateToAccountVisitSummary(data: .chatter)
                
                let chatterViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier :"ChatterModelViewControllerID") as! ChatterModelViewController
                DispatchQueue.main.async {
                    self.present(chatterViewController, animated: true)
                }
            }
        }) {
            
        }
    }
    
    //Action Item Button Clicked
    @IBAction func actionItemsClicked(sender : UIButton){
        DispatchQueue.main.async {
            let modalPopupStoryboard = UIStoryboard.init(name: "PopupModal", bundle: nil)
            let modalPopupViewController: DuringVisitActionItemModelViewController = modalPopupStoryboard.instantiateViewController(withIdentifier: "ActionItemsModalID") as! DuringVisitActionItemModelViewController
            modalPopupViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            self.present(modalPopupViewController, animated: true, completion: nil)
            modalPopupViewController.navigationDelegate = self
        }
    }
    
    //Notification Button Clicked
    @IBAction func notificationsClicked(sender : UIButton){
        DispatchQueue.main.async {
            let modalPopupStoryboard = UIStoryboard.init(name: "PopupModal", bundle: nil)
            let modalPopupViewController: DuringVisitNotificationModalviewController = modalPopupStoryboard.instantiateViewController(withIdentifier: "notificationID") as! DuringVisitNotificationModalviewController
            modalPopupViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            self.present(modalPopupViewController, animated: true, completion: nil)
            modalPopupViewController.delegate = self
            
        }
    }
    
    @objc func saveOpportunityCommitValuesLocally() {
        if DuringVisitsInsightsViewController.modifiedCommitOpportunitiesList.count > 0 {
            for opportunity in DuringVisitsInsightsViewController.modifiedCommitOpportunitiesList {
                _ = StoreDispatcher.shared.editOpportunityCommitToSoup(fieldsToUpload: ["id":opportunity.id,"SGWS_Commit__c":opportunity.commit])
            }
        }
    }
    
    @objc func saveOutcomeToWorkOrderOpportunityLocally() {
        if  DuringVisitsInsightsViewController.modifiedOutcomeWorkOrderList.count > 0 {
            for object in DuringVisitsInsightsViewController.modifiedOutcomeWorkOrderList {
                
                let workOrder: String = PlanVisitManager.sharedInstance.visit?.Id ?? ""
                _ = StoreDispatcher.shared.editOpportunityOutcomeToSoup(fieldsToUpload: [
                    "Id": object["Id"]!,
                    "SGWS_Outcome__c": object["SGWS_Outcome__c"]!,
                    "SGWS_Work_Order__c": workOrder] )
//                _ = StoreDispatcher.shared.fetchOpportunityWorkorderDebug()
                
                let attributeDict = ["type":"WorkOrder"]
                
                let addNewDict: [String:Any] = [
                    
                    PlanVisit.planVisitFields[13]:PlanVisitManager.sharedInstance.visit?.soupEntryId ?? "",
                    kSyncTargetLocal:true,
                    kSyncTargetLocallyCreated:true,
                    kSyncTargetLocallyUpdated:false,
                    kSyncTargetLocallyDeleted:false,
                    "attributes":attributeDict]
                
                _ = VisitSchedulerViewModel().editVisitToSoupEx(fields: addNewDict)
            }
        }
    }
    
}

//MARK:- RefreshStrategyScreen Delegate
extension DuringVisitsViewController : RefreshStrategyScreenDelegate{
    
    //After coming back from Edit Strategy Screen, reload Strategy Logic
    func refreshStrategyScreenToLoadNewData(){
        self.loadTheDataFromStrategyQA()
    }
}

extension DuringVisitsViewController : NavigateToDuringVisitViewControllerDelegate{
    
    //After coming back from Action Item Modal View
    func navigateToDuringVisitVC() {
        self.dismiss(animated: false, completion: {
            self.delegate?.NavigateToAccountVisitSummaryActionItems(data: .actionItems)
        })
    }
}

extension DuringVisitsViewController :NavigateToDuringVisitViewController{
    
    //After coming back from Notifications Modal View
    func navigateNotificationToDuringVisitVC() {
        DispatchQueue.main.async {
            self.dismiss(animated: false, completion: {
                self.delegate?.NavigateToAccountVisitSummary(data: .notifications)
            })
        }
    }
}

extension DuringVisitsViewController : RefreshDuringVisitStrategyDelegate{
    
    //After coming back from Strategy Screen, reload Strategy Logic
    func refreshStrategyDataInDuringVisit() {
        self.loadTheDataFromStrategyQA()
    }
}

