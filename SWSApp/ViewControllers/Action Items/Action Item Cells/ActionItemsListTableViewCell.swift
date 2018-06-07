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
    @IBOutlet weak var accountViewHeightConstraint: NSLayoutConstraint!
    
    func displayCellContent(actionItem: ActionItem){
        actionItemTitleLabel.text = actionItem.subject
        dueDateLabel.text = DateTimeUtility.convertUtcDatetoReadableDateString(dateString: actionItem.activityDate)
        actionItemStatusLabel.text = actionItem.status
        if actionItem.isUrgent {
            urgentImageViewWidthConstarint.constant = 20
            titleLabelLeadingConstraints.constant = 10
        }else{
            urgentImageViewWidthConstarint.constant = 0
            titleLabelLeadingConstraints.constant = 0
        }
        if ActionItemFilterModel.fromAccount{
            accountViewHeightConstraint.constant = 0
        }else{
            accountViewHeightConstraint.constant = 80
            fetchAccountDetails(actionItem: actionItem)
        }
    }
    
    func fetchAccountDetails(actionItem: ActionItem?){
        accountNameLabel.text = actionItem?.accountName
        accountNumberLabel.text = actionItem?.accountNumber
        var fullAddress = ""
        if let shippingStreet = actionItem?.shippingStreet, let shippingCity = actionItem?.shippingCity , let shippingState = actionItem?.shippingState, let shippingPostalCode = actionItem?.shippingPostalCode{
            
            if shippingStreet == "" && shippingCity == "" && shippingState == "" && shippingPostalCode == "" {
                fullAddress = "\(shippingStreet) \(shippingCity) \(shippingState) \(shippingPostalCode)"
            }else{
                if (shippingStreet != "" || shippingCity != "") {
                    if (shippingState != "" || shippingPostalCode != "") {
                        fullAddress = "\(shippingStreet) \(shippingCity), \(shippingState) \(shippingPostalCode)"
                    }else{
                        fullAddress = "\(shippingStreet) \(shippingCity) \(shippingState) \(shippingPostalCode)"
                    }
                }else{
                    fullAddress = "\(shippingStreet) \(shippingCity) \(shippingState) \(shippingPostalCode)"
                }
            }
        }
        accountAddressLabel?.text = fullAddress
    }
}
