//
//  SelectOpportunitiesViewController.swift
//  SWSApp
//
//  Created by vipin.vijay on 26/04/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation
import SwipeCellKit

class SelectOpportunitiesViewController: UIViewController {
    @IBOutlet weak var opportunitiesListView: UITableView!
    var opportunityAccountId: String?
    var opportunityList = [Opportunity]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        opportunityList = OpportunitySortUtility().opportunityFor(forAccount: (PlanVisitManager.sharedInstance.visit?.accountId)!)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("Plan VC will disappear")
        PlanVisitManager.sharedInstance.editPlanVisit = false
    }
    
    
    // MARK:- IBAction
    
    @IBAction func closeVC(sender: UIButton) {
        //STATEMACHINE:No State Change
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshAccountVisitList"), object:nil)
        DispatchQueue.main.async {
            self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func backVC(sender: UIButton) {
        //STATEMACHINE:No State Change
        DispatchQueue.main.async {
            self.dismiss(animated: true)
        }
    }
    
    @IBAction func saveAndClose(sender: UIButton) {
        //STATEMACHINE:If you com tho this Screen its in Planned state
        PlanVisitManager.sharedInstance.visit?.status = "Planned"
        _ = PlanVisitManager.sharedInstance.editAndSaveVisit()
        DispatchQueue.main.async {
            self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func loadStrategyScreen(sender : UIButton){
        
        let accountId = PlanVisitManager.sharedInstance.visit?.accountId
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Strategy", bundle: nil)
        let vc: AccountStrategyViewController = storyboard.instantiateViewController(withIdentifier: "AccountStrategyViewControllerID") as! AccountStrategyViewController
        StrategyScreenLoadFrom.isLoadFromStrategy = "1"
        
        AccountId.selectedAccountId = accountId!
        
        (vc as AccountStrategyViewController).modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        DispatchQueue.main.async {
            self.present(vc, animated: true, completion: nil)
        }
        
    }
    
}
//MARK:- TableView DataSource Methods
extension SelectOpportunitiesViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return opportunityList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "opportunitiesListTableViewCell", for: indexPath) as? OpportunitiesListTableViewCell
        cell?.selectionStyle = .none
        
        cell?.displayCellContent(opportunityList[indexPath.row])
        cell?.delegate =  self
        return cell ?? UITableViewCell()
    }
    
}

//MARK:- Swipe Evenyt Delegate Methods
extension SelectOpportunitiesViewController: SwipeTableViewCellDelegate {
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let editAction = SwipeAction(style: .default, title: "Edit") { action, indexPath in
            DispatchQueue.main.async {
                // TBD action Edit
            }
        }
        editAction.hidesWhenSelected = true
        editAction.image = #imageLiteral(resourceName: "editIcon")
        editAction.backgroundColor = UIColor(named:"InitialsBackground")
        
        return [editAction]
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeTableOptions {
        var options = SwipeTableOptions()
        options.transitionStyle = .drag
        return options
    }
}

//MARK:- TableView Delegate Methods
extension SelectOpportunitiesViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
}
