//
//  SelectedAssociateTableViewCell.swift
//  SWSApp
//
//  Created by vipin.vijay on 25/04/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation

class SelectedAssociateTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailAddrLabel: UILabel!
    @IBOutlet weak var roleLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var phoneNumLabel: UILabel!
    @IBOutlet weak var removeButton: UIButton!
    @IBOutlet weak var initialNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initialNameLabel.layer.cornerRadius = 40/2
        self.initialNameLabel.clipsToBounds = true
        // Initialization code
    }
    
    @IBAction func removeCell(sender: UIButton) {
        self.removeFromSuperview()
        NotificationCenter.default.post(name: Notification.Name("REMOVEASSOCIATE"), object: nil, userInfo:["tag":sender.tag])
    }
}
