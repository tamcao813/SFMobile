//
//  DateTimeUtility.swift
//  SWSApp
//
//  Created by shilpa.a.kulkarni on 13/04/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation
class DateTimeUtility
{
    static func getDDMMYYYFormattedDateString(dateStringfromAccountObject:String?)->String
    {
        // 13April Shilpa: Handling the empty date coming from backend for some of the accounts 1969
        if(dateStringfromAccountObject?.count == 0 || dateStringfromAccountObject == "1969-12-31")
        {
            return ""
        }
        //print("dateStringfromAccountObject: " + dateStringfromAccountObject!)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"// MM/DD/YYYY
        // get Date object from dateStringfromAccountObject
        let dateObjectFromDateStringfromAccountObject:Date = dateFormatter.date(from: dateStringfromAccountObject!)!
        dateFormatter.dateFormat = "mm/dd/yyyy"// MM/DD/YYYY
        let formattedMMDDYYDateStr = dateFormatter.string(from: dateObjectFromDateStringfromAccountObject)
        print("formattedMMDDYYDateStr: " + formattedMMDDYYDateStr)
        return formattedMMDDYYDateStr
    }
}