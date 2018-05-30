//
//  ContactListTableViewCell.swift
//  SWSApp
//
//  Created by shubham.e.shukla on 4/20/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class ContactListTableViewCell: UITableViewCell {

    @IBOutlet weak var initialNameLabel: UILabel!
    @IBOutlet weak var nameValueLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var phoneValueLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailValueLabel: UILabel!
    @IBOutlet weak var linkedAccountWithContact: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initialNameLabel.layer.cornerRadius = 40/2
        initialNameLabel.clipsToBounds = true
        
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

protocol ContactListTableViewButtonCellDelegate : NSObjectProtocol {
    func newContactButtonTapped()
}

class ContactListTableViewButtonCell: UITableViewCell {
    
    @IBOutlet weak var newContactButton: UIButton!
    weak var delegate: ContactListTableViewButtonCellDelegate?
    
    @IBOutlet weak var noOfResultLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.newContactButton.layer.cornerRadius = 4
        newContactButton.clipsToBounds = true
        
        newContactButton.setAttributedTitle(AttributedStringUtil.formatAttributedText(smallString: "Add Contact ", bigString: "+"), for: .normal)
    }
    
    @IBAction func newContactButtonTapped(_ sender: UIButton){
        delegate?.newContactButtonTapped()
    }
}
