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
    var contactDetail: Contact?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customizedUI()
    }
    
    func customizedUI(){
        firstNameTextField.addPaddingLeft(10)
        lastNameTextField.addPaddingLeft(10)
        preferredNameTextField.addPaddingLeft(10)
    }
    
    func displayCellContent(){
        if let firstName = contactDetail?.firstName, firstName != "" {
            firstNameTextField.text = firstName
        }
        if let lastName = contactDetail?.lastName, lastName != "" {
            lastNameTextField.text = lastName
        }
        if let preferredName = contactDetail?.preferredName, preferredName != "" {
            preferredNameTextField.text = preferredName
        }
    }
}

extension NameTableViewCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        CreateNewContactViewController.createNewGlobals.userInput = true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        contactDetail?.firstName = firstNameTextField.text!
        contactDetail?.lastName  = lastNameTextField.text!
        contactDetail?.preferredName = preferredNameTextField.text!
    }
}
