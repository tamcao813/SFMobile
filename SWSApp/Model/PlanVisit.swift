//
//  PlanVisit.swift
//  SWSApp
//
//  Created by vipin.vijay on 03/05/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation

class PlanVisit {
    
    static let planVisitFields: [String] = ["Id","Subject","AccountId","SGWS_Appointment_Status__c","StartDate","EndDate","SGWS_Visit_Purpose__c","Description","SGWS_Agenda_Notes__c","Status","SGWS_AppModified_DateTime__c","ContactId"]
    
    var Id : String
    var subject : String
    var accountId : String
    var sgwsAppointmentStatus : String
    var startDate : String
    var endDate : String
    var sgwsVisitPurpose : String
    var description : String
    var sgwsAgendaNotes : String
    var status : String
    var lastModifiedDate : String
    var contactId : String

    
    convenience init(withAry ary: [Any]) {
        let resultDict = Dictionary(uniqueKeysWithValues: zip(PlanVisit.planVisitFields, ary))
        self.init(json: resultDict)
    }
    
    init(json: [String: Any]) {
        
        Id = json["Id"] as? String ?? ""
        subject = json["Subject"] as? String ?? ""
        accountId = json["AccountId"] as? String ?? ""
        sgwsAppointmentStatus = json["SGWS_Appointment_Status__c"] as? String ?? ""
        startDate = json["StartDate"] as? String ?? ""
        endDate = json["EndDate"] as? String ?? ""
        sgwsVisitPurpose = json["SGWS_Visit_Purpose__c"] as? String ?? ""
        description = json["Description"] as? String ?? ""
        sgwsAgendaNotes = json["SGWS_Agenda_Notes__c"] as? String ?? ""
        status = json["Status"] as? String ?? ""
        lastModifiedDate = json["SGWS_AppModified_DateTime__c"] as? String ?? ""
        contactId = json["ContactId"] as? String ?? ""

    }
    
    init(for: String) {
        
        Id = ""
        subject = ""
        accountId = ""
        sgwsAppointmentStatus = ""
        startDate = ""
        endDate = ""
        sgwsVisitPurpose = ""
        description = ""
        sgwsAgendaNotes = ""
        status = ""
        lastModifiedDate = ""
        contactId = ""
    }
}
