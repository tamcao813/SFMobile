//
//  NameTableViewCell.swift
//  SWSApp
//
//  Created by manu.a.gupta on 26/04/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class NameTableViewCell: UITableViewCell {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var preferredNameTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customizedUI()
    }
    
    func customizedUI(){
        firstNameTextField.addPaddingLeft(10)
        lastNameTextField.addPaddingLeft(10)
        preferredNameTextField.addPaddingLeft(10)
    }
}

extension NameTableViewCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}
