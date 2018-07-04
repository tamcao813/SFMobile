//
//  AccountVisitSummaryViewController.swift
//  Acoount Visit
//
//  Created by maco on 19/04/18.
//  Copyright © 2018 maco. All rights reserved.
//

import UIKit
import SmartSync
//MARK: LOCATION Related Code
import CoreLocation

protocol NavigateToContactsDelegate {
    func navigateTheScreenToContactsInPersistantMenu(data : LoadThePersistantMenuScreen)
    func navigateTheScreenToActionItemsInPersistantMenu(data : LoadThePersistantMenuScreen)
    func navigateToAccountScreen()
}

struct geoLocationForVisit {
    static var didReceiveLocation = false
    static var startLatitude:Double = 0.0
    static var startLongitude:Double = 0.0
    static var startTime:String = ""
    static var endLatitude:Double = 0.0
    static var endLongitude:Double = 0.0
    static var endTime:String = ""
    static var lastVisitStatus = ""
}



class AccountVisitSummaryViewController: UIViewController, CLLocationManagerDelegate {
    
    var visitId: String?
    var accountObject: Account?
    var opportunityList = [Opportunity]()
    var selectedOpportunitiesFromDB = [OpportunityWorkorder]()
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var editVisitButtonHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var startVisitButtonHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var editVisitButton: UIButton!
    @IBOutlet weak var startVisitButton: UIButton!
    @IBOutlet weak var deleteVisitButton: UIButton!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    var selectedContact: Contact!
    var visitObject: WorkOrderUserObject?
    var visitStatus: AccountVisitStatus?
    var delegate : NavigateToContactsDelegate?
    
    //LOCATION
    var locationManager = CLLocationManager()
    
    func setLocationManager(){
        locationManager.distanceFilter  = kCLLocationAccuracyNearestTenMeters;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
    }
    
    func startUpdatingLocationAlerts() {
        // 1. status is not determined
        if CLLocationManager.authorizationStatus() == .notDetermined {
            locationManager.requestAlwaysAuthorization()
        }
            // 2. authorization were denied
        else if CLLocationManager.authorizationStatus() == .denied {
            print("Location services were previously denied. Please enable location services for this app in Settings.")
        }
            // 3. we do have authorization
        else if CLLocationManager.authorizationStatus() == .authorizedAlways {
            locationManager.startUpdatingLocation()
        }
    }
    //Location related callbacks
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        locationManager.stopUpdatingLocation()
        //Kep the location fetched so that delay is less
        geoLocationForVisit.startLatitude = userLocation.coordinate.latitude
        geoLocationForVisit.startLongitude = userLocation.coordinate.longitude
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("The error is in location \(error)")
    }
    
    //MARK: View life cycle code
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.refreshVisit), name: NSNotification.Name("refreshAccountVisitList"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.refreshVisitList(_:)), name: NSNotification.Name("refreshAccountVisit"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.navigateToAccountScreen), name: NSNotification.Name("navigateToAccountScreen"), object: nil)
        
        //VisitModelForUIAPI.isEditMode = false
        
        self.setLocationManager()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchVisit()
        initializingXIBs()
        fetchOpportunityList()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        locationManager.stopUpdatingLocation()
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func refreshVisit(){
        fetchVisit()
        fetchOpportunityList()
    }
    
    @objc func refreshVisitList(_ notification: NSNotification){
        if let visit = notification.userInfo?["visit"] as? WorkOrderUserObject {
            fetchVisit(visitIdTemp:visit.Id)
        }
         fetchOpportunityList()
    }
    
    @objc func navigateToAccountScreen(){
        DispatchQueue.main.async {
            FilterMenuModel.selectedAccountId = (self.accountObject?.account_Id)!
            self.dismiss(animated: false, completion: nil)
            self.delegate?.navigateToAccountScreen()
        }
    }
    
    //MARK: Visit/Event related helper method
    func fetchVisit(visitIdTemp:String?){
        if let id = visitIdTemp{
            let visitArray = GlobalWorkOrderArray.workOrderArray
            for visit in visitArray {
                if visit.Id == id {
                    visitObject = visit
                    break
                }
            }
        }
        PlanVisitManager.sharedInstance.visit = visitObject
        
        fetchAccountDetails()
        fetchContactDetails()
        UICustomizations()
    }
    
    func fetchOpportunityList() {
        opportunityList = OpportunitySortUtility().opportunityFor(forAccount: (PlanVisitManager.sharedInstance.visit?.accountId)!)
        opportunityList = opportunityList.filter{($0.status != "Closed") && ($0.status != "Closed Won")}
        var selectedOpportunitiesList = [Opportunity]()
        selectedOpportunitiesFromDB = OpportunityViewModel().globalOpportunityWorkorder()
        if selectedOpportunitiesFromDB.count > 0 {
            
            selectedOpportunitiesFromDB = selectedOpportunitiesFromDB.filter( { $0.workOrder == (PlanVisitManager.sharedInstance.visit?.Id)!} )
            if selectedOpportunitiesFromDB.count > 0 {
                
                for obj in selectedOpportunitiesFromDB {
                    
                    selectedOpportunitiesList.append(contentsOf: opportunityList.filter( { $0.id == obj.opportunityId } ))
                }
            }
        }
        opportunityList = selectedOpportunitiesList
    }
    
    func fetchVisit(){
        if let id = visitId{
//            let visitArray = VisitsViewModel().visitsForUser()
            let visitArray = GlobalWorkOrderArray.workOrderArray
            for visit in visitArray {
                if visit.Id == id {
                    visitObject = visit
                    break
                }
            }
        }
        PlanVisitManager.sharedInstance.visit = visitObject
        fetchAccountDetails()
        fetchContactDetails()
        UICustomizations()
    }
    
    func fetchAccountDetails(){
        if let accountId = visitObject?.accountId {
            let accountsArray = AccountsViewModel().accountsForLoggedUser()
            for account in accountsArray{
                if account.account_Id == accountId {
                    accountObject = account
                    AccountObject.account = account
                    break
                }
            }
        }
    }
    
    /// fetchContactDetails will fetch both Global and SGWS contact
    func fetchContactDetails(){
        if let contactId = visitObject?.contactId {
            if contactId.isEmpty {
                selectedContact = nil
            } else {
                var contactsArray = ContactsViewModel().globalContacts()
                contactsArray = contactsArray + ContactsViewModel().sgwsEmployeeContacts()
                for contact in contactsArray {
                    if contact.contactId == contactId {
                        selectedContact = contact
                        break
                    } else {
                        selectedContact = nil
                    }
                }
            }
        }
        tableView.reloadData()
    }
    
    func UICustomizations(){
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        self.tableView.estimatedRowHeight = 100
        if visitObject?.status == "Schedule" || visitObject?.status == "Scheduled"{
            visitStatus = .scheduled
        }else if visitObject?.status == "InProgress" || visitObject?.status == "In-Progress"{
            visitStatus = .inProgress
        }else if visitObject?.status == "Completed"{
            visitStatus = .completed
        }else if visitObject?.status == "Planned"{
            visitStatus = .planned
        }
        statusLabel.text = visitObject?.status
        tableView.reloadData()
        let image = #imageLiteral(resourceName: "delete").withRenderingMode(.alwaysTemplate)
        deleteVisitButton.setImage(image, for: .normal)
        deleteVisitButton.tintColor = UIColor(hexString: "#4287C2")
        deleteVisitButton.setTitle("    Delete Visit", for: .normal)
        self.getStartDateAndEndTime()
        refactoringUIOnApplicationStatusBasis()
        
//        if AppDelegate.isConnectedToNetwork(){
//            deleteVisitButton.isUserInteractionEnabled = true
//        }else{
//            deleteVisitButton.isUserInteractionEnabled = false
//        }
    }
    
    func getStartDateAndEndTime() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000+0000"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        guard let visitStartDateString = visitObject?.startDate else {
            //TODO: handle it in better way, Ideally visitObject.startDate should never be null
            return
        }
        
        //according to date format
        monthLabel.text =   DateTimeUtility.convertUTCDateStringToLocalTimeZone(dateString: visitStartDateString,dateFormat:"MMM")
        dayLabel.text =   DateTimeUtility.convertUTCDateStringToLocalTimeZone(dateString: visitStartDateString,dateFormat:"dd")
        var startTime = ""
        var endTime = ""
        startTime =  DateTimeUtility.convertUTCDateStringToLocalTimeZone(dateString: visitStartDateString,dateFormat:"hh:mm a")
        guard let visitEndDateString = visitObject?.endDate else {
            //TODO: handle it in better way, Ideally visitObject.enddate should never be null
            return
        }
        endTime =  DateTimeUtility.convertUTCDateStringToLocalTimeZone(dateString: visitEndDateString,dateFormat:"hh:mm a")
        timeLabel.text = "\(startTime)-\(endTime)"
    }
    
    func initializingXIBs(){
        self.tableView.register(UINib(nibName: "LocationTableViewCell", bundle: nil), forCellReuseIdentifier: "LocationTableViewCell")
        self.tableView.register(UINib(nibName: "HeadSubHeadTableViewCell", bundle: nil), forCellReuseIdentifier: "HeadSubHeadTableViewCell")
        self.tableView.register(UINib(nibName: "AssociatedContactsTableViewCell", bundle: nil), forCellReuseIdentifier: "AssociatedContactsTableViewCell")
        self.tableView.register(UINib(nibName: "UnorderedListTableViewCell", bundle: nil), forCellReuseIdentifier: "UnorderedListTableViewCell")
        self.tableView.register(UINib(nibName: "AccountsSummaryOpportunities", bundle: nil), forCellReuseIdentifier: "AccountOpportunityCell")

       // self.tableView.register(UINib(nibName: "ButtonTableViewCell", bundle: nil), forCellReuseIdentifier: "ButtonTableViewCell")
    }
    
    func refactoringUIOnApplicationStatusBasis(){
        switch visitStatus {
        case .scheduled?:
            editVisitButtonHeightConstraint.constant = 40
            startVisitButtonHeightConstraint.constant = 40
            editVisitButton.setTitle("Edit Visit", for: .normal)
            startVisitButton.setTitle("Start Visit", for: .normal)
            deleteVisitButton.isHidden = false
        case .inProgress?:
            editVisitButtonHeightConstraint.constant = 0
            startVisitButtonHeightConstraint.constant = 40
            startVisitButton.setTitle("Continue Visit", for: .normal)
            deleteVisitButton.isHidden = true
        case .completed?:
            editVisitButtonHeightConstraint.constant = 40
            startVisitButtonHeightConstraint.constant = 0
            editVisitButton.setTitle("Edit Notes", for: .normal)
            deleteVisitButton.isHidden = true
        case .planned?:
            editVisitButtonHeightConstraint.constant = 40
            startVisitButtonHeightConstraint.constant = 40
            editVisitButton.setTitle("Edit Visit", for: .normal)
            startVisitButton.setTitle("Start Visit", for: .normal)
            deleteVisitButton.isHidden = false
        default:
            break
        }
    }
    
    func deleteLocalVisitEntry(){
        let attributeDict = ["type":"WorkOrder"]
        let visitNoteDict: [String:Any] = [
            Visit.VisitsFields[0]: self.visitObject!.Id,
            Visit.VisitsFields[14]:self.visitObject?.soupEntryId,
            kSyncTargetLocal:true,
            kSyncTargetLocallyCreated:false,
            kSyncTargetLocallyUpdated:false,
            kSyncTargetLocallyDeleted:true,
            "attributes":attributeDict]
        
        let success = VisitSchedulerViewModel().deleteVisitLocally(fields: visitNoteDict)
        
        if let index = GlobalWorkOrderArray.workOrderArray.index(where: {$0.Id == self.visitObject?.Id}) {
            GlobalWorkOrderArray.workOrderArray.remove(at: index)
        }
        
        if(success){
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshAccountOverView"), object:nil)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshVisitEventList"), object:nil)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshCalendar"), object:nil)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "REFRESH_MONTH_CALENDAR"), object:nil)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    @IBAction func deleteVisitButtonTapped(_ sender: UIButton){
        
        AlertUtilities.showAlertMessageWithTwoActionsAndHandler("Visit Delete", errorMessage: StringConstants.deleteConfirmation, errorAlertActionTitle: "Delete", errorAlertActionTitle2: "Cancel", viewControllerUsed: self, action1: {
            
            if StoreDispatcher.shared.isWorkOrderCreatedLocally(id: self.visitObject!.Id){
                
                self.deleteLocalVisitEntry()
                self.dismiss(animated: true, completion: nil)
                
            }else{
                
                DispatchQueue.main.async { //do this in group.notify
                    MBProgressHUD.show(onWindow: true)
                }
            
                //Call Delete UI API and after success save the data to DB
                StoreDispatcher.shared.deleteVisitFromOutlook(recordTypeId: self.visitObject!.Id) { (data) in
                    if data == nil{
                        
                        DispatchQueue.main.async { //do this in group.notify
                            MBProgressHUD.hide(forWindow: true)
                        }
                        
                        self.deleteLocalVisitEntry()
                        
                        VisitSchedulerViewModel().syncVisitsWithServer{ error in
                            
                            if error != nil{
                                
                                print("Sync visit with server failed \(String(describing: error?.localizedDescription))")
                                
                            }
                            DispatchQueue.main.async {
                                VisitModelForUIAPI.isEditMode = false
                                MBProgressHUD.hide(forWindow: true)
                            }
                        }
                        
                        self.dismiss(animated: true, completion: nil)
                        
                    }else{
                        
                        DispatchQueue.main.async { //do this in group.notify
                            MBProgressHUD.hide(forWindow: true)
                        }
                        
                        AlertUtilities.showAlertMessageWithTwoActionsAndHandler("Alert", errorMessage: "Deletion of Visit has failed, Please try again ", errorAlertActionTitle: "Ok", errorAlertActionTitle2: nil, viewControllerUsed: self, action1: {
                            
                           // self.dismiss(animated: true, completion: nil)
                            
                        }, action2: {
                            
                        })
                    }
                }
            }
            
        }) {
            print("Cancel")
        }
        
    }
    
    @IBAction func startOrContinueVisitButtonTapped(_ sender: UIButton){
        if visitStatus == .scheduled  || visitStatus == .planned || visitStatus == .inProgress{
            let storyboard: UIStoryboard = UIStoryboard(name: "DuringVisit", bundle: nil)
            let vc: DuringVisitsViewController = storyboard.instantiateViewController(withIdentifier: "DuringVisitsViewControllerID") as! DuringVisitsViewController
            (vc as DuringVisitsViewController).modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            
            PlanVisitManager.sharedInstance.visit = visitObject
            (vc as DuringVisitsViewController).visitObject = visitObject
            (vc as DuringVisitsViewController).delegate = self
            
            //location related code: If coming from "Continue Visit" set flag so no start time goes on server
            if(visitStatus == .inProgress && sender.titleLabel?.text! == "Continue Visit"){
                geoLocationForVisit.startTime = "FromContinueVisit"
            }
            else {
                geoLocationForVisit.startTime = DateTimeUtility.getCurrentTimeStampInUTCAsString()
                self.startUpdatingLocationAlerts()
            }
            
            self.present(vc, animated: true, completion: nil)
        }else{
            
            let storyboard: UIStoryboard = UIStoryboard(name: "PlanVisitEditableScreen", bundle: nil)
            let vc: SelectOpportunitiesViewController = storyboard.instantiateViewController(withIdentifier: "SelectOpportunitiesViewControllerID") as! SelectOpportunitiesViewController
            (vc as SelectOpportunitiesViewController).modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            self.present(vc, animated: true, completion: nil)

        }
    }
    
    @IBAction func editVisitOrNotesButtonTapped(_ sender: UIButton){
        
        switch visitStatus {
        case .scheduled?:
            PlanVisitManager.sharedInstance.editPlanVisit = true
            let createVisitViewController = UIStoryboard(name: "AccountVisit", bundle: nil).instantiateViewController(withIdentifier :"CreateNewVisitViewController") as! CreateNewVisitViewController
            createVisitViewController.isEditingMode = false
            createVisitViewController.visitId = visitObject?.Id
            PlanVisitManager.sharedInstance.visit?.sgwsVisitPurpose = (visitObject?.sgwsVisitPurpose)!
            PlanVisitManager.sharedInstance.visit?.sgwsAgendaNotes = (visitObject?.sgwsAgendaNotes)!
            DispatchQueue.main.async {
                self.present(createVisitViewController, animated: true)
            }
        case .inProgress?:
            print("In progress")
        case .completed?:
            let storyboard = UIStoryboard(name: "PlanVisitEditableScreen", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier :"EditAgendaNoteID") as? EditAgendaNoteViewController
            viewController?.editNotesText = (self.visitObject?.description)!
            viewController?.modalPresentationStyle = .overCurrentContext
            PlanVisitManager.sharedInstance.visit?.sgwsVisitPurpose = (visitObject?.sgwsVisitPurpose)!
            PlanVisitManager.sharedInstance.visit?.sgwsAgendaNotes = (visitObject?.sgwsAgendaNotes)!
            self.present(viewController!, animated: true)
        case .planned?:
            PlanVisitManager.sharedInstance.editPlanVisit = true
            let createVisitViewController = UIStoryboard(name: "AccountVisit", bundle: nil).instantiateViewController(withIdentifier :"CreateNewVisitViewController") as! CreateNewVisitViewController
            createVisitViewController.isEditingMode = false
            PlanVisitManager.sharedInstance.visit?.sgwsVisitPurpose = (visitObject?.sgwsVisitPurpose)!
            PlanVisitManager.sharedInstance.visit?.sgwsAgendaNotes = (visitObject?.sgwsAgendaNotes)!
            createVisitViewController.visitId = visitObject?.Id
            DispatchQueue.main.async {
                self.present(createVisitViewController, animated: true)
            }
        default:
            break
        }
    }
    
    @IBAction func closeButtonTapped(_ sender: UIButton?){
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshAccountOverView"), object:nil)
        locationManager.stopUpdatingLocation()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func accountStrategyButtonTapped(_ sender: Any) {
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Strategy", bundle: nil)
        let vc: AccountStrategyViewController = storyboard.instantiateViewController(withIdentifier: "AccountStrategyViewControllerID") as! AccountStrategyViewController
        StrategyScreenLoadFrom.isLoadFromStrategy = "1"
        
        AccountId.selectedAccountId = (accountObject?.account_Id)!
        
        (vc as AccountStrategyViewController).modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.present(vc, animated: true, completion: nil)
    }
}

//MARK:- NavigateToContacts Delegate
extension AccountVisitSummaryViewController : NavigateToAccountVisitSummaryDelegate , NavigateToAccountAccountVisitSummaryDelegate{
    
    func navigateToAccountVisitingScreen() {
        DispatchQueue.main.async {
        self.dismiss(animated: false, completion: nil)
        }
    }
    
    func NavigateToAccountVisitSummary(data: LoadThePersistantMenuScreen) {

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
           
            self.closeButtonTapped(nil)
        }
       
        self.delegate?.navigateTheScreenToContactsInPersistantMenu(data: data)
        
        
        
    }
    func NavigateToAccountVisitSummaryActionItems(data: LoadThePersistantMenuScreen) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.closeButtonTapped(nil)
        }
       // FilterMenuModel.selectedAccountId = (AccountObject.account?.account_Id)!
      //  FilterMenuModel.isFromAccountVisitSummary = "YES"        
      //  NotificationCenter.default.post(name: NSNotification.Name(rawValue: "navigateToAccountScreen"), object:nil)
        self.delegate?.navigateTheScreenToActionItemsInPersistantMenu(data: data)

    }
    
    func navigateToAccountVisitSummaryScreen() {
        DispatchQueue.main.async {
         //   AlertUtilities.showAlertMessageWithTwoActionsAndHandler("Any changes will not be saved", errorMessage: "Are you sure you want to close?", errorAlertActionTitle: "Yes", errorAlertActionTitle2: "No", viewControllerUsed: self, action1: {
                FilterMenuModel.selectedAccountId = (self.accountObject?.account_Id)!
                self.dismiss(animated: true, completion: nil)
                self.delegate?.navigateToAccountScreen()
           // }){
                
            }
        }        
    //}
}


extension AccountVisitSummaryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        switch visitStatus {
        case .scheduled?:
            return 2
        case .inProgress?,.planned?,.completed?:
            return 5
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch visitStatus {
        case .scheduled?:
            switch section {
            case 0:
                return 50
            case 1:
                return 0
            case 2:
                return 30
            default:
                return 0
            }
        case .inProgress?,.planned?,.completed?:
            switch section {
            case 0:
                return 50
            case 1:
                return 30
                
            case 2:
//                fetchOpportunityList()
                if opportunityList.count > 0 {
                    return 30
                } else {
                    return 0
                }
            default:
                return 0
            }
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UINib(nibName: "AccountVisitSectionHeaderView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as? AccountVisitSectionHeaderView
        footerView?.headerLabel.text = ""
        return footerView
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UINib(nibName: "AccountVisitSectionHeaderView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as? AccountVisitSectionHeaderView
        if visitStatus == .scheduled {
            headerView?.headerLabel.text = getHeaderValuesInScheduledState(section: section)
        }else {
            headerView?.headerLabel.text = getHeaderValuesInProgress(section: section)
        }
        return headerView
    }
    
    func getHeaderValuesInScheduledState(section: Int) -> String{
        var headerValue = ""
        if section == 0 {
            if visitObject?.location.count == 0 {
                headerValue = "Location"
            } else {
                headerValue = (visitObject?.location)!
            }
        }
        return headerValue
    }
    
    func getHeaderValuesInProgress(section: Int) -> String{
        var headerValue = ""
        if section == 0 {
            if visitObject?.location.count == 0 {
                headerValue = "Location"
            } else {
                headerValue = (visitObject?.location)!
            }
            
        }else if section == 1 {
            headerValue = "Associated Contacts"
        }
        return headerValue
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch visitStatus {
        case .scheduled?:
            return getScheduledStateCell(section: indexPath.section)
        case .inProgress?,.completed?,.planned?:
            return getInprogressStateCell(section: indexPath.section)
        default:
            return UITableViewCell()
        }
    }
    
    func getScheduledStateCell(section: Int) -> UITableViewCell{
        switch section {
        case 0:
            return getLocationCell()
        case 1:
            return getConatactCell() // As er Dileep request we have added contact cell in scedule status
        default:
            return UITableViewCell()
        }
    }
    
    func getInprogressStateCell(section: Int) -> UITableViewCell{
        switch section {
        case 0:
            return getLocationCell()
        case 1:
            return getConatactCell()
        case 2:
                return getOpportunitiesCell()
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeadSubHeadTableViewCell") as? HeadSubHeadTableViewCell
            cell?.headingLabel.text = "Service Purposes"
            let str = visitObject?.sgwsVisitPurpose.replacingOccurrences(of: ";", with: "\n • ")
            if !(str?.isEmpty)! {
                cell?.SubheadingLabel.text = " • " + str!
            } else { cell?.SubheadingLabel.text = ""}
            return cell!
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeadSubHeadTableViewCell") as? HeadSubHeadTableViewCell
            cell?.headingLabel.text = "Agenda Notes"
            cell?.SubheadingLabel.text = visitObject?.sgwsAgendaNotes
            return cell!
        default:
            return UITableViewCell()
        }
    }
    
    func getLocationCell() -> LocationTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationTableViewCell") as? LocationTableViewCell
        cell?.delegate = self
        cell?.account = accountObject
        cell?.displayCellContent()
        return cell!
    }
    
    
    func getOpportunitiesCell() -> AccountsSummaryOpportunityCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccountOpportunityCell") as? AccountsSummaryOpportunityCell
        cell?.headingLabel.text = "Opportunities Selected"
        if opportunityList.count > 0 {
            cell?.headerView.isHidden = false
            cell?.tableHeightConstraint.constant = CGFloat(opportunityList.count * 60)
            cell?.displayCellContent(selectedOpportunityList: opportunityList)
        }else {
            cell?.tableHeightConstraint.constant = 0.0
            cell?.headerView.isHidden = true
            

        }
        
        return cell!
    }
    
    func getConatactCell() -> AssociatedContactsTableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "AssociatedContactsTableViewCell") as? AssociatedContactsTableViewCell
        
        if selectedContact != nil {
            cell?.containerHeightConstraint.constant = 75
            cell?.containerView.isHidden = false
            cell?.displayCellContent(contact: selectedContact)
        }else{
            cell?.containerHeightConstraint.constant = 0
            cell?.containerView.isHidden = true            
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 1 {
            if(selectedContact != nil) {
                //Check if this selected contact is SGWS Employees
                let sgwsContacts = StoreDispatcher.shared.fetchAllSGWSEmployeeContacts()
                
                let syncConfigurationList = sgwsContacts.filter( { return $0.contactId == selectedContact.contactId } )
                
                if(syncConfigurationList.count > 0){
                    return
                }
                //return
                DispatchQueue.main.async {
                    self.dismiss(animated: false, completion: nil)
                }
                let contactDict:[String: Contact] = ["contact": selectedContact]
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SwitchToContact"), object:nil, userInfo: contactDict)
            }

        }
    }
}

extension AccountVisitSummaryViewController: ButtonTableViewCellDelegate {
    func accountStrategyButtonTapped() {
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Strategy", bundle: nil)
        let vc: AccountStrategyViewController = storyboard.instantiateViewController(withIdentifier: "AccountStrategyViewControllerID") as! AccountStrategyViewController
        StrategyScreenLoadFrom.isLoadFromStrategy = "1"
        
        AccountId.selectedAccountId = (accountObject?.account_Id)!
        
        (vc as AccountStrategyViewController).modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.present(vc, animated: true, completion: nil)
        
    }
}

extension AccountVisitSummaryViewController : NavigateToVisitSummaryScreenDelegate{
   
    func navigateToVisitSummaryScreen() {
        self.dismiss(animated: true, completion: nil)
    }
}





