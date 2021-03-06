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
        
        if CalendarFilterMenuModel.selectConsultantClicked != ""{
            filteredEvents = filterOnTeamBasis(actionItems: filteredEvents)
        }
        
        guard searchText != "" else {
            return filteredEvents
        }
        
        let (enteredAnyFilterCaseReturn, filteredByReturnArray) = searchCalendarBySearchText(calendarEvents: filteredEvents, searchText: searchText)
        if enteredAnyFilterCaseReturn {
            filteredEvents = filteredByReturnArray
        }
        else {
            filteredEvents = [WREvent]()
        }
        
        return filteredEvents
    }
    
    //Perform Filter based on Team Basis
    static func filterOnTeamBasis(actionItems: [WREvent]) -> [WREvent]{
        if let id = CalendarFilterMenuModel.selectedConsultant?.id {
            print(id)
            return actionItems.filter( { return $0.ownerId.contains(id) } )
        }
        return actionItems
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
            
            if (calendarEvent.accountId.self.range(of: trimmedSearchString, options: .caseInsensitive) != nil)
            {
                enteredAnyFilterCase = true
                calendarListWithSearchResults.append(calendarEvent)
                continue
            }
            
            if (calendarEvent.accountNumber.self.range(of: trimmedSearchString, options: .caseInsensitive) != nil)
            {
                enteredAnyFilterCase = true
                calendarListWithSearchResults.append(calendarEvent)
                continue
            }
            
            if (calendarEvent.accountName.self.range(of: trimmedSearchString, options: .caseInsensitive) != nil)
            {
                enteredAnyFilterCase = true
                calendarListWithSearchResults.append(calendarEvent)
                continue
            }
            
            if (calendarEvent.contactName.self.range(of: trimmedSearchString, options: .caseInsensitive) != nil)
            {
                enteredAnyFilterCase = true
                calendarListWithSearchResults.append(calendarEvent)
                continue
            }

        }
        
        return (enteredAnyFilterCase, calendarListWithSearchResults)
    }
    
}
