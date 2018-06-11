//
//  CalendarFilterMenuModel.swift
//  SWSApp
//
//  Created by Thillaiganesh, C. on 18/05/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class CalendarFilter {
    
    func sectionNames(isManager: Bool = false) -> [String] {
        var names = [String]()
        names.append("Appointment Type")
        
        if isManager {
            names.append("My Team")
        }
        
        return names
    }
    
    //var sectionNames : Array<Any>  = ["Appointment Type"]
    
    var sectionItems : [[Any]] = [ ["Visits", "Events"] ]
    
}

let CalendarFilterCell = "calendarMenuTableTableViewCell"

struct CalendarFilterMenuModel {
    static var searchText = ""
    static var visitsType = ""
    static var eventsType = ""
    
    static var selectedConsultant: Consultant?
    
}
