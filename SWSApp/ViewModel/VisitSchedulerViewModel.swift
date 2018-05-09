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
            }
        })
        
}
    
    func editVisitToSoup(fields: [String:Any]) -> Bool {
        return StoreDispatcher.shared.editVisit(fields:fields)
    }
    

}
