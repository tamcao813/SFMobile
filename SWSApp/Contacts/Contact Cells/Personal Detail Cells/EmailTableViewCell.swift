//
//  EmailTableViewCell.swift
//  SWSApp
//
//  Created by manu.a.gupta on 26/04/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class EmailTableViewCell: UITableViewCell {

    @IBOutlet weak var emailTextField: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        customizedUI()
    }

    func customizedUI(){
        emailTextField.addPaddingLeft(10)
    }
    
}

extension EmailTableViewCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}

