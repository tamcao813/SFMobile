//
//  ActionItemsListViewController.swift
//  SWSApp
//
//  Created by manu.a.gupta on 11/05/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit
import SwipeCellKit
import SmartSync

class ActionItemsListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var actionItemsArray = [ActionItem]()
    var filteredActionItemsArray = [ActionItem]()
    var titleAscendingSort = false
    var dueDateAscendingSort = false
    var statusAscendingSort = false
    @IBOutlet weak var actionItemButtonContainerViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tableViewBottomConstraint: NSLayoutConstraint!
    var searchStr = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.actionItemSyncDownComplete), name: NSNotification.Name("actionItemSyncDownComplete"), object: nil)
        DispatchQueue.main.async {
            if ActionItemFilterModel.fromAccount{
                self.actionItemButtonContainerViewHeight.constant = 0
                self.tableViewBottomConstraint.constant = 0
            }else{
                self.actionItemButtonContainerViewHeight.constant = 40
                self.tableViewBottomConstraint.constant = 63
            }
        }
        fetchActionItemsFromDB()
    }
    
    @objc func actionItemSyncDownComplete(){
        fetchActionItemsFromDB()
    }
    
    
    @objc func refreshActionItemList(){
        fetchActionItemsFromDB()
    }
    
    func fetchActionItemsFromDB(){
        actionItemsArray = [ActionItem]()
        if ActionItemFilterModel.fromAccount{
            let actionItemsArrayLocal = AccountsActionItemViewModel().actionItemFourMonthsSorted()
            if let accountId = ActionItemFilterModel.accountId {
                for actionItem in actionItemsArrayLocal {
                    if actionItem.accountId == accountId {
                        actionItemsArray.append(actionItem)
                    }
                }
            }
        }else{
            actionItemsArray = AccountsActionItemViewModel().actionItemFourMonthsSorted()
        }
       // actionItemsArray = AccountsActionItemViewModel().actionItemFourMonthsSorted()
        if ActionItemFilterModel.filterApplied {
            applyFilter(searchText: searchStr)
        }
        customizedUI()
        reloadTableView()
    }
    
    func customizedUI(){
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        self.tableView.estimatedRowHeight = 100
        self.tableView.tableFooterView = UIView()
        initializeNibs()
    }
    
    func initializeNibs(){
        self.tableView.register(UINib(nibName: "ActionItemsListTableViewCell", bundle: nil), forCellReuseIdentifier: "ActionItemsListTableViewCell")
    }
    
    @IBAction func newActionItemButtonTapped(_ sender: UIButton){
        DispatchQueue.main.async {
            let createActionItemViewController = UIStoryboard(name: "ActionItem", bundle: nil).instantiateViewController(withIdentifier :"CreateNewActionItemViewController") as! CreateNewActionItemViewController
            createActionItemViewController.isEditingMode = false
            createActionItemViewController.delegate = self
            self.present(createActionItemViewController, animated: true)
        }
    }
    
    @IBAction func titleSortPressed(_ sender: UIButton){
        if ActionItemFilterModel.filterApplied{
            if titleAscendingSort {
                filteredActionItemsArray = filteredActionItemsArray.sorted(by: { $0.subject < $1.subject })
                titleAscendingSort = false
            }else{
                filteredActionItemsArray = filteredActionItemsArray.sorted(by: { $0.subject > $1.subject })
                titleAscendingSort = true
            }
        }else{
            if titleAscendingSort {
                actionItemsArray = actionItemsArray.sorted(by: { $0.subject < $1.subject })
                titleAscendingSort = false
            }else{
                actionItemsArray = actionItemsArray.sorted(by: { $0.subject > $1.subject })
                titleAscendingSort = true
            }
        }
        
        reloadTableView()
    }
    
    @IBAction func dueDateSortPressed(_ sender: UIButton){
        if ActionItemFilterModel.filterApplied{
            if dueDateAscendingSort{
                filteredActionItemsArray = filteredActionItemsArray.sorted(by: { $0.activityDate < $1.activityDate })
                dueDateAscendingSort = false
            }else{
                filteredActionItemsArray = filteredActionItemsArray.sorted(by: { $0.activityDate > $1.activityDate })
                dueDateAscendingSort = true
            }
        }else{
            if dueDateAscendingSort{
                actionItemsArray = actionItemsArray.sorted(by: { $0.activityDate < $1.activityDate })
                dueDateAscendingSort = false
            }else{
                actionItemsArray = actionItemsArray.sorted(by: { $0.activityDate > $1.activityDate })
                dueDateAscendingSort = true
            }
        }
        reloadTableView()
    }
    
    @IBAction func statusSortPressed(_ sender: UIButton){
        if ActionItemFilterModel.filterApplied{
            if statusAscendingSort{
                filteredActionItemsArray = filteredActionItemsArray.sorted(by: { $0.status < $1.status })
                statusAscendingSort = false
            }else{
                filteredActionItemsArray = filteredActionItemsArray.sorted(by: { $0.status > $1.status })
                statusAscendingSort = true
            }
        }else{
            if statusAscendingSort{
                actionItemsArray = actionItemsArray.sorted(by: { $0.status < $1.status })
                statusAscendingSort = false
            }else{
                actionItemsArray = actionItemsArray.sorted(by: { $0.status > $1.status })
                statusAscendingSort = true
            }
        }
        reloadTableView()
    }
    
    func reloadTableView(){
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}

//MARK:- ActionItemSearchButtonTapped Delegate
extension ActionItemsListViewController : ActionItemSearchButtonTappedDelegate{
    func performFilterOperation(searchText: UISearchBar) {
        ActionItemFilterModel.filterApplied = true
        //Perform Search Operation First then do Filtering
        applyFilter(searchText: searchText.text!)
    }
    
    func applyFilter(searchText: String){
        if searchText != ""{
            searchStr = searchText
            filteredActionItemsArray =  ActionItemSortUtility().searchAndFilter(searchStr: searchText, actionItems: actionItemsArray)
        }else{
            filteredActionItemsArray = ActionItemSortUtility().filterOnly(actionItems: actionItemsArray)
        }
        reloadTableView()
    }
    
    func clearFilter(){
        ActionItemFilterModel.filterApplied = false
        reloadTableView()
    }
}

//MARK:- TableView Delegate, DataSource Methods
extension ActionItemsListViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if ActionItemFilterModel.filterApplied{
            return filteredActionItemsArray.count
        }else{
            return actionItemsArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ActionItemsListTableViewCell") as? ActionItemsListTableViewCell
        if ActionItemFilterModel.filterApplied{
            cell?.displayCellContent(actionItem: filteredActionItemsArray[indexPath.row])
        }else{
            cell?.displayCellContent(actionItem: actionItemsArray[indexPath.row])
        }
        cell?.delegate =  self
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            let detailViewController = UIStoryboard(name: "ActionItem", bundle: nil).instantiateViewController(withIdentifier :"ActionItemDetailsViewController") as! ActionItemDetailsViewController
            if ActionItemFilterModel.filterApplied{
                detailViewController.actionItemId = self.filteredActionItemsArray[indexPath.row].Id
            }else{
                detailViewController.actionItemId = self.actionItemsArray[indexPath.row].Id
            }
            detailViewController.delegate = self
            self.present(detailViewController, animated: true)
        }        
    }
}

//MARK:- Swipe Evenyt Delegate Methods
extension ActionItemsListViewController: SwipeTableViewCellDelegate {
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            self.tableView.beginUpdates()
            self.deleteActionItem(index: indexPath.row)
            self.tableView.endUpdates()
        }
        deleteAction.hidesWhenSelected = true
        deleteAction.image = #imageLiteral(resourceName: "deletX")
        deleteAction.backgroundColor = UIColor(named:"InitialsBackground")
        
        let editAction = SwipeAction(style: .default, title: "Edit") { action, indexPath in
            DispatchQueue.main.async {
                let createVisitViewController = UIStoryboard(name: "ActionItem", bundle: nil).instantiateViewController(withIdentifier :"CreateNewActionItemViewController") as! CreateNewActionItemViewController
                createVisitViewController.isEditingMode = true
                if ActionItemFilterModel.filterApplied{
                    createVisitViewController.actionItemId = self.filteredActionItemsArray[indexPath.row].Id
                }else{
                    createVisitViewController.actionItemId = self.actionItemsArray[indexPath.row].Id
                }
                self.present(createVisitViewController, animated: true)
            }
        }
        editAction.hidesWhenSelected = true
        editAction.image = #imageLiteral(resourceName: "editIcon")
        editAction.backgroundColor = UIColor(named:"InitialsBackground")
        
        var statusText = ""
        var statusImage = UIImage()
        switch actionItemsArray[indexPath.row].status {
        case "Complete","Completed":
            statusText = "Open"
            statusImage = #imageLiteral(resourceName: "selectedBlue")
        case "Open","Overdue":
            statusText = "Complete"
            statusImage = #imageLiteral(resourceName: "selectedBlue")
        default:
            break
        }
        let changeStatus = SwipeAction(style: .default, title: statusText) { action, indexPath in
            if statusText.contains("Comp"){
                self.editStatus(index: indexPath.row,statusComplete: true)
            }else{
                self.editStatus(index: indexPath.row,statusComplete: false)
            }
        }
        changeStatus.hidesWhenSelected = true
        changeStatus.image = statusImage
        changeStatus.backgroundColor = UIColor(named:"InitialsBackground")
        
        return [deleteAction,editAction,changeStatus]
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeTableOptions {
        var options = SwipeTableOptions()
        options.transitionStyle = .drag
        return options
    }
}

extension ActionItemsListViewController {
    func editStatus(index: Int,statusComplete: Bool){
        var editActionItem = ActionItem(for: "editActionItem")
        if ActionItemFilterModel.filterApplied{
            editActionItem = self.filteredActionItemsArray[index]
        }else{
            editActionItem = self.actionItemsArray[index]
        }
        if statusComplete {
            editActionItem.status = "Complete"
        }else{
            if ActionItemSortUtility().isItOpenState(dueDate: editActionItem.activityDate){
                editActionItem.status = "Open"
            }else{
                editActionItem.status = "Overdue"
            }
        }
        
        editActionItem.lastModifiedDate = ActionItemSortUtility().getTimestamp()
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
            self.fetchActionItemsFromDB()
        }
    }
    
    func deleteActionItem(index: Int){
        let alert = UIAlertController(title: "Action Item Delete", message: StringConstants.deleteConfirmation, preferredStyle: UIAlertControllerStyle.alert)
        let continueAction = UIAlertAction(title: "Yes", style: .default) {
            action in
            var id = ""
            if ActionItemFilterModel.filterApplied{
                id = self.filteredActionItemsArray[index].Id
            }else{
                id = self.actionItemsArray[index].Id
            }
            
            let attributeDict = ["type":"Task"]
            let editActionItemDict: [String:Any] = [
                ActionItem.AccountActionItemFields[0]: id,
                kSyncTargetLocal:true,
                kSyncTargetLocallyCreated:false,
                kSyncTargetLocallyUpdated:false,
                kSyncTargetLocallyDeleted:true,
                "attributes":attributeDict]
            
            let success = AccountsActionItemViewModel().deleteActionItemLocally(fields: editActionItemDict)
            if(success){
                self.fetchActionItemsFromDB()
            }
            else {
                //Alert errors
            }
        }
        alert.addAction(continueAction)
        alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension ActionItemsListViewController: CreateNewActionItemViewControllerDelegate {
    func updateActionDesc() {
        
    }
    
    func updateActionList() {
        fetchActionItemsFromDB()
    }
}

extension ActionItemsListViewController: ActionItemDetailsViewControllerDelegate {
    func updateList(){
        fetchActionItemsFromDB()
    }
}


