//
//  AccountVisitListFilter.swift
//  SWSApp
//
//  Created by r.a.jantakal on 25/05/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation

class AccountVisitListFilter {
    
    var sectionNames : Array<Any>  = ["Type", "Date Range", "Status", "Past Visits"]
    
    var sectionItems : Array<Any> = [ ["Visit", "Event"],
                                      ["","","Today","Tomorrow", "This Week"],
                                      ["Scheduled" , "Planned", "In Progress", "Complete"],
                                      ["Past Visits"]]
    
}

struct AccountVisitListFilterModel {
    
    static var isTypeVisit = "NO"
    static var isTypeEvent = "NO"
    
    static var isToday = "NO"
    static var isTomorrow = "NO"
    static var isThisWeek = "NO"
    
    static var isStatusScheduled = "NO"
    static var isStatusPlanned = "NO"
    static var isInProgress = "NO"
    static var isComplete = "NO"
    
    static var isPastVisits = "NO"
    
    static var filterApplied = false
    
}
