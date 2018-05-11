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
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SZ"
        dateFormatter.timeZone = TimeZone.current
        
        if let date: Date = dateFormatter.date(from: contactDetails.lastModifiedDate) {
            dateFormatter.dateFormat = "MMM d, yyyy"
            if contactDetails.lastModifiedByName == "" {
                accountModifiedValueLabel.text = "Last updated on " + dateFormatter.string(from: date)
            }
            else {
                accountModifiedValueLabel.text = "Last updated on " + dateFormatter.string(from: date) + " by " + contactDetails.lastModifiedByName
            }
        }
        else {
            if contactDetails.lastModifiedByName == "" {
                accountModifiedValueLabel.text = ""
            }
            else {
                accountModifiedValueLabel.text = "Last updated by " + contactDetails.lastModifiedByName
            }
        }

    }

}
