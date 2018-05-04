//
//  PlanVisit.swift
//  SWSApp
//
//  Created by vipin.vijay on 03/05/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation

class PlanVisit {
    
    static let planVisitFields: [String] = ["Id","Subject","AccountId","Account.Name","Account.AccountNumber","Account.BillingAddress","ContactId","Contact.Name","Contact.Phone","Contact.Email","Contact.SGWS_Roles__c","SGWS_Appointment_Status__c","StartDate","EndDate","SGWS_Visit_Purpose__c","Description","SGWS_Agenda_Notes__c","Status","LastModifiedDate"]
    
    var Id : String
    var subject : String
    var accountId : String
    var accountName : String
    var accountNumber : String
    var accountBillingAddress : String
    var contactId : String
    var contactName : String
    var contactPhone : String
    var contactEmail : String
    var contactSGWS_Roles : String
    var sgwsAppointmentStatus : String
    var startDate : String
    var endDate : String
    var sgwsVisitPurpose : String
    var description : String
    var sgwsAgendaNotes : String
    var status : String
    var lastModifiedDate : String
    
    convenience init(withAry ary: [Any]) {
        let resultDict = Dictionary(uniqueKeysWithValues: zip(Visit.VisitsFields, ary))
        self.init(json: resultDict)
    }
    
    init(json: [String: Any]) {
        
        Id = json["Id"] as? String ?? ""
        subject = json["Subject"] as? String ?? ""
        accountId = json["AccountId"] as? String ?? ""
        accountName = json["Account.Name"] as? String ?? ""
        accountNumber = json["Account.AccountNumber"] as? String ?? ""
        accountBillingAddress = json["Account.BillingAddress"] as? String ?? ""
        contactId = json["ContactId"] as? String ?? ""
        contactName = json["Contact.Name"] as? String ?? ""
        contactPhone = json["Contact.Phone"] as? String ?? ""
        contactEmail = json["Contact.Email"] as? String ?? ""
        contactSGWS_Roles = json["Contact.SGWS_Roles__c"] as? String ?? ""
        sgwsAppointmentStatus = json["SGWS_Appointment_Status__c"] as? String ?? ""
        startDate = json["StartDate"] as? String ?? ""
        endDate = json["EndDate"] as? String ?? ""
        sgwsVisitPurpose = json["SGWS_Visit_Purpose__c"] as? String ?? ""
        description = json["Description"] as? String ?? ""
        sgwsAgendaNotes = json["SGWS_Agenda_Notes__c"] as? String ?? ""
        status = json["Status"] as? String ?? ""
        lastModifiedDate = json["LastModifiedDate"] as? String ?? ""
    }
    
    init(for: String) {
        
        Id = ""
        subject = ""
        accountId = ""
        accountName = ""
        accountNumber = ""
        accountBillingAddress = ""
        contactId = ""
        contactName = ""
        contactPhone = ""
        contactEmail = ""
        contactSGWS_Roles = ""
        sgwsAppointmentStatus = ""
        startDate = ""
        endDate = ""
        sgwsVisitPurpose = ""
        description = ""
        sgwsAgendaNotes = ""
        status = ""
        lastModifiedDate = ""
    }
}
