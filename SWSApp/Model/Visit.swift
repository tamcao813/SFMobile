//
//  Visit.swift
//  SWSApp
//
//  Created by r.a.jantakal on 30/04/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation

class Visit{
    
    static let VisitsFields: [String] = ["Id","Subject","SGWS_WorkOrder_Location__c", "AccountId","ContactId","SGWS_Appointment_Status__c","StartDate","EndDate","SGWS_Visit_Purpose__c","Description","SGWS_Agenda_Notes__c","Status","SGWS_AppModified_DateTime__c","RecordTypeId","_soupEntryId","SGWS_All_Day_Event__c"]
    
    var Id : String
    var subject : String
    var accountId : String
    var contactId : String
    var sgwsAppointmentStatus : Bool
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
    
    var sgwsAlldayEvent:Bool

    
    convenience init(withAry ary: [Any]) {
        let resultDict = Dictionary(uniqueKeysWithValues: zip(Visit.VisitsFields, ary))
        self.init(json: resultDict)
    }
    
    init(json: [String: Any]) {
        
        Id = json["Id"] as? String ?? ""
        subject = json["Subject"] as? String ?? ""
        accountId = json["AccountId"] as? String ?? ""
      
        contactId = json["ContactId"] as? String ?? ""
        
        sgwsAppointmentStatus = json["SGWS_Appointment_Status__c"] as? Bool ?? false

        let sgwsAppointmentStatusString = json["SGWS_Appointment_Status__c"] as? String ?? ""
        if sgwsAppointmentStatusString == "true" {
                    sgwsAppointmentStatus = true
        }
        if sgwsAppointmentStatusString == "1" {
                    sgwsAppointmentStatus = true
        }
        
        
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
        sgwsAlldayEvent = json["SGWS_All_Day_Event__c"] as? Bool ?? false
        let sgwsAlldayEventString = json["SGWS_All_Day_Event__c"] as? String ?? ""
        if sgwsAlldayEventString == "true" {
            sgwsAlldayEvent = true
        }
        if sgwsAlldayEventString == "1" {
            sgwsAlldayEvent = true
        }
        
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
       
        contactId = ""
       
        sgwsAppointmentStatus = false
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
        sgwsAlldayEvent = false
    }
}



