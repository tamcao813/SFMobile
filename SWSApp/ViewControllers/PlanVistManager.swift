//
//  PlanVistManager.swift
//  SWSApp
//
//  Created by vipin.vijay on 03/05/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import SmartSync

class PlanVistManager {
    static let sharedInstance = PlanVistManager()
    
    var userInfo = (ID: "bobthedev", Password: 01036343984)
    var visit:Visit? = Visit(for: "")
    var editPlanVisit = false
    var Id = ""
    var subject = ""
    var accountId = ""
    var accountName = ""
    var accountNumber = ""
    var accountBillingAddress = ""
    var contactId = ""
    var contactName = ""
    var contactPhone = ""
    var contactEmail = ""
    var contactSGWS_Roles = ""
    var sgwsAppointmentStatus = ""
    var startDate = ""
    var endDate = ""
    var sgwsVisitPurpose = ""
    var description = ""
    var sgwsAgendaNotes = ""
    var status = ""
    var lastModifiedDate = ""
    var userID = ""
    // Networking: communicating server
    func network() {
        // get everything
    }
    
    init() {
        print("CloudCodeExecutor has been initialized")
    }
    
    
    func editAndSaveVisit()->Bool{
        
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let accountId = appDelegate.loggedInUser?.accountId

            let new_visit = PlanVisit(for: "newVisit")
            
            new_visit.subject = (visit?.subject)!
            new_visit.accountId = visit!.accountId
            new_visit.sgwsAppointmentStatus = (visit?.sgwsAppointmentStatus)!
            new_visit.startDate =  (visit?.startDate)!
        new_visit.endDate = (visit?.endDate)!
            new_visit.sgwsVisitPurpose = (visit?.sgwsVisitPurpose)!
            new_visit.description = (visit?.description)!
            new_visit.sgwsAgendaNotes = (visit?.sgwsAgendaNotes)!
            new_visit.status = (visit?.status)!
            let attributeDict = ["type":"WorkOrder"]
            
            
            let addNewDict: [String:Any] = [
                
                PlanVisit.planVisitFields[0]: new_visit.Id,
                PlanVisit.planVisitFields[1]: new_visit.subject,
                PlanVisit.planVisitFields[2]: new_visit.accountId,
                PlanVisit.planVisitFields[3]: new_visit.sgwsAppointmentStatus,
                PlanVisit.planVisitFields[4]: new_visit.startDate,
                PlanVisit.planVisitFields[5]: new_visit.endDate,
                PlanVisit.planVisitFields[6]: new_visit.sgwsVisitPurpose,
                PlanVisit.planVisitFields[7]: new_visit.description,
                PlanVisit.planVisitFields[8]: new_visit.sgwsAgendaNotes,
                PlanVisit.planVisitFields[9]: new_visit.status,
                
                kSyncTargetLocal:true,
                kSyncTargetLocallyCreated:true,
                kSyncTargetLocallyUpdated:false,
                kSyncTargetLocallyDeleted:false,
                "attributes":attributeDict]
            
            let success = VisitSchedulerViewModel().editVisitToSoup(fields: addNewDict)
            print("Success is here \(success)")
            
        
    
    return true
    }
    
}
