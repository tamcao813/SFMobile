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
        return StoreDispatcher.shared.createNewVisitLocally(fieldsToUpload:fields)
    }
    
    
    func deleteVisitLocally(fields: [String:Any]) -> Bool {
        if StoreDispatcher.shared.deleteVisitsLocally(fieldsToUpload:fields){
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshCalendar"), object:nil)
            return true
        }
        return false
    }
    
    
    func uploadVisitToServer(fields: [String], completion: @escaping (_ error: NSError?)->() ) {
        StoreDispatcher.shared.syncUpVisits(fieldsToUpload: fields, completion: {error in
            if error != nil {
                print(error?.localizedDescription ?? "error")
                print("Visit Sync up failed")
                completion(error)
            }else {
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
    
    func syncVisitsWithServer(_ completion:@escaping (_ error: NSError?)->()) {
        let fields: [String] = ["Subject","SGWS_WorkOrder_Location__c","AccountId","SGWS_Appointment_Status__c","StartDate","EndDate","SGWS_Visit_Purpose__c","Description","SGWS_Agenda_Notes__c","Status","SGWS_AppModified_DateTime__c","ContactId","RecordTypeId","SGWS_All_Day_Event__c"]
        
        StoreDispatcher.shared.syncUpVisits(fieldsToUpload: fields, completion: {error in
            if error != nil {
                print(error?.localizedDescription ?? "error")
                print("syncVisitsWithServer: Visit Sync up failed")
            }
            
            StoreDispatcher.shared.reSyncVisits { error in
                if error != nil {
                    print(error?.localizedDescription ?? "error")
                    print("syncVisitsWithServer: Visit reSync failed")
                    completion(error)
                }
                else {
                    completion(nil)
                }
            }
        })
    }
  
    

}
