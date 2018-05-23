//
//  ActionItemTitleTableViewCell.swift
//  SWSApp
//
//  Created by manu.a.gupta on 11/05/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class ActionItemTitleTableViewCell: UITableViewCell {

    @IBOutlet weak var actionTitleTextField: UITextField!
    var actionItemObject: ActionItem?
    override func awakeFromNib() {
        super.awakeFromNib()
        customizedUI()
    }
    
    func customizedUI(){
        actionTitleTextField.delegate = self
        actionTitleTextField.addPaddingLeft(10)
    }
}

extension ActionItemTitleTableViewCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        actionItemObject?.subject = textField.text!
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}
