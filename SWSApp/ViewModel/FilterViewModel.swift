//
//  ViewModel.swift
//  ExpandableHeaders
//
//  Created by Krishna, Kamya on 3/29/18.
//  Copyright © 2018 Anexinet. All rights reserved.
//

import Foundation

class Filter {
    
    let sectionNames : Array<Any>  = ["Past Due", "Action Items", "Status", "Premise" , "Single / Multi locations" ,"Channel", "Sub-Channel" ,"License Type"]
    
    let sectionItems : Array<Any> = [ ["YES", "NO"],[],
                                      ["Active", "Inactive","Suspended"],
                                      ["ON","OFF"], ["Single","Multi"],[],[],["W","L","B","N"]]
    
}

let filterCell = "customCell1"
let locationCell = "customCell2"

struct FilterMenuModel {
    
    static var pastDueYes = ""
    static var pastDueNo = ""
    
    static var statusIsActive = ""
    static var statusIsInActive = ""
    static var statusIsSuspended = ""
    
    static var premiseOn = ""
    static var premiseOff = ""
    
    static var singleSelected = ""
    static var multiSelected = ""
    
    static var licenseW = ""
    static var licenseL = ""
    static var licenseB = ""
    static var licenseN = ""
    
    static var city: String = ""
    
}
