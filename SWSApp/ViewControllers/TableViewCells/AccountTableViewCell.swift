//
//  AccountTableViewCell.swift
//  SWSApp
//
//  Created by vipin.vijay on 20/04/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class AccountTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var accountLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        self.selectedBackgroundView!.backgroundColor = selected ? .red : nil
        if (selected) {
            self.layer.borderColor = UIColor(red: 66/255, green: 135/255, blue: 194/255, alpha: 1.0).cgColor
            self.layer.borderWidth = 2.0
            let backgroundView = UIView()
            backgroundView.backgroundColor = UIColor.clear
            self.selectedBackgroundView = backgroundView
        } else {
            self.layer.borderColor = UIColor.clear.cgColor
            self.layer.borderWidth = 0.0
        }
    }
    
}

