//
//  ContactListAccountHeaderDetails.swift
//  SWSApp
//
//  Created by Thillaiganesh, C. on 27/04/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class ContactListAccountHeaderDetails: UITableViewCell {

    @IBOutlet weak var accountLinkedToValueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func displayCellContent(_ contactDetails: Contact) {
        accountLinkedToValueLabel.text = "Accounts Linked to " + contactDetails.firstName
    }
    
}
