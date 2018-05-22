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
    
}
