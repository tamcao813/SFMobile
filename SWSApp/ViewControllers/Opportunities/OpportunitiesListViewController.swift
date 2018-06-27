//
//  OpportunitiesListViewController.swift
//  SWSApp
//
//  Created by Thillaiganesh, C. on 31/05/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit
import SwipeCellKit

class OpportunitiesListViewController: UIViewController,ParentViewControllerDelegate {
    
    func getUpdatedDataFromServer(accounts: [Opportunity]) {
        opportunityList = OpportunitySortUtility().opportunityFor(forAccount: OpportunitiesFilterMenuModel.accountId!)
        self.opportunitiesListTableView.reloadData()
    }
    
    @IBOutlet weak var opportunitiesListTableView: UITableView!

    var opportunityAccountId: String?
    
    var opportunityList = [Opportunity]()
    
    var opportunityId = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        ParentViewController.delegate = self
        
        // Do any additional setup after loading the view.
        opportunityList = OpportunitySortUtility().opportunityFor(forAccount: OpportunitiesFilterMenuModel.accountId!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- Sort Button Actions
    @IBAction func actionSortProductName(_ sender: Any) {
        
        if OpportunitiesFilterMenuModel.isAscendingProductName == "YES" {
            OpportunitiesFilterMenuModel.isAscendingProductName = "NO"
        }
        else {
            OpportunitiesFilterMenuModel.isAscendingProductName = "YES"
        }
        OpportunitiesFilterMenuModel.isAscendingSource = ""
        OpportunitiesFilterMenuModel.isAscendingPYCMSold = ""
        OpportunitiesFilterMenuModel.isAscendingCommit = ""
        OpportunitiesFilterMenuModel.isAscendingSold = ""
        OpportunitiesFilterMenuModel.isAscendingMonth = ""
        OpportunitiesFilterMenuModel.isAscendingStatus = ""
        
        sortAndRelaodTable()
    }
    
    @IBAction func actionSortSource(_ sender: Any) {
        
        if OpportunitiesFilterMenuModel.isAscendingSource == "YES" {
            OpportunitiesFilterMenuModel.isAscendingSource = "NO"
        }
        else {
            OpportunitiesFilterMenuModel.isAscendingSource = "YES"
        }
        OpportunitiesFilterMenuModel.isAscendingProductName = ""
        OpportunitiesFilterMenuModel.isAscendingPYCMSold = ""
        OpportunitiesFilterMenuModel.isAscendingCommit = ""
        OpportunitiesFilterMenuModel.isAscendingSold = ""
        OpportunitiesFilterMenuModel.isAscendingMonth = ""
        OpportunitiesFilterMenuModel.isAscendingStatus = ""
        
        sortAndRelaodTable()
    }
    
    @IBAction func actionSortPYCMSold(_ sender: Any) {
        
        if OpportunitiesFilterMenuModel.isAscendingPYCMSold == "YES" {
            OpportunitiesFilterMenuModel.isAscendingPYCMSold = "NO"
        }
        else {
            OpportunitiesFilterMenuModel.isAscendingPYCMSold = "YES"
        }
        OpportunitiesFilterMenuModel.isAscendingProductName = ""
        OpportunitiesFilterMenuModel.isAscendingSource = ""
        OpportunitiesFilterMenuModel.isAscendingCommit = ""
        OpportunitiesFilterMenuModel.isAscendingSold = ""
        OpportunitiesFilterMenuModel.isAscendingMonth = ""
        OpportunitiesFilterMenuModel.isAscendingStatus = ""
        
        sortAndRelaodTable()
    }
    
    @IBAction func actionSortCommit(_ sender: Any) {
        
        if OpportunitiesFilterMenuModel.isAscendingCommit == "YES" {
            OpportunitiesFilterMenuModel.isAscendingCommit = "NO"
        }
        else {
            OpportunitiesFilterMenuModel.isAscendingCommit = "YES"
        }
        OpportunitiesFilterMenuModel.isAscendingProductName = ""
        OpportunitiesFilterMenuModel.isAscendingSource = ""
        OpportunitiesFilterMenuModel.isAscendingPYCMSold = ""
        OpportunitiesFilterMenuModel.isAscendingSold = ""
        OpportunitiesFilterMenuModel.isAscendingMonth = ""
        OpportunitiesFilterMenuModel.isAscendingStatus = ""
        
        sortAndRelaodTable()
    }
    
    @IBAction func actionSortSold(_ sender: Any) {
        
        if OpportunitiesFilterMenuModel.isAscendingSold == "YES" {
            OpportunitiesFilterMenuModel.isAscendingSold = "NO"
        }
        else {
            OpportunitiesFilterMenuModel.isAscendingSold = "YES"
        }
        OpportunitiesFilterMenuModel.isAscendingProductName = ""
        OpportunitiesFilterMenuModel.isAscendingSource = ""
        OpportunitiesFilterMenuModel.isAscendingPYCMSold = ""
        OpportunitiesFilterMenuModel.isAscendingCommit = ""
        OpportunitiesFilterMenuModel.isAscendingMonth = ""
        OpportunitiesFilterMenuModel.isAscendingStatus = ""
        
        sortAndRelaodTable()
    }
    
    @IBAction func actionSortMonth(_ sender: Any) {
        
        if OpportunitiesFilterMenuModel.isAscendingMonth == "YES" {
            OpportunitiesFilterMenuModel.isAscendingMonth = "NO"
        }
        else {
            OpportunitiesFilterMenuModel.isAscendingMonth = "YES"
        }
        OpportunitiesFilterMenuModel.isAscendingProductName = ""
        OpportunitiesFilterMenuModel.isAscendingSource = ""
        OpportunitiesFilterMenuModel.isAscendingPYCMSold = ""
        OpportunitiesFilterMenuModel.isAscendingCommit = ""
        OpportunitiesFilterMenuModel.isAscendingSold = ""
        OpportunitiesFilterMenuModel.isAscendingStatus = ""
        
        sortAndRelaodTable()
    }
    
    @IBAction func actionSortStatus(_ sender: Any) {
        
        if OpportunitiesFilterMenuModel.isAscendingStatus == "YES" {
            OpportunitiesFilterMenuModel.isAscendingStatus = "NO"
        }
        else {
            OpportunitiesFilterMenuModel.isAscendingStatus = "YES"
        }
        OpportunitiesFilterMenuModel.isAscendingProductName = ""
        OpportunitiesFilterMenuModel.isAscendingSource = ""
        OpportunitiesFilterMenuModel.isAscendingPYCMSold = ""
        OpportunitiesFilterMenuModel.isAscendingCommit = ""
        OpportunitiesFilterMenuModel.isAscendingSold = ""
        OpportunitiesFilterMenuModel.isAscendingMonth = ""
        
        sortAndRelaodTable()
    }
    
    func sortAndRelaodTable() {
        
       opportunityList =  OpportunitySortUtility().opportunitySort(opportunityList)

        opportunitiesListTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "opportunitiesWebView") {
            let opportunityWebViewVC = segue.destination as? OpportunitiesWebViewController
            opportunityWebViewVC?.opportunityWebViewId = opportunityId
            
        }
        
    }
    
}

//MARK:- TableView DataSource Methods
extension OpportunitiesListViewController : UITableViewDataSource {
    
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
extension OpportunitiesListViewController: SwipeTableViewCellDelegate {
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let editAction = SwipeAction(style: .default, title: "Edit") { action, indexPath in
            DispatchQueue.main.async {
                // TBD action Edit
                self.opportunityId = self.opportunityList[indexPath.row].id
                self.performSegue(withIdentifier: "opportunitiesWebView", sender: nil)
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
extension OpportunitiesListViewController : UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        opportunityId = opportunityList[indexPath.row].id
        self.performSegue(withIdentifier: "opportunitiesWebView", sender: nil)
    }
}

//MARK:- SearchCalendarByEnteredTextDelegate Delegate
extension OpportunitiesListViewController : SearchOpportunitiesByEnteredTextDelegate{
    
    func sortOpportunitiesData(searchString: String) {
        print("sortOpportunitiesData")
    }
    
    func filteringOpportunities(filtering: Bool) {
        if !filtering {
            opportunityList = OpportunitySortUtility().opportunityFor(forAccount: OpportunitiesFilterMenuModel.accountId!)
            DispatchQueue.main.async {
                self.opportunitiesListTableView.reloadData()
            }
        }
    }
    
    func performOpportunitiesFilterOperation(searchString: String) {
        if let opportunitiesFiltered = OpportunitySortUtility().searchOpportunityBySearchBarQuery(opportunityToSearch: OpportunitySortUtility().opportunityFor(forAccount: OpportunitiesFilterMenuModel.accountId!), searchText: searchString) {
            
            opportunityList = opportunitiesFiltered
        }
        else {
            opportunityList = OpportunitySortUtility().opportunityFor(forAccount: OpportunitiesFilterMenuModel.accountId!)
        }

        DispatchQueue.main.async {
            self.opportunitiesListTableView.reloadData()
        }
    }
    
}
