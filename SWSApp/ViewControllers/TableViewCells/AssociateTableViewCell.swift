//
//  AssiciateTableViewCell.swift
//  SWSApp
//
//  Created by vipin.vijay on 24/04/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation

class AssociateTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailAddrLabel: UILabel!
    @IBOutlet weak var roleLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var phoneNumLabel: UILabel!
    @IBOutlet weak var initialNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initialNameLabel.layer.cornerRadius = 40/2
        self.initialNameLabel.clipsToBounds = true
        
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
