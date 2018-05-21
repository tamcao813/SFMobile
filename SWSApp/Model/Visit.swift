//
//  Visit.swift
//  SWSApp
//
//  Created by r.a.jantakal on 30/04/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation

class Visit{
    
    static let VisitsFields: [String] = ["Id","Subject","SGWS_WorkOrder_Location__c", "AccountId","Account.Name","Account.AccountNumber","Account.BillingAddress","ContactId","Contact.Name","Contact.Phone","Contact.Email","Contact.SGWS_Roles__c","SGWS_Appointment_Status__c","StartDate","EndDate","SGWS_Visit_Purpose__c","Description","SGWS_Agenda_Notes__c","Status","SGWS_AppModified_DateTime__c","RecordTypeId"]
    
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
    var recordTypeId : String
    var location:String
    
    var soupEntryId:Int
    
    var workOrderType :String

    
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
        lastModifiedDate = json["SGWS_AppModified_DateTime__c"] as? String ?? ""
        recordTypeId = json["RecordTypeId"] as? String ?? ""
        location = json["SGWS_WorkOrder_Location__c"] as? String ?? ""
        soupEntryId = json["_soupEntryId"] as? Int ?? 0
        
        if((StoreDispatcher.shared.workOrderTypeDict[StoreDispatcher.shared.workOrderTypeVisit]) == StoreDispatcher.shared.workOrderRecordTypeIdVisit){
            workOrderType = StoreDispatcher.shared.workOrderTypeVisit
        } else {
            workOrderType = StoreDispatcher.shared.workOrderTypeEvent
            
        }
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
        recordTypeId = ""
        location = ""
        soupEntryId = 0
        workOrderType = ""

    }
}



