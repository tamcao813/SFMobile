//
//  ContactListDetailsTableViewCell.swift
//  SWSApp
//
//  Created by shubham.e.shukla on 4/21/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class ContactListDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var initialNameLabel: UILabel!
    @IBOutlet weak var nameValueLabel: UILabel!
    @IBOutlet weak var phoneValueLabel: UILabel!
    @IBOutlet weak var emailValueLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        initialNameLabel.layer.cornerRadius = initialNameLabel.frame.size.width/2
        initialNameLabel.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func displayCellContent(_ contactDetails: Contact){
        
        let fullName = contactDetails.firstName + " " + contactDetails.lastName
        initialNameLabel.text = contactDetails.getIntials(name: fullName)
        nameValueLabel.text = fullName
        phoneValueLabel.text = contactDetails.phoneuNmber
        emailValueLabel.text =  contactDetails.email

    }

}
