//
//  LinkAccountToContactViewController.swift
//  SWSApp
//
//  Created by manu.a.gupta on 16/05/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
//import DropDown

protocol LinkAccountToContactViewControllerDelegate: NSObjectProtocol {
    func updateContact()
}

class LinkAccountToContactViewController: UIViewController {
    
    struct  linkAccountToContactGlobals {
        static var userInput = false
    }

    @IBOutlet weak var unlinkButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pageHeadingLabel: UILabel!
    var accountSelected: Account?
    var doesHaveBuyingPower: Bool?
    var primaryFunctionTextField : UITextField!
    var searchAccountTextField : UITextField!
    var contactClassificationTextField : UITextField!
    var otherReasonTextField : UITextField!
    var accountsDropDown: DropDown?
    var contactObject: Contact?
    var contactName: String?
    @IBOutlet weak var errorLabel: UILabel!
    var isInEditMode: Bool = false
    var delegate: LinkAccountToContactViewControllerDelegate?
    var accountIdSelected: String = ""
    var accContactRelation: AccountContactRelation?
    var isFirstTimeLoaded: Bool = true
    var countOfLinkedAccounts: Int = 0
    var alreadyLinkedAccounts = [String]()
    var pickerOption: [String : Any]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizedUI()
        initializingXIBs()
        
        fetchACRs()
        
        if isInEditMode {
            fetchAccountDetails()
            doesHaveBuyingPower = accContactRelation?.buyingPower == 1
        }
        
        let opts = PlistMap.sharedInstance.readPList(plist: StringConstants.contactRole)
        
        for opt in opts {
            let option = opt as! [String: Any]
            if option["value"] as? String == accContactRelation?.roles{
                pickerOption = option
                break
            }
        }
    
    }
    
    func fetchACRs() {
        //fetch ACRs for checking when linking accounts
        let acrs = ContactsViewModel().linkedAccountsForContact(with: (contactObject?.contactId)!)
        countOfLinkedAccounts = acrs.count
        
        for acr in acrs {
            alreadyLinkedAccounts.append(acr.accountId)
        }
        
    }
    
    func fetchAccountDetails(){
        if !isInEditMode {
            return
        }
        
        let accountsArray = AccountsViewModel().accountsForLoggedUser()
        
        //below is for Edit
        let accountId = accContactRelation?.accountId
        for account in accountsArray{
            if account.account_Id == accountId {
                accountSelected = account
                break
            }
        }
    }
    
    func customizedUI(){
        if isInEditMode {
            pageHeadingLabel.text = "Edit Linked Account"
            unlinkButton.isHidden = false
            unlinkButton.isEnabled = true
        } else {
            pageHeadingLabel.text = "Link New Account to \(contactName ?? "")"
            unlinkButton.isHidden = true
            unlinkButton.isEnabled = false
        }
        
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        self.tableView.estimatedRowHeight = 100
        
        IQKeyboardManager.shared.enable = true
    }
    
    func initializingXIBs(){
        self.tableView.register(UINib(nibName: "SearchAccountTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchAccountTableViewCell")
        
        self.tableView.register(UINib(nibName: "AccountContactLinkTableViewCell", bundle: nil), forCellReuseIdentifier: "DropDownCell")
        
        self.tableView.register(UINib(nibName: "ToggleTableViewCell", bundle: nil), forCellReuseIdentifier: "ToggleTableViewCell")
        
        self.tableView.register(UINib(nibName: "ContactClassificationTableViewCell", bundle: nil), forCellReuseIdentifier: "ContactClassificationTableViewCell")
        
        self.tableView.register(UINib(nibName: "PrimaryFunctionTableViewCell", bundle: nil), forCellReuseIdentifier: "PrimaryFunctionTableViewCell")
    }
    
    @IBAction func unlinkAccount(_ sender: UIButton) {
        if sender.isSelected {
            sender.titleLabel?.text = "Account Unlinked"
            return
        }
        
        if countOfLinkedAccounts == 1 {
            let alert = UIAlertController(title: "Cannot unlink, this is the only linked account.", message: "Each Contact must be linked to at least one Account.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            sender.isSelected = false
            return
        }
        
        sender.titleLabel?.text = "Account Unlinked"
        accContactRelation?.isActive = 0
        sender.isSelected = true
        sender.isEnabled = false
    }
    
    @IBAction func closeButtonTapped(_ sender: UIButton){
        self.view.endEditing(true)
        if let dropdown = accountsDropDown{
            dropdown.hide()
        }
        DispatchQueue.main.async {
            if linkAccountToContactGlobals.userInput {
                AlertUtilities.showAlertMessageWithTwoActionsAndHandler("Any changes will not be saved", errorMessage: "Are you sure you want to close?", errorAlertActionTitle: "Yes", errorAlertActionTitle2: "No", viewControllerUsed: self, action1: {
                    linkAccountToContactGlobals.userInput = false
                    self.dismiss(animated: true, completion: nil)
                }){
                    
                }
            }else{
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton){
        if !isInEditMode {
            searchAccountTextField.borderColor = .lightGray
        }
        primaryFunctionTextField.borderColor = .lightGray
        
        if !isInEditMode {
            if accountSelected == nil {
                searchAccountTextField.borderColor = .red
                tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
                errorLabel.text = StringConstants.emptyFieldError
                return
            }
        }
        
        if (primaryFunctionTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)! {
            primaryFunctionTextField.borderColor = .red
            primaryFunctionTextField.becomeFirstResponder()
            tableView.scrollToRow(at: IndexPath(row: 0, section: 2), at: .top, animated: true)
            errorLabel.text = StringConstants.emptyFieldError
            return
        }
        
        if let buyerFlag = doesHaveBuyingPower,!buyerFlag && (contactClassificationTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)! {
            contactClassificationTextField.borderColor = .red
            tableView.scrollToRow(at: IndexPath(row: 0, section: 3), at: .top, animated: true)
            errorLabel.text = StringConstants.emptyFieldError
            return
        }

        if let buyerFlag = doesHaveBuyingPower,!buyerFlag,(contactClassificationTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)) == "Other",(otherReasonTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)! {
            otherReasonTextField.borderColor = .red
            tableView.scrollToRow(at: IndexPath(row: 0, section: 3), at: .top, animated: true)
            errorLabel.text = StringConstants.emptyFieldError
            return
        }
        
        var  aCR = AccountContactRelation(for:"NewACR")
    
        if isInEditMode {
            aCR = accContactRelation!
            
            if aCR.contactName.count == 0 {
                aCR.contactName = (contactObject?.firstName)! + " " + (contactObject?.lastName)!
            }
        }
        else {
            aCR.accountId = (accountSelected?.account_Id)!
            aCR.contactId = (contactObject?.contactId)!
            aCR.contactName = (contactObject?.firstName)! + " " + (contactObject?.lastName)!
            aCR.isActive = 1
        }
        
        aCR.roles = primaryFunctionTextField.text!
        if let buyingPower = doesHaveBuyingPower {
            aCR.buyingPower = buyingPower ? 1:0
        }
        
        if let buyingPower = doesHaveBuyingPower,!buyingPower {
            aCR.contactClassification = contactClassificationTextField.text!            
            if aCR.contactClassification == "Other" {
                aCR.otherSpecification = otherReasonTextField.text!
            }
        }
        
        var success:Bool = false
        
        if isInEditMode {
            var ary = [AccountContactRelation]()
            ary.append(aCR)
            success = ContactsViewModel().updateACRToSoup(objects:ary)
        }
        else {
            success = ContactsViewModel().createNewACRToSoup(object: aCR)
        }
        
        if success {
            self.dismiss(animated: true, completion: {
                self.delegate?.updateContact()
            })
        } else {
            var meg = "Failed to link the new account."
            if isInEditMode {
                meg = "Failed to update the account."
            }
            let alertController = UIAlertController(title: "Alert", message:
                meg, preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default,handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
    }

}

extension LinkAccountToContactViewController : UITableViewDataSource,UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            if isInEditMode {
                return 0
            }
            else {
                return 1
            }
        case 1:
            if isInEditMode {
                return 1
            }
            else {
                if accountSelected != nil {
                    return 1
                }
                return 0
            }
        case 2:
            return 1
        case 3:
            if let buyingPower = doesHaveBuyingPower {
                if buyingPower {
                    contactClassificationTextField?.text = "" //clear the text
                    otherReasonTextField?.text = "" //clear the text
                    return 1
                }else{
                    return 2
                }
            }else{
                return 1
            }
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "SearchAccountTableViewCell") as? SearchAccountTableViewCell
                cell?.searchContactTextField.accessibilityIdentifier = "LinkContactSearchContactTextFieldID"
                searchAccountTextField = cell?.searchContactTextField
                cell?.searchContactTextField.layer.backgroundColor = UIColor.clear.cgColor
                accountsDropDown = cell?.accountsDropDown
                cell?.delegate = self
                return cell!
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DropDownCell") as? AccountContactLinkTableViewCell
            cell?.containerTrailingConstraint.constant = 40
            cell?.containerLeadingConstraint.constant = 40
            cell?.delegate = self
            if let account = accountSelected {
                cell?.displayCellContent(account: account, isEditing: isInEditMode)
            }
            return cell!
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PrimaryFunctionTableViewCell") as? PrimaryFunctionTableViewCell
            cell?.delegate = self
            primaryFunctionTextField = cell?.primaryFunctionTextField
            
            if let option = pickerOption{
                primaryFunctionTextField.text = option["value"] as? String
            }
            
            return cell!
        case 3:
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "ToggleTableViewCell") as? ToggleTableViewCell
                cell?.delegate = self
                if let option = pickerOption{
                    if option["validFor"] as! Int == 1 {
                        cell?.noButton.isUserInteractionEnabled = true
                        cell?.yesButton.isUserInteractionEnabled = true
                    }else{
                        cell?.noButton.isUserInteractionEnabled = false
                        cell?.yesButton.isUserInteractionEnabled = false
                    }
                }
                
                if let buyer = doesHaveBuyingPower{
                    cell?.setBuyingPower(value: buyer)
                }
                return cell!
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "ContactClassificationTableViewCell") as? ContactClassificationTableViewCell
                cell?.displayCellContents()
                if let acr = accContactRelation {
                    if let buyingPower = doesHaveBuyingPower,!buyingPower,isFirstTimeLoaded {
                        cell?.classificationTextField.text = acr.contactClassification
                        if acr.contactClassification == "Other" {
                            cell?.otherTextField.text = acr.otherSpecification
                            cell?.otherTextField.isHidden = false
                        }
                    }
                }
                
                contactClassificationTextField = cell?.classificationTextField
                contactClassificationTextField.accessibilityIdentifier = "linkContactClassificationTextFieldID"
                otherReasonTextField = cell?.otherTextField
                otherReasonTextField.accessibilityIdentifier = "linkOtherReasonTextFieldID"
                return cell!
            default:
                return UITableViewCell()
            }
        default:
            return UITableViewCell()
        }
    }
}

extension LinkAccountToContactViewController: AccountContactLinkTableViewCellDelegate {
    func removeAccount() {
        accountSelected = nil
        tableView.reloadData()
    }
}

extension LinkAccountToContactViewController: PrimaryFunctionTableViewCellDelegate {
    func primaryFunctionValueSelected(pickerOption: [String : Any]) {
        linkAccountToContactGlobals.userInput = true
        self.pickerOption = pickerOption
        if pickerOption["validFor"] as! Int == 1 {
            doesHaveBuyingPower = true
        }else{
            doesHaveBuyingPower = false
        }
        self.tableView.reloadData()
    }
}

extension LinkAccountToContactViewController: ToggleTableViewCellDelegate {
    func buyingPowerChanged(buyingPower: Bool) {
        linkAccountToContactGlobals.userInput = true
        if buyingPower {
            doesHaveBuyingPower = true
        }else{
            doesHaveBuyingPower = false
        }
        isFirstTimeLoaded = false
        self.tableView.reloadData()
    }
}

extension LinkAccountToContactViewController: SearchAccountTableViewCellDelegate {
    func scrollTableView() {
        
    }
    
    func accountSelected(account : Account) {
        
        let filtered = alreadyLinkedAccounts.filter {$0 == account.account_Id}
        
        if filtered.count >= 1 { 
        
            let alertController = UIAlertController(title: "This account is already linked.", message:
                "Please select another account.", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default,handler: nil))
            self.present(alertController, animated: true, completion: nil)
            return
        }
        
        accountSelected = account
        tableView.reloadData()
    }
}
