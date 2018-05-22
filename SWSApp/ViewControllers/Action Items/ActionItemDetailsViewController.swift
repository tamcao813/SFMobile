//
//  ActionItemDetailsViewController.swift
//  SWSApp
//
//  Created by manu.a.gupta on 14/05/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit
import SmartSync

protocol ActionItemDetailsViewControllerDelegate: NSObjectProtocol {
    func updateList()
}

class ActionItemDetailsViewController: UIViewController {
    
    @IBOutlet weak var Complete_Open_Button: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var actionItemStatusLabel: UILabel!
    @IBOutlet weak var footerView: UIView!
    
    var actionItemId: String?
    var actionItemObject: ActionItem?
    var selectedAccount: Account?
    weak var delegate: ActionItemDetailsViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getSelectedActionItem()
        toggleCompleteButton()
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
        customizedUI()
        tableView.reloadData()
    }
    
    func customizedUI(){
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        self.tableView.estimatedRowHeight = 100
        initializeXibs()
        footerView.dropShadow()
        actionItemStatusLabel.text = actionItemObject?.status
        dueDateLabel.text = DateTimeUtility.getDDMMYYYDateStringInAction(dateStringfromAccountObject: actionItemObject?.activityDate)//actionItemObject?.activityDate
    }
    
    func initializeXibs(){
        self.tableView.register(UINib(nibName: "AccountContactLinkTableViewCell", bundle: nil), forCellReuseIdentifier: "DropDownCell")
    }
    
    @IBAction func deleteActionItem(_ sender: Any) {
        
        let alert = UIAlertController(title: "Action Item Delete", message: StringConstants.deleteConfirmation, preferredStyle: UIAlertControllerStyle.alert)
        let continueAction = UIAlertAction(title: "Delete", style: .default) {
            action in
            
            
            let attributeDict = ["type":"Task"]
            let editActionItemDict: [String:Any] = [
                ActionItem.AccountActionItemFields[0]: self.actionItemObject!.Id,
                kSyncTargetLocal:true,
                kSyncTargetLocallyCreated:false,
                kSyncTargetLocallyUpdated:false,
                kSyncTargetLocallyDeleted:true,
                "attributes":attributeDict]
            
            let success = AccountsActionItemViewModel().deleteActionItemLocally(fields: editActionItemDict)
            if(success){
                self.delegate?.updateList()
                self.dismiss(animated: true, completion: nil)
            }
            else {
                //Alert errors
            }
        }
        alert.addAction(continueAction)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func closeButtonTapped(_ sender: UIButton){
        DispatchQueue.main.async {
            self.delegate?.updateList()
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func toggleCompleteButton(){
        if self.actionItemObject!.status == "Completed"{
            DispatchQueue.main.async {
                self.Complete_Open_Button.setTitle("Open", for: .normal)
            }
        }else{
            DispatchQueue.main.async {
                self.Complete_Open_Button.setTitle("Complete", for: .normal)
            }
        }
    }
    
    func setStatusOnDB(){
        if Complete_Open_Button.titleLabel?.text  == "Complete"{
            DispatchQueue.main.async {
                self.completeEditActionItem()
                self.Complete_Open_Button.setTitle("Open", for: .normal)
            }
        }else{
            DispatchQueue.main.async {
                self.openEditActionItem()
                self.Complete_Open_Button.setTitle("Complete", for: .normal)
            }
        }
    }
    
    @IBAction func statusChangeButtonTapped(_ sender: UIButton){
        toggleCompleteButton()
        setStatusOnDB()       
    }
    
    func getTimestamp() -> String{
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000+0000"
        let timeStamp = dateFormatter.string(from: date)
        return timeStamp
    }
    
    
    func completeEditActionItem(){
        
        var editActionItem = ActionItem(for: "editActionItem")
        editActionItem = actionItemObject!
        
        editActionItem.accountId = (selectedAccount?.account_Id)!
        editActionItem.subject   =  self.actionItemObject!.subject
        editActionItem.description = self.actionItemObject!.description
        editActionItem.activityDate = self.actionItemObject!.activityDate
        editActionItem.isUrgent =   self.actionItemObject!.isUrgent
        editActionItem.status =     "Completed"
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
            self.delegate?.updateList()
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func openEditActionItem(){
        
        var editActionItem = ActionItem(for: "editActionItem")
        editActionItem = actionItemObject!
        
        editActionItem.accountId = (selectedAccount?.account_Id)!
        editActionItem.subject   =  self.actionItemObject!.subject
        editActionItem.description = self.actionItemObject!.description
        editActionItem.activityDate = self.actionItemObject!.activityDate
        editActionItem.isUrgent =   self.actionItemObject!.isUrgent
        editActionItem.status =     "Open"
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
            self.delegate?.updateList()
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    @IBAction func editButtonTapped(_ sender: UIButton){
        DispatchQueue.main.async {
            let createActionItemViewController = UIStoryboard(name: "ActionItem", bundle: nil).instantiateViewController(withIdentifier :"CreateNewActionItemViewController") as! CreateNewActionItemViewController
            createActionItemViewController.isEditingMode = true
            createActionItemViewController.actionItemId = self.actionItemId
            createActionItemViewController.delegate = self
            self.present(createActionItemViewController, animated: true)
        }
    }
}



extension ActionItemDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ActionItemTitleDetailTableViewCell") as? ActionItemTitleDetailTableViewCell
            cell?.displayCellContent(actionItem: actionItemObject!)
            return cell!
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ActionItemDescriptionTableViewCell") as? ActionItemDescriptionTableViewCell
            cell?.headerLabel.text = "Linked Account"
            return cell!
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DropDownCell") as? AccountContactLinkTableViewCell
            cell?.containerTrailingConstraint.constant = 40
            cell?.containerLeadingConstraint.constant = 20
            cell?.deleteButton.isHidden = true
            if let account = selectedAccount{
                cell?.displayCellContent(account: account)
            }
            return cell!
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ActionItemDescriptionTableViewCell") as? ActionItemDescriptionTableViewCell
            cell?.headerLabel.text = "Action Item Description"
            cell?.subheaderLabel.text = actionItemObject?.description
            return cell!
        default:
            return UITableViewCell()
        }
    }
}

extension ActionItemDetailsViewController:CreateNewActionItemViewControllerDelegate{
    func updateActionDesc() {
        getSelectedActionItem()
        toggleCompleteButton()
    }
    
    func updateActionList() {
        
    }
}
