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
    
    func createNewContactToSoup(object: Contact) -> Bool {
        var contactfields: [String:Any] = object.toJson()
        contactfields.removeValue(forKey: "_soupEntryId")
        return StoreDispatcher.shared.createNewContactToSoup(fields: contactfields)
    }
    
    func createNewVisitLocally(fields: [String:Any]) -> (Bool,Int) {
        //contactfields.removeValue(forKey: "_soupEntryId")
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
            return true
        }
        return false
    }
    

}
