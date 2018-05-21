//
//  ActionItemTitleDetailTableViewCell.swift
//  SWSApp
//
//  Created by manu.a.gupta on 14/05/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class ActionItemTitleDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var alertImageViewWidthConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func displayCellContent(actionItem: ActionItem){
        titleLabel.text = actionItem.subject
        if actionItem.isUrgent == "1" {
            alertImageViewWidthConstraint.constant = 20
//            titleLabelLeadingConstraints.constant = 10
        }else{
            alertImageViewWidthConstraint.constant = 0
//            titleLabelLeadingConstraints.constant = 0
        }
    }

}
