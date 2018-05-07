//
//  AssociatedContactsTableViewCell.swift
//  Acoount Visit
//
//  Created by maco on 19/04/18.
//  Copyright © 2018 maco. All rights reserved.
//

import UIKit

class AssociatedContactsTableViewCell: UITableViewCell {

    @IBOutlet weak var initialsLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var functionRoleLabel: UILabel!
    @IBOutlet weak var containerHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()        
    }
    
    func displayCellContent(visit: Visit){
        nameLabel.text = visit.contactName
        phoneLabel.text = visit.contactPhone
        emailLabel.text = visit.contactEmail
        functionRoleLabel.text = visit.contactSGWS_Roles
        initialsLabel.text = Validations().getIntials(name: visit.contactName)
    }
    
}
