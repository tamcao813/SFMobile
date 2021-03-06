//
//  CreateNewVisitViewController.swift
//  SWSApp
//
//  Created by manu.a.gupta on 08/05/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit
//import DropDown
import IQKeyboardManagerSwift
import SmartSync

class CreateNewVisitViewController: UIViewController {
    
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var accountsDropdown: DropDown!
    var contactsDropdown: DropDown!
    var isEditingMode = false
    var callToConfirm = true
    var locationStr = ""
    var selectedAccount: Account!
    var selectedContact: Contact!
    var visitId: String!
    var visitObject: WorkOrderUserObject?
    @IBOutlet weak var errorLbl: UILabel!
    var visitViewModel = VisitSchedulerViewModel()
    
    //TextFields
    var searchAccountTextField: UITextField!
    var contactsAccountTextField: UITextField!
    var startDate: UITextField!
    var startTime: UITextField!
    var endTime: UITextField!
    
    struct createNewVisitViewControllerGlobals {
        static var userInput = false
        static var isContactField = false
        static var startDateField = ""
        static var startTimeField = ""
        static var endTimeField = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLbl.text = ""
        errorLbl.isHidden = false
        initializeNibs()
        customizedUI()
        fetchVisit()
        IQKeyboardManager.shared.enable = true
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    deinit {
        IQKeyboardManager.shared.enable = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        reloadTableView()
    }
    
    func fetchVisit(){
        //if let id = visitId{
        if let _ = visitId{
            let visitArray = VisitsViewModel().visitsForUser()
            for visit in visitArray {
                if visit.Id == visitId {
                    visitObject = visit
                    break
                }
            }
        }
        fetchAccountDetails()
        fetchContactDetails()
    }
    
    func fetchAccountDetails(){
        if let accountId = visitObject?.accountId {
            let accountsArray = AccountsViewModel().accountsForLoggedUser
            for account in accountsArray{
                if account.account_Id == accountId {
                    selectedAccount = account
                }
            }
        }
    }
    
    func fetchContactDetails(){
        if let contactId = visitObject?.contactId {
            let contactsArray = ContactsViewModel().globalContacts()
            for contact in contactsArray {
                if contact.contactId == contactId {
                    selectedContact = contact
                    break
                }
                
            }
        }
    }
    
    @objc func keyboardWillShow(_ notification:Notification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if createNewVisitViewControllerGlobals.isContactField {
                self.tableView.contentInset = UIEdgeInsetsMake(0, 0, keyboardSize.height + 100, 0) }
        }
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        
        if let _ = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        }
    }
    
    func customizedUI(){
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        self.tableView.estimatedRowHeight = 100
        if isEditingMode {
            headingLabel.text = "Edit Visit"
        }else{
            headingLabel.text = "Plan a Visit"
        }
    }
    
    func initializeNibs() {
        self.tableView.register(UINib(nibName: "SearchAccountTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchAccountTableViewCell")
        self.tableView.register(UINib(nibName: "AccountContactLinkTableViewCell", bundle: nil), forCellReuseIdentifier: "DropDownCell")
        self.tableView.register(UINib(nibName: "SearchForContactTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchForContactTableViewCell")
        self.tableView.register(UINib(nibName: "ViewContactLinkToVisitTableViewCell", bundle: nil), forCellReuseIdentifier: "ViewContactLinkToVisitTableViewCell")
        self.tableView.register(UINib(nibName: "ScheduleAppointmentTableViewCell", bundle: nil), forCellReuseIdentifier: "ScheduleAppointmentTableViewCell")
        self.tableView.register(UINib(nibName: "VisitLocationTableViewCell", bundle: nil), forCellReuseIdentifier: "VisitLocationTableViewCell")
        self.tableView.register(UINib(nibName: "VisitCallToConfirmTableViewCell", bundle: nil), forCellReuseIdentifier: "VisitCallToConfirmTableViewCell") 
    }
    
    @IBAction func closeButtonTapped(_ sender: UIButton){
        self.view.endEditing(true)
        if let dropdown = accountsDropdown{
            dropdown.hide()
        }
        if let dropdown = contactsDropdown {
            dropdown.hide()
        }
        DispatchQueue.main.async {
            if  createNewVisitViewControllerGlobals.userInput {
                AlertUtilities.showAlertMessageWithTwoActionsAndHandler("Any changes will not be saved", errorMessage: "Are you sure you want to close?", errorAlertActionTitle: "Yes", errorAlertActionTitle2: "No", viewControllerUsed: self, action1: {
                    createNewVisitViewControllerGlobals.userInput = false
                    self.dismiss(animated: true, completion: nil)
                }){
                    
                }
            }else{
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func reloadTableView(){
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    @IBAction func planButtonTapped(sender: UIButton) {
        if validateVisitData() {
            errorLbl.text = ""
            if PlanVisitManager.sharedInstance.visit != nil {
                editCurrentVisit()
                let opportunitiesViewController = UIStoryboard(name: "PlanVisitEditableScreen", bundle: nil).instantiateViewController(withIdentifier :"SelectOpportunitiesViewControllerID")
                DispatchQueue.main.async {
                    self.present(opportunitiesViewController, animated: true)
                }
            }else{
                createNewVisit(dismiss: false)
            }
        }
    }
    
    @IBAction func scheduleAndClose(sender: UIButton) {
        if validateVisitData() {
            errorLbl.text = ""
            PlanVisitManager.sharedInstance.visit?.status = "Scheduled"
            if PlanVisitManager.sharedInstance.visit != nil {
                editCurrentVisit()
                DispatchQueue.main.async {
                    self.dismiss(animated: true)
                }
            }else{
                createNewVisit(dismiss: true)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "REFRESH_MONTH_CALENDAR"), object:nil)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshAccountOverView"), object:nil)
            }
        }
    }
    
    func validateVisitData() -> Bool{
        searchAccountTextField.borderColor = UIColor.lightGray
        startDate.borderColor = UIColor.lightGray
        startTime.borderColor = UIColor.lightGray
        contactsAccountTextField.borderColor = UIColor.lightGray
        
        if selectedAccount == nil {
            searchAccountTextField.borderColor = .red
            tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            errorLbl.text = StringConstants.emptyFieldError
            return false
        }else if (startDate.text?.isEmpty)! {
            startDate.borderColor = .red
            tableView.scrollToRow(at: IndexPath(row: 0, section: 4), at: .top, animated: true)
            errorLbl.text = StringConstants.emptyFieldError
            return false
        }else if (startTime.text?.isEmpty)! {
            startTime.borderColor = .red
            tableView.scrollToRow(at: IndexPath(row: 0, section: 4), at: .top, animated: true)
            errorLbl.text = StringConstants.emptyFieldError
            return false
        }else if (endTime.text?.isEmpty)! {
            contactsAccountTextField.borderColor = .red
            tableView.scrollToRow(at: IndexPath(row: 0, section: 4), at: .top, animated: true)
            errorLbl.text = StringConstants.emptyFieldError
            return false
        }else{
            return true
        }
    }
    
    func editCurrentVisit(){
        PlanVisitManager.sharedInstance.visit?.accountId = selectedAccount.account_Id
        if let contact = selectedContact {
            PlanVisitManager.sharedInstance.visit?.contactId = contact.contactId
        }else{
            PlanVisitManager.sharedInstance.visit?.contactId = ""
        }
        PlanVisitManager.sharedInstance.visit?.startDate =  getDataTimeinStr(date: startDate.text!, time: startTime.text!)
        PlanVisitManager.sharedInstance.visit?.endDate = getDataTimeinStr(date: startDate.text!, time: endTime.text!)
        PlanVisitManager.sharedInstance.visit?.location = locationStr
        PlanVisitManager.sharedInstance.visit?.sgwsAppointmentStatus = callToConfirm
        //let status = PlanVisitManager.sharedInstance.editAndSaveVisit()
        PlanVisitManager.sharedInstance.visit?.recordTypeId = StoreDispatcher.shared.workOrderRecordTypeIdVisit
        
        let _ = PlanVisitManager.sharedInstance.editAndSaveVisit()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "REFRESH_MONTH_CALENDAR"), object:nil)
    }
    
    func createNewVisit(dismiss: Bool) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        PlanVisitManager.sharedInstance.userID = (appDelegate.loggedInUser?.userId)!
        print("callToConfirm", callToConfirm)
        print("loc", locationStr)
        let new_visit = PlanVisit(for: "newVisit")
        
        //Get Current date and time
        let date = Date()
        print(date)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000+0000"
        let timeStamp = dateFormatter.string(from: date)
        
        //added the last modified App date and time
        new_visit.lastModifiedDate = timeStamp
        
        new_visit.Id = self.generateRandomIDForVisit()
        new_visit.accountId = selectedAccount.account_Id
        if let contact = selectedContact {
            new_visit.contactId = contact.contactId
        }else{
            new_visit.contactId = ""
        }
        new_visit.startDate =  getDataTimeinStr(date: startDate.text!, time: startTime.text!)
        new_visit.endDate = getDataTimeinStr(date: startDate.text!, time: endTime.text!)
        if dismiss {
            new_visit.status = "Scheduled"
        }else{
            new_visit.status = "Planned"
        }
        new_visit.location = locationStr
        new_visit.sgwsAppointmentStatus = callToConfirm
        
        new_visit.recordTypeId = StoreDispatcher.shared.workOrderRecordTypeIdVisit
      //  new_visit.sgwsAlldayEvent = true
        //TBD location to be set , what is enetered in UI
        
        
        let attributeDict = ["type":"WorkOrder"]
        let addNewDict: [String:Any] = [
            
            PlanVisit.planVisitFields[0]: new_visit.Id,
            PlanVisit.planVisitFields[10]: new_visit.lastModifiedDate,
            //            PlanVisit.planVisitFields[1]: new_visit.subject,
            PlanVisit.planVisitFields[2]: new_visit.accountId,
            //            PlanVisit.planVisitFields[3]: new_visit.sgwsAppointmentStatus,
            PlanVisit.planVisitFields[4]: new_visit.startDate,
            PlanVisit.planVisitFields[5]: new_visit.endDate,
            //            PlanVisit.planVisitFields[6]: new_visit.sgwsVisitPurpose,
            //            PlanVisit.planVisitFields[7]: new_visit.description,
            //            PlanVisit.planVisitFields[8]: new_visit.sgwsAgendaNotes,
            PlanVisit.planVisitFields[9]: new_visit.status,
            PlanVisit.planVisitFields[11]: new_visit.contactId,
            PlanVisit.planVisitFields[12]:new_visit.recordTypeId,
            PlanVisit.planVisitFields[3]:new_visit.sgwsAppointmentStatus,
           PlanVisit.planVisitFields[14]:new_visit.location,
            //PlanVisit.planVisitFields[15]:new_visit.sgwsAlldayEvent,

            
            
            kSyncTargetLocal:true,
            kSyncTargetLocallyCreated:true,
            kSyncTargetLocallyUpdated:false,
            kSyncTargetLocallyDeleted:false,
            "attributes":attributeDict]
        
        //let (success,Id) = visitViewModel.createNewVisitLocally(fields: addNewDict)
        let (success,_) = visitViewModel.createNewVisitLocally(fields: addNewDict)
        
        if(success){
            let visit = WorkOrderUserObject(for: "")
            //Add the soup entry Id
            visit.Id = new_visit.Id//String((success,Id).1)
            visit.accountId = new_visit.accountId
            visit.contactId = new_visit.contactId
            visit.startDate = new_visit.startDate
            visit.endDate = new_visit.endDate
            visit.status = new_visit.status
            visit.description = new_visit.description
            visit.sgwsAgendaNotes = new_visit.sgwsAgendaNotes
            visit.sgwsVisitPurpose = new_visit.sgwsVisitPurpose
            visit.lastModifiedDate = new_visit.lastModifiedDate
            visit.recordTypeId = new_visit.recordTypeId
            visit.subject = new_visit.subject
            visit.location = new_visit.location
            
            PlanVisitManager.sharedInstance.visit = visit
        }
        
        if(success){
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshCalendar"), object:nil)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshAccountVisitList"), object:nil)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "REFRESH_MONTH_CALENDAR"), object:nil)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshAccountOverView"), object:nil)
            if dismiss {
                DispatchQueue.main.async {
                    self.dismiss(animated: true)
                }
            }else{
                let storyboard = UIStoryboard(name: "PlanVisitEditableScreen", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier :"SelectOpportunitiesViewControllerID")
                DispatchQueue.main.async {
                    self.present(viewController, animated: true)
                }
            }
        }
    }
    
    func generateRandomIDForVisit()->String  {
        //  Make a variable equal to a random number....
        let randomNum:UInt32 = arc4random_uniform(99999999) // range is 0 to 99
        // convert the UInt32 to some other  types
        let someString:String = String(randomNum)
        return someString
    }
    
    func getDataTimeinStr(date:String, time: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'hh:mm a"
        var string = date + "T" + time
        if let dateFromString = dateFormatter.date(from: string) {
            //again assign the dateFormat and UTC timezone to get proper string else it will return the UTC format string
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000+0000"
            dateFormatter.timeZone = TimeZone(identifier:"UTC")
            string = dateFormatter.string(from: dateFromString)
        }
        return string
    }
}

extension CreateNewVisitViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            if selectedAccount != nil {
                return 1
            }else{
                return 0
            }
        case 2:
            return 1
        case 3:
            if selectedContact != nil {
                return 1
            }else{
                return 0
            }
        case 4:
            return 1
        case 5:
            return 1
        case 6:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SearchAccountTableViewCell") as? SearchAccountTableViewCell
            searchAccountTextField = cell?.searchContactTextField
            accountsDropdown = cell?.accountsDropDown
            cell?.delegate = self
            return cell!
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DropDownCell") as? AccountContactLinkTableViewCell
            cell?.containerTrailingConstraint.constant = 40
            cell?.containerLeadingConstraint.constant = 40
            cell?.delegate = self
            if let account = selectedAccount {
                cell?.displayCellContent(account: account)
            }
            return cell!
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SearchForContactTableViewCell") as? SearchForContactTableViewCell
            contactsAccountTextField = cell?.searchContactTextField
            contactsDropdown = cell?.contactDropDown
            cell?.delegate = self
            return cell!
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ViewContactLinkToVisitTableViewCell") as? ViewContactLinkToVisitTableViewCell
            cell?.delegate = self
            if let contact = selectedContact {
                cell?.displayCellContent(contact: contact)
            }
            return cell!
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ScheduleAppointmentTableViewCell") as? ScheduleAppointmentTableViewCell
            startDate = cell?.schedulerComponentView.dateTextField
            startTime = cell?.schedulerComponentView.startTimeTextField
            endTime = cell?.schedulerComponentView.endTimeTextField
            if let visit = visitObject {
                cell?.schedulerComponentView.dateTextField.text = self.getDate(stringDate: visit.startDate)
                cell?.schedulerComponentView.startTimeTextField.text = self.getTime(stringDate: visit.startDate)
                cell?.schedulerComponentView.endTimeTextField.text = self.getTime(stringDate: visit.endDate)
                cell?.layoutIfNeeded()
            }
            return cell!
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "VisitLocationTableViewCell") as? VisitLocationTableViewCell
            cell?.delegate = self
            if let visit = visitObject {
                cell?.locationTxtFld.text = visit.location
                locationStr = visit.location
            }
            return cell!
        case 6:
            let cell = tableView.dequeueReusableCell(withIdentifier: "VisitCallToConfirmTableViewCell") as? VisitCallToConfirmTableViewCell
            cell?.delegate = self
            if let visit = visitObject {
                if visit.sgwsAppointmentStatus {
                    cell?.appontmentControl.selectedSegmentIndex = 0
                    callToConfirm = true
                } else {
                    cell?.appontmentControl.selectedSegmentIndex = 1
                    callToConfirm = false
                }
            }
            return cell!
        default:
            return UITableViewCell()
        }
    }
    
    func getDate(stringDate: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000+0000"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        var date = dateFormatter.date(from: stringDate)
        if date == nil {
            dateFormatter.dateFormat = "yyyy-MM-dd'T'hh:mm a"
            dateFormatter.timeZone = TimeZone.current
            date = dateFormatter.date(from: stringDate)
        }
        if date != nil {
            dateFormatter.dateFormat = "yyyy-MM-dd"
            return dateFormatter.string(from: date!)
        }
        return ""
    }
    
    func getTime(stringDate: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000+0000"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        var date = dateFormatter.date(from: stringDate)
        if date == nil {
            dateFormatter.dateFormat = "yyyy-MM-dd'T'hh:mm a"
            dateFormatter.timeZone = TimeZone.current
            date = dateFormatter.date(from: stringDate)
        }
        if date != nil {
            dateFormatter.dateFormat = "yyyy-MM-dd'T'hh:mm a"
            dateFormatter.timeZone = TimeZone.current
            let localTimeZoneString = dateFormatter.string(from: date!)
            date = dateFormatter.date(from: localTimeZoneString)
        }
        
        if date != nil {
            //Use lowercase hh:mm to show time in 12 hrs format
            dateFormatter.dateFormat = "hh:mm a"
            dateFormatter.amSymbol = "AM"
            dateFormatter.pmSymbol = "PM"
            return dateFormatter.string(from: date!)
        }
        return ""
    }
    
}

extension CreateNewVisitViewController: SearchAccountTableViewCellDelegate {
    func scrollTableView() {
        
    }
    
    func accountSelected(account : Account) {
        createNewVisitViewControllerGlobals.userInput = true
        selectedAccount = account
        reloadTableView()
    }
}

extension CreateNewVisitViewController: AccountContactLinkTableViewCellDelegate {
    func removeAccount() {
        createNewVisitViewControllerGlobals.userInput = true
        selectedAccount = nil
        reloadTableView()
    }
}

extension CreateNewVisitViewController: SearchForContactTableViewCellDelegate {
    func contactSelected(contact: Contact) {
        createNewVisitViewControllerGlobals.userInput = true
        selectedContact = contact
        reloadTableView()
    }
}

extension CreateNewVisitViewController: ContactVisitLinkTableViewCellDelegate {
    func removeContact(){
        createNewVisitViewControllerGlobals.userInput = true
        selectedContact = nil
        reloadTableView()
    }
}

extension CreateNewVisitViewController: locationDelegate {
    func onLocationUpdate(sender: String) {
        locationStr = sender
    }
}

extension CreateNewVisitViewController: appointmentStatusDelegate {
    func appointmentStatusUpdate(sender: Bool) {
        callToConfirm = sender
    }
}
