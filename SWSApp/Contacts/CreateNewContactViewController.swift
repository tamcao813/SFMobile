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
        otherReasonTextField.borderColor = .lightGray
        
        //need to check an account has been selected for this contact - UI needs to get the account name from the dropdown and then get get it's accountId - better yet, the dropDown has both Acconut name and Id
        
        if !doesHaveBuyingPower && contactClassificationTextField.text == "Other"{
            if (otherReasonTextField.text?.isEmpty)! {
                otherReasonTextField.borderColor = .red
                otherReasonTextField.becomeFirstResponder()
                tableView.scrollToRow(at: IndexPath(row: 2, section: 0), at: .top, animated: true)
                showAlert = true
            }
        }else if (firstNameTextField.text?.isEmpty)! {
            firstNameTextField.borderColor = .red
            firstNameTextField.becomeFirstResponder()
            tableView.scrollToRow(at: IndexPath(row: 0, section: 1), at: .top, animated: true)
            showAlert = true
        } else if (lastNameTextField.text?.isEmpty)! {
            lastNameTextField.borderColor = .red
            lastNameTextField.becomeFirstResponder()
            tableView.scrollToRow(at: IndexPath(row: 0, section: 1), at: .top, animated: true)
            showAlert = true
        }else if (primaryFunctionTextField.text?.isEmpty)! {
            primaryFunctionTextField.borderColor = .red
            primaryFunctionTextField.becomeFirstResponder()
            tableView.scrollToRow(at: IndexPath(row: 1, section: 1), at: .top, animated: true)
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
        newContact.contactId = ""
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
        newContact.preferredCommunicationMethod = preferredCommunicationTextField.text!
        if newContact.preferredCommunicationMethod == "Select One" {
            newContact.preferredCommunicationMethod = ""
        }
        newContact.birthDate = birthdayTextField.text!
        if newContact.birthDate == "Select" {
            newContact.birthDate = ""
        }
        newContact.anniversary = anniversaryTextField.text!
        if newContact.anniversary == "Select" {
            newContact.anniversary = ""
        }
        newContact.child1Name = familyName1Textfield.text!
        newContact.child1Birthday = familyDate1Textfield.text!
        if newContact.child1Birthday == "Select" {
            newContact.child1Birthday = ""
        }
        newContact.child2Name = familyName2Textfield.text!
        newContact.child2Birthday = familyDate2Textfield.text!
        if newContact.child2Birthday == "Select" {
            newContact.child2Birthday = ""
        }
        newContact.child3Name = familyName3Textfield.text!
        newContact.child3Birthday = familyDate3Textfield.text!
        if newContact.child3Birthday == "Select" {
            newContact.child3Birthday = ""
        }
        newContact.child4Name = familyName4Textfield.text!
        newContact.child4Birthday = familyDate4Textfield.text!
        if newContact.child4Birthday == "Select" {
            newContact.child4Birthday = ""
        }
        newContact.child5Name = familyName5Textfield.text!
        newContact.child5Birthday = familyDate5Textfield.text!
        if newContact.child5Birthday == "Select" {
            newContact.child5Birthday = ""
        }
        newContact.likes = likeTextView.text!
        newContact.dislikes = dislikeTextView.text!
        newContact.sgwsNotes = notesTextView.text!
        newContact.fax = faxTextField.text!
        newContact.contactClassification = contactClassificationTextField.text!
        newContact.otherSpecification = otherReasonTextField.text!
        
        newContact.accountId = "001m000000cHLmTAAW" //need to get this from the account dropdown selected option
        
        /*
         if contactClassificationTextField.text! == "Other"{
         newContact.contactClassification = otherReasonTextField.text!
         }else{
         newContact.contactClassification = contactClassificationTextField.text!
         }
        */
        
        let success = ContactsViewModel().createNewContactToSoup(object: newContact)
        
        //sync up to Contact which will update ACR, then for now we need to sync down ACR
        if success {
            self.dismiss(animated: true, completion: {
                ContactsViewModel().uploadContactToServerAndSyncDownACR(object: newContact, completion: { error in

                    if error == nil {
                        self.delegate.updateContactList()
                    }
                    else {
                        print("uploadContactToServerAndSyncDownACR error " + (error?.localizedDescription)!)
                    }
                })
            })
        } else {
            let alertController = UIAlertController(title: "Alert", message:
                "Unable to create the new contact in local database", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default,handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }        
       
        //assuming online
//        if success { //upsert to local store is successful then upload to server
//            accNotesViewModel.uploadNotesToServer(fields: addNewDict, completion: { error in
//                if error != nil {
//                    print(error?.localizedDescription ?? "error")
//                }
//            })
//        }
    }
}

extension CreateNewContactViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            if doesHaveBuyingPower {
                return 2
            }else{
                return 3
            }
        case 1:
            return 9
        case 2:
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
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "SearchAccountTableViewCell") as? SearchAccountTableViewCell
                return cell!
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "ToggleTableViewCell") as? ToggleTableViewCell
                cell?.delegate = self
                return cell!
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: "ContactClassificationTableViewCell") as? ContactClassificationTableViewCell
                contactClassificationTextField = cell?.classificationTextField
                otherReasonTextField = cell?.otherTextField
                return cell!
            default:
                return UITableViewCell()
            }
        case 1:
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "NameTableViewCell") as? NameTableViewCell
                firstNameTextField = cell?.firstNameTextField
                lastNameTextField = cell?.lastNameTextField
                preferredNameTextField = cell?.preferredNameTextField
                return cell!
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "PrimaryFunctionTableViewCell") as? PrimaryFunctionTableViewCell
                departmentTextField = cell?.departmentTextField
                titleTextField = cell?.titleTextField
                primaryFunctionTextField = cell?.primaryFunctionTextField
                return cell!
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: "PhoneTableViewCell") as? PhoneTableViewCell
                phoneTextField = cell?.phoneTextField
                faxTextField = cell?.faxTextField
                return cell!
            case 3:
                let cell = tableView.dequeueReusableCell(withIdentifier: "EmailTableViewCell") as? EmailTableViewCell
                emailTextField = cell?.emailTextField
                return cell!
            case 4:
                let cell = tableView.dequeueReusableCell(withIdentifier: "ContactHoursTableViewCell") as? ContactHoursTableViewCell
                contactHoursTextField = cell?.contactHoursTextField
                return cell!
            case 5:
                let cell = tableView.dequeueReusableCell(withIdentifier: "DropdownTableViewCell") as? DropdownTableViewCell
                preferredCommunicationTextField = cell?.dropdownTextfield                
                return cell!
            case 6:
                let cell = tableView.dequeueReusableCell(withIdentifier: "DateFieldTableViewCell") as? DateFieldTableViewCell
                cell?.headerLabel.text = "Birthday"
                birthdayTextField = cell?.dateTextfield
                return cell!
            case 7:
                let cell = tableView.dequeueReusableCell(withIdentifier: "DateFieldTableViewCell") as? DateFieldTableViewCell
                cell?.headerLabel.text = "Anniversary"
                anniversaryTextField = cell?.dateTextfield
                return cell!
            default:
                return UITableViewCell()
            }
        case 2:
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "FamilyTableViewCell") as? FamilyTableViewCell
                familyDate1Textfield = cell?.dateTextField
                familyName1Textfield = cell?.nameTextField
                return cell!
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "FamilyTableViewCell") as? FamilyTableViewCell
                cell?.familyLabelHeightConstraint.constant = 0
                cell?.dateLabelHeightConstraint.constant = 0
                cell?.nameLabelHeightConstraint.constant = 0
                familyDate2Textfield = cell?.dateTextField
                familyName2Textfield = cell?.nameTextField
                return cell!
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: "FamilyTableViewCell") as? FamilyTableViewCell
                cell?.familyLabelHeightConstraint.constant = 0
                cell?.dateLabelHeightConstraint.constant = 0
                cell?.nameLabelHeightConstraint.constant = 0
                familyDate3Textfield = cell?.dateTextField
                familyName3Textfield = cell?.nameTextField
                return cell!
            case 3:
                let cell = tableView.dequeueReusableCell(withIdentifier: "FamilyTableViewCell") as? FamilyTableViewCell
                cell?.familyLabelHeightConstraint.constant = 0
                cell?.dateLabelHeightConstraint.constant = 0
                cell?.nameLabelHeightConstraint.constant = 0
                familyDate4Textfield = cell?.dateTextField
                familyName4Textfield = cell?.nameTextField
                return cell!
            case 4:
                let cell = tableView.dequeueReusableCell(withIdentifier: "FamilyTableViewCell") as? FamilyTableViewCell
                cell?.familyLabelHeightConstraint.constant = 0
                cell?.dateLabelHeightConstraint.constant = 0
                cell?.nameLabelHeightConstraint.constant = 0
                familyDate5Textfield = cell?.dateTextField
                familyName5Textfield = cell?.nameTextField
                return cell!
            case 5:
                let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionTableViewCell") as? DescriptionTableViewCell
                cell?.headerLabel.text = "Likes"
                likeTextView = cell?.descriptionTextView
                return cell!
            case 6:
                let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionTableViewCell") as? DescriptionTableViewCell
                cell?.headerLabel.text = "Dislikes"
                dislikeTextView = cell?.descriptionTextView
                return cell!
            case 7:
                let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionTableViewCell") as? DescriptionTableViewCell
                cell?.headerLabel.text = "Notes"
                notesTextView = cell?.descriptionTextView
                return cell!
            default:
                return UITableViewCell()
            }
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
