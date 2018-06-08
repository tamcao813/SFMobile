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
        
        if opportunityDetails.productDesc == "" { // TBD This should either one only
            productNameLabel.text = opportunityDetails.productName
        }
        else {
            productNameLabel.text = opportunityDetails.productDesc
        }
        sourceLabel.text = opportunityDetails.recordTypeName
        
        displayViewByCellContent(opportunityDetails)

        monthLabel.text = opportunityDetails.monthActive
        statusLabel.text = opportunityDetails.stageName

        relatedLabel.text = "Related Objectives: " + opportunityDetails.ObjectivesName
    }

    func displayViewByCellContent(_ opportunityDetails: Opportunity) {
        
        if OpportunitiesFilterMenuModel.viewBy9L == "YES" {
            pycmSoldLabel.text = valueAfter9Lcalculation(opportunityDetails, valueToConvert: opportunityDetails.PYCMSold)
            commitLabel.text = valueAfter9Lcalculation(opportunityDetails, valueToConvert: opportunityDetails.commit)
            soldLabel.text = valueAfter9Lcalculation(opportunityDetails, valueToConvert: opportunityDetails.sold)
        }
        else {
            pycmSoldLabel.text = opportunityDetails.PYCMSold
            commitLabel.text = opportunityDetails.commit
            soldLabel.text = opportunityDetails.sold
        }
    }
    
    // (<Value> * the Bottles Per Case for that product * the Size (in Liters) of that product) / 9
    func valueAfter9Lcalculation(_ opportunityDetails: Opportunity, valueToConvert: String) -> String {
        
        // TBD to check for null values input values
        
        let valueInt: Int = (valueToConvert as NSString).integerValue
        let bottlesPerCaseInt: Int = (valueToConvert as NSString).integerValue //TBD not sure with column mapping
        let sizeInt: Int = (opportunityDetails.orderSize as NSString).integerValue

        return String((valueInt * bottlesPerCaseInt * sizeInt) / 9)
    }

}
