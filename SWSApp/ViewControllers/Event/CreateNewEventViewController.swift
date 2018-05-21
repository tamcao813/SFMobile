//
//  CreateNewEventViewController.swift
//  SWSApp
//
//  Created by manu.a.gupta on 21/05/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

struct CreateNewEventViewControllerGlobals {
    static var userInput = false
}

class CreateNewEventViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pageHeaderLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    var eventTitleTextField: UITextField!
    var searchAccountTextField: UITextField!
    var searchContactTextField: UITextField!
    var eventDescriptionTextView: UITextView!
    var locationTextField: UITextField!
    var accountsDropdown: DropDown!
    var contactsDropdown: DropDown!
    var isEditingMode = false
    var selectedAccount: Account!
    var selectedContact: Contact!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizedUI()
        initializeNibs()
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
            createNewEvent()
        }
    }
    
    func allFieldsAreValidated() -> Bool{
        if ((eventTitleTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)) != nil){
            eventTitleTextField.borderColor = UIColor(patternImage: UIImage(named: "Bad")!)
            eventTitleTextField.becomeFirstResponder()
            errorLabel.text = StringConstants.emptyFieldError
            tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            return false
        }
        
        if selectedAccount != nil{
            searchAccountTextField.borderColor = .red
//            tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            errorLabel.text = StringConstants.emptyFieldError
            return false
        }
        return true
    }
    
    func createNewEvent(){
//        var newContact = Contact(for: "NewContact")
    }
    
}


extension CreateNewEventViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            if selectedAccount != nil {
                return 1
            }
            return 0
        case 3:
            return 1
        case 4:
            if selectedContact != nil {
                return 1
            }
            return 0
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "ActionItemTitleTableViewCell") as? ActionItemTitleTableViewCell
            eventTitleTextField = cell?.actionTitleTextField
            cell?.actionHeaderLabel.text = "Title*"
            cell?.actionTitleTextField.placeholder = "Enter Title"
            return cell!
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SearchAccountTableViewCell") as? SearchAccountTableViewCell
            searchAccountTextField = cell?.searchContactTextField
            accountsDropdown = cell?.accountsDropDown
            cell?.delegate = self
            return cell!
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DropDownCell") as? AccountContactLinkTableViewCell
            cell?.containerTrailingConstraint.constant = 40
            cell?.containerLeadingConstraint.constant = 40
            cell?.delegate = self
            if let account = selectedAccount {
                cell?.displayCellContent(account: account)
            }
            return cell!
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SearchForContactTableViewCell") as? SearchForContactTableViewCell
            searchContactTextField = cell?.searchContactTextField
            contactsDropdown = cell?.contactDropDown
            cell?.delegate = self
            return cell!
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ViewContactLinkToVisitTableViewCell") as? ViewContactLinkToVisitTableViewCell
            cell?.delegate = self
            if let contact = selectedContact {
                cell?.displayCellContent(contact: contact)
            }
            return cell!
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ActionItemTitleTableViewCell") as? ActionItemTitleTableViewCell
            locationTextField = cell?.actionTitleTextField
            cell?.actionHeaderLabel.text = "Location"
            cell?.actionTitleTextField.placeholder = "Enter Location"
            return cell!
        case 6:
            return getEventDescriptionCell()
        default:
            return UITableViewCell()
        }
    }
    
    func getEventDescriptionCell() -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionTableViewCell") as? DescriptionTableViewCell
        cell?.headerLabel.text = "Event Description"
        eventDescriptionTextView = cell?.descriptionTextView
        return cell!
    }
}

extension CreateNewEventViewController: SearchAccountTableViewCellDelegate {
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

