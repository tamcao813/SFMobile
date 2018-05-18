//
//  CalendarSortUtility.swift
//  SWSApp
//
//  Created by Thillaiganesh, C. on 18/05/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class CalendarSortUtility {

    static func searchCalendarBySearchBarQuery(calendarEvents:[WREvent]?, searchText:String)->[WREvent]!
    {
        guard calendarEvents != nil else {
            return[WREvent]()
        }
        
        guard calendarEvents!.count > 0  else {
            return[WREvent]()
        }
        
        var filteredEvents = [WREvent]()
        
        if CalendarFilterMenuModel.allType != "YES" {
            if CalendarFilterMenuModel.visitsType == "YES" {
                let filteredVisitEvents = calendarEvents!.filter( { return $0.type == "visit" } )
                filteredEvents.append(contentsOf: filteredVisitEvents)
            }

            if CalendarFilterMenuModel.eventsType == "YES" {
                let filteredEventEvents = calendarEvents!.filter( { return $0.type == "event" } )
                filteredEvents.append(contentsOf: filteredEventEvents)
            }
        }
        else {
            filteredEvents = calendarEvents!
        }
        
        return filteredEvents
    }
    
}
