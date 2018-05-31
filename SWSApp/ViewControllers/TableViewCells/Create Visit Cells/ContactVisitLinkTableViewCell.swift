//
//  ContactVisitLinkTableViewCell.swift
//  SWSApp
//
//  Created by manu.a.gupta on 08/05/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit
//import DropDown

class ContactVisitLinkTableViewCell: DropDownCell {
    
    @IBOutlet weak var roleLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var intialLabel: UILabel!
    
    weak var delegate : ContactVisitLinkTableViewCellDelegate!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func displayCellContent(contact: Contact){
        roleLabel.text = contact.functionRole
        phoneNumberLabel.text = contact.phoneNumber
        emailLabel.text = contact.email
        let fullName = contact.firstName + " " + contact.lastName
        intialLabel.text = contact.getIntials(name: fullName)
    }
    
}
