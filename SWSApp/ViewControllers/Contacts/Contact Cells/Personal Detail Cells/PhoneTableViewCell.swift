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
    var contactDetail: Contact?
    var search:String=""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customizedUI()
    }
    
    func customizedUI(){
        phoneTextField.addPaddingLeft(10)
        faxTextField.addPaddingLeft(10)
    }
    
    func displayCellContent(){
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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.isEmpty{
            search = String(search.characters.dropLast())
        }else{
            search = textField.text!+string
        }
        
        if (removeSpecialCharsFromString(text: search).characters.count) > 10{
            return false
        }
        return true
    }
    
    func removeSpecialCharsFromString(text: String) -> String {
        let okayChars : Set<Character> =
            Set("1234567890".characters)
        return String(text.characters.filter {okayChars.contains($0) })
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        search = textField.text!
        CreateNewContactViewController.createNewGlobals.userInput = true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {        
        textField.text = Validations().validatePhoneNumber(phoneNumber: phoneTextField.text!)
        contactDetail?.phoneNumber = phoneTextField.text!
        contactDetail?.fax = faxTextField.text!
    }       
}

extension String {
    
    public func isPhone()->Bool {
        if self.isAllDigits() == true {
            let phoneRegex = "[235689][0-9]{6}([0-9]{3})?"
            let predicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
            return  predicate.evaluate(with: self)
        }else {
            return false
        }
    }
    
    private func isAllDigits()->Bool {
        let charcterSet  = NSCharacterSet(charactersIn: "+0123456789").inverted
        let inputString = self.components(separatedBy: charcterSet)
        let filtered = inputString.joined(separator: "")
        return  self == filtered
    }
}

