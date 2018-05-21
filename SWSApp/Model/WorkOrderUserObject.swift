//
//  WorkOrderUserObject.swift
//  SWSApp
//
//  Created by soumin.nikhra on 5/14/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation

//{WorkOrder:Id},{WorkOrder:Subject},{WorkOrder:AccountId},A.{AccountTeamMember:Account.Name},A.{AccountTeamMember:Account.ShippingCity},A.{AccountTeamMember:Account.ShippingCountry},A.{AccountTeamMember:Account.ShippingPostalCode},A.{AccountTeamMember:Account.ShippingState},A.{AccountTeamMember:Account.ShippingStreet},{WorkOrder:SGWS_Appointment_Status__c},{WorkOrder:StartDate},{WorkOrder:EndDate},{WorkOrder:SGWS_Visit_Purpose__c},{WorkOrder:Description},{WorkOrder:SGWS_Agenda_Notes__c},{WorkOrder:Status},{WorkOrder:SGWS_AppModified_DateTime__c},{WorkOrder:ContactId},{Contact:Id},{Contact:Name},{Contact:FirstName},{Contact:LastName},{Contact:Phone},{Contact:Email},{WorkOrder:RecordTypeId},{WorkOrder:_soupEntryId}

class WorkOrderUserObject {
    
    //["Id","Subject","AccountId","Account.Name","Account.AccountNumber","Account.BillingAddress","ContactId","Contact.Name","Contact.Phone","Contact.Email","Contact.SGWS_Roles__c","SGWS_Appointment_Status__c","StartDate","EndDate","SGWS_Visit_Purpose__c","Description","SGWS_Agenda_Notes__c","Status","SGWS_AppModified_DateTime__c","SGWS_WorkOrder_Location__c ","RecordTypeId"]
    
    static let WorkOrderUserObjectFields: [String] = ["Id","Subject","SGWS_WorkOrder_Location__c","AccountId","Account.Name","Account.AccountNumber","Account.ShippingCity","Account.ShippingCountry","Account.ShippingPostalCode","Account.ShippingState","Account.ShippingStreet","SGWS_Appointment_Status__c","StartDate","EndDate","SGWS_Visit_Purpose__c","Description","SGWS_Agenda_Notes__c","Status","SGWS_AppModified_DateTime__c","ContactId", "Name", "FirstName", "LastName","Phone","Email","RecordTypeId","_soupEntryId"]
    
    var Id : String
    var subject : String
    var accountId : String
    var accountName : String
    var accountNumber : String


    
    var shippingCity: String
    var shippingCountry: String
    var shippingPostalCode: String
    var shippingState: String
    var shippingStreet: String
    
    var sgwsAppointmentStatus : String
    var startDate : String
    var endDate : String
    var sgwsVisitPurpose : String
    var description : String
    var sgwsAgendaNotes : String
    var status : String
    var lastModifiedDate : String
    
    var contactId: String
    var name: String
    var firstName: String
    var lastName: String
    var phone : String
    var email: String
    
    
    var recordTypeId: String
    var soupEntryId: Int
    var location :String


    
    
    
    convenience init(withAry ary: [Any]) {
        let resultDict = Dictionary(uniqueKeysWithValues: zip(WorkOrderUserObject.WorkOrderUserObjectFields, ary))
        self.init(json: resultDict)
    }
    
    init(json: [String: Any]) {
        
        Id = json["Id"] as? String ?? ""
        subject = json["Subject"] as? String ?? ""
        accountId = json["AccountId"] as? String ?? ""
        accountName = json["Account.Name"] as? String ?? ""
        accountNumber = json["Account.Number"] as? String ?? ""

        shippingCity = json["Account.ShippingCity"] as? String ?? ""
        shippingCountry = json["Account.ShippingCountry"] as? String ?? ""
        shippingPostalCode = json["Account.ShippingPostalCode"] as? String ?? ""
        shippingState = json["Account.ShippingState"] as? String ?? ""
        shippingStreet = json["Account.ShippingStreet"] as? String ?? ""
        
        sgwsAppointmentStatus = json["SGWS_Appointment_Status__c"] as? String ?? ""
        startDate = json["StartDate"] as? String ?? ""
        endDate = json["EndDate"] as? String ?? ""
        sgwsVisitPurpose = json["SGWS_Visit_Purpose__c"] as? String ?? ""
        description = json["Description"] as? String ?? ""
        sgwsAgendaNotes = json["SGWS_Agenda_Notes__c"] as? String ?? ""
        status = json["Status"] as? String ?? ""
        lastModifiedDate = json["SGWS_AppModified_DateTime__c"] as? String ?? ""
        
        contactId = json["ContactId"] as? String ?? ""
        firstName = json["FirstName"] as? String ?? ""
        lastName = json["LastName"] as? String ?? ""
        name = json["Name"] as? String ?? ""
        if(name == ""){
            name = firstName + " " + lastName
        }
        phone = json["Phone"] as? String ?? ""
        email = json["Email"] as? String ?? ""

        recordTypeId = json["RecordTypeId"] as? String ?? ""

        soupEntryId = json["_soupEntryId"] as? Int ?? 0
        location = json["SGWS_WorkOrder_Location__c"] as? String ?? ""

    }
    
    init(for: String) {
        
        Id = ""
        subject = ""
        accountId = ""
        accountName = ""
        accountNumber = ""
        
        shippingCity = ""
        shippingCountry = ""
        shippingPostalCode = ""
        shippingState = ""
        shippingStreet = ""
        sgwsAppointmentStatus = ""
        startDate = ""
        endDate = ""
        sgwsVisitPurpose = ""
        description = ""
        sgwsAgendaNotes = ""
        status = ""
        lastModifiedDate = ""
        
        contactId = ""
        name = ""
        firstName = ""
        lastName = ""
        recordTypeId = ""
        email = ""
        phone = ""
        soupEntryId = 0
        location = ""
        
    }
}
