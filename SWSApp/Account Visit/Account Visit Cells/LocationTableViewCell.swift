//
//  LocationTableViewCell.swift
//  Acoount Visit
//
//  Created by maco on 19/04/18.
//  Copyright © 2018 maco. All rights reserved.
//

import UIKit


protocol NavigateToAccountAccountVisitSummaryDelegate {
    func navigateToAccountVisitSummaryScreen()
}

class LocationTableViewCell: UITableViewCell {

    var delegate : NavigateToAccountAccountVisitSummaryDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
 
    
    @IBAction func navigateToAccountDetailsScreen(sender : UIButton){
        delegate?.navigateToAccountVisitSummaryScreen()
    }
}
