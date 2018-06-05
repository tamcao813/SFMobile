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
        if let accountId = actionItemObject?.accountId, accountId != ""{
            let accountsArray = AccountsViewModel().accountsForLoggedUser
            for account in accountsArray{
                if account.account_Id == accountId {
                    selectedAccount = account
                    break
                }
            }
        }
        customizedUI()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func customizedUI(){
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        self.tableView.estimatedRowHeight = 100
        initializeXibs()
        footerView.dropShadow()
        actionItemStatusLabel.text = actionItemObject?.status
        if let actionItem = actionItemObject {
            dueDateLabel.text = DateTimeUtility.convertUtcDatetoReadableDateOnlyDate(dateStringfromAccountNotes: actionItem.activityDate)
        }
    }
    
    func initializeXibs(){
        self.tableView.register(UINib(nibName: "AccountContactLinkTableViewCell", bundle: nil), forCellReuseIdentifier: "DropDownCell")
    }
    
    @IBAction func deleteActionItem(_ sender: Any) {
        
        let alert = UIAlertController(title: "Action Item Delete", message: StringConstants.deleteConfirmation, preferredStyle: UIAlertControllerStyle.alert)
        let continueAction = UIAlertAction(title: "Yes", style: .default) {
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
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshAccountOverView"), object:nil)
                if ActionItemFilterModel.fromAccount{
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshActionItemList"), object:nil)
                    
                }
                self.dismiss(animated: true, completion: nil)
            }
            else {
                //Alert errors
            }
        }
        alert.addAction(continueAction)
        alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshAccountOverView"), object:nil)
    }
    
    @IBAction func closeButtonTapped(_ sender: UIButton){
        DispatchQueue.main.async {
            self.delegate?.updateList()
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshAccountOverView"), object:nil)
            if ActionItemFilterModel.fromAccount{
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshActionItemList"), object:nil)
            }
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func toggleCompleteButton(){
        if self.actionItemObject!.status.contains("Comp"){
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
        if (Complete_Open_Button.titleLabel?.text?.contains("Comp"))!{
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
    
    func completeEditActionItem(){
        var editActionItem = ActionItem(for: "editActionItem")
        editActionItem = actionItemObject!
        editActionItem.status = "Complete"
        editActionItem.lastModifiedDate = DateTimeUtility.getCurrentTimeStampInUTCAsString()
        let attributeDict = ["type":"Task"]
        let actionItemDict: [String:Any] = [
            
            ActionItem.AccountActionItemFields[0]: editActionItem.Id,
            ActionItem.AccountActionItemFields[4]: editActionItem.status,
            ActionItem.AccountActionItemFields[7]: editActionItem.lastModifiedDate,
            
            kSyncTargetLocal:true,
            kSyncTargetLocallyCreated:false,
            kSyncTargetLocallyUpdated:true,
            kSyncTargetLocallyDeleted:false,
            "attributes":attributeDict]
        
        let success = AccountsActionItemViewModel().editActionItemStatusLocally(fields: actionItemDict)
        if success {
            self.delegate?.updateList()
            if ActionItemFilterModel.fromAccount{
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshActionItemList"), object:nil)
            }
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func openEditActionItem(){
        var editActionItem = ActionItem(for: "editActionItem")
        editActionItem = actionItemObject!
        editActionItem.status = "Open"
        if editActionItem.activityDate != "",!ActionItemSortUtility().isItOpenState(dueDate: editActionItem.activityDate){
            editActionItem.status = "Overdue"
        }
        
        editActionItem.lastModifiedDate = DateTimeUtility.getCurrentTimeStampInUTCAsString()
        let attributeDict = ["type":"Task"]
        let actionItemDict: [String:Any] = [
            
            ActionItem.AccountActionItemFields[0]: editActionItem.Id,
            ActionItem.AccountActionItemFields[4]: editActionItem.status,
            ActionItem.AccountActionItemFields[7]: editActionItem.lastModifiedDate,
            
            kSyncTargetLocal:true,
            kSyncTargetLocallyCreated:false,
            kSyncTargetLocallyUpdated:true,
            kSyncTargetLocallyDeleted:false,
            "attributes":attributeDict]
        
        let success = AccountsActionItemViewModel().editActionItemStatusLocally(fields: actionItemDict)
        if success {
            self.delegate?.updateList()
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshAccountOverView"), object:nil)
            if ActionItemFilterModel.fromAccount{
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshActionItemList"), object:nil)
            }
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            if let account = selectedAccount{
                return 1
            }
            return 0
        case 3:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
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
                cell?.displayCellContent(account: account, isEditing: true)
            }
                //else{
//                cell?.phoneNumberLabel.text = ""
//                cell?.addressLabel.text = ""
//                cell?.accountLabel.text = ""
//            }
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 2{
            if let accountId = selectedAccount?.account_Id {
                DispatchQueue.main.async {
                    AlertUtilities.showAlertMessageWithTwoActionsAndHandler("Any changes will not be saved", errorMessage: "Are you sure you want to close?", errorAlertActionTitle: "Yes", errorAlertActionTitle2: "No", viewControllerUsed: self, action1: {
                        FilterMenuModel.selectedAccountId = accountId
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showAllAccounts"), object:nil)
                        self.dismiss(animated: true, completion: nil)
                    }){
                        
                    }
                }
            }
        }
    }
}

extension ActionItemDetailsViewController:CreateNewActionItemViewControllerDelegate{
    func updateActionDesc() {
        selectedAccount = nil
        getSelectedActionItem()
        toggleCompleteButton()
    }
    
    func updateActionList() {
        
    }
}
