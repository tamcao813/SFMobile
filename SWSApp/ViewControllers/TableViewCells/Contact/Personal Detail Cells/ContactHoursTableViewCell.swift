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
    var contactDetail: Contact?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customizedUI()
    }
    
    func customizedUI(){
        contactHoursTextField.addPaddingLeft(10)
    }
    
    func displayCellContent(){
        if let contactHours = contactDetail?.contactHours, contactHours != "" {
            contactHoursTextField.text = contactHours
        }
    }
}

extension ContactHoursTableViewCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        CreateNewContactViewController.createNewGlobals.userInput = true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        contactDetail?.contactHours = contactHoursTextField.text!
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return AlertUtilities.disableEmojis(text: string)
    }
}
