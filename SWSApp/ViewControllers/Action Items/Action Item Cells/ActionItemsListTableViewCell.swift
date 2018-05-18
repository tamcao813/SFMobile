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
    
    func displayCellContent(actionItem: ActionItem){
        actionItemTitleLabel.text = actionItem.title
        dueDateLabel.text = actionItem.dueDate
        switch actionItem.status {
        case .complete?:
            actionItemStatusLabel.text = "Complete"
        case .open?:
            actionItemStatusLabel.text = "Open"
        case .overdue?:
            actionItemStatusLabel.text = "Overdue"
        default:
            break
        }
        if actionItem.isItUrgent! {
            urgentImageViewWidthConstarint.constant = 36
        }else{
            urgentImageViewWidthConstarint.constant = 0
        }
    }
    
}
