//
//  OpportunitiesListViewCell.swift
//  SWSApp
//
//  Created by chandana on 12/06/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit
import SwipeCellKit


class OpportunitiesListViewCell: SwipeTableViewCell {
    
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var pycmSoldLabel: UILabel!
    @IBOutlet weak var commitLabel: UILabel!
    @IBOutlet weak var soldLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var selectedIcon : UIImageView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        
    }
    
    func displayCellContent(_ opportunityDetails: Opportunity) {
        
        productNameLabel.text = opportunityDetails.productName
        sourceLabel.text = opportunityDetails.source
       
        if opportunityDetails.isOpportunitySelected {
            selectedIcon?.isHidden = false
            self.layer.borderColor = UIColor(named: "Data New")?.cgColor
            self.layer.borderWidth = 2
        }else{
            selectedIcon?.isHidden = true
             self.layer.borderColor = UIColor.lightGray.cgColor
            self.layer.borderWidth = 1
        }
        displayViewByCellContent(opportunityDetails)
        statusLabel.text = opportunityDetails.status
    }
    
    func displayViewByCellContent(_ opportunityDetails: Opportunity) {
        
        if OpportunitiesFilterMenuModel.viewBy9L == "YES" {
            pycmSoldLabel.text = opportunityDetails.PYCMSold9L
            commitLabel.text = opportunityDetails.commit9L
            soldLabel.text = opportunityDetails.sold9L
        }else {
            pycmSoldLabel.text = opportunityDetails.PYCMSold
            commitLabel.text = opportunityDetails.commit
            soldLabel.text = opportunityDetails.sold
        }
    }
    
}
