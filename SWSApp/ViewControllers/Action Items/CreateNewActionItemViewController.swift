//
//  CreateNewActionItemViewController.swift
//  SWSApp
//
//  Created by manu.a.gupta on 11/05/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import SmartSync

protocol CreateNewActionItemViewControllerDelegate: NSObjectProtocol {
    func updateActionList()
    func updateActionDesc()
}

class CreateNewActionItemViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var screenHeaderLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    var accountDropDown: DropDown?
    var selectedAccount: Account?
    var actionItemId: String?
    var actionItemObject : ActionItem?
    var actionItemDescriptionTextView: UITextView!
    var actionTitleTextField: UITextField!
    var searchAccountTextField: UITextField!
    var dueDateTextField: UITextField!
    var dateTextFieldContainerView: UIView!
    var isEditingMode = false
    var isUrgentSwitch: UISwitch!
    struct createActionItemsGlobals {
        static var userInput = false
    }
    @IBOutlet weak var saveView: UIView!
    weak var delegate: CreateNewActionItemViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizedUI()
        IQKeyboardManager.shared.enable = true
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    
    @objc func keyboardWillShow(_ notification:Notification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if ActionItemFilterModel.isAccountField {
                self.tableView.contentInset = UIEdgeInsetsMake(0, 0, keyboardSize.height + 100, 0)
               ActionItemFilterModel.isAccountField = false
            }
        }
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        if let _ = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        }
    }
    
    deinit {
        IQKeyboardManager.shared.enable = false
    }
    
    func customizedUI(){
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        self.tableView.estimatedRowHeight = 100
        self.tableView.tableFooterView = UIView()
        saveView.dropShadow()
        initializeNibs()
        getSelectedActionItem()
    }
    
    func getSelectedActionItem(){
        if let id = actionItemId {
            let actionItemsArray = AccountsActionItemViewModel().getAcctionItemForUser()
            for actionItem in actionItemsArray{
                if actionItem.Id == id {
                    actionItemObject = actionItem
                    break
                }
            }
        }
        getSelectedAccount()
    }
    
    func getSelectedAccount(){
        if let accountId = actionItemObject?.accountId {
            let accountsArray = AccountsViewModel().accountsForLoggedUser
            for account in accountsArray{
                if account.account_Id == accountId {
                    selectedAccount = account
                    break
                }
            }
        }
        tableView.reloadData()
    }
    
    
    func initializeNibs(){
        self.tableView.register(UINib(nibName: "ActionItemTitleTableViewCell", bundle: nil), forCellReuseIdentifier: "ActionItemTitleTableViewCell")
        self.tableView.register(UINib(nibName: "SearchAccountTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchAccountTableViewCell")
        self.tableView.register(UINib(nibName: "AccountContactLinkTableViewCell", bundle: nil), forCellReuseIdentifier: "DropDownCell")
        self.tableView.register(UINib(nibName: "DescriptionTableViewCell", bundle: nil), forCellReuseIdentifier: "DescriptionTableViewCell")
        self.tableView.register(UINib(nibName: "IsItUrgentTableViewCell", bundle: nil), forCellReuseIdentifier: "IsItUrgentTableViewCell")
        self.tableView.register(UINib(nibName: "DateFieldTableViewCell", bundle: nil), forCellReuseIdentifier: "DateFieldTableViewCell")        
    }
    
    
    @IBAction func closeButtonTapped(_ sender: UIButton){
        self.view.endEditing(true)
        if let dropdown = accountDropDown{
            dropdown.hide()
        }
        DispatchQueue.main.async {
            if  createActionItemsGlobals.userInput {
                AlertUtilities.showAlertMessageWithTwoActionsAndHandler("Any changes will not be saved", errorMessage: "Are you sure you want to close?", errorAlertActionTitle: "Yes", errorAlertActionTitle2: "No", viewControllerUsed: self, action1: {
                    createActionItemsGlobals.userInput = false
                    self.dismiss(animated: true, completion: nil)
                }){}
            }else{
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func saveAndCloseButtonTapped(_ sender: UIButton){
        actionTitleTextField.borderColor = .lightGray
        searchAccountTextField.borderColor = .lightGray
        actionItemDescriptionTextView.borderColor = .lightGray
        dueDateTextField.borderColor = .lightGray
        if (actionTitleTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)!  {
            actionTitleTextField.borderColor = .red
            actionTitleTextField.becomeFirstResponder()
            tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            errorLabel.text = StringConstants.emptyFieldError
            return
//        }else if selectedAccount == nil {
//            searchAccountTextField.borderColor = .red
//            tableView.scrollToRow(at: IndexPath(row: 0, section: 1), at: .top, animated: true)
//            errorLabel.text = StringConstants.emptyFieldError
//            return
        }else if actionItemDescriptionTextView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty{
            actionItemDescriptionTextView.borderColor = .red
            tableView.scrollToRow(at: IndexPath(row: 0, section: 3), at: .top, animated: true)
            errorLabel.text = StringConstants.emptyFieldError
            return
        }
        errorLabel.text = ""
        if isEditingMode {
            
        editActionItem()
            
        }else{
        createNewActionItem()
        }
    }
    
    func createNewActionItem(){
        var newActionItem = ActionItem(for: "NewActionItem")
        if !isEditingMode {
            newActionItem.Id = generateRandomIDForActionItems()
        }else{
            newActionItem = actionItemObject!
        }
        
        if let accountId = selectedAccount?.account_Id {
            newActionItem.accountId = accountId
        }else{
            newActionItem.accountId = ""
        }
        
        newActionItem.subject = actionTitleTextField.text!
        newActionItem.description = actionItemDescriptionTextView.text!
        newActionItem.activityDate = DateTimeUtility().convertDateSendToServerActionItem(dateString: dueDateTextField.text!)
        if newActionItem.activityDate != ""{
            if ActionItemSortUtility().isItOpenState(dueDate: newActionItem.activityDate){
                newActionItem.status = "Open"
            }else{
                newActionItem.status = "Overdue"
            }
        }else{
            newActionItem.status = "Open"
        }
        if isUrgentSwitch.isOn {
            newActionItem.isUrgent = true
        }else{
            newActionItem.isUrgent = false
        }
        newActionItem.lastModifiedDate = getTimestamp()
        let attributeDict = ["type":"Task"]
        let actionItemDict: [String:Any] = [
            
            ActionItem.AccountActionItemFields[0]: newActionItem.Id,
            ActionItem.AccountActionItemFields[1]: newActionItem.accountId,
            ActionItem.AccountActionItemFields[2]: newActionItem.subject,
            ActionItem.AccountActionItemFields[3]: newActionItem.description,
            ActionItem.AccountActionItemFields[4]: newActionItem.status,
            ActionItem.AccountActionItemFields[5]: newActionItem.activityDate,
            ActionItem.AccountActionItemFields[6]: newActionItem.isUrgent,
            ActionItem.AccountActionItemFields[7]: newActionItem.lastModifiedDate,
            
            
            kSyncTargetLocal:true,
            kSyncTargetLocallyCreated:true,
            kSyncTargetLocallyUpdated:false,
            kSyncTargetLocallyDeleted:false,
            "attributes":attributeDict]
        
        let success = AccountsActionItemViewModel().createNewActionItemLocally(fields: actionItemDict)
        if success {
            self.delegate?.updateActionList()
            if ActionItemFilterModel.fromAccount{
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshActionItemList"), object:nil)
            }
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func editActionItem(){
        var editActionItem = ActionItem(for: "editActionItem")
        editActionItem = actionItemObject!
        
        if let accountId = selectedAccount?.account_Id {
            editActionItem.accountId = accountId
        }else{
            editActionItem.accountId = ""
        }
        editActionItem.subject = actionTitleTextField.text!
        editActionItem.description = actionItemDescriptionTextView.text!
        editActionItem.activityDate = DateTimeUtility().convertDateSendToServerActionItem(dateString: dueDateTextField.text!)
        if let status = actionItemObject?.status {
            editActionItem.status = status
            if editActionItem.activityDate != ""{
                if editActionItem.status == "Open" || editActionItem.status == "Overdue"{
                    if ActionItemSortUtility().isItOpenState(dueDate: editActionItem.activityDate){
                        editActionItem.status = "Open"
                    }else{
                        editActionItem.status = "Overdue"
                    }
                }
            }
        }
        if isUrgentSwitch.isOn {
            editActionItem.isUrgent = true
        }else{
            editActionItem.isUrgent = false
        }
        editActionItem.lastModifiedDate = getTimestamp()
        let attributeDict = ["type":"Task"]
        let actionItemDict: [String:Any] = [
            
            ActionItem.AccountActionItemFields[0]: editActionItem.Id,
            ActionItem.AccountActionItemFields[1]: editActionItem.accountId,
            ActionItem.AccountActionItemFields[2]: editActionItem.subject,
            ActionItem.AccountActionItemFields[3]: editActionItem.description,
            ActionItem.AccountActionItemFields[4]: editActionItem.status,
            ActionItem.AccountActionItemFields[5]: editActionItem.activityDate,
            ActionItem.AccountActionItemFields[6]: editActionItem.isUrgent,
            ActionItem.AccountActionItemFields[7]: editActionItem.lastModifiedDate,
            
            kSyncTargetLocal:true,
            kSyncTargetLocallyCreated:false,
            kSyncTargetLocallyUpdated:true,
            kSyncTargetLocallyDeleted:false,
            "attributes":attributeDict]
        
        let success = AccountsActionItemViewModel().editActionItemLocally(fields: actionItemDict)
        if success {
            self.delegate?.updateActionDesc()
            if ActionItemFilterModel.fromAccount{
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshActionItemList"), object:nil)
            }
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func generateRandomIDForActionItems()->String  {
        //  Make a variable equal to a random number....
        let randomNum:UInt32 = arc4random_uniform(99999999) // range is 0 to 99
        // convert the UInt32 to some other  types
        let someString:String = String(randomNum)
        print("number in notes is \(someString)")
        return someString
    }
    
    func getTimestamp() -> String{
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000+0000"
        let timeStamp = dateFormatter.string(from: date)
        return timeStamp
    }
}

extension CreateNewActionItemViewController : UITableViewDelegate, UITableViewDataSource {    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 2{
            if selectedAccount != nil{
                return 1
            }else{
                return 0
            }
        }else{
            return 1
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ActionItemTitleTableViewCell") as? ActionItemTitleTableViewCell
            actionTitleTextField = cell?.actionTitleTextField
            if let actionItem = actionItemObject {
                cell?.actionItemObject = actionItem
                cell?.actionTitleTextField.text = actionItem.subject
            }
            return cell!
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SearchAccountTableViewCell") as? SearchAccountTableViewCell
            searchAccountTextField = cell?.searchContactTextField
            accountDropDown = cell?.accountsDropDown
            cell?.titleLabel.text = "Link an Account"
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionTableViewCell") as? DescriptionTableViewCell
            cell?.headerLabel.text = "Action Item Description*"
            actionItemDescriptionTextView = cell?.descriptionTextView
            if let actionItem = actionItemObject {
                cell?.actionItemObject = actionItem
                actionItemDescriptionTextView.text = actionItem.description
            }
            return cell!
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "IsItUrgentTableViewCell") as? IsItUrgentTableViewCell
            isUrgentSwitch = cell?.isUrgentSwitch
            if let actionItem = actionItemObject {
                cell?.isUrgentSwitch.isOn = actionItem.isUrgent
                if actionItem.isUrgent {
                    cell?.switchValueLabel.text = "Yes"
                }else{
                    cell?.switchValueLabel.text = "No"
                }
            }
            return cell!
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DateFieldTableViewCell") as? DateFieldTableViewCell
            dueDateTextField = cell?.dateTextfield
            dateTextFieldContainerView = cell?.dateTextFieldContainerView
//            cell?.datePickerView.minimumDate = Date()
            cell?.headerLabel.text = "Due Date"
            if let actionItem = actionItemObject {
                cell?.actionItem = actionItem
                cell?.dateTextfield.text = DateTimeUtility.convertUtcDatetoReadableDateOnlyDate(dateStringfromAccountNotes: actionItemObject?.activityDate)
                
            }
            return cell!
        default:
            return UITableViewCell()
        }
    }
}

extension CreateNewActionItemViewController: SearchAccountTableViewCellDelegate {
    func scrollTableView() {
        
    }
    
    func accountSelected(account : Account) {
        createActionItemsGlobals.userInput = true
        selectedAccount = account
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension CreateNewActionItemViewController: AccountContactLinkTableViewCellDelegate {
    func removeAccount() {
        createActionItemsGlobals.userInput = true
        selectedAccount = nil
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
