//
//  VisitsViewModel.swift
//  SWSApp
//
//  Created by r.a.jantakal on 30/04/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation

class VisitsViewModel {
    
    func visitsForUser() -> [WorkOrderUserObject] {
        return StoreDispatcher.shared.fetchVisits()
    }
    
    func visitsForUserFourMonthsSorted() -> [WorkOrderUserObject] {
        
        var visitsForUserArray = visitsForUser()
        
        let prevMonthDate = Date().add(component: .month, value: -1)
        let next3MonthDate = Date().add(component: .month, value: 3)

        visitsForUserArray = visitsForUserArray.filter {
            
            if let startDate = DateTimeUtility.getDateFromyyyyMMddTimeFormattedDateString(dateString: $0.startDate) {
                if startDate.isLater(than: prevMonthDate), startDate.isEarlier(than: next3MonthDate) {
                    return true
                }
                else {
                    return false
                }
            }
            return false
            
        }
        
        visitsForUserArray = visitsForUserArray.sorted(by: { $0.lastModifiedDate < $1.lastModifiedDate })
        
        return visitsForUserArray
        
    }
    
    func visitsForUserForDate(givenDate: Date) -> [WorkOrderUserObject] {
        
        var visitsForUserArray = visitsForUser()
        
        visitsForUserArray = visitsForUserArray.filter {
            
            if let startDate = DateTimeUtility.getDateFromyyyyMMddTimeFormattedDateString(dateString: $0.startDate) {
                
                let daysBetween = Date.daysBetween(start: startDate, end: givenDate, ignoreHours: true)
                if daysBetween == 0 {
                    return true
                }
                else {
                    return false
                }
            }
            return false
            
        }

        return visitsForUserArray
        
    }
    
    
    // account overview visit 2 weeks upcoming related function
    func visitsForUserTwoWeeksUpcoming() -> [WorkOrderUserObject] {
        
        var visitsForUserArray = visitsForUser()
        
        let prevWeekDate = Date().add(component: .day, value: 0)
        let nextTwoWeekDate = Date().add(component: .day, value: 14)
        
        visitsForUserArray = visitsForUserArray.filter {
            
            if let startDate = DateTimeUtility.getDateFromyyyyMMddTimeFormattedDateString(dateString: $0.startDate) {
                if startDate.isLater(than: prevWeekDate), startDate.isEarlier(than: nextTwoWeekDate) {
                    return true
                }
                else {
                    return false
                }
            }
            return false
            
        }
        
        visitsForUserArray = visitsForUserArray.sorted(by: { $0.lastModifiedDate < $1.lastModifiedDate })
        
        return visitsForUserArray
        
    }
    
    
    
    // account overview visit 1 weeks past related function
    func visitsForUserOneWeeksPast() -> [WorkOrderUserObject] {
        
        var visitsForUserArray = visitsForUser()
        
        let prevWeekDate = Date().add(component: .day, value: -7)
        let nextWeekDate = Date().add(component: .day, value: 0)
        
        visitsForUserArray = visitsForUserArray.filter {
            
            if let startDate = DateTimeUtility.getDateFromyyyyMMddTimeFormattedDateString(dateString: $0.startDate) {
                if startDate.isLater(than: prevWeekDate), startDate.isEarlier(than: nextWeekDate) {
                    return true
                }
                else {
                    return false
                }
            }
            return false
            
        }
        
        visitsForUserArray = visitsForUserArray.sorted(by: { $0.lastModifiedDate < $1.lastModifiedDate })
        
        return visitsForUserArray
        
    }
    
    
    // account overview event 2 weeks upcoming related function
    func eventsForUserTwoWeeksUpcoming() -> [WorkOrderUserObject] {
        
        var eventForUserArray = visitsForUser()
        
        let prevWeekDate = Date().add(component: .day, value: 0)
        let nextTwoWeekDate = Date().add(component: .day, value: 14)
        
        eventForUserArray = eventForUserArray.filter {
            
            if let startDate = DateTimeUtility.getDateFromyyyyMMddTimeFormattedDateString(dateString: $0.startDate) {
                if startDate.isLater(than: prevWeekDate), startDate.isEarlier(than: nextTwoWeekDate) {
                    return true
                }
                else {
                    return false
                }
            }
            return false
        }
        eventForUserArray = eventForUserArray.filter {
            
            print("StoreDispatcher.shared.workOrderTypeVisit \(StoreDispatcher.shared.workOrderTypeVisit)")
            print("$0.recordTypeId \($0.recordTypeId)")
            
            if((StoreDispatcher.shared.workOrderTypeDict[StoreDispatcher.shared.workOrderTypeVisit]) == $0.recordTypeId){
                return false
            } else {
                return true
            }
        }
        eventForUserArray = eventForUserArray.sorted(by: { $0.lastModifiedDate < $1.lastModifiedDate })
        
        return eventForUserArray
        
    }
    
    
    
    
    
    
}
