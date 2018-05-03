//
//  PhoneTableViewCell.swift
//  SWSApp
//
//  Created by manu.a.gupta on 26/04/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class PhoneTableViewCell: UITableViewCell {

    @IBOutlet weak var phoneTextField: CustomUITextField!
    @IBOutlet weak var faxTextField: CustomUITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customizedUI()
    }

    func customizedUI(){
        phoneTextField.addPaddingLeft(10)
        faxTextField.addPaddingLeft(10)
    }
    
    func displayCellContent(contactDetail: Contact?){
        if let phone = contactDetail?.phoneNumber, phone != "" {
            phoneTextField.text = phone
        }
        if let fax = contactDetail?.fax, fax != "" {
            faxTextField.text = fax
        }
    }
}

extension PhoneTableViewCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}
