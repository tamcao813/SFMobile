//
//  AccountVisitListViewController.swift
//  SWSApp
//
//  Created by Krishna, Kamya on 4/23/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit
import SwipeCellKit

class AccountVisitListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var accountVisitArray = [
        ["title" : "Visit: Crown Liquor Store One", "status" : "Scheduled"],
        ["title" : "Visit: Crown Liquor Store One", "status" : "In Progress"],
        ["title" : "Visit: Crown Liquor Store One", "status" : "Completed"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizedUI()
        initializingXIBs()
    }

    func customizedUI(){
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        self.tableView.estimatedRowHeight = 100
        self.tableView.allowsSelection = true
        self.tableView.allowsMultipleSelectionDuringEditing = true
//        self.tableView.tableFooterView = UIView()
    }
    
    func initializingXIBs(){
        self.tableView.register(UINib(nibName: "AccountVisitListTableViewCell", bundle: nil), forCellReuseIdentifier: "AccountVisitListTableViewCell")
    }
    
    @IBAction func newVisitButtonTapped(_ sender: UIButton){
        
    }

}

extension AccountVisitListViewController : UITableViewDelegate, UITableViewDataSource, SwipeTableViewCellDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accountVisitArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccountVisitListTableViewCell") as? AccountVisitListTableViewCell
        cell?.delegate = self
        cell?.addressLabel.text = accountVisitArray[indexPath.row]["title"]
        cell?.visitStatusLabel.text = accountVisitArray[indexPath.row]["status"]
        if accountVisitArray[indexPath.row]["status"] == "Scheduled"{
            cell?.statusView.backgroundColor = UIColor(hexString: "#CDA635")
        }else if accountVisitArray[indexPath.row]["status"] == "Completed"{
            cell?.statusView.backgroundColor = UIColor(hexString: "#319553")
        }else {
            cell?.statusView.backgroundColor = UIColor(hexString: "#97A124")
        }
        
        return cell!
    }
    
    //MARK:- Table view on Swipe EDIT and DELETE actions
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {

        guard orientation == .right else { return nil }

        let editAction = SwipeAction(style: .default, title: "Edit") {action, indexPath in
            let accountStoryboard = UIStoryboard.init(name: "AccountVisit", bundle: nil)
            let accountVisitsVC = accountStoryboard.instantiateViewController(withIdentifier: "AccountVisitSummaryViewController") as? AccountVisitSummaryViewController
            if self.accountVisitArray[indexPath.row]["status"] == "Scheduled"{
                accountVisitsVC?.visitStatus = .scheduled
            }else if self.accountVisitArray[indexPath.row]["status"] == "Completed"{
                accountVisitsVC?.visitStatus = .completed
            }else {
                accountVisitsVC?.visitStatus = .inProgress
            }
            accountVisitsVC?.modalPresentationStyle = .overCurrentContext
            self.present(accountVisitsVC!, animated: true, completion: nil)
        }
        editAction.image = UIImage(named:"editIcon")
        editAction.backgroundColor = UIColor(named:"InitialsBackground")

        let deleteAction = SwipeAction(style: .default, title: "Delete") {action, indexPath in

        }
        deleteAction.image = UIImage(named:"deletX")
        deleteAction.backgroundColor = UIColor(named:"InitialsBackground")
        return [deleteAction, editAction]
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeTableOptions {
        var options = SwipeTableOptions()
        options.expansionStyle = .destructive
        options.transitionStyle = .border
        return options
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let accountStoryboard = UIStoryboard.init(name: "AccountVisit", bundle: nil)
        let accountVisitsVC = accountStoryboard.instantiateViewController(withIdentifier: "AccountVisitSummaryViewController") as? AccountVisitSummaryViewController
        if accountVisitArray[indexPath.row]["status"] == "Scheduled"{
            accountVisitsVC?.visitStatus = .scheduled
        }else if accountVisitArray[indexPath.row]["status"] == "Completed"{
            accountVisitsVC?.visitStatus = .completed
        }else {
            accountVisitsVC?.visitStatus = .inProgress
        }
        accountVisitsVC?.modalPresentationStyle = .overCurrentContext
        present(accountVisitsVC!, animated: true, completion: nil)
    }
}

enum AccountVisitStatus : String {
    case scheduled
    case inProgress
    case completed
}
