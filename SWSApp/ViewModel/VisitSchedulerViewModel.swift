//
//  VisitSchedulerViewModel.swift
//  SWSApp
//
//  Created by vipin.vijay on 03/05/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation

class VisitSchedulerViewModel {
    
    func visitsForUser() -> [PlanVisit] {
        return StoreDispatcher.shared.fetchSchedulerVisits()
    }
    
    func createNewVisitLocally(fields: [String:Any]) -> (Bool,Int) {
        return StoreDispatcher.shared.createNewVisitLocally(fieldsToUpload:fields)
    }
    
    
    func deleteVisitLocally(fields: [String:Any]) -> Bool {
        if StoreDispatcher.shared.deleteVisitsLocally(fieldsToUpload:fields){
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshCalendar"), object:nil)            
        }
        return StoreDispatcher.shared.deleteVisitsLocally(fieldsToUpload:fields)
    }
    
    
    func uploadVisitToServer(fields: [String], completion: @escaping (_ error: NSError?)->() ) {
        
        StoreDispatcher.shared.syncUpVisits(fieldsToUpload: fields, completion: {error in
            
            if error != nil {
                print(error?.localizedDescription ?? "error")
                print("Visit Sync up failed")
                completion(error)
            }
            else {
                print("Syncup for Visit Completed")
                completion(nil)
            }
        })
        
}
    
    func editVisitToSoup(fields: [String:Any]) -> Bool {
        if StoreDispatcher.shared.editVisit(fields:fields){
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshVisitSummaryScreen"), object:nil)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshCalendar"), object:nil)
        }
        return StoreDispatcher.shared.editVisit(fields:fields)
    }
    
    // account overview related function
    func visitsForUserTwoWeeksUpcoming() -> [PlanVisit] {
        
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
    
    

}
