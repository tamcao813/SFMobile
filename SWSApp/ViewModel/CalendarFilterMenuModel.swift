//
//  CalendarFilterMenuModel.swift
//  SWSApp
//
//  Created by Thillaiganesh, C. on 18/05/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class CalendarFilter {
    
    var sectionNames : Array<Any>  = ["Event Type"]
    
    var sectionItems : Array<Any> = [ ["All", "Visits", "Events"] ]
    
}

let CalendarFilterCell = "calendarMenuTableTableViewCell"

struct CalendarFilterMenuModel {

    static var allType = ""
    static var visitsType = ""
    static var eventsType = ""

}
