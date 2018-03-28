//
//  ContactTableViewCell.swift
//  SWSApp
//
//  Created by shubham.e.shukla on 3/27/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {

    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var initialsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.initialsLabel.layer.cornerRadius = 50/2
        initialsLabel.layer.borderWidth = 1
        
        initialsLabel.clipsToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
