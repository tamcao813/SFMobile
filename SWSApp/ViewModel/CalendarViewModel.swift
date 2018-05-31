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
        
        let globalAccountsForLoggedUser = AccountsViewModel().accountsForLoggedUser
        let globalContactList = ContactsViewModel().globalContacts()
        
        for visit in visitArray
        {

            let dateFormatter = DateFormatter()
            dateFormatter.timeZone = TimeZone.current

//            if let eventStartDate = DateTimeUtility.getDateFromyyyyMMddTimeFormattedDateString(dateString: visit.startDate) {
                if let eventStartDate = visit.dateStart {

//                if let eventEndDate = DateTimeUtility.getDateFromyyyyMMddTimeFormattedDateString(dateString: visit.endDate) {
                if let eventEndDate = visit.dateEnd {
                    
                    let daysBetween = Date.daysBetween(start: eventStartDate, end: eventEndDate, ignoreHours: true)
                    
                    let accountList: [Account]? = AccountSortUtility.searchAccountByAccountId(accountsForLoggedUser: globalAccountsForLoggedUser, accountId: visit.accountId)
                    guard accountList != nil, (accountList?.count)! > 0  else {
                        continue
                    }
                    
                    var visitTitle = ""
                    var visitType = "visit"
                    if((StoreDispatcher.shared.workOrderTypeDict[StoreDispatcher.shared.workOrderTypeVisit]) == visit.recordTypeId){
                        visitType = "visit"
                        
                        visitTitle = accountList![0].accountName + ": " + accountList![0].accountNumber
                        
                    } else {
                        
                        visitType = "event"
                        visitTitle = visit.subject
                        
                    }
                    
                    guard let _ = visitTitle as String? else {
                        visitTitle = ""
                    }
                    
                    var vistAccountName = accountList![0].accountName
                    guard let _ = vistAccountName as String? else {
                        vistAccountName = ""
                    }

                    var vistAccountNumber = accountList![0].accountNumber
                    guard let _ = vistAccountNumber as String? else {
                        vistAccountNumber = ""
                    }

                    var visitContactName = ""

                    if let selectedContact = ContactSortUtility.searchContactByContactId(contactList: globalContactList, contactId: visit.contactId)  {
                        visitContactName = selectedContact.name
                    }

                    if daysBetween == 0 {
                        
                        let minutessBetween = Date.minutesBetween(start: eventStartDate, end: eventEndDate)
                        let visitEvent = WREvent.makeVisitEvent(Id: visit.Id, type: visitType, date: eventStartDate, startDate: DateTimeUtility.dateToStringinyyyyMMddd(eventDate: eventStartDate), chunk: (minutessBetween > 30) ? eventStartDate.chunkBetween(date: eventEndDate) : 30.minutes, title: visitTitle)
                        visitEvent.accountId = visit.accountId
                        visitEvent.accountNumber = vistAccountNumber
                        visitEvent.accountName = vistAccountName
                        visitEvent.contactName = visitContactName
                        visitsToCalendarEventsArray.append(visitEvent)

                    }
                    else {

                        for day in 0...daysBetween {
                            
                            let currentStartDate = eventStartDate.add(component: .day, value: day)

                            let visitEvent: WREvent!
                            if day == 0 {
                                visitEvent = WREvent.makeVisitEvent(Id: visit.Id, type: visitType, date: eventStartDate, startDate: DateTimeUtility.dateToStringinyyyyMMddd(eventDate: eventStartDate), chunk: eventStartDate.chunkBetween(date: eventStartDate.endOfDay), title: visitTitle)
                            } else if day == daysBetween {
                                visitEvent = WREvent.makeVisitEvent(Id: visit.Id, type: visitType, date: eventEndDate.startOfDay, startDate: DateTimeUtility.dateToStringinyyyyMMddd(eventDate: eventEndDate.startOfDay), chunk: eventEndDate.startOfDay.chunkBetween(date: eventEndDate), title: visitTitle)
                            } else {
                                visitEvent = WREvent.makeVisitEvent(Id: visit.Id, type: visitType, date: currentStartDate.startOfDay, startDate: DateTimeUtility.dateToStringinyyyyMMddd(eventDate: currentStartDate.startOfDay), chunk: currentStartDate.startOfDay.chunkBetween(date: currentStartDate.endOfDay), title: visitTitle)
                            }
                            visitEvent.accountId = visit.accountId
                            visitEvent.accountNumber = vistAccountNumber
                            visitEvent.accountName = vistAccountName
                            visitEvent.contactName = visitContactName
                            visitsToCalendarEventsArray.append(visitEvent)
                            
                        }
                    }

                }

            }
            
        }
        
        return visitsToCalendarEventsArray
        
    }
    
}
