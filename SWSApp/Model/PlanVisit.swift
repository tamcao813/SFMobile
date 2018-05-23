//
//  PlanVisit.swift
//  SWSApp
//
//  Created by vipin.vijay on 03/05/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation

class PlanVisit {
    
    static let planVisitFields: [String] = ["Id","Subject","AccountId","SGWS_Appointment_Status__c","StartDate","EndDate","SGWS_Visit_Purpose__c","Description","SGWS_Agenda_Notes__c","Status","SGWS_AppModified_DateTime__c","ContactId","RecordTypeId","_soupEntryId","SGWS_WorkOrder_Location__c","SGWS_All_Day_Event__c"]
    
    var Id : String
    var subject : String
    var accountId : String
    var sgwsAppointmentStatus : Bool
    var startDate : String
    var endDate : String
    var sgwsVisitPurpose : String
    var description : String
    var sgwsAgendaNotes : String
    var status : String
    var lastModifiedDate : String
    var contactId : String
    var recordTypeId : String
    var location:String
    var soupEntryId : Int
    var workOrderType :String

    var sgwsAlldayEvent :Bool
    
    convenience init(withAry ary: [Any]) {
        let resultDict = Dictionary(uniqueKeysWithValues: zip(PlanVisit.planVisitFields, ary))
        self.init(json: resultDict)
    }
    
    init(json: [String: Any]) {
        
        Id = json["Id"] as? String ?? ""
        subject = json["Subject"] as? String ?? ""
        accountId = json["AccountId"] as? String ?? ""
        sgwsAppointmentStatus = json["SGWS_Appointment_Status__c"] as? Bool ?? false
        startDate = json["StartDate"] as? String ?? ""
        endDate = json["EndDate"] as? String ?? ""
        sgwsVisitPurpose = json["SGWS_Visit_Purpose__c"] as? String ?? ""
        description = json["Description"] as? String ?? ""
        sgwsAgendaNotes = json["SGWS_Agenda_Notes__c"] as? String ?? ""
        status = json["Status"] as? String ?? ""
        lastModifiedDate = json["SGWS_AppModified_DateTime__c"] as? String ?? ""
        contactId = json["ContactId"] as? String ?? ""
        recordTypeId = json["RecordTypeId"] as? String ?? ""
        location =  json["SGWS_WorkOrder_Location__c"] as? String ?? ""
        soupEntryId = json["_soupEntryId"] as? Int ?? 0
        sgwsAlldayEvent = json["SGWS_All_Day_Event__c"] as? Bool ?? false


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
        sgwsAppointmentStatus = false
        startDate = ""
        endDate = ""
        sgwsVisitPurpose = ""
        description = ""
        sgwsAgendaNotes = ""
        status = ""
        lastModifiedDate = ""
        contactId = ""
        recordTypeId = ""
        location = ""
        soupEntryId = 0
        workOrderType = ""
        sgwsAlldayEvent = false

    }
}
