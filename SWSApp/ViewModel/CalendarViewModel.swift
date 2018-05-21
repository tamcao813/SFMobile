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
        
        let visitData = VisitsViewModel().visitsForUserFourMonthsSorted()
        
        return loadVisitsToCalendarEvents(visitArray: visitData)
        
    }
    
    func loadVisitsToCalendarEvents(visitArray: [WorkOrderUserObject]) -> [WREvent]? {
        
        var visitsToCalendarEventsArray = [WREvent]()
        
        for visit in visitArray
        {

            let dateFormatter = DateFormatter()
            dateFormatter.timeZone = TimeZone.current

            if let eventStartDate = DateTimeUtility.getDateFromyyyyMMddTimeFormattedDateString(dateString: visit.startDate) {
                
                if let eventEndDate = DateTimeUtility.getDateFromyyyyMMddTimeFormattedDateString(dateString: visit.endDate) {

                    let daysBetween = Date.daysBetween(start: eventStartDate, end: eventEndDate, ignoreHours: true)
                    
                    let accountList: [Account]? = AccountSortUtility.searchAccountByAccountId(accountsForLoggedUser: AccountsViewModel().accountsForLoggedUser, accountId: visit.accountId)
                    guard accountList != nil, (accountList?.count)! > 0  else {
                        continue
                    }
                    
                    let visitTitle = accountList![0].accountName + ": " + accountList![0].accountNumber
                    
                    if daysBetween == 0 {
                        
                        let minutessBetween = Date.minutesBetween(start: eventStartDate, end: eventEndDate)
                        let visitEvent = WREvent.makeVisitEvent(Id: visit.Id, type: "visit", date: eventStartDate, chunk: (minutessBetween > 30) ? eventStartDate.chunkBetween(date: eventEndDate) : 30.minutes, title: visitTitle)
                        visitsToCalendarEventsArray.append(visitEvent)

                    }
                    else {

                        for day in 0...daysBetween {
                            
                            let currentStartDate = eventStartDate.add(component: .day, value: day)

                            let visitEvent: WREvent!
                            if day == 0 {
                                visitEvent = WREvent.makeVisitEvent(Id: visit.Id, type: "visit", date: eventStartDate, chunk: eventStartDate.chunkBetween(date: eventStartDate.endOfDay), title: visitTitle)
                            } else if day == daysBetween {
                                visitEvent = WREvent.makeVisitEvent(Id: visit.Id, type: "visit", date: eventEndDate.startOfDay, chunk: eventEndDate.startOfDay.chunkBetween(date: eventEndDate), title: visitTitle)
                            } else {
                                visitEvent = WREvent.makeVisitEvent(Id: visit.Id, type: "visit", date: currentStartDate.startOfDay, chunk: currentStartDate.startOfDay.chunkBetween(date: currentStartDate.endOfDay), title: visitTitle)
                            }
                            visitsToCalendarEventsArray.append(visitEvent)
                            
                        }
                    }

                }

            }
            
        }
        
        return visitsToCalendarEventsArray
        
    }
    
}
