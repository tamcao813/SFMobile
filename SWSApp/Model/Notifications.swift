//
//  Notification.swift
//  SWSApp
//
//  Created by shubham.e.shukla on 5/30/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation
class Notifications {
    
    static let notificationsFields: [String] = ["Id","Account__c","CreatedDate","Name","SGWS_Account_License_Notification__c","SGWS_Site__c","isRead"]
    
    var Id : String
    var account : String
    var createdDate : String
    var name : String
    var sgwsAccLicenseNotification : String
    var sgwsSite : String
    var isRead : Bool

    
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
        isRead = json["isRead"] as? Bool ?? false
      
    }
    
    init(for: String) {
        
        Id = ""
        account = ""
        createdDate = ""
        name = ""
        sgwsAccLicenseNotification = ""
        sgwsSite = ""
        isRead = false
       
        
    }
    
}
