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
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchActionItemsFromDB()
        customizedUI()
    }
    
    func fetchActionItemsFromDB(){
        actionItemsArray = [ActionItem]()
        actionItemsArray = AccountsActionItemViewModel().getAcctionItemForUser()
        tableView.reloadData()
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
            let createVisitViewController = UIStoryboard(name: "ActionItem", bundle: nil).instantiateViewController(withIdentifier :"CreateNewActionItemViewController") as! CreateNewActionItemViewController
            createVisitViewController.isEditingMode = false
            self.present(createVisitViewController, animated: true)
        }
    }
    
}

//MARK:- TableView Delegate, DataSource Methods
extension ActionItemsListViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return actionItemsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ActionItemsListTableViewCell") as? ActionItemsListTableViewCell
        cell?.delegate = self
        cell?.displayCellContent(actionItem: actionItemsArray[indexPath.row])
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            let detailViewController = UIStoryboard(name: "ActionItem", bundle: nil).instantiateViewController(withIdentifier :"ActionItemDetailsViewController") as! ActionItemDetailsViewController
            detailViewController.actionItemObject = self.actionItemsArray[indexPath.row]
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
            self.actionItemsArray.remove(at: indexPath.row)
            self.tableView.endUpdates()
        }
        deleteAction.hidesWhenSelected = true
//        deleteAction.image = UIImage(named: "delete")
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
//        editAction.image = UIImage(named: "delete")
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
//        changeStatus.image = statusImage
        changeStatus.backgroundColor = UIColor(named:"InitialsBackground")
        
        return [deleteAction,editAction,changeStatus]
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeTableOptions {
        var options = SwipeTableOptions()
        options.expansionStyle = .destructive
        options.transitionStyle = .border
        return options
    }
}
