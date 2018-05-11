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
        customizedUI()
    }
    
    func customizedUI(){
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        self.tableView.estimatedRowHeight = 100
        self.tableView.tableFooterView = UIView()
        actionItemsArray.append(ActionItem(id: "1", title: "Action Item 1", dueDate: "2018-02-15", account: "Crown Liquor Store", status: .complete, description: "Action Item 1 Crown Liquor Store", isItUrgent: true))
        actionItemsArray.append(ActionItem(id: "1", title: "Action Item 1", dueDate: "2018-02-15", account: "Crown Liquor Store", status: .open, description: "Action Item 1 Crown Liquor Store", isItUrgent: false))
        initializeNibs()
    }
    
    func initializeNibs(){
        self.tableView.register(UINib(nibName: "ActionItemsListTableViewCell", bundle: nil), forCellReuseIdentifier: "ActionItemsListTableViewCell")
    }
    
    @IBAction func newActionItemButtonTapped(_ sender: UIButton){
        let createVisitViewController = UIStoryboard(name: "ActionItem", bundle: nil).instantiateViewController(withIdentifier :"CreateNewActionItemViewController") as! CreateNewActionItemViewController
        createVisitViewController.isEditingMode = false        
        self.present(createVisitViewController, animated: true)
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
}

//MARK:- Swipe Evenyt Delegate Methods
extension ActionItemsListViewController: SwipeTableViewCellDelegate {
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .default, title: "Delete") { action, indexPath in
            return
        }
        deleteAction.hidesWhenSelected = true
//        deleteAction.image = UIImage(named: "delete")
        deleteAction.backgroundColor = UIColor(named:"InitialsBackground")
        
        let editAction = SwipeAction(style: .default, title: "Edit") { action, indexPath in
        }
        editAction.hidesWhenSelected = true
//        editAction.image = UIImage(named: "delete")
        editAction.backgroundColor = UIColor(named:"InitialsBackground")
        
        var statusText = ""
        var statusImage = UIImage()
        switch actionItemsArray[indexPath.row].status {
        case .complete?:
            statusText = "Complete"
            statusImage = UIImage()
        case .open?:
            statusText = "Open"
            statusImage = UIImage()
        case .overdue?:
            statusText = "Overdue"
            statusImage = UIImage()
        default:
            break
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

class ActionItem {
    var id: String?
    var title: String?
    var dueDate: String?
    var account: String?
    var status: ActionItemStatus?
    var description: String?
    var isItUrgent: Bool?
    
    init(id: String?,title: String?,dueDate: String?,account: String?, status: ActionItemStatus?, description: String?, isItUrgent: Bool?) {
        self.id = id
        self.title = title
        self.dueDate = dueDate
        self.account = account
        self.status = status
        self.description = description
        self.isItUrgent = isItUrgent
    }
}

enum ActionItemStatus {
    case complete
    case open
    case overdue
}
