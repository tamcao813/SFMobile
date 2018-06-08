//
//  OpportunitiesListViewController.swift
//  SWSApp
//
//  Created by Thillaiganesh, C. on 31/05/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit
import SwipeCellKit

class OpportunitiesListViewController: UIViewController {

    var opportunityAccountId: String?
    
    var opportunityList = [Opportunity]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        opportunityList = OpportunitySortUtility().opportunityFor(forAccount: OpportunitiesFilterMenuModel.accountId!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
}
