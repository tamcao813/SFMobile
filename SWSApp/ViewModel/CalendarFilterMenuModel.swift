//
//  CalendarFilterMenuModel.swift
//  SWSApp
//
//  Created by Thillaiganesh, C. on 18/05/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class CalendarFilter {
    
    var sectionNames : Array<Any>  = ["Appointment Type"]
    
    var sectionItems : Array<Any> = [ ["Visits", "Events"] ]
    
}

let CalendarFilterCell = "calendarMenuTableTableViewCell"

struct CalendarFilterMenuModel {

    static var searchText = ""

    static var visitsType = ""
    static var eventsType = ""

}
