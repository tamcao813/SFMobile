//
//  AccountVisitListFilter.swift
//  SWSApp
//
//  Created by r.a.jantakal on 25/05/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation

class AccountVisitListFilter {
    
    func sectionNames(isManager: Bool = false) -> [String] {
        var names = [String]()
        names.append("Type")
        names.append("Date Range")
        names.append("Status")
        names.append("Past Visits")
        
        if isManager {
            names.append("My Team")
        }
        
        return names
    }
    
    //var sectionNames : Array<Any>  = ["Type", "Date Range", "Status", "Past Visits"]
    
    var sectionItems : [[Any]] = [ ["Visit", "Event"],
                                      ["","","Today","Tomorrow", "This Week"],
                                      ["Scheduled" , "Planned", "In Progress", "Complete"],
                                      ["Past Visits"]]
    
}

struct AccountVisitListFilterModel {
    
    static var isTypeVisit = "NO"
    static var isTypeEvent = "NO"
    
    static var startDate = ""
    static var endDate = ""
    
    static var isToday = "NO"
    static var isTomorrow = "NO"
    static var isThisWeek = "NO"
    
    static var isStatusScheduled = "NO"
    static var isStatusPlanned = "NO"
    static var isInProgress = "NO"
    static var isComplete = "NO"
    
    static var isPastVisits = "NO"
    
    static var filterApplied = false
    
    static var selectedConsultant: Consultant?
}
