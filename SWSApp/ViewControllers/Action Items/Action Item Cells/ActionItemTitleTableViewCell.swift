//
//  ActionItemTitleTableViewCell.swift
//  SWSApp
//
//  Created by manu.a.gupta on 11/05/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class ActionItemTitleTableViewCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var actionTitleTextField: UITextField!
    @IBOutlet weak var actionHeaderLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        customizedUI()
    }
    
    func customizedUI(){
        actionTitleTextField.delegate = self
        actionTitleTextField.addPaddingLeft(10)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.tag == 0{
            CreateNewEventViewControllerGlobals.eventTitle = textField.text!
        }else if textField.tag == 6{
            CreateNewEventViewControllerGlobals.location = textField.text!
        }
        
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
