//
//  Visit.swift
//  SWSApp
//
//  Created by r.a.jantakal on 30/04/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation

class Visit{
    
    static let VisitsFields: [String] = ["Id","Subject","SGWS_WorkOrder_Location__c", "AccountId","ContactId","SGWS_Appointment_Status__c","StartDate","EndDate","SGWS_Visit_Purpose__c","Description","SGWS_Agenda_Notes__c","Status","SGWS_AppModified_DateTime__c","RecordTypeId","_soupEntryId","SGWS_All_Day_Event__c","OwnerId","visitTitle","visitType", "accountList", "systemConfigurationObject","SGWS_Start_Latitude__c","SGWS_Start_Longitude__c","SGWS_Start_Time_of_Visit__c","SGWS_End_Latitude__c","SGWS_End_Longitude__c","SGWS_End_Time_of_Visit__c"]
    
    var Id : String
    var subject : String
    var accountId : String
    var contactId : String
    var sgwsAppointmentStatus : Bool
    var startDate : String
    var dateStart : Date?
    var endDate : String
    var dateEnd : Date?
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
    var ownerId: String
    
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
        let globalSyncConfigurationList = SyncConfigurationViewModel().syncConfiguration()
        let globalAccountsForLoggedUser = AccountsViewModel().accountsForLoggedUser()
        
        startDate = json["StartDate"] as? String ?? ""
        if startDate == "" {
            dateStart = nil
        }
        else {
            dateStart = DateTimeUtility.getDateInUTCFormatFromDateString(dateString: startDate)
        }
        endDate = json["EndDate"] as? String ?? ""
        if endDate == "" {
            dateEnd = nil
        }
        else {
            dateEnd = DateTimeUtility.getDateInUTCFormatFromDateString(dateString: endDate)
        }
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
        
        startLatitude = json["SGWS_Start_Latitude__c"] as? Double ?? 0.0
        startLongitude = json["SGWS_Start_Longitude__c"] as? Double ?? 0.0
        startTime_of_Visit = json["SGWS_Start_Time_of_Visit__c"] as? String ?? ""
        endLatitude = json["SGWS_End_Latitude__c"] as? Double ?? 0.0
        endLongitude = json["SGWS_End_Longitude__c"] as? Double ?? 0.0
        endTime_of_Visit = json["SGWS_End_Time_of_Visit__c"] as? String ?? ""
       
        
//        if((StoreDispatcher.shared.workOrderTypeDict[StoreDispatcher.shared.workOrderTypeVisit]) == StoreDispatcher.shared.workOrderRecordTypeIdVisit){
//            workOrderType = StoreDispatcher.shared.workOrderTypeVisit
//        } else {
//            workOrderType = StoreDispatcher.shared.workOrderTypeEvent
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
        ownerId = json["OwnerId"] as? String ?? ""
    }
    
    init(for: String) {
        Id = ""
        subject = ""
        accountId = ""
        contactId = ""
        sgwsAppointmentStatus = false
        startDate = ""
        dateStart = nil
        endDate = ""
        dateEnd = nil
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
