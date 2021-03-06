//
//  Validations.swift
//  SWSApp
//
//  Created by manu.a.gupta on 27/04/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation
import UIKit

class Validations {
    
    func isValidDate(dateString: String) -> Bool {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "MM-dd-yyyy"
        if let _ = dateFormatterGet.date(from: dateString) {
            //date parsing succeeded, if you need to do additional logic, replace _ with some variable name i.e date
            return true
        } else {
            // Invalid date
            return false
        }
    }
    
    func isValidEmail(testStr:String) -> Bool {
        print("validate emilId: \(testStr)")
        let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: testStr)
        return result
    }
    
    func validatePhoneNumber(phoneNumber: String) -> String{
        let newString = phoneNumber as NSString
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
            formattedString.appendFormat("(%@) ", areaCode)
            index += 3
        }
        if length - index > 3 {
            let prefix = decimalString.substring(with: NSMakeRange(index, 3))
            formattedString.appendFormat("%@-", prefix)
            index += 3
        }
        
        let remainder = decimalString.substring(from: index)
        formattedString.append(remainder)
        return formattedString as String
    }
    
    func getIntials(name: String) -> String{
        if name == "" { return "" }
        
        let nameSep = name.components(separatedBy: " ")
        if (nameSep == [name]) || (nameSep == ["", nameSep[1]]) || (nameSep == [nameSep[0], ""])  {
            if name.count >= 2 {
                return String(name.prefix(1))
            }
            else {
                return name
            }
        }
        
        let initials = name.components(separatedBy: " ")
        print(initials)
        var firstChar = ""
    
        if(initials[0] != "") {
            let firstCharIndex = initials[0].index(initials[0].startIndex, offsetBy: 1)
            firstChar = String(initials[0][..<firstCharIndex])
            print(firstChar)
        }
        if(initials[1] != "") {
            let firstCharIndex = initials[1].index(initials[1].startIndex, offsetBy: 1)
           // firstChar = String(initials[1][..<firstCharIndex])
            firstChar = firstChar+String(initials[1][..<firstCharIndex])
            print(firstChar)
        }
        return firstChar
    }
    
    func removeSpecialCharsFromString(text: String) -> String {
        let stringValue:String = "1234567890"
        let CharArray = Array(stringValue)
        return String(Array(text).filter {CharArray.contains($0) })
    }
}
