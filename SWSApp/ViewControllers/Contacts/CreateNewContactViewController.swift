//
//  CreateNewContactViewController.swift
//  SWSApp
//
//  Created by Krishna, Kamya on 4/25/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
protocol CreateNewContactViewControllerDelegate : NSObjectProtocol{
    func updateContactList()
}

class CreateNewContactViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pageHeaderLabel: UILabel!
    var searchAccountTextField: UITextField!
    var firstNameTextField: UITextField!
    var lastNameTextField: UITextField!
    var preferredNameTextField: UITextField!
    var contactClassificationTextField: UITextField!
    var otherReasonTextField: UITextField!
    var primaryFunctionTextField: UITextField!
    var titleTextField: UITextField!
    var departmentTextField: UITextField!
    var phoneTextField: UITextField!
    var faxTextField: UITextField!
    var emailTextField: UITextField!
    var contactHoursTextField: UITextField!
    var preferredCommunicationTextField: UITextField!
    var birthdayTextField: UITextField!
    var anniversaryTextField: UITextField!
    var likeTextView: UITextView!
    var dislikeTextView: UITextView!
    var notesTextView: UITextView!
    var familyName1Textfield: UITextField!
    var familyName2Textfield: UITextField!
    var familyName3Textfield: UITextField!
    var familyName4Textfield: UITextField!
    var familyName5Textfield: UITextField!
    var familyDate1Textfield: UITextField!
    var familyDate2Textfield: UITextField!
    var familyDate3Textfield: UITextField!
    var familyDate4Textfield: UITextField!
    var familyDate5Textfield: UITextField!
    @IBOutlet weak var headingLabel: UITextField!
    var doesHaveBuyingPower: Bool = false
    weak var delegate: CreateNewContactViewControllerDelegate!
    var isNewContact: Bool = true
    var contactDetail: Contact?
    var accountSelected : Account!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizedUI()
        initializingXIBs()
        IQKeyboardManager.shared.enable = true
    }
    
    deinit {
        IQKeyboardManager.shared.enable = false
    }
    
    func customizedUI(){
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        self.tableView.estimatedRowHeight = 100
        if isNewContact {
            pageHeaderLabel.text = "New Contact"
        }else{
            pageHeaderLabel.text = "Edit Personal Details"
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func initializingXIBs(){
        self.tableView.register(UINib(nibName: "SearchAccountTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchAccountTableViewCell")
        
        self.tableView.register(UINib(nibName: "ToggleTableViewCell", bundle: nil), forCellReuseIdentifier: "ToggleTableViewCell")
        
        self.tableView.register(UINib(nibName: "ContactClassificationTableViewCell", bundle: nil), forCellReuseIdentifier: "ContactClassificationTableViewCell")
        
        self.tableView.register(UINib(nibName: "NameTableViewCell", bundle: nil), forCellReuseIdentifier: "NameTableViewCell")
        
        self.tableView.register(UINib(nibName: "PrimaryFunctionTableViewCell", bundle: nil), forCellReuseIdentifier: "PrimaryFunctionTableViewCell")
        
        self.tableView.register(UINib(nibName: "PhoneTableViewCell", bundle: nil), forCellReuseIdentifier: "PhoneTableViewCell")
        
        self.tableView.register(UINib(nibName: "EmailTableViewCell", bundle: nil), forCellReuseIdentifier: "EmailTableViewCell")
        
        self.tableView.register(UINib(nibName: "ContactHoursTableViewCell", bundle: nil), forCellReuseIdentifier: "ContactHoursTableViewCell")
        
        self.tableView.register(UINib(nibName: "DescriptionTableViewCell", bundle: nil), forCellReuseIdentifier: "DescriptionTableViewCell")
        
        self.tableView.register(UINib(nibName: "DropdownTableViewCell", bundle: nil), forCellReuseIdentifier: "DropdownTableViewCell")
        
        self.tableView.register(UINib(nibName: "DateFieldTableViewCell", bundle: nil), forCellReuseIdentifier: "DateFieldTableViewCell")
        
        self.tableView.register(UINib(nibName: "FamilyTableViewCell", bundle: nil), forCellReuseIdentifier: "FamilyTableViewCell")
        
        self.tableView.register(UINib(nibName: "AccountContactLinkTableViewCell", bundle: nil), forCellReuseIdentifier: "DropDownCell")
        
    }
    
    @IBAction func closeButtonTapped(_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton){
        var showAlert = false
        firstNameTextField.borderColor = .lightGray
        lastNameTextField.borderColor = .lightGray
        primaryFunctionTextField.borderColor = .lightGray
        phoneTextField.borderColor = .lightGray
        birthdayTextField.borderColor = .lightGray
        anniversaryTextField.borderColor = .lightGray
        if isNewContact {
            searchAccountTextField.borderColor = .lightGray
        }
        
        if isNewContact && !doesHaveBuyingPower{
            otherReasonTextField.borderColor = .lightGray
        }
        
        
        //need to check an account has been selected for this contact - UI needs to get the account name from the dropdown and then get get it's accountId - better yet, the dropDown has both Acconut name and Id
        if isNewContact && accountSelected == nil {
            showAlert = true
            searchAccountTextField.borderColor = .red
            tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        }else if isNewContact && !doesHaveBuyingPower && contactClassificationTextField.text == "Other"{
            if (otherReasonTextField.text?.isEmpty)! {
                otherReasonTextField.borderColor = .red
                otherReasonTextField.becomeFirstResponder()
                tableView.scrollToRow(at: IndexPath(row: 2, section: 0), at: .top, animated: true)
                showAlert = true
            }
        }else if (firstNameTextField.text?.isEmpty)! {
            firstNameTextField.borderColor = .red
            firstNameTextField.becomeFirstResponder()
            tableView.scrollToRow(at: IndexPath(row: 0, section: 3), at: .top, animated: true)
            showAlert = true
        } else if (lastNameTextField.text?.isEmpty)! {
            lastNameTextField.borderColor = .red
            lastNameTextField.becomeFirstResponder()
            tableView.scrollToRow(at: IndexPath(row: 0, section: 3), at: .top, animated: true)
            showAlert = true
        }else if (primaryFunctionTextField.text?.isEmpty)! {
            primaryFunctionTextField.borderColor = .red
            primaryFunctionTextField.becomeFirstResponder()
            tableView.scrollToRow(at: IndexPath(row: 1, section: 3), at: .top, animated: true)
            showAlert = true
        }else{
            showAlert = false
        }
        
        if showAlert {
            let alertController = UIAlertController(title: "Alert", message:
                "Please enter required fields", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default,handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }else{
            createContactLocally()
        }
    }
    
    func createContactLocally(){
        let newContact = Contact(for: "NewContact")
        if isNewContact {
            newContact.contactId = ""
        }
        else {
            newContact.contactId = (contactDetail?.contactId)!
        }
        newContact.buyerFlag = doesHaveBuyingPower
        newContact.firstName = firstNameTextField.text!
        newContact.lastName = lastNameTextField.text!
        newContact.preferredName = preferredNameTextField.text!
        newContact.functionRole = primaryFunctionTextField.text!
        newContact.title = titleTextField.text!
        newContact.department = departmentTextField.text!
        newContact.phoneNumber = phoneTextField.text!
        newContact.email = emailTextField.text!
        newContact.contactHours = contactHoursTextField.text!
        
        newContact.preferredCommunicationMethod = (preferredCommunicationTextField.text! == "Select One") ? "" : preferredCommunicationTextField.text!
        
        newContact.birthDate = (birthdayTextField.text! == "Select") ? "" : birthdayTextField.text!
        
        newContact.anniversary = (anniversaryTextField.text! == "Select") ? "" : anniversaryTextField.text!
        
        newContact.child1Name = familyName1Textfield.text!
        newContact.child1Birthday = (familyDate1Textfield.text! == "Select") ? "" : familyDate1Textfield.text!
        
        newContact.child2Name = familyName2Textfield.text!
        newContact.child2Birthday = (familyDate2Textfield.text! == "Select") ? "" : familyDate2Textfield.text!
        
        newContact.child3Name = familyName3Textfield.text!
        newContact.child2Birthday = (familyDate3Textfield.text! == "Select") ? "" : familyDate3Textfield.text!
        
        newContact.child4Name = familyName4Textfield.text!
        newContact.child4Birthday = (familyDate4Textfield.text! == "Select") ? "" : familyDate4Textfield.text!
        
        newContact.child5Name = familyName5Textfield.text!
        newContact.child5Birthday = (familyDate5Textfield.text! == "Select") ? "" : familyDate5Textfield.text!
        
        newContact.likes = likeTextView.text!
        newContact.dislikes = dislikeTextView.text!
        newContact.sgwsNotes = notesTextView.text!
        newContact.fax = faxTextField.text!
        if isNewContact {
            newContact.contactClassification = contactClassificationTextField.text!
            //            newContact.otherSpecification = otherReasonTextField.text!
            newContact.accountId = accountSelected.account_Id
        }
        else {
            newContact.accountId = (contactDetail?.accountId)!
        }
        var success: Bool!
        if isNewContact {
            success = ContactsViewModel().createNewContactToSoup(object: newContact)
            let arcSuccess = ContactsViewModel().createARCDictionary(contactObject: newContact, accountObject: accountSelected)
        }else{
            success = ContactsViewModel().editNewContactToSoup(object: newContact)
        }
        
        //sync up to Contact which will update ACR, then for now we need to sync down ACR
        if success {
            self.dismiss(animated: true, completion: {
                self.delegate.updateContactList()
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshAccounts"), object:nil)
            })
        }
    }
}

extension CreateNewContactViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            if isNewContact {
                return 1
            }else{
                return 0
            }
        case 1:
            if isNewContact {
                if accountSelected != nil {
                    return 1 //accountSelected.count
                }else{
                    return 0
                }
            }else{
                return 0
            }
        case 2:
            if isNewContact {
                if doesHaveBuyingPower {
                    return 1
                }else{
                    return 2
                }
            }else{
                return 0
            }            
        case 3:
            return 8
        case 4:
            return 8
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SearchAccountTableViewCell") as? SearchAccountTableViewCell
            searchAccountTextField = cell?.searchContactTextField
            cell?.delegate = self
            return cell!
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DropDownCell") as? AccountContactLinkTableViewCell
            cell?.containerTrailingConstraint.constant = 40
            cell?.containerLeadingConstraint.constant = 40
            cell?.delegate = self
            if let account = accountSelected {
                cell?.displayCellContent(account: account)
            }
            return cell!
        case 2:
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "ToggleTableViewCell") as? ToggleTableViewCell
                cell?.delegate = self
                return cell!
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "ContactClassificationTableViewCell") as? ContactClassificationTableViewCell
                contactClassificationTextField = cell?.classificationTextField
                otherReasonTextField = cell?.otherTextField
                return cell!
            default:
                return UITableViewCell()
            }
        case 3:
            return getPersonalDetailsCells(indexPath: indexPath)
        case 4:
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "FamilyTableViewCell") as? FamilyTableViewCell
                familyDate1Textfield = cell?.dateTextField
                familyName1Textfield = cell?.nameTextField
                if let childName = contactDetail?.child1Name, childName != "" {
                    cell?.nameTextField.text = childName
                }
                
                if let childDate = contactDetail?.child1Birthday, childDate != "" {
                    cell?.dateTextField.text = childDate
                }
                return cell!
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "FamilyTableViewCell") as? FamilyTableViewCell
                cell?.familyLabelHeightConstraint.constant = 0
                cell?.dateLabelHeightConstraint.constant = 0
                cell?.nameLabelHeightConstraint.constant = 0
                familyDate2Textfield = cell?.dateTextField
                familyName2Textfield = cell?.nameTextField
                if let childName = contactDetail?.child2Name, childName != "" {
                    cell?.nameTextField.text = childName
                }
                
                if let childDate = contactDetail?.child2Birthday, childDate != "" {
                    cell?.dateTextField.text = childDate
                }
                return cell!
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: "FamilyTableViewCell") as? FamilyTableViewCell
                cell?.familyLabelHeightConstraint.constant = 0
                cell?.dateLabelHeightConstraint.constant = 0
                cell?.nameLabelHeightConstraint.constant = 0
                familyDate3Textfield = cell?.dateTextField
                familyName3Textfield = cell?.nameTextField
                if let childName = contactDetail?.child3Name, childName != "" {
                    cell?.nameTextField.text = childName
                }
                
                if let childDate = contactDetail?.child3Birthday, childDate != "" {
                    cell?.dateTextField.text = childDate
                }
                return cell!
            case 3:
                let cell = tableView.dequeueReusableCell(withIdentifier: "FamilyTableViewCell") as? FamilyTableViewCell
                cell?.familyLabelHeightConstraint.constant = 0
                cell?.dateLabelHeightConstraint.constant = 0
                cell?.nameLabelHeightConstraint.constant = 0
                familyDate4Textfield = cell?.dateTextField
                familyName4Textfield = cell?.nameTextField
                if let childName = contactDetail?.child4Name, childName != "" {
                    cell?.nameTextField.text = childName
                }
                
                if let childDate = contactDetail?.child4Birthday, childDate != "" {
                    cell?.dateTextField.text = childDate
                }
                return cell!
            case 4:
                let cell = tableView.dequeueReusableCell(withIdentifier: "FamilyTableViewCell") as? FamilyTableViewCell
                cell?.familyLabelHeightConstraint.constant = 0
                cell?.dateLabelHeightConstraint.constant = 0
                cell?.nameLabelHeightConstraint.constant = 0
                familyDate5Textfield = cell?.dateTextField
                familyName5Textfield = cell?.nameTextField
                if let childName = contactDetail?.child5Name, childName != "" {
                    cell?.nameTextField.text = childName
                }
                
                if let childDate = contactDetail?.child5Birthday, childDate != "" {
                    cell?.dateTextField.text = childDate
                }
                return cell!
            case 5:
                let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionTableViewCell") as? DescriptionTableViewCell
                cell?.headerLabel.text = "Likes"
                likeTextView = cell?.descriptionTextView
                if let likes = contactDetail?.likes, likes != "" {
                    cell?.descriptionTextView.text = likes
                }
                return cell!
            case 6:
                let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionTableViewCell") as? DescriptionTableViewCell
                cell?.headerLabel.text = "Dislikes"
                dislikeTextView = cell?.descriptionTextView
                if let dislikes = contactDetail?.dislikes, dislikes != "" {
                    cell?.descriptionTextView.text = dislikes
                }
                return cell!
            case 7:
                let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionTableViewCell") as? DescriptionTableViewCell
                cell?.headerLabel.text = "Notes"
                notesTextView = cell?.descriptionTextView
                if let notes = contactDetail?.sgwsNotes, notes != "" {
                    cell?.descriptionTextView.text = notes
                }
                return cell!
            default:
                return UITableViewCell()
            }
        default:
            return UITableViewCell()
        }
    }
    
    func getPersonalDetailsCells(indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "NameTableViewCell") as? NameTableViewCell
            firstNameTextField = cell?.firstNameTextField
            lastNameTextField = cell?.lastNameTextField
            preferredNameTextField = cell?.preferredNameTextField
            if let contactDetail = contactDetail {
                cell?.displayCellContent(contactDetail: contactDetail)
            }
            return cell!
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PrimaryFunctionTableViewCell") as? PrimaryFunctionTableViewCell
            if let contactDetail = contactDetail {
                cell?.displayCellContent(contactDetail: contactDetail)
            }
            departmentTextField = cell?.departmentTextField
            titleTextField = cell?.titleTextField
            primaryFunctionTextField = cell?.primaryFunctionTextField
            return cell!
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PhoneTableViewCell") as? PhoneTableViewCell
            phoneTextField = cell?.phoneTextField
            faxTextField = cell?.faxTextField
            
            if let contactDetail = contactDetail {
                cell?.displayCellContent(contactDetail: contactDetail)
            }
            return cell!
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "EmailTableViewCell") as? EmailTableViewCell
            emailTextField = cell?.emailTextField
            if let contactDetail = contactDetail {
                cell?.displayCellContent(contactDetail: contactDetail)
            }
            return cell!
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ContactHoursTableViewCell") as? ContactHoursTableViewCell
            contactHoursTextField = cell?.contactHoursTextField
            if let contactDetail = contactDetail {
                cell?.displayCellContent(contactDetail: contactDetail)
            }
            return cell!
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DropdownTableViewCell") as? DropdownTableViewCell
            preferredCommunicationTextField = cell?.dropdownTextfield
            if let preferredCommunicationMethod = contactDetail?.preferredCommunicationMethod, preferredCommunicationMethod != ""{
                cell?.dropdownTextfield.text = preferredCommunicationMethod
            }
            return cell!
        case 6:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DateFieldTableViewCell") as? DateFieldTableViewCell
            cell?.headerLabel.text = "Birthday"
            birthdayTextField = cell?.dateTextfield
            if let birthDate = contactDetail?.birthDate, birthDate != "" {
                cell?.dateTextfield.text = birthDate
            }
            return cell!
        case 7:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DateFieldTableViewCell") as? DateFieldTableViewCell
            cell?.headerLabel.text = "Anniversary"
            anniversaryTextField = cell?.dateTextfield
            if let anniversaryDate = contactDetail?.anniversary, anniversaryDate != "" {
                cell?.dateTextfield.text = anniversaryDate
            }
            return cell!
        default:
            return UITableViewCell()
        }
    }
}

extension CreateNewContactViewController: ToggleTableViewCellDelegate {
    func buyingPowerChanged(buyingPower: Bool) {
        doesHaveBuyingPower = buyingPower
        self.tableView.reloadData()
    }
}

extension CreateNewContactViewController: SearchAccountTableViewCellDelegate {
    func accountSelected(account : Account) {
        accountSelected = account
        tableView.reloadData()
    }
}

extension CreateNewContactViewController: AccountContactLinkTableViewCellDelegate {
    func removeAccount() {
        accountSelected = nil
        tableView.reloadData()
    }
}
