//
//  CalendarSortUtility.swift
//  SWSApp
//
//  Created by Thillaiganesh, C. on 18/05/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class CalendarSortUtility {

    static func searchCalendarBySearch(calendarEvents:[WREvent]?) -> [WREvent]!
    {
        return searchCalendarBySearchBarQuery(calendarEvents: calendarEvents, searchText: CalendarFilterMenuModel.searchText)
    }

    static func searchCalendarBySearchBarQuery(calendarEvents:[WREvent]?, searchText:String) -> [WREvent]!
    {
        guard calendarEvents != nil else {
            return[WREvent]()
        }
        
        guard calendarEvents!.count > 0  else {
            return[WREvent]()
        }
        
        var filteredEvents = [WREvent]()
        
        if CalendarFilterMenuModel.visitsType == "YES" {
            let filteredVisitEvents = calendarEvents!.filter( { return $0.type == "visit" } )
            filteredEvents.append(contentsOf: filteredVisitEvents)
        }
        
        if CalendarFilterMenuModel.eventsType == "YES" {
            let filteredEventEvents = calendarEvents!.filter( { return $0.type == "event" } )
            filteredEvents.append(contentsOf: filteredEventEvents)
        }
        
        guard searchText != "" else {
            return filteredEvents
        }
        
        let (enteredAnyFilterCaseReturn, filteredByReturnArray) = searchCalendarBySearchText(calendarEvents: filteredEvents, searchText: searchText)
        if enteredAnyFilterCaseReturn {
            filteredEvents = filteredByReturnArray
        }

        return filteredEvents
    }
    
    static func searchCalendarBySearchText(calendarEvents:[WREvent], searchText:String)->(Bool, [WREvent])
    {
        var enteredAnyFilterCase = false
        var calendarListWithSearchResults = [WREvent]()

        let trimmedSearchString = searchText.trimmingCharacters(in: .whitespacesAndNewlines)

        for calendarEvent in calendarEvents
        {
            if (calendarEvent.title.self.range(of: trimmedSearchString, options: .caseInsensitive) != nil)
            {
                enteredAnyFilterCase = true
                calendarListWithSearchResults.append(calendarEvent)
                continue
            }
            
            guard let selectedVisit = VisitSortUtility.searchVisitByVisitId(visitId: calendarEvent.Id) else {
                continue
            }

            if (selectedVisit.accountId.self.range(of: trimmedSearchString, options: .caseInsensitive) != nil)
            {
                enteredAnyFilterCase = true
                calendarListWithSearchResults.append(calendarEvent)
                continue
            }
            
            guard let selectedContact = ContactSortUtility.searchContactByContactId(selectedVisit.contactId) else {
                continue
            }
            
            if (selectedContact.name.self.range(of: trimmedSearchString, options: .caseInsensitive) != nil)
            {
                enteredAnyFilterCase = true
                calendarListWithSearchResults.append(calendarEvent)
                continue
            }

        }
        
        return (enteredAnyFilterCase, calendarListWithSearchResults)
    }
    
}
