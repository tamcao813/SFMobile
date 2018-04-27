//
//  SelectedAssociateTableViewCell.swift
//  SWSApp
//
//  Created by vipin.vijay on 25/04/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation

class SelectedAssociateTableViewCell: UITableViewCell {
    
    @IBOutlet weak var removeButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func removeCell(sender: UIButton) {
        self.removeFromSuperview()
        NotificationCenter.default.post(name: Notification.Name("REMOVEASSOCIATE"), object: nil, userInfo:["tag":sender.tag])
    }
}
