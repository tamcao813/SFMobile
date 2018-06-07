//
//  ActionItemFilter.swift
//  SWSApp
//
//  Created by manu.a.gupta on 21/05/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation

class ActionItemFilter {
    func sectionNames(isManager: Bool = false) -> [String] {
        var names = [String]()
        if isManager {
            names.append("My Team")
        }
        names.append("Action Item Status")
        names.append("Action Item Type")
        names.append("Due Date")
        
        return names
    }
    
    var sectionItems: [[Any]] = [ ["Complete", "Open", "Overdue"],
                                  ["Urgent","Not Urgent"],
                                  ["Yes", "No"]]
    
}

struct ActionItemFilterModel {
    
    static var fromAccount = false
    static var accountId: String?
    static var isAccountField = true
    
    static var isComplete = "NO"
    static var isOpen = "NO"
    static var isOverdue = "NO"
    
    static var isUrgent = "NO"
    static var isNotUrgent = "NO"
    
    static var dueYes = "NO"
    static var dueNo = "NO"
    
    static var filterApplied = false
    
    static var selectedConsultant: Consultant?
}
