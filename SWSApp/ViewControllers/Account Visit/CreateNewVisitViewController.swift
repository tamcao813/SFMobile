//
//  CreateNewVisitViewController.swift
//  SWSApp
//
//  Created by manu.a.gupta on 08/05/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit
import DropDown
import IQKeyboardManagerSwift

class CreateNewVisitViewController: UIViewController {

    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var accountsDropdown: DropDown!
    var contactsDropdown: DropDown!
    var isEditingMode = false
    var searchAccountTextField: UITextField!
    var contactsAccountTextField: UITextField!
    var selectedAccount: Account!
    var selectedContact: Contact!
    var visitId: String!
    var visitObject: Visit?
    
    struct createNewVisitViewControllerGlobals {
        static var userInput = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeNibs()
        customizedUI()
        fetchVisit()
        IQKeyboardManager.shared.enable = true
    }
    
    deinit {
        IQKeyboardManager.shared.enable = false
    }
    
    func fetchVisit(){
        if let id = visitId{
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

}

extension CreateNewVisitViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
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
            searchAccountTextField = cell?.searchContactTextField
            accountsDropdown = cell?.contactDropDown
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
            if let visit = visitObject {
                cell?.schedulerComponentView.dateTextField.text = self.getDate(stringDate: visit.startDate)
                cell?.schedulerComponentView.startTimeTextField.text = self.getTime(stringDate: visit.startDate)
                cell?.schedulerComponentView.endTimeTextField.text = self.getTime(stringDate: visit.endDate)
//                cell?.layoutIfNeeded()
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
        let dateDate = dateFormatter.date(from: stringDate)
        if dateDate != nil {
            dateFormatter.dateFormat = "yyyy-MM-dd"
            return dateFormatter.string(from: dateDate!)
        }
        return ""
    }
    
    
    
    func getTime(stringDate: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000+0000"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let date = dateFormatter.date(from: stringDate)
        
        if date != nil {
            dateFormatter.dateFormat = "HH:mm a"
            dateFormatter.amSymbol = "AM"
            dateFormatter.pmSymbol = "PM"
            return dateFormatter.string(from: date!)
        }
        return ""
    }
}

extension CreateNewVisitViewController: SearchAccountTableViewCellDelegate {
    func accountSelected(account : Account) {
        selectedAccount = account
        reloadTableView()
    }
}

extension CreateNewVisitViewController: AccountContactLinkTableViewCellDelegate {
    func removeAccount() {
        selectedAccount = nil
        reloadTableView()
    }
}

extension CreateNewVisitViewController: SearchForContactTableViewCellDelegate {
    func contactSelected(contact: Contact) {
        selectedContact = contact
        reloadTableView()
    }
}

extension CreateNewVisitViewController: ContactVisitLinkTableViewCellDelegate {
    func removeContact(){
        selectedContact = nil
        reloadTableView()
    }
}
