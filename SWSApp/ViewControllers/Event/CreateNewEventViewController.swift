//
//  CreateNewEventViewController.swift
//  SWSApp
//
//  Created by manu.a.gupta on 21/05/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import SmartSync

struct CreateNewEventViewControllerGlobals {
    static var userInput = false
    
    static var eventTitle = ""
    static var startDate = ""
    static var endDate = ""
    static var startTime = ""
    static var endTime = ""
    static var allDayEventSelected = false
    static var location = ""
    static var description = ""
    
    static var isFirstTimeLoad = true
    static var isAccountOrContactClicked = false
    
    
}

class CreateNewEventViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pageHeaderLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    
    var eventTitleTextField: UITextField!
    var startDateTextField: UITextField!
    var endDateTextField : UITextField!
    var startTimeTextField : UITextField!
    var endTimeTextField : UITextField!
    var searchAccountTextField: UITextField!
    var searchContactTextField: UITextField!
    var eventDescriptionTextView: UITextView!
    var locationTextField: UITextField!
    var accountsDropdown: DropDown!
    var contactsDropdown: DropDown!
    var isEditingMode = false
    
    var selectedAccount: Account!
    var selectedContact: Contact!
    var eventWorkOrderObject: WorkOrderUserObject!
    
    var visitViewModel = VisitSchedulerViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizedUI()
        initializeNibs()
        IQKeyboardManager.shared.enable = true
        self.clearModelForNewEntry()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func clearModelForNewEntry(){
        CreateNewEventViewControllerGlobals.eventTitle = ""
        CreateNewEventViewControllerGlobals.startDate = ""
        CreateNewEventViewControllerGlobals.endDate = ""
        CreateNewEventViewControllerGlobals.startTime = ""
        CreateNewEventViewControllerGlobals.endTime = ""
        CreateNewEventViewControllerGlobals.location = ""
        CreateNewEventViewControllerGlobals.description = ""
        CreateNewEventViewControllerGlobals.isFirstTimeLoad = true
    }
    
    func customizedUI(){
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        self.tableView.estimatedRowHeight = 100
    }
    
    func initializeNibs() {
        self.tableView.register(UINib(nibName: "ActionItemTitleTableViewCell", bundle: nil), forCellReuseIdentifier: "ActionItemTitleTableViewCell")
        self.tableView.register(UINib(nibName: "SearchAccountTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchAccountTableViewCell")
        self.tableView.register(UINib(nibName: "AccountContactLinkTableViewCell", bundle: nil), forCellReuseIdentifier: "DropDownCell")
        self.tableView.register(UINib(nibName: "SearchForContactTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchForContactTableViewCell")
        self.tableView.register(UINib(nibName: "ViewContactLinkToVisitTableViewCell", bundle: nil), forCellReuseIdentifier: "ViewContactLinkToVisitTableViewCell")
        self.tableView.register(UINib(nibName: "DescriptionTableViewCell", bundle: nil), forCellReuseIdentifier: "DescriptionTableViewCell")
        self.tableView.register(UINib(nibName: "EventStartEndDateTableViewCell", bundle: nil), forCellReuseIdentifier: "EventStartEndDateTableViewCell")
        
    }
    
    func reloadTableView(){
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
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
            if  CreateNewEventViewControllerGlobals.userInput {
                AlertUtilities.showAlertMessageWithTwoActionsAndHandler("Any changes will not be saved", errorMessage: "Are you sure you want to close?", errorAlertActionTitle: "Yes", errorAlertActionTitle2: "No", viewControllerUsed: self, action1: {
                    self.dismiss(animated: true, completion: nil)
                    CreateNewEventViewControllerGlobals.userInput = false
                }){
                    
                }
            }else{
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton){
        if allFieldsAreValidated() {
            if isEditingMode{
                
                if PlanVisitManager.sharedInstance.visit != nil {
                    editCurrentEvent()
                    DispatchQueue.main.async {
                        self.dismiss(animated: true)
                    }
                }
                
            }else{
                
                createNewEvent()
            }
        }
    }
    
    @objc func keyboardWillShow(_ notification:Notification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if CreateNewEventViewControllerGlobals.isAccountOrContactClicked {
                self.tableView.contentInset = UIEdgeInsetsMake(0, 0, keyboardSize.height + 250, 0) }
        }
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        
        if let _ = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        }
    }
    
    func editCurrentEvent(){
        PlanVisitManager.sharedInstance.visit?.accountId = selectedAccount.account_Id
        if let contact = selectedContact {
            PlanVisitManager.sharedInstance.visit?.contactId = contact.contactId
        }else{
            PlanVisitManager.sharedInstance.visit?.contactId = ""
        }
        PlanVisitManager.sharedInstance.visit?.startDate =  getDataTimeinStr(date: CreateNewEventViewControllerGlobals.startDate, time: CreateNewEventViewControllerGlobals.startTime)
        PlanVisitManager.sharedInstance.visit?.endDate = getDataTimeinStr(date: CreateNewEventViewControllerGlobals.endDate, time: CreateNewEventViewControllerGlobals.endTime)
        //let status = PlanVisitManager.sharedInstance.editAndSaveVisit()
        PlanVisitManager.sharedInstance.visit?.recordTypeId = StoreDispatcher.shared.workOrderRecordTypeIdEvent
        
        PlanVisitManager.sharedInstance.visit?.subject = CreateNewEventViewControllerGlobals.eventTitle
        PlanVisitManager.sharedInstance.visit?.location = CreateNewEventViewControllerGlobals.location
        PlanVisitManager.sharedInstance.visit?.description = CreateNewEventViewControllerGlobals.description
        PlanVisitManager.sharedInstance.visit?.sgwsAlldayEvent = CreateNewEventViewControllerGlobals.allDayEventSelected
        
        let _ = PlanVisitManager.sharedInstance.editAndSaveVisit()
    }
    
    func allFieldsAreValidated() -> Bool{
        if ((eventTitleTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)) == ""){
            eventTitleTextField.borderColor = .red
            eventTitleTextField.becomeFirstResponder()
            errorLabel.text = StringConstants.emptyFieldError
            tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            return false
        }
        
        if CreateNewEventViewControllerGlobals.startDate == ""{
            self.startDateTextField.borderColor = .red
            self.errorLabel.text = StringConstants.emptyFieldError
            return false
        }
        
        if CreateNewEventViewControllerGlobals.startTime == ""{
            startTimeTextField.borderColor = .red
            errorLabel.text = StringConstants.emptyFieldError
            return false
        }
        
        if CreateNewEventViewControllerGlobals.endDate == ""{
            endDateTextField.borderColor = .red
            errorLabel.text = StringConstants.emptyFieldError
            return false
        }
        
        if CreateNewEventViewControllerGlobals.endTime == ""{
            endTimeTextField.borderColor = .red
            errorLabel.text = StringConstants.emptyFieldError
            return false
        }
        
        if selectedAccount == nil {
            searchAccountTextField.borderColor = .red
            errorLabel.text = StringConstants.emptyFieldError
            return false
        }
        
        return true
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
    
    
    func createNewEvent(){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        PlanVisitManager.sharedInstance.userID = (appDelegate.loggedInUser?.userId)!
        
        let new_Event = PlanVisit(for: "newEvent")
        
        //Get Current date and time
        let date = Date()
        print(date)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000+0000"
        let timeStamp = dateFormatter.string(from: date)
        
        //added the last modified App date and time
        new_Event.lastModifiedDate = timeStamp
        
        let localId = AlertUtilities.generateRandomIDForNewEntry()
        
        new_Event.Id = localId//self.generateRandomIDForVisit()
        new_Event.accountId = selectedAccount.account_Id
        if let contact = selectedContact {
            new_Event.contactId = contact.contactId
        }else{
            new_Event.contactId = ""
        }
        new_Event.startDate =  getDataTimeinStr(date: CreateNewEventViewControllerGlobals.startDate, time: CreateNewEventViewControllerGlobals.startTime)
        new_Event.endDate = getDataTimeinStr(date: CreateNewEventViewControllerGlobals.endDate, time: CreateNewEventViewControllerGlobals.endTime)
        
        new_Event.recordTypeId = StoreDispatcher.shared.workOrderRecordTypeIdEvent
        
        new_Event.subject = CreateNewEventViewControllerGlobals.eventTitle
        
        new_Event.description = CreateNewEventViewControllerGlobals.description
        
        new_Event.location = CreateNewEventViewControllerGlobals.location
        new_Event.sgwsAlldayEvent = CreateNewEventViewControllerGlobals.allDayEventSelected
        
        let attributeDict = ["type":"WorkOrder"]
        let addNewDict: [String:Any] = [
            
            PlanVisit.planVisitFields[0]    : new_Event.Id,
            PlanVisit.planVisitFields[10]   : new_Event.lastModifiedDate,
            PlanVisit.planVisitFields[2]    : new_Event.accountId,
            PlanVisit.planVisitFields[4]    : new_Event.startDate,
            PlanVisit.planVisitFields[1]    : new_Event.subject,
            PlanVisit.planVisitFields[5]    : new_Event.endDate,
            PlanVisit.planVisitFields[7]    : new_Event.description,
            PlanVisit.planVisitFields[11]   : new_Event.contactId,
            PlanVisit.planVisitFields[12]   : new_Event.recordTypeId,
            PlanVisit.planVisitFields[14]   : new_Event.location,
            PlanVisit.planVisitFields[15]   : new_Event.sgwsAlldayEvent,
            
            kSyncTargetLocal:true,
            kSyncTargetLocallyCreated:true,
            kSyncTargetLocallyUpdated:false,
            kSyncTargetLocallyDeleted:false,
            "attributes":attributeDict]
        
        //let (success,Id) = visitViewModel.createNewVisitLocally(fields: addNewDict)
        let (success,_) = visitViewModel.createNewVisitLocally(fields: addNewDict)
        
        if(success){
            let event = WorkOrderUserObject(for: "")
            //Add the soup entry Id
            event.Id = new_Event.Id//String((success,Id).1)
            event.accountId = new_Event.accountId
            event.contactId = new_Event.contactId
            event.startDate = new_Event.startDate
            event.endDate = new_Event.endDate
            event.description = new_Event.description
            event.lastModifiedDate = new_Event.lastModifiedDate
            event.recordTypeId = new_Event.recordTypeId
            event.subject = new_Event.subject
            event.location = new_Event.location
            event.sgwsAlldayEvent = new_Event.sgwsAlldayEvent
            
            PlanVisitManager.sharedInstance.visit = event
        }
        
        if(success){
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshCalendar"), object:nil)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshAccountVisitList"), object:nil)
            
            DispatchQueue.main.async {
                self.dismiss(animated: true)
            }
            //            else{
            //                let storyboard = UIStoryboard(name: "PlanVisitEditableScreen", bundle: nil)
            //                let viewController = storyboard.instantiateViewController(withIdentifier :"SelectOpportunitiesViewControllerID")
            //                DispatchQueue.main.async {
            //                    self.present(viewController, animated: true)
            //                }
            //            }
        }
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


extension CreateNewEventViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return 1
        case 3:
            if selectedAccount != nil {
                return 1
            }
            return 0
        case 4:
            return 1
        case 5:
            if selectedContact != nil {
                return 1
            }
            return 0
        case 6:
            return 1
        case 7:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ActionItemTitleTableViewCell") as? ActionItemTitleTableViewCell
            eventTitleTextField = cell?.actionTitleTextField
            cell?.actionHeaderLabel.text = "Title*"
            cell?.actionTitleTextField.placeholder = "Enter Title"
            cell?.actionTitleTextField.tag = indexPath.section
            
            if let eventObject = eventWorkOrderObject{
                
                if CreateNewEventViewControllerGlobals.isFirstTimeLoad == true{
                    cell?.actionTitleTextField.text = eventObject.subject
                    //Setting the model Data in Edit Mode
                    CreateNewEventViewControllerGlobals.eventTitle = eventObject.subject
                    
                }else{
                    
                    cell?.actionTitleTextField.text = CreateNewEventViewControllerGlobals.eventTitle
                }
            }
            
            return cell!
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "EventStartEndDateTableViewCell") as! EventStartEndDateTableViewCell
            startDateTextField = cell.eventStartDateTextField!
            endDateTextField = cell.eventEndDateTextField!
            startTimeTextField = cell.eventStartTimeTextField!
            endTimeTextField = cell.eventEndTimeTextField!
            
            if let eventObject = eventWorkOrderObject{
                
                //For the first Time Load as it will be False
                if CreateNewEventViewControllerGlobals.isFirstTimeLoad == true{
                    
                    cell.eventStartDateTextField.text = self.getDate(stringDate: eventObject.startDate)
                    cell.eventEndDateTextField.text = self.getDate(stringDate: eventObject.endDate)
                    cell.eventStartTimeTextField.text = self.getTime(stringDate: eventObject.startDate)
                    cell.eventEndTimeTextField.text = self.getTime(stringDate: eventObject.endDate)
                    
                    //Setting the model Data in Edit Mode
                    CreateNewEventViewControllerGlobals.startDate = self.getDate(stringDate: eventObject.startDate)
                    CreateNewEventViewControllerGlobals.endDate = self.getDate(stringDate: eventObject.endDate)
                    CreateNewEventViewControllerGlobals.startTime = self.getTime(stringDate: eventObject.startDate)
                    CreateNewEventViewControllerGlobals.endTime = self.getTime(stringDate: eventObject.endDate)
                    
                    if eventObject.sgwsAlldayEvent == true{
                        cell.btnAllDayEvent?.setImage(UIImage(named:"Checkbox Selected"), for: .normal)
                    }else{
                        cell.btnAllDayEvent?.setImage(UIImage(named:"Checkbox"), for: .normal)
                    }
                    
                }else{
                    
                    cell.eventStartDateTextField.text =  CreateNewEventViewControllerGlobals.startDate
                    cell.eventEndDateTextField.text = CreateNewEventViewControllerGlobals.endDate
                    cell.eventStartTimeTextField.text = CreateNewEventViewControllerGlobals.startTime
                    cell.eventEndTimeTextField.text = CreateNewEventViewControllerGlobals.endTime
                }
            }
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SearchAccountTableViewCell") as? SearchAccountTableViewCell
            searchAccountTextField = cell?.searchContactTextField
            accountsDropdown = cell?.accountsDropDown
            cell?.delegate = self
            return cell!
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DropDownCell") as? AccountContactLinkTableViewCell
            cell?.containerTrailingConstraint.constant = 40
            cell?.containerLeadingConstraint.constant = 40
            cell?.delegate = self
            if let account = selectedAccount {
                cell?.displayCellContent(account: account)
            }
            return cell!
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SearchForContactTableViewCell") as? SearchForContactTableViewCell
            searchContactTextField = cell?.searchContactTextField
            contactsDropdown = cell?.contactDropDown
            cell?.delegate = self
            return cell!
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ViewContactLinkToVisitTableViewCell") as? ViewContactLinkToVisitTableViewCell
            cell?.delegate = self
            if let contact = selectedContact {
                cell?.displayCellContent(contact: contact)
            }
            return cell!
        case 6:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ActionItemTitleTableViewCell") as? ActionItemTitleTableViewCell
            locationTextField = cell?.actionTitleTextField
            cell?.actionHeaderLabel.text = "Location"
            cell?.actionTitleTextField.placeholder = "Enter Location"
            cell?.actionTitleTextField.tag = indexPath.section
            
            if let eventObject = eventWorkOrderObject{
                
                if CreateNewEventViewControllerGlobals.isFirstTimeLoad == true{
                    cell?.actionTitleTextField.text = eventObject.location
                    CreateNewEventViewControllerGlobals.location = eventObject.location
                    
                }else{
                    cell?.actionTitleTextField.text = CreateNewEventViewControllerGlobals.location
                }
            }
            
            return cell!
        case 7:
            return getEventDescriptionCell()
        default:
            return UITableViewCell()
        }
    }
    
    func getEventDescriptionCell() -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionTableViewCell") as? DescriptionTableViewCell
        cell?.headerLabel.text = "Event Description"
        eventDescriptionTextView = cell?.descriptionTextView
        cell?.descriptionTextView.tag = 500
        
        if let eventObject = eventWorkOrderObject{
            
            if CreateNewEventViewControllerGlobals.isFirstTimeLoad == true{
                cell?.descriptionTextView.text = eventObject.description
                CreateNewEventViewControllerGlobals.description = eventObject.description
                
            }else{
                cell?.descriptionTextView.text = CreateNewEventViewControllerGlobals.description
            }
        }
        
        return cell!
        
    }
}

extension CreateNewEventViewController: SearchAccountTableViewCellDelegate {
    func scrollTableView() {
        
        
    }
    
    func accountSelected(account : Account) {
        CreateNewEventViewControllerGlobals.userInput = true
        selectedAccount = account
        reloadTableView()
    }
}

extension CreateNewEventViewController: AccountContactLinkTableViewCellDelegate {
    func removeAccount() {
        CreateNewEventViewControllerGlobals.userInput = true
        selectedAccount = nil
        reloadTableView()
    }
}

extension CreateNewEventViewController: SearchForContactTableViewCellDelegate {
    func contactSelected(contact: Contact) {
        CreateNewEventViewControllerGlobals.userInput = true
        selectedContact = contact
        reloadTableView()
    }
}

extension CreateNewEventViewController: ContactVisitLinkTableViewCellDelegate {
    func removeContact(){
        CreateNewEventViewControllerGlobals.userInput = true
        selectedContact = nil
        reloadTableView()
    }
}

