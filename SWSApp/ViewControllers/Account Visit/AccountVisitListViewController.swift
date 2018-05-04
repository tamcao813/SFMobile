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
        ["title" : "Visit: Crown Liquor Store One", "status" : "Completed"],
        ["title" : "Visit: Crown Liquor Store One", "status" : "Planned"]]
    
    var tableViewData : [Visit]?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizedUI()
        initializingXIBs()
        getTheDataFromDB()
    }
    
    func getTheDataFromDB(){
        let visitArray = VisitsViewModel()
        
        tableViewData = visitArray.visitsForUser()
        
        print(tableViewData)
        
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
        let storyboard = UIStoryboard(name: "PlanVisitEditableScreen", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier :"PlanVisitViewControllerID")
        viewController.modalPresentationStyle = .overCurrentContext
        self.present(viewController, animated: true)
    }
    
}

extension AccountVisitListViewController : UITableViewDelegate, UITableViewDataSource, SwipeTableViewCellDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewData!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccountVisitListTableViewCell") as? AccountVisitListTableViewCell
        cell?.delegate = self
        
        let celldata = tableViewData![indexPath.row]
        cell?.displayCellData(data: celldata)
        
        
//        cell?.addressLabel.text = accountVisitArray[indexPath.row]["title"]
//        cell?.visitStatusLabel.text = accountVisitArray[indexPath.row]["status"]
//        if accountVisitArray[indexPath.row]["status"] == "Scheduled"{
//            cell?.statusView.backgroundColor = UIColor(hexString: "#CDA635")
//        }else if accountVisitArray[indexPath.row]["status"] == "Completed"{
//            cell?.statusView.backgroundColor = UIColor(hexString: "#319553")
//        }else {
//            cell?.statusView.backgroundColor = UIColor(hexString: "#97A124")
//        }
        
        return cell!
    }
    
    //MARK:- Table view on Swipe EDIT and DELETE actions
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        
        guard orientation == .right else { return nil }
        
        let editAction = SwipeAction(style: .default, title: "Edit") {action, indexPath in
            let accountStoryboard = UIStoryboard.init(name: "AccountVisit", bundle: nil)
            let accountVisitsVC = accountStoryboard.instantiateViewController(withIdentifier: "AccountVisitSummaryViewController") as? AccountVisitSummaryViewController
            
            let data : Visit = self.tableViewData![indexPath.row]
            
            if data.status == "Scheduled"{
                accountVisitsVC?.visitStatus = .scheduled
            }else if data.status  == "Completed"{
                accountVisitsVC?.visitStatus = .completed
            }else {
                accountVisitsVC?.visitStatus = .inProgress
            }
            accountVisitsVC?.modalPresentationStyle = .overCurrentContext
            self.present(accountVisitsVC!, animated: true, completion: nil)
        }
        
        editAction.hidesWhenSelected = true
        editAction.image = UIImage(named:"editIcon")
        editAction.backgroundColor = UIColor(named:"InitialsBackground")
        
        let deleteAction = SwipeAction(style: .default, title: "Delete") {action, indexPath in
            
            let cell = tableView.cellForRow(at: indexPath) as! AccountVisitListTableViewCell
            let closure: (UIAlertAction) -> Void = { _ in cell.hideSwipe(animated: true) }
            
            
//            AlertUtilities.showAlertMessageWithTwoActionsAndHandler("Visit Delete", errorMessage: StringConstants.deleteConfirmation, errorAlertActionTitle: "Cancel", errorAlertActionTitle2: "Delete", viewControllerUsed: self, action1: {
//                print("Cancel")
//                closure
//            }, action2: {
//                print("Delete")
//                closure
//            })
            
            
            
            let alert = UIAlertController(title: "Visit Delete", message: StringConstants.deleteConfirmation, preferredStyle: UIAlertControllerStyle.alert)
            
            let continueAction = UIAlertAction(title: "Delete", style: .default , handler: closure)
            alert.addAction(continueAction)
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: closure))
            self.present(alert, animated: true, completion: nil)
            
            
        }
        deleteAction.image = UIImage(named:"deletX")
        deleteAction.backgroundColor = UIColor(named:"InitialsBackground")
        return [deleteAction, editAction]
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeTableOptions {
        var options = SwipeTableOptions()
        //options.expansionStyle = .
        options.transitionStyle = .border
        return options
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let accountStoryboard = UIStoryboard.init(name: "AccountVisit", bundle: nil)
        let accountVisitsVC = accountStoryboard.instantiateViewController(withIdentifier: "AccountVisitSummaryViewController") as? AccountVisitSummaryViewController
        
        let data : Visit = tableViewData![indexPath.row]
        PlanVistManager.sharedInstance.visit = tableViewData![indexPath.row]
        PlanVistManager.sharedInstance.editPlanVisit = true
        if data.status == "Scheduled"{
            accountVisitsVC?.visitStatus = .scheduled
        }else if data.status  == "Completed"{
            accountVisitsVC?.visitStatus = .completed
        }else if data.status  == "In-Progress"{
            accountVisitsVC?.visitStatus = .inProgress
        }else if data.status  == "Planned"{
            accountVisitsVC?.modalPresentationStyle = .overCurrentContext
        }
        present(accountVisitsVC!, animated: true, completion: nil)
        accountVisitsVC?.modalPresentationStyle = .overCurrentContext
        (accountVisitsVC)?.delegate = self
    }
}

//MARK:- NavigateToContacts Delegate
extension AccountVisitListViewController : NavigateToContactsDelegate{
    
    //Send a notification to Parent VC to load respective VC
    func navigateTheScreenToContactsInPersistantMenu(data: LoadThePersistantMenuScreen) {        
        if data == .contacts{
            ContactFilterMenuModel.comingFromDetailsScreen = ""
            ContactsGlobal.accountId = ""

            // Added this line so that Contact detail view is not launched for this scenario.
            ContactFilterMenuModel.selectedContactId = ""

            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showAllContacts"), object:nil)
        }else {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "loadMoreScreens"), object:data.rawValue)
            
        }
    }
    
    func navigateToAccountScreen() {
        
        // Added this line so that Account detail view is not launched for this scenario.
        FilterMenuModel.selectedAccountId = ""

         NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showAllAccounts"), object:nil)
    }
}


enum AccountVisitStatus : String {
    case scheduled
    case inProgress
    case completed
    case planned
}
