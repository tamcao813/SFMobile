//
//  CreateNewContactViewController.swift
//  SWSApp
//
//  Created by Krishna, Kamya on 4/25/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import SmartStore
import SmartSync
//import DropDown

protocol CreateNewContactViewControllerDelegate : NSObjectProtocol{
    func updateContactList()
}

class CreateNewContactViewController: UIViewController {
    
    
    struct  createNewGlobals {
        static var userInput = false
    }
    
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
    var favouriteTextView: UITextView!
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
    var doesHaveBuyingPower: Bool = true
    weak var delegate: CreateNewContactViewControllerDelegate!
    var isNewContact: Bool = true
    var contactId: String?
    var contactDetail: Contact?
    var accountSelected : Account!
    var globalContacts = [Contact]()
    @IBOutlet weak var errorLabel: UILabel!
    var accountsDropDown : DropDown?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let id = contactId {
            contactDetail = ContactSortUtility.searchContactByContactId(id)
        }
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
        self.view.endEditing(true)
        if let dropdown = accountsDropDown{
            dropdown.hide()
        }
        DispatchQueue.main.async {
            if  createNewGlobals.userInput {
                AlertUtilities.showAlertMessageWithTwoActionsAndHandler("Any changes will not be saved", errorMessage: "Are you sure you want to close?", errorAlertActionTitle: "Yes", errorAlertActionTitle2: "No", viewControllerUsed: self, action1: {
                    createNewGlobals.userInput = false
                    self.dismiss(animated: true, completion: nil)
                }){
                    
                }
            }else{
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton){
        phoneTextField.text = Validations().validatePhoneNumber(phoneNumber: phoneTextField.text!)
        errorLabel.text = ""
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
        
        if checkValidations() {
            createContactLocally()
        }
    }
    
    func checkValidations() -> Bool{
        if checkAccountSelectedValidation() && checkFirstNameValidation() && checkLastNameValidation() && checkPrimaryFunctionValidation() && checkPhoneNumberValidation() && checkFaxNumberValidation() && checkEmailValidation(){
            return true
        }else{
            return false
        }
    }
    
    func checkAccountSelectedValidation() -> Bool{
        if isNewContact && accountSelected == nil {
            searchAccountTextField.borderColor = .red
            tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            errorLabel.text = StringConstants.emptyFieldError
            return false
        }
        return true
    }

    func checkPrimaryFunctionValidation() -> Bool {
        if (primaryFunctionTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)! {
            primaryFunctionTextField.borderColor = .red
            primaryFunctionTextField.becomeFirstResponder()
            if isNewContact {
                tableView.scrollToRow(at: IndexPath(row: 1, section: 3), at: .top, animated: true)
            }else{
                tableView.scrollToRow(at: IndexPath(row: 1, section: 3), at: .top, animated: true)
            }
            errorLabel.text = StringConstants.emptyFieldError
            return false
        }
        return true
    }
    
    func checkFirstNameValidation() -> Bool {
        if (firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)!  {
            firstNameTextField.borderColor = .red
            firstNameTextField.becomeFirstResponder()
            if isNewContact {
                tableView.scrollToRow(at: IndexPath(row: 0, section: 3), at: .top, animated: true)
            }
            errorLabel.text = StringConstants.emptyFieldError
            return false
        }
        return true
    }
    
    func checkLastNameValidation() -> Bool {
        if (lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)! {
            lastNameTextField.borderColor = .red
            lastNameTextField.becomeFirstResponder()
            if isNewContact {
                tableView.scrollToRow(at: IndexPath(row: 0, section: 3), at: .top, animated: true)
            }
            errorLabel.text = StringConstants.emptyFieldError
            return false
        }
        return true
    }
    
    func checkPhoneNumberValidation() -> Bool{
        if (phoneTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)! && (emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)!{
            phoneTextField.borderColor = .red
            phoneTextField.becomeFirstResponder()
            if isNewContact {
                tableView.scrollToRow(at: IndexPath(row: 1, section: 3), at: .top, animated: true)
            }else{
                tableView.scrollToRow(at: IndexPath(row: 2, section: 3), at: .top, animated: true)
            }
            errorLabel.text = StringConstants.emptyFieldError
            return false
        }else if phoneTextField.text != "" && Validations().removeSpecialCharsFromString(text: phoneTextField.text!).count != 10{
            phoneTextField.borderColor = .red
            phoneTextField.becomeFirstResponder()
            if isNewContact {
                tableView.scrollToRow(at: IndexPath(row: 1, section: 3), at: .top, animated: true)
            }else{
                tableView.scrollToRow(at: IndexPath(row: 2, section: 3), at: .top, animated: true)
            }
            errorLabel.text = StringConstants.errorInField
            return false
        }
        return true
    }
    
    func checkFaxNumberValidation() -> Bool{
        if faxTextField.text != "" && Validations().removeSpecialCharsFromString(text: faxTextField.text!).count != 10{
            faxTextField.borderColor = .red
            faxTextField.becomeFirstResponder()
            if isNewContact {
                tableView.scrollToRow(at: IndexPath(row: 1, section: 3), at: .top, animated: true)
            }else{
                tableView.scrollToRow(at: IndexPath(row: 2, section: 3), at: .top, animated: true)
            }
            errorLabel.text = StringConstants.errorInField
            return false
        }
        return true
    }
    
    func checkEmailValidation() -> Bool{
        if emailTextField.text != "" && !Validations().isValidEmail(testStr: emailTextField.text!){
            emailTextField.borderColor = .red
            emailTextField.becomeFirstResponder()
            if isNewContact {
                tableView.scrollToRow(at: IndexPath(row: 1, section: 3), at: .top, animated: true)
            }else{
                tableView.scrollToRow(at: IndexPath(row: 2, section: 3), at: .top, animated: true)
            }
            errorLabel.text = StringConstants.errorInField
            return false
        }
        return true
    }
    
    
    
    func createContactLocally(){
        // Creating Contact Object
        let newContact = getNewContactObject()
        
        // Checking for dulplicate entry in contact list
        if checkDuplicateEntryExist(newContact: newContact){
            return
        }
        
        var success: Bool!
        if isNewContact {
            success = ContactsViewModel().createNewContactToSoup(object: newContact)
            if !success {
                print("failed to create new contact to local soup")
                return
            }
            
            if !createAcrSoupEntry(contact: newContact){
                print("failed to create new ACR to local soup")
                return
            }
        }else{
            success = ContactsViewModel().editNewContactToSoup(object: newContact)
        }
        
        if success {
            self.dismiss(animated: true, completion: {
                self.delegate.updateContactList()
                createNewGlobals.userInput = false
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshAccounts"), object:nil)
            })
        }else{
            showAlert(message: "Unable to create the new contact in local database")
        }
    }
    
    func getNewContactObject() -> Contact{
        var newContact = Contact(for: "NewContact")
        
        if !isNewContact {
            newContact = contactDetail!
            newContact.buyerFlag = (contactDetail?.buyerFlag)!
        }else{
            newContact.buyerFlag = true
            newContact.accountId = accountSelected.account_Id
        }
        newContact.firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        newContact.lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        newContact.name = newContact.firstName.trimmingCharacters(in: .whitespacesAndNewlines) + " " + newContact.lastName.trimmingCharacters(in: .whitespacesAndNewlines)
        newContact.lastModifiedByName = (UserViewModel().loggedInUser?.userName)!
        newContact.preferredName = preferredNameTextField.text!
        newContact.functionRole = primaryFunctionTextField.text!
        newContact.title = titleTextField.text!
        newContact.department = departmentTextField.text!
        newContact.phoneNumber = phoneTextField.text!
        newContact.email = emailTextField.text!
        newContact.contactHours = contactHoursTextField.text!
        newContact.favouriteActivities = favouriteTextView.text!
        newContact.lastModifiedDate = getTimeStampInString()
        newContact.buyerFlag = doesHaveBuyingPower
        
        newContact.preferredCommunicationMethod = (preferredCommunicationTextField.text! == "Select One") ? "" : preferredCommunicationTextField.text!
        
        newContact.birthDate = (birthdayTextField.text! == "Select") ? "" : birthdayTextField.text!
        
        newContact.anniversary = (anniversaryTextField.text! == "Select") ? "" : anniversaryTextField.text!
        
        newContact.child1Name = familyName1Textfield.text!
        newContact.child1Birthday = (familyDate1Textfield.text! == "Select") ? "" : familyDate1Textfield.text!
        
        newContact.child2Name = familyName2Textfield.text!
        newContact.child2Birthday = (familyDate2Textfield.text! == "Select") ? "" : familyDate2Textfield.text!
        
        newContact.child3Name = familyName3Textfield.text!
        newContact.child3Birthday = (familyDate3Textfield.text! == "Select") ? "" : familyDate3Textfield.text!
        
        newContact.child4Name = familyName4Textfield.text!
        newContact.child4Birthday = (familyDate4Textfield.text! == "Select") ? "" : familyDate4Textfield.text!
        
        newContact.child5Name = familyName5Textfield.text!
        newContact.child5Birthday = (familyDate5Textfield.text! == "Select") ? "" : familyDate5Textfield.text!
        
        newContact.likes = likeTextView.text!
        newContact.dislikes = dislikeTextView.text!
        newContact.sgwsNotes = notesTextView.text!
        newContact.fax = faxTextField.text!
        
        return newContact
    }
    
    func getTimeStampInString() -> String{
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000+0000"
        let timeStamp = dateFormatter.string(from: date)
        return timeStamp
    }
    
    func createAcrSoupEntry(contact: Contact) -> Bool {
        let newACR = AccountContactRelation(for: "newACR")
        newACR.accountId = contact.accountId
        newACR.contactId = contact.contactId
        newACR.contactName = contact.firstName + " " + contact.lastName
        newACR.roles = contact.functionRole
        newACR.isActive = 1
        newACR.buyingPower = contact.buyerFlag ? 1:0
        
        return ContactsViewModel().createNewACRToSoup(object: newACR)
    }
    
    func checkDuplicateEntryExist(newContact: Contact) -> Bool{
        globalContacts = ContactsViewModel().globalContacts()
        if globalContacts.count > 0 {
            for index in 0 ... globalContacts.count - 1 {
                if globalContacts[index].contactId == newContact.contactId {
                    globalContacts.remove(at: index)
                    break
                }
            }
        }
        
        // Checkin Duplicate Entry
        for contact in globalContacts {
            if contact.firstName == newContact.firstName && contact.lastName == newContact.lastName && contact.phoneNumber == newContact.phoneNumber || contact.firstName == newContact.firstName && contact.lastName == newContact.lastName && contact.email == newContact.email {
                showAlert(message: "A duplicate contact with the same name and phone or name and email has been detected")
                return true
            }
        }
        return false
    }
    
    func showAlert(message: String){
        let alertController = UIAlertController(title: "Alert", message:
            message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default,handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}


extension CreateNewContactViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return getNumberOfRowForSearchAccountSection()
        case 1:
            return getNumberOfRowsForAccountSection()
        case 2:
            return getNumberOfRowsForBuyerFlagSection()
        case 3:
            return 8
        case 4:
            return 9
        default:
            return 0
        }
    }
    
    func getNumberOfRowForSearchAccountSection() -> Int {
        if isNewContact {
            return 1
        }else{
            return 0
        }
    }
    
    func getNumberOfRowsForAccountSection() -> Int {
        if isNewContact {
            if accountSelected != nil {
                return 1
            }else{
                return 0
            }
        }else{
            return 0
        }
    }
    
    func getNumberOfRowsForBuyerFlagSection() -> Int {
        if isNewContact {
            if doesHaveBuyingPower {
                return 1
            }else{
                return 2
            }
        }else{
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
            accountsDropDown = cell?.accountsDropDown
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
                cell?.setBuyingPower(value:  doesHaveBuyingPower)
                return cell!
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "ContactClassificationTableViewCell") as? ContactClassificationTableViewCell
                cell?.displayCellContents()
                contactClassificationTextField = cell?.classificationTextField
                otherReasonTextField = cell?.otherTextField
                return cell!
            default:
                return UITableViewCell()
            }
        case 3:
            return getPersonalDetailsCells(indexPath: indexPath)
        case 4:
            return getFamiliesCell(indexPath: indexPath)
        default:
            return UITableViewCell()
        }
    }
    
    func getFamiliesCell(indexPath: IndexPath) -> UITableViewCell{
        switch indexPath.row {
        case 0:
            return getChildCell1()
        case 1:
            return getChildCell2()
        case 2:
            return getChildCell3()
        case 3:
            return getChildCell4()
        case 4:
            return getChildCell5()
        case 5:
            return getLikesDescriptionCell()
        case 6:
            return getDislikesDescriptionCell()
        case 7:
            return getFavouriteDescriptionCell()
        case 8:
            return getNotesDescriptionCell()
        default:
            return UITableViewCell()
        }
    }
    
    func getNotesDescriptionCell() -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionTableViewCell") as? DescriptionTableViewCell
        cell?.headerLabel.text = "Notes"
        notesTextView = cell?.descriptionTextView
        cell?.descriptionTextView.tag = 4
        if let notes = contactDetail?.sgwsNotes, notes != "" {
            cell?.contactDetail = contactDetail
            cell?.displayCellContent()
        }
        return cell!
    }
    
    func getLikesDescriptionCell() -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionTableViewCell") as? DescriptionTableViewCell
        cell?.headerLabel.text = "Likes"
        likeTextView = cell?.descriptionTextView
        cell?.descriptionTextView.tag = 1
        if let dislikes = contactDetail?.dislikes, dislikes != "" {
            cell?.contactDetail = contactDetail
            cell?.displayCellContent()
        }
        return cell!
    }
    
    func getDislikesDescriptionCell() -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionTableViewCell") as? DescriptionTableViewCell
        cell?.headerLabel.text = "Dislikes"
        dislikeTextView = cell?.descriptionTextView
        cell?.descriptionTextView.tag = 2
        if let likes = contactDetail?.likes, likes != "" {
            cell?.contactDetail = contactDetail
            cell?.displayCellContent()
        }
        return cell!
    }
    
    func getFavouriteDescriptionCell() -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionTableViewCell") as? DescriptionTableViewCell
        cell?.headerLabel.text = "Favorite Activities"
        favouriteTextView = cell?.descriptionTextView
        cell?.descriptionTextView.tag = 3
        if let fav = contactDetail?.favouriteActivities, fav != "" {
            cell?.contactDetail = contactDetail
            cell?.displayCellContent()
        }
        return cell!
    }
    
    func getChildCell1() -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "FamilyTableViewCell") as? FamilyTableViewCell
        cell?.nameTextField.tag = 1
        cell?.dateTextField.tag = 1
        familyDate1Textfield = cell?.dateTextField
        familyName1Textfield = cell?.nameTextField
        if let childName = contactDetail?.child1Name, childName != "" {
            cell?.contactDetail = contactDetail
            cell?.displayCellContent()
        }
        if let childDate = contactDetail?.child1Birthday, childDate != "" {
            cell?.dateTextField.text = childDate
        }
        return cell!
    }
    
    func getChildCell2() -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "FamilyTableViewCell") as? FamilyTableViewCell
        cell?.nameTextField.tag = 2
        cell?.dateTextField.tag = 2
        cell?.familyLabelHeightConstraint.constant = 0
        cell?.dateLabelHeightConstraint.constant = 0
        cell?.nameLabelHeightConstraint.constant = 0
        familyDate2Textfield = cell?.dateTextField
        familyName2Textfield = cell?.nameTextField
        if let childName = contactDetail?.child2Name, childName != "" {
            cell?.contactDetail = contactDetail
            cell?.displayCellContent()
        }
        if let childDate = contactDetail?.child2Birthday, childDate != "" {
            cell?.dateTextField.text = childDate
        }
        return cell!
    }
    
    func getChildCell3() -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "FamilyTableViewCell") as? FamilyTableViewCell
        cell?.nameTextField.tag = 3
        cell?.dateTextField.tag = 3
        cell?.familyLabelHeightConstraint.constant = 0
        cell?.dateLabelHeightConstraint.constant = 0
        cell?.nameLabelHeightConstraint.constant = 0
        familyDate3Textfield = cell?.dateTextField
        familyName3Textfield = cell?.nameTextField
        if let childName = contactDetail?.child3Name, childName != "" {
            cell?.contactDetail = contactDetail
            cell?.displayCellContent()
        }
        if let childDate = contactDetail?.child3Birthday, childDate != "" {
            cell?.dateTextField.text = childDate
        }
        return cell!
    }
    
    func getChildCell4() -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "FamilyTableViewCell") as? FamilyTableViewCell
        cell?.nameTextField.tag = 4
        cell?.dateTextField.tag = 4
        cell?.familyLabelHeightConstraint.constant = 0
        cell?.dateLabelHeightConstraint.constant = 0
        cell?.nameLabelHeightConstraint.constant = 0
        familyDate4Textfield = cell?.dateTextField
        familyName4Textfield = cell?.nameTextField
        if let childName = contactDetail?.child4Name, childName != "" {
            cell?.contactDetail = contactDetail
            cell?.displayCellContent()
        }
        if let childDate = contactDetail?.child4Birthday, childDate != "" {
            cell?.dateTextField.text = childDate
        }
        return cell!
    }
    
    func getChildCell5() -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "FamilyTableViewCell") as? FamilyTableViewCell
        cell?.nameTextField.tag = 5
        cell?.dateTextField.tag = 5
        cell?.familyLabelHeightConstraint.constant = 0
        cell?.dateLabelHeightConstraint.constant = 0
        cell?.nameLabelHeightConstraint.constant = 0
        familyDate5Textfield = cell?.dateTextField
        familyName5Textfield = cell?.nameTextField
        if let childName = contactDetail?.child5Name, childName != "" {
            cell?.contactDetail = contactDetail
            cell?.displayCellContent()
        }
        if let childDate = contactDetail?.child5Birthday, childDate != "" {
            cell?.dateTextField.text = childDate
        }
        return cell!
    }
    
    func getPersonalDetailsCells(indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            return getNameCell()
        case 1:
            return getPrimaryFunctionCell()
        case 2:
            return getPhoneCell()
        case 3:
            return getEmailCell()
        case 4:
            return getContactHoursCell()
        case 5:
            return getPreferredCommunicationCell()
        case 6:
            return getBirthdayCell()
        case 7:
            return getAnniversaryCell()
        default:
            return UITableViewCell()
        }
    }
    
    func getNameCell() -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "NameTableViewCell") as? NameTableViewCell
        if !isNewContact {
            cell?.firstNameTextField.isEnabled = false
            cell?.lastNameTextField.isEnabled = false
        }
        firstNameTextField = cell?.firstNameTextField
        lastNameTextField = cell?.lastNameTextField
        preferredNameTextField = cell?.preferredNameTextField
        if let contactDetail = contactDetail {
            cell?.contactDetail = contactDetail
            cell?.displayCellContent()
        }
        return cell!
    }
    
    func getPrimaryFunctionCell() -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PrimaryFunctionTableViewCell") as? PrimaryFunctionTableViewCell
        cell?.setBuyingPower(value: doesHaveBuyingPower)
        
        if let contactDetail = contactDetail {
            cell?.contactDetail = contactDetail
            cell?.displayCellContent()
        }
        departmentTextField = cell?.departmentTextField
        titleTextField = cell?.titleTextField
        primaryFunctionTextField = cell?.primaryFunctionTextField
        return cell!
    }
    
    func getPhoneCell() -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhoneTableViewCell") as? PhoneTableViewCell
        phoneTextField = cell?.phoneTextField
        faxTextField = cell?.faxTextField
        if let contactDetail = contactDetail {
            cell?.contactDetail = contactDetail
            cell?.displayCellContent()
        }
        return cell!
    }
    
    func getEmailCell() -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmailTableViewCell") as? EmailTableViewCell
        emailTextField = cell?.emailTextField
        if let contactDetail = contactDetail {
            cell?.contactDetail = contactDetail
            cell?.displayCellContent()
        }
        return cell!
    }
    
    func getContactHoursCell() -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactHoursTableViewCell") as? ContactHoursTableViewCell
        contactHoursTextField = cell?.contactHoursTextField
        if let contactDetail = contactDetail {
            cell?.contactDetail = contactDetail
            cell?.displayCellContent()
        }
        return cell!
    }
    
    
    func getPreferredCommunicationCell() -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DropdownTableViewCell") as? DropdownTableViewCell
        preferredCommunicationTextField = cell?.dropdownTextfield
        if let preferredCommunicationMethod = contactDetail?.preferredCommunicationMethod, preferredCommunicationMethod != ""{
            cell?.contactDetail = contactDetail
            cell?.displayCellContent()
        }
        return cell!
    }
    
    func getAnniversaryCell() -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DateFieldTableViewCell") as? DateFieldTableViewCell
        cell?.headerLabel.text = "Anniversary"
        anniversaryTextField = cell?.dateTextfield
        cell?.dateTextfield.tag = 2
        if let anniversaryDate = contactDetail?.anniversary, anniversaryDate != "" {
            cell?.contactDetail = contactDetail
            cell?.displayCellContent()
        }
        return cell!
    }
    
    func getBirthdayCell() -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DateFieldTableViewCell") as? DateFieldTableViewCell
        cell?.headerLabel.text = "Birthday"
        birthdayTextField = cell?.dateTextfield
        cell?.dateTextfield.tag = 1
        if let birthDate = contactDetail?.birthDate, birthDate != "" {
            cell?.contactDetail = contactDetail
            cell?.displayCellContent()
        }
        return cell!
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
        createNewGlobals.userInput = true
        accountSelected = account
        tableView.reloadData()
    }
}

extension CreateNewContactViewController: AccountContactLinkTableViewCellDelegate {
    func removeAccount() {
        createNewGlobals.userInput = true
        accountSelected = nil
        tableView.reloadData()
    }
}
