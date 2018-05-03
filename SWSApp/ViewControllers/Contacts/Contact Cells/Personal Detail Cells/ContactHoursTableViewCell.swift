//
//  ContactHoursTableViewCell.swift
//  SWSApp
//
//  Created by manu.a.gupta on 26/04/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class ContactHoursTableViewCell: UITableViewCell {
    
    @IBOutlet weak var contactHoursTextField: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        customizedUI()
    }
    
    func customizedUI(){
        contactHoursTextField.addPaddingLeft(10)
    }
    
    func displayCellContent(contactDetail: Contact?){
        if let contactHours = contactDetail?.contactHours, contactHours != "" {
            contactHoursTextField.text = contactHours
        }
    }
}

extension ContactHoursTableViewCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}
