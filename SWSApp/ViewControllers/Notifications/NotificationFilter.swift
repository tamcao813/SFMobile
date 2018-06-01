//
//  NotificationFilter.swift
//  SWSApp
//
//  Created by manu.a.gupta on 31/05/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation

class NotificationFilter {
    
    var sectionNames : Array<Any>  = ["Type", "Subhead FPO" ]
    
    var sectionItems : Array<Any> = [ ["License Expiration", "Contact Birthday"],
                                      ["Read","Unread"]]
    
}

struct NotificationFilterModel {
    
    static var isAccountField = true
    
    static var isLicenseExpiration = "NO"
    static var isContactBirthday = "NO"
    
    static var isRead = "NO"
    static var isUnread = "NO"
    
    static var filterApplied = false
    
}
