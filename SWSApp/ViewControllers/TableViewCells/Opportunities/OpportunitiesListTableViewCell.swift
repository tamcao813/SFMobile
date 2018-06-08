//
//  OpportunitiesListTableViewCell.swift
//  SWSApp
//
//  Created by Thillaiganesh, C. on 05/06/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit
import SwipeCellKit

class OpportunitiesListTableViewCell: SwipeTableViewCell {

    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var pycmSoldLabel: UILabel!
    @IBOutlet weak var commitLabel: UILabel!
    @IBOutlet weak var soldLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var relatedLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func displayCellContent(_ opportunityDetails: Opportunity) {
        
        productNameLabel.text = opportunityDetails.productDesc
        sourceLabel.text = opportunityDetails.recordTypeName
        
        pycmSoldLabel.text = opportunityDetails.PYCMSold
        commitLabel.text = opportunityDetails.commit
        soldLabel.text = opportunityDetails.sold

        monthLabel.text = opportunityDetails.monthActive
        statusLabel.text = opportunityDetails.stageName

        relatedLabel.text = "Related Objectives: " + opportunityDetails.ObjectivesName
    }

}
