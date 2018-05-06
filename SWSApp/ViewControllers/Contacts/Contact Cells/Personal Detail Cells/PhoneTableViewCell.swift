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
        if (search.characters.count) > 10{
            return false
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        CreateNewContactViewController.createNewGlobals.userInput = true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let newString = textField.text! as NSString
        let components = newString.components(separatedBy: NSCharacterSet.decimalDigits.inverted)
        let decimalString = components.joined(separator: "") as NSString
        let length = decimalString.length
        let hasLeadingOne = length > 0 && decimalString.character(at: 0) == (1 as unichar)
        
        var index = 0 as Int
        let formattedString = NSMutableString()
        
        if hasLeadingOne {
            formattedString.append("1 ")
            index += 1
        }
        if (length - index) > 3 {
            let areaCode = decimalString.substring(with: NSMakeRange(index, 3))
            formattedString.appendFormat("(%@)", areaCode)
            index += 3
        }
        if length - index > 3 {
            let prefix = decimalString.substring(with: NSMakeRange(index, 3))
            formattedString.appendFormat("%@-", prefix)
            index += 3
        }
        
        let remainder = decimalString.substring(from: index)
        formattedString.append(remainder)
        textField.text = formattedString as String
                
        contactDetail?.phoneNumber = phoneTextField.text!
        contactDetail?.fax = faxTextField.text!
    }
    
//    func validate(value: String) -> Bool {
//        let PHONE_REGEX = "^.*?..*?.()."
//        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
//        let result =  phoneTest.evaluate(with: value)
//        return result
//    }
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

