//
//  ActionItemsContainerViewController.swift
//  SWSApp
//
//  Created by manu.a.gupta on 21/05/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class ActionItemsContainerViewController: UIViewController {
    
    var actionItemFilterVC : ActionItemFilterViewController?
    var actionItemListVC : ActionItemsListViewController?
    var fromPersistentMenu = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if fromPersistentMenu {
            ActionItemFilterModel.fromAccount = false
            ActionItemFilterModel.accountId = nil
        }
        //SNK
       // actionItemFilterVC?.clearActionItemFilterModel()
        actionItemListVC?.refreshActionItemList()
        actionItemFilterVC?.delegate = actionItemListVC
        actionItemListVC?.tableView.setContentOffset(.zero, animated: true)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "listSegue") {
            actionItemListVC = segue.destination as? ActionItemsListViewController
            //actionItemListVC?.delegate = self
            
        }else if (segue.identifier == "filterSegue") {
            actionItemFilterVC = segue.destination as? ActionItemFilterViewController
            
        }
    }
    
    func clearActionItemFilter(){
        actionItemFilterVC?.clearActionItemFilterModel()
    }
    
}


