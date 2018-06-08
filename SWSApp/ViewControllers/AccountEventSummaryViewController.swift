//
//  AccountEventViewController.swift
//  SWSApp
//
//  Created by vipin.vijay on 21/05/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation
import UIKit
import SmartSync

class AccountEventSummaryViewController: UIViewController {
    
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
    
    var visitStatus: AccountVisitStatus?
    var delegate : NavigateToContactsDelegate?
    var visitId: String?
    var accountObject: Account?
    var selectedContact: Contact!
    var visitObject: WorkOrderUserObject?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.refreshVisit), name: NSNotification.Name("refreshAccountVisitList"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.navigateToAccountScreen), name: NSNotification.Name("navigateToAccountScreen"), object: nil)
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchVisit()
        initializingXIBs()
    }
    
    @objc func refreshVisit(){
        fetchVisit()
    }
    
    @objc func navigateToAccountScreen(){
        DispatchQueue.main.async {
            FilterMenuModel.selectedAccountId = (self.accountObject?.account_Id)!
            self.dismiss(animated: false, completion: nil)
            self.delegate?.navigateToAccountScreen()
        }
    }
    
    
    func fetchVisit(){
        if let id = visitId{
            let visitArray = VisitsViewModel().visitsForUser()
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
                    break
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
        tableView.reloadData()
        let image = #imageLiteral(resourceName: "delete").withRenderingMode(.alwaysTemplate)
        deleteVisitButton.setImage(image, for: .normal)
        deleteVisitButton.tintColor = UIColor(hexString: "#4287C2")
        deleteVisitButton.setTitle("    Delete Event", for: .normal)
        self.getStartDateAndEndTime()
    }
    
    func getStartDateAndEndTime() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000+0000"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        guard let visitStartDateString = visitObject?.startDate else {
            //TODO: handle it in better way, Ideally visitObject.startDate should never be null
            return
        }
        
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
        self.tableView.register(UINib(nibName: "ButtonTableViewCell", bundle: nil), forCellReuseIdentifier: "ButtonTableViewCell")
        self.tableView.register(UINib(nibName: "EventDescriptionTableViewCell", bundle: nil), forCellReuseIdentifier: "EventDescriptionTableViewCell")
        self.tableView.register(UINib(nibName: "EventLocationTableViewCell", bundle: nil), forCellReuseIdentifier: "EventLocationTableViewCell")
    }
    
    @IBAction func deleteVisitButtonTapped(_ sender: UIButton){
        
        AlertUtilities.showAlertMessageWithTwoActionsAndHandler("Event Delete", errorMessage: StringConstants.deleteConfirmation, errorAlertActionTitle: "Delete", errorAlertActionTitle2: "Cancel", viewControllerUsed: self, action1: {
            
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
            
            if(success){
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshAccountOverView"), object:nil)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshAccountVisitList"), object:nil)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "REFRESH_MONTH_CALENDAR"), object:nil)
                
                self.dismiss(animated: true, completion: nil)
            }
        }) {
            
            print("Cancel")
        }
        
    }
    
    
    @IBAction func editVisitOrNotesButtonTapped(_ sender: UIButton){
        
        PlanVisitManager.sharedInstance.editPlanVisit = true
        let createEventViewController = UIStoryboard(name: "CreateEvent", bundle: nil).instantiateViewController(withIdentifier :"CreateNewEventViewController") as! CreateNewEventViewController
        
        createEventViewController.isEditingMode = true
        
        createEventViewController.selectedAccount = accountObject
        createEventViewController.selectedContact = selectedContact
        createEventViewController.eventWorkOrderObject = visitObject
        
        //createEventViewController.visitId = visitObject?.Id
        
        DispatchQueue.main.async {
            self.present(createEventViewController, animated: true)
            createEventViewController.pageHeaderLabel.text = "Edit Event"
        }
        
    }
    
    @IBAction func closeButtonTapped(_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension AccountEventSummaryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 30
        case 1:
            return 30
        case 2:
            return 30
        case 3:
            return 30
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 20
        case 1:
            return 20
        case 2:
            return 20
        case 3:
            return 50
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UINib(nibName: "AccountVisitSectionHeaderView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as? AccountVisitSectionHeaderView
        footerView?.headerLabel.text = ""
        return footerView
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UINib(nibName: "AccountVisitSectionHeaderView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as? AccountVisitSectionHeaderView
        
        if  section == 0 {
            headerView?.headerLabel.font = UIFont(name: (headerView?.headerLabel.font.fontName)!, size: 24)
            headerView?.headerLabel.text = getHeaderValuesInProgress(section: section)
        } else {
            headerView?.headerLabel.font = UIFont(name: (headerView?.headerLabel.font.fontName)!, size: 20)
            headerView?.headerLabel.text = getHeaderValuesInProgress(section: section)
        }
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        switch indexPath.section {
        case 0:
            return 100
        case 1:
            return 100
        case 2:
            return 30
        case 3:
            return 80
        default:
            return 0
        }
    }
    
    func getHeaderValuesInProgress(section: Int) -> String{
        var headerValue = ""
        if section == 0 {
            headerValue = (visitObject?.subject)!
        }else if section == 1 {
            headerValue = "Account"
        } else if section == 2 {
            headerValue = "Location"
        } else if section == 3 {
            headerValue = "Contact"
        }
        return headerValue
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return getInprogressStateCell(section: indexPath.section)
    }
    
    func getInprogressStateCell(section: Int) -> UITableViewCell{
        switch section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "EventDescriptionTableViewCell") as? EventDescriptionTableViewCell
            let text = visitObject?.description
            let attributedString = NSMutableAttributedString(string:text!)
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 10
            attributedString.addAttribute(NSAttributedStringKey.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
            cell?.descLabel.attributedText = attributedString;
            return cell!
        case 1:
            return getLocationCell()
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "EventLocationTableViewCell") as? EventLocationTableViewCell
            let text = visitObject?.location
            let attributedString = NSMutableAttributedString(string:text!)
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 5
            attributedString.addAttribute(NSAttributedStringKey.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
            cell?.label.attributedText = attributedString;
            return cell!
        case 3:
            return getConatactCell()
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
    
    func getConatactCell() -> AssociatedContactsTableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "AssociatedContactsTableViewCell") as? AssociatedContactsTableViewCell
        
        if let contactId = selectedContact, contactId.contactId != "" {
            cell?.containerHeightConstraint.constant = 80
            cell?.containerView.isHidden = false
            cell?.displayCellContent(contact: contactId)
        }else{
            cell?.containerHeightConstraint.constant = 0
            cell?.containerView.isHidden = true
        }
        return cell!
    }
}

extension AccountEventSummaryViewController: ButtonTableViewCellDelegate {
    func accountStrategyButtonTapped() {
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Strategy", bundle: nil)
        let vc: AccountStrategyViewController = storyboard.instantiateViewController(withIdentifier: "AccountStrategyViewControllerID") as! AccountStrategyViewController
        StrategyScreenLoadFrom.isLoadFromStrategy = "1"
        
        AccountId.selectedAccountId = (accountObject?.account_Id)!
        
        (vc as AccountStrategyViewController).modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.present(vc, animated: true, completion: nil)
        
    }
}

//MARK:- NavigateToContacts Delegate
extension AccountEventSummaryViewController : NavigateToAccountVisitSummaryDelegate , NavigateToAccountAccountVisitSummaryDelegate{
    
    func navigateToAccountVisitingScreen() {
        DispatchQueue.main.async {
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    func NavigateToAccountVisitSummary(data: LoadThePersistantMenuScreen) {
        DispatchQueue.main.async {
            self.dismiss(animated: false, completion: nil)
            self.delegate?.navigateTheScreenToContactsInPersistantMenu(data: data)
        }
        
        
    }
    
    func navigateToAccountVisitSummaryScreen() {
        DispatchQueue.main.async {
       //     AlertUtilities.showAlertMessageWithTwoActionsAndHandler("Any changes will not be saved", errorMessage: "Are you sure you want to close?", errorAlertActionTitle: "Yes", errorAlertActionTitle2: "No", viewControllerUsed: self, action1: {
                FilterMenuModel.selectedAccountId = (self.accountObject?.account_Id)!
                self.dismiss(animated: true, completion: nil)
                self.delegate?.navigateToAccountScreen()
          //  }){
                
            }
        }
   // }
}

