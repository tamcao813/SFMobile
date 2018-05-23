//
//  ActionItemsListViewController.swift
//  SWSApp
//
//  Created by manu.a.gupta on 11/05/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit
import SwipeCellKit

class ActionItemsListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var actionItemsArray = [ActionItem]()
    var filteredActionItemsArray = [ActionItem]()
    var titleAscendingSort = false
    var dueDateAscendingSort = false
    var statusAscendingSort = false
    @IBOutlet weak var actionItemButtonContainerViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tableViewBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.refreshActionItemList), name: NSNotification.Name("refreshActionItemList"), object: nil)
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
    
    @objc func refreshActionItemList(){
        fetchActionItemsFromDB()
    }
    
    func fetchActionItemsFromDB(){
        actionItemsArray = [ActionItem]()
        if ActionItemFilterModel.fromAccount{
            let actionItemsArrayLocal = AccountsActionItemViewModel().getAcctionItemForUser()
            if let accountId = ActionItemFilterModel.accountId {
                for actionItem in actionItemsArrayLocal {
                    if actionItem.accountId == accountId {
                        actionItemsArray.append(actionItem)
                    }
                }
            }
        }else{
            actionItemsArray = AccountsActionItemViewModel().getAcctionItemForUser()
        }
        actionItemsArray = actionItemsArray.sorted(by: { $0.lastModifiedDate > $1.lastModifiedDate })
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
        if titleAscendingSort {
            actionItemsArray = actionItemsArray.sorted(by: { $0.subject < $1.subject })
            titleAscendingSort = false
        }else{
            actionItemsArray = actionItemsArray.sorted(by: { $0.subject > $1.subject })
            titleAscendingSort = true
        }
        reloadTableView()
    }
    
    @IBAction func dueDateSortPressed(_ sender: UIButton){
        if dueDateAscendingSort{
            actionItemsArray = actionItemsArray.sorted(by: { $0.activityDate < $1.activityDate })
            dueDateAscendingSort = false
        }else{
            actionItemsArray = actionItemsArray.sorted(by: { $0.activityDate > $1.activityDate })
            dueDateAscendingSort = true
        }
        reloadTableView()
    }
    
    @IBAction func statusSortPressed(_ sender: UIButton){
        if statusAscendingSort{
            actionItemsArray = actionItemsArray.sorted(by: { $0.status < $1.status })
            statusAscendingSort = false
        }else{
            actionItemsArray = actionItemsArray.sorted(by: { $0.status > $1.status })
            statusAscendingSort = true
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
        if searchText.text != ""{
            filteredActionItemsArray =  ActionItemSortUtility().searchAndFilter(searchStr: searchText.text!, actionItems: actionItemsArray)
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
       // cell?.delegate =  self
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
/*
//MARK:- Swipe Evenyt Delegate Methods
extension ActionItemsListViewController: SwipeTableViewCellDelegate {
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
     
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            self.tableView.beginUpdates()
            self.actionItemsArray.remove(at: indexPath.row)
            self.tableView.endUpdates()
        }
        deleteAction.hidesWhenSelected = true
        deleteAction.image = UIImage(named: "delete")
        deleteAction.backgroundColor = UIColor(named:"InitialsBackground")
     
        let editAction = SwipeAction(style: .default, title: "Edit") { action, indexPath in
            DispatchQueue.main.async {
                let createVisitViewController = UIStoryboard(name: "ActionItem", bundle: nil).instantiateViewController(withIdentifier :"CreateNewActionItemViewController") as! CreateNewActionItemViewController
                createVisitViewController.isEditingMode = true
                createVisitViewController.actionItemObject = self.actionItemsArray[indexPath.row]
                self.present(createVisitViewController, animated: true)
            }
        }
        editAction.hidesWhenSelected = true
        editAction.image = UIImage(named: "delete")
        editAction.backgroundColor = UIColor(named:"InitialsBackground")
     
        var statusText = ""
        var statusImage = UIImage()
        switch actionItemsArray[indexPath.row].status {
        case "Complete":
            statusText = "Complete"
            statusImage = UIImage()
        case "Open":
            statusText = "Open"
            statusImage = UIImage()
        default:
            statusText = actionItemsArray[indexPath.row].status
        }
        let changeStatus = SwipeAction(style: .default, title: statusText) { action, indexPath in
        }
        changeStatus.hidesWhenSelected = true
        changeStatus.image = statusImage
        changeStatus.backgroundColor = UIColor(named:"InitialsBackground")
     
        return [deleteAction,editAction,changeStatus]
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeTableOptions {
        var options = SwipeTableOptions()
        options.expansionStyle = .destructive
        options.transitionStyle = .border
        return options
    }
}*/

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


