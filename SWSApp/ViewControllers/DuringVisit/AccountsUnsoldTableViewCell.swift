//
//  AccountsUnsoldTableViewCell.swift
//  SWSApp
//
//  Created by chandana on 21/06/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation


import UIKit

class AccountsUnsoldTableViewCell: UITableViewCell {
    
   
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var unsoldPeriodLabel: UILabel!
    @IBOutlet weak var commitAmtLabel: UILabel!
    @IBOutlet weak var outcomeLabel: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}

