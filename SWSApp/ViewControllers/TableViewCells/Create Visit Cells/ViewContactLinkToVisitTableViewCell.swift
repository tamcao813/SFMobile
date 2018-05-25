//
//  ViewContactLinkToVisitTableViewCell.swift
//  SWSApp
//
//  Created by manu.a.gupta on 08/05/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit
protocol ContactVisitLinkTableViewCellDelegate: NSObjectProtocol  {
    func removeContact()
}

class ViewContactLinkToVisitTableViewCell: UITableViewCell {

    
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var initialsLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var roleLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    weak var delegate: ContactVisitLinkTableViewCellDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func displayCellContent(contact: Contact){
        nameLabel.text = contact.name
        roleLabel.text = contact.functionRole
        phoneNumberLabel.text = contact.phoneNumber
        emailLabel.text = contact.email
    }
    
    @IBAction func deleteButtonTapped(_ sender: UIButton){
        self.delegate.removeContact()
    }
    
}
