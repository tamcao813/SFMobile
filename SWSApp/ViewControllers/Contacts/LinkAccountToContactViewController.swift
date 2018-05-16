//
//  LinkAccountToContactViewController.swift
//  SWSApp
//
//  Created by manu.a.gupta on 16/05/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit
import DropDown

protocol LinkAccountToContactViewControllerDelegate: NSObjectProtocol {
    func updateContact()
}

class LinkAccountToContactViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pageHeadingLabel: UILabel!
    var accountSelected: Account!
    var doesHaveBuyingPower = false
    var primaryFunctionTextField : UITextField!
    var searchAccountTextField : UITextField!
    var contactClassificationTextField : UITextField!
    var otherReasonTextField : UITextField!
    var accountsDropDown: DropDown?
    var contactObject: Contact?
    var contactName: String?
    @IBOutlet weak var errorLabel: UILabel!
    var isInEditMode: Bool?
    var delegate: LinkAccountToContactViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizedUI()
        initializingXIBs()
        if let accountId = contactObject?.accountId {
            fetchAccountDetails(accountId: accountId)
        }
    }
    
    func fetchAccountDetails(accountId: String){
        let accountsArray = AccountsViewModel().accountsForLoggedUser
        for account in accountsArray{
            if account.account_Id == accountId {
                accountSelected = account
                break
            }
        }
    }
    
    func customizedUI(){
        if isInEditMode! {
            pageHeadingLabel.text = "Edit Linked Account"
        }else{
            pageHeadingLabel.text = "Link New Account to \(contactName ?? "")"
        }
        
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        self.tableView.estimatedRowHeight = 100
    }
    
    func initializingXIBs(){
        self.tableView.register(UINib(nibName: "SearchAccountTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchAccountTableViewCell")
        
        self.tableView.register(UINib(nibName: "AccountContactLinkTableViewCell", bundle: nil), forCellReuseIdentifier: "DropDownCell")
        
        self.tableView.register(UINib(nibName: "ToggleTableViewCell", bundle: nil), forCellReuseIdentifier: "ToggleTableViewCell")
        
        self.tableView.register(UINib(nibName: "ContactClassificationTableViewCell", bundle: nil), forCellReuseIdentifier: "ContactClassificationTableViewCell")
        
        self.tableView.register(UINib(nibName: "PrimaryFunctionTableViewCell", bundle: nil), forCellReuseIdentifier: "PrimaryFunctionTableViewCell")
        
        
    }
    
    @IBAction func closeButtonTapped(_ sender: UIButton){
        self.view.endEditing(true)
        if let dropdown = accountsDropDown{
            dropdown.hide()
        }
        DispatchQueue.main.async {
//            if  createNewGlobals.userInput {
                AlertUtilities.showAlertMessageWithTwoActionsAndHandler("Any changes will not be saved", errorMessage: "Are you sure you want to close?", errorAlertActionTitle: "Yes", errorAlertActionTitle2: "No", viewControllerUsed: self, action1: {
//                    createNewGlobals.userInput = false
                    self.dismiss(animated: true, completion: nil)
                }){
                    
                }
//            }else{
//                self.dismiss(animated: true, completion: nil)
//            }
        }
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton){
        searchAccountTextField.borderColor = .lightGray
        primaryFunctionTextField.borderColor = .lightGray
        
        if accountSelected == nil {
            searchAccountTextField.borderColor = .red
            tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            errorLabel.text = StringConstants.emptyFieldError
            return
        }else if (primaryFunctionTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)! {
            primaryFunctionTextField.borderColor = .red
            primaryFunctionTextField.becomeFirstResponder()
            tableView.scrollToRow(at: IndexPath(row: 0, section: 2), at: .top, animated: true)
            errorLabel.text = StringConstants.emptyFieldError
            return
        }
        
        // Dismiss after saving and call the delegate to update the contact object
        //self.delegate.update()
    }

}

extension LinkAccountToContactViewController : UITableViewDataSource,UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            if accountSelected != nil {
                return 1
            }
            return 0
        case 2:
            return 1
        case 3:
            if doesHaveBuyingPower {
                return 1
            }else{
                return 2
            }
        default:
            return 0
        }
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "PrimaryFunctionTableViewCell") as? PrimaryFunctionTableViewCell
            if let contactDetail = contactObject {
//                cell?.contactDetail = contactDetail
//                cell?.displayCellContent()
                cell?.primaryFunctionTextField.text = contactDetail.functionRole
            }
            cell?.departmentTextField.isHidden = true
            cell?.titleTextField.isHidden = true
            cell?.titleLabel.isHidden = true
            cell?.departmentLabel.isHidden = true
            cell?.delegate = self
            primaryFunctionTextField = cell?.primaryFunctionTextField
            return cell!
        case 3:
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "ToggleTableViewCell") as? ToggleTableViewCell
                cell?.delegate = self
                if let contactDetail = contactObject {
                    //Assign the buying flag 
                    //cell?.buyingPower = contactDetail.buyerFlag
                }
                return cell!
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "ContactClassificationTableViewCell") as? ContactClassificationTableViewCell
                cell?.displayCellContents()
                if let contactDetail = contactObject {
                    // Assign the value according to the contactObject and contact classification picker
                }
                contactClassificationTextField = cell?.classificationTextField
                otherReasonTextField = cell?.otherTextField
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
    func primaryFunctionValueSelected(value: String) {
        // Assign Value to buyerflag according to the primary function dropdown value and disable the toggle switch accordingly and reload table
        
    }
}

extension LinkAccountToContactViewController: ToggleTableViewCellDelegate {
    func buyingPowerChanged(buyingPower: Bool) {
        doesHaveBuyingPower = buyingPower
        self.tableView.reloadData()
    }
}

extension LinkAccountToContactViewController: SearchAccountTableViewCellDelegate {
    func accountSelected(account : Account) {
        accountSelected = account
        tableView.reloadData()
    }
}
