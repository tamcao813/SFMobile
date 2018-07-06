//
//  ViewModel.swift
//  ExpandableHeaders
//
//  Created by Krishna, Kamya on 3/29/18.
//  Copyright © 2018 Anexinet. All rights reserved.
//

import Foundation

class Filter {
    
    //var sectionNames : Array<Any>  = ["Past Due", "Action Items", "Status", "Premise" , "Single / Multi locations" ,"Channel", "Sub-Channel" ,"License Type"]
    
    var sectionItems: [[Any]] = [ ["Yes", "No"],[],
                                  ["Active", "Inactive","Suspended"],
                                  ["On","Off"], ["Single","Multi"],["L","W","B","N"]]
    
    func sectionNames(isManager: Bool = false) -> [String] {
        var names = ["Past Due","Action Items","Status","Premise","Single / Multi locations","Channel","Sub-Channel","License Type"]
        
        if isManager {
            names.append("My Team")
        }
        
        return names
    }
    
}

let filterCell = "customCell1"
let locationCell = "customCell2"
let cell3 = "customCell3"

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
    
    static var channel = ""
    static var subChannel = ""
    
    static var channelIndex = -1
    static var subChannelIndex = -1
    
    //static var activeSelected = ""
    //static var inActiveSelected = ""
    //static var suspendedSelected = ""
    
    static var city: String = ""
    
    static var isFromAccountListView = ""

    static var comingFromDetailsScreen = ""
    static var selectedAccountId = ""
    
    static var isFromAccountVisitSummary = ""
    
    static var selectedConsultant: Consultant?
}
