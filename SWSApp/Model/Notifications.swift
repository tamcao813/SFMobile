//
//  Notification.swift
//  SWSApp
//
//  Created by shubham.e.shukla on 5/30/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation
class Notifications {
    
    static let notificationsFields: [String] = ["Id","Account__c","CreatedDate","Name","SGWS_Account_License_Notification__c","SGWS_Site__c","SGWS_Contact_Birthday_Notification__c","SGWS_Contact__c","isRead","_soupEntryId","SGWS_Type__c"]
    
    var Id : String
    var account : String
    var createdDate : String
    var name : String
    var sgwsAccLicenseNotification : String
    var sgwsSite : String
    var sgwsContactBirthdayNotification : String
    var sgwsContact :String
    var isRead : Bool
    var soupEntryId : String
    var sgwsType :String
    
    
    
    convenience init(withAry ary: [Any]) {
        let resultDict = Dictionary(uniqueKeysWithValues: zip(Notifications.notificationsFields, ary))
        self.init(json: resultDict)
    }
    
    init(json: [String: Any]) {
        
        Id = json["Id"] as? String ?? ""
        account = json["Account__c"] as? String ?? ""
        createdDate = json["CreatedDate"] as? String ?? ""
        name = json["Name"] as? String ?? ""
        sgwsAccLicenseNotification = json["SGWS_Account_License_Notification__c"] as? String ?? ""
        sgwsSite = json["SGWS_Site__c"] as? String ?? ""
        sgwsContactBirthdayNotification = json["SGWS_Contact_Birthday_Notification__c"] as? String ?? ""
        sgwsContact = json["SGWS_Contact__c"] as? String ?? ""
        isRead = json["isRead"] as? Bool ?? false
        let isReadString = json["isRead"] as? String ?? ""
        if isReadString == "true" {
            isRead = true
        }
        if isReadString == "1" {
            isRead = true
        }
        soupEntryId = json["_soupEntryId"] as? String ?? ""
        sgwsType = json["SGWS_Type__c"]  as? String ?? ""       
    }
    
    init(for: String) {
        Id = ""
        account = ""
        createdDate = ""
        name = ""
        sgwsAccLicenseNotification = ""
        sgwsSite = ""
        sgwsContactBirthdayNotification = ""
        sgwsContact = ""
        isRead = false
        soupEntryId = ""
        sgwsType = ""
    }
    
}
