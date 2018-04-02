//
//  ViewModel.swift
//  ExpandableHeaders
//
//  Created by Krishna, Kamya on 3/29/18.
//  Copyright © 2018 Anexinet. All rights reserved.
//

import Foundation

class FilterViewModel {
    var pastDue: String = ""
    var openIssues: String = ""
    var status: String = ""
    var premise: String = ""
    var locations: String = ""
    var channel: String = ""
    var subChannel: String = ""
    var licenseType: String = ""
    var city: String = ""
}


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
    
    
    
    
    static var openIssues = ""
    static var status: String = ""
    static var premise: String = ""
    static var locations: String = ""
    static var channel: String = ""
    static var subChannel: String = ""
    static var licenseType: String = ""
    static var city: String = ""
    
}
