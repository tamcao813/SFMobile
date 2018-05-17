//
//  AccountVisitEvent.swift
//  SWSApp
//
//  Created by soumin.nikhra on 5/14/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation

class AccountVisitEvent {
    
    static let accountVisitEventFields: [String] = ["Id","Subject","AccountId","Account.ShippingCity","Account.ShippingCountry","Account.ShippingPostalCode","Account.ShippingState","Account.ShippingStreet","SGWS_Appointment_Status__c","StartDate","EndDate","SGWS_Visit_Purpose__c","Description","SGWS_Agenda_Notes__c","Status","SGWS_AppModified_DateTime__c","ContactId", "Name", "FirstName", "LastName","RecordTypeId"]
    
    var Id : String
    var subject : String
    var accountId : String
    
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
    
    
    var recordTypeId: String

    
    
    
    convenience init(withAry ary: [Any]) {
        let resultDict = Dictionary(uniqueKeysWithValues: zip(AccountVisitEvent.accountVisitEventFields, ary))
        self.init(json: resultDict)
    }
    
    init(json: [String: Any]) {
        
        Id = json["Id"] as? String ?? ""
        subject = json["Subject"] as? String ?? ""
        
        accountId = json["AccountId"] as? String ?? ""
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

        recordTypeId = json["RecordTypeId"] as? String ?? ""

        
    }
    
    init(for: String) {
        
        Id = ""
        subject = ""
        
        accountId = ""
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
        
    }
}
