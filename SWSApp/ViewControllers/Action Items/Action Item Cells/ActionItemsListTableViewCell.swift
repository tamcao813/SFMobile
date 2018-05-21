//
//  ActionItemsListTableViewCell.swift
//  SWSApp
//
//  Created by manu.a.gupta on 11/05/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit
import SwipeCellKit

class ActionItemsListTableViewCell: SwipeTableViewCell {
    
    @IBOutlet weak var actionItemTitleLabel: UILabel!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var actionItemStatusLabel: UILabel!
    @IBOutlet weak var accountNameLabel: UILabel!
    @IBOutlet weak var accountNumberLabel: UILabel!
    @IBOutlet weak var accountAddressLabel: UILabel!
    @IBOutlet weak var urgentImageViewWidthConstarint: NSLayoutConstraint!
    @IBOutlet weak var titleLabelLeadingConstraints: NSLayoutConstraint!
    
    func displayCellContent(actionItem: ActionItem){
        actionItemTitleLabel.text = actionItem.subject
        dueDateLabel.text = actionItem.activityDate
        actionItemStatusLabel.text = actionItem.status
        if actionItem.isUrgent == "1" {
            urgentImageViewWidthConstarint.constant = 20
            titleLabelLeadingConstraints.constant = 10
        }else{
            urgentImageViewWidthConstarint.constant = 0
            titleLabelLeadingConstraints.constant = 0
        }
//        fetchAccountDetails(actionItem: actionItem)
    }
    
//    func fetchAccountDetails(actionItem: ActionItem){
//        let accountsArray = AccountsViewModel().accountsForLoggedUser
//        for account in accountsArray{
//            if account.account_Id == actionItem.accountId {
//                accountNameLabel.text = account.accountName
//                accountNumberLabel.text = account.accountNumber
//                break
//            }
//        }
//    }
}
