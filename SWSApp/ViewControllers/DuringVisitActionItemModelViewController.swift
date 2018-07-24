//
//  DuringVisitActionItemModelViewController.swift
//  SWSApp
//
//  Created by Jagadeeshwar Reddy on 22/06/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation
import SmartSync


protocol NavigateToDuringVisitViewControllerDelegate {
    func navigateToDuringVisitVC()
}


class DuringVisitActionItemModelViewController:UIViewController {
    
    //Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bgView: UIView!
    
    var actionItemsArray = [ActionItem]()
    
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bgView.backgroundColor = UIColor.white
        bgView.layer.shadowColor = UIColor.lightGray.cgColor
        bgView.layer.shadowOpacity = 1
        bgView.layer.shadowOffset = CGSize.zero
        bgView.layer.shadowRadius = 5
        fetchActionItemsFromDB()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    /// Fetches Action Items From Task Table and sort filters 4 months of Action Item in Sort by Date Pattern
    func fetchActionItemsFromDB(){
        actionItemsArray = [ActionItem]()
        let accountId = PlanVisitManager.sharedInstance.visit?.accountId
        let actionItemsArrayLocal = AccountsActionItemViewModel().actionItemFourMonthsDescSorted()
        for actionItem in actionItemsArrayLocal {
            if actionItem.accountId == accountId {
                actionItemsArray.append(actionItem)
            }
        }
    }
    
    var navigationDelegate : NavigateToDuringVisitViewControllerDelegate?
    
    //MARK:- IBActions
    //close button
    @IBAction func closeButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    //view All Action Item Button
    @IBAction func viewAllActionItemButton(_ sender: UIButton) {
        DispatchQueue.main.async {
            AlertUtilities.showAlertMessageWithTwoActionsAndHandler("Any changes will not be saved", errorMessage: "Are you sure you want to close?", errorAlertActionTitle: "Yes", errorAlertActionTitle2: "No", viewControllerUsed: self, action1: {
                
                //self.dismiss(animated: true, completion: nil)
                //self.navigationDelegate?.navigateToDuringVisitVC()
                
                LoadThePersistantMenuScreenItem.loadItemScreen = 1
                self.performSegue(withIdentifier: "unwindToActionItemSegue", sender: nil)
                
            }) {
                
            }
        }

    }
    
}

//MARK:- Delegate and DataSource methods
extension DuringVisitActionItemModelViewController:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return actionItemsArray.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "actionItemModelCellID", for: indexPath) as! ActionItemModalTableViewCell
        cell.selectionStyle = .none
        let actionItem = actionItemsArray[indexPath.row]
        cell.actionItemTitleLbl?.text = actionItem.subject
        cell.dueDateLbl?.text = DateTimeUtility.convertUtcDatetoReadableDateOnlyDate(dateStringfromAccountNotes:  DateTimeUtility().convertMMDDYYYtoUTCWithoutTime(dateString: actionItem.activityDate))
        cell.statusLbl?.text = actionItem.status
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 112
    }
    
}

