//
//  ContactListAccountFooterDetails.swift
//  SWSApp
//
//  Created by Thillaiganesh, C. on 27/04/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class ContactListAccountFooterDetails: UITableViewCell {

    @IBOutlet weak var accountModifiedValueLabel: UILabel!
    @IBOutlet weak var linkNewAccountContactButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func displayCellContent(_ contactDetails: Contact) {
        accountModifiedValueLabel.text = "Last updated by " + contactDetails.lastModifiedByName
    }

}
