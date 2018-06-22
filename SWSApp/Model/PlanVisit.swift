//
//  PlanVisit.swift
//  SWSApp
//
//  Created by vipin.vijay on 03/05/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation

class PlanVisit {
    
    //SyncUp
    static let workOrderSyncUpfields: [String] = ["Subject","SGWS_WorkOrder_Location__c","AccountId","SGWS_Appointment_Status__c","StartDate","EndDate","SGWS_Visit_Purpose__c","Description","SGWS_Agenda_Notes__c","Status","SGWS_AppModified_DateTime__c","ContactId","RecordTypeId","SGWS_All_Day_Event__c"]
    
    static let planVisitFields: [String] = ["Id","Subject","AccountId","SGWS_Appointment_Status__c","StartDate","EndDate","SGWS_Visit_Purpose__c","Description","SGWS_Agenda_Notes__c","Status","SGWS_AppModified_DateTime__c","ContactId","RecordTypeId","_soupEntryId","SGWS_WorkOrder_Location__c","SGWS_All_Day_Event__c","OwnerId","visitTitle","visitType","accountList","systemConfigurationObject","SGWS_Start_Latitude__c","SGWS_Start_Longitude__c","SGWS_Start_Time_of_Visit__c","SGWS_End_Latitude__c","SGWS_End_Longitude__c","SGWS_End_Time_of_Visit__c"]
    
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
    
    var ownerId : String
    
    var visitTitle: String
    var visitType: String
    var accountList: [Account]?
    let systemConfigurationObject:SyncConfiguration?
    
    // location related
    var startLatitude:Double
    var startLongitude:Double
    var startTime_of_Visit: String
 
    var endLatitude:Double
    var endLongitude:Double
    var endTime_of_Visit: String
    
    
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
        
        ownerId = json["OwnerId"] as? String ?? ""
        startLatitude = json["SGWS_Start_Latitude__c"] as? Double ?? 0.0
        startLongitude = json["SGWS_Start_Longitude__c"] as? Double ?? 0.0
        startTime_of_Visit = json["SGWS_Start_Time_of_Visit__c"] as? String ?? ""
 
        
        
        endLatitude = json["SGWS_End_Latitude__c"] as? Double ?? 0.0
        endLongitude = json["SGWS_End_Longitude__c"] as? Double ?? 0.0
        endTime_of_Visit = json["SGWS_End_Time_of_Visit__c"] as? String ?? ""
        
        
        let globalSyncConfigurationList = SyncConfigurationViewModel().syncConfiguration()
        let globalAccountsForLoggedUser = GlobalWorkOrderArray.accountArray
        
        
//        if((StoreDispatcher.shared.workOrderTypeDict[StoreDispatcher.shared.workOrderTypeVisit]) == StoreDispatcher.shared.workOrderRecordTypeIdVisit){
//            workOrderType = StoreDispatcher.shared.workOrderTypeVisit
//        } else {
//            workOrderType = StoreDispatcher.shared.workOrderTypeEvent
//
//        }
        
        accountList = AccountSortUtility.searchAccountByAccountId(accountsForLoggedUser: globalAccountsForLoggedUser, accountId: self.accountId)
        
        workOrderType = ""
        
        systemConfigurationObject = SyncConfigurationSortUtility.searchSyncConfigurationByRecordTypeId(syncConfigurationList: globalSyncConfigurationList, recordTypeId:recordTypeId)
        visitType = ""
        visitTitle = ""
        if (systemConfigurationObject?.developerName == "SGWS_WorkOrder_Event") {
            visitType = "event"
            visitTitle = subject
        }
        else if (systemConfigurationObject?.developerName == "SGWS_WorkOrder_Visit") {
            visitType = "visit"
            visitTitle = accountList![0].accountName + ": " + accountList![0].accountNumber
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
        ownerId = ""
        visitTitle = ""
        visitType = ""
        accountList = nil
        systemConfigurationObject = nil
        startLatitude = 0.0
         startLongitude = 0.0
        startTime_of_Visit = ""
        endLatitude = 0.0
        endLongitude = 0.0
        endTime_of_Visit = ""
        
        
    }
}
