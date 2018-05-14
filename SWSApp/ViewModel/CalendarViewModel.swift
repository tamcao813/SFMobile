//
//  CalendarViewModel.swift
//  SWSApp
//
//  Created by Thillaiganesh, C. on 14/05/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class CalendarViewModel {

    func calendarData() -> [WREvent] {

        if let eventList = loadVisitData() {
            return eventList
        }
        
        return [WREvent]()

    }
    
    // MARK: - Visit Data
    func loadVisitData() -> [WREvent]? {
        
        let visitData = VisitsViewModel().visitsForUserSorted()
        
        return loadVisitsToCalendarEvents(visitArray: visitData)
        
    }
    
    func loadVisitsToCalendarEvents(visitArray: [Visit]) -> [WREvent]? {
        
        var visitsToCalendarEventsArray = [WREvent]()
        
        for visit in visitArray
        {

            var eventDate: Date? // TBD This needs to be moved to Date Util
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.zzz+zzzz"
            dateFormatter.timeZone = TimeZone(identifier:"UTC")
            eventDate = dateFormatter.date(from: visit.startDate)
            
            if let _ = eventDate {
                dateFormatter.timeZone = TimeZone.current
            }
            else {
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                dateFormatter.timeZone = TimeZone(identifier:"UTC")
                eventDate = dateFormatter.date(from: visit.startDate)

                if let _ = eventDate {
                    dateFormatter.timeZone = TimeZone.current
                }
            }

            if let _ = eventDate {
                print("loadVisitsToCalendarEvents: \(String(describing: eventDate))")
                print(dateFormatter.string(from: eventDate!))
                let visitEvent = WREvent.makeVisitEvent(Id: visit.Id, type: "visit", date: eventDate!, chunk: 2.hours, title: visit.subject)
                
                visitsToCalendarEventsArray.append(visitEvent)
            }
            
        }
        
        return visitsToCalendarEventsArray
        
    }
    
}
