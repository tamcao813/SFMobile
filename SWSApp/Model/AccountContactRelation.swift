//
//  AccountContactRelation.swift
//  SWSApp
//
//  Created by soumin.nikhra on 4/23/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation

class AccountContactRelation {
    static let AccountContactRelationFields: [String] = ["Id","Account.Name", "Roles", "AccountId", "ContactId", "Contact.name", "SGWS_Account_Site_Number__c"]
    
    var acrId:String
    var accountName: String
    var roles: String
    var accountId: String
    var contactId: String
    var contactName: String
    var sgwsSiteNumber: String
    
    convenience init(withAry ary: [Any]) {
        let resultDict = Dictionary(uniqueKeysWithValues: zip(AccountContactRelation.AccountContactRelationFields, ary))
        self.init(json: resultDict)
    }
    
    init(json: [String: Any]) {
        acrId = json["Id"] as? String ?? ""
        accountName = json["Account.Name"] as? String ?? ""
        roles = json["Roles"] as? String ?? ""
        accountId = json["AccountId"] as? String ?? ""
        contactId = json["ContactId"] as? String ?? ""
        contactName = json["Contact.name"] as? String ?? ""
        sgwsSiteNumber = json["SGWS_Account_Site_Number__c"] as? String ?? ""
        
    }
    
    init(for: String) {
        acrId = ""
        accountName = ""
        roles = ""
        accountId = ""
        contactId = ""
        contactName = ""
        sgwsSiteNumber = ""
    }
    
    func toJson() -> [String:Any] {
        var json = [String:Any]()
        
        if acrId.count > 0{
            acrId = json["Id"] as? String ?? ""
        }
        
        if accountName.count > 0 {
            accountName = json["Account.Name"] as? String ?? ""
        }
        
        if roles.count > 0{
            roles = json["Roles"] as? String ?? ""
        }
        
        if accountId.count > 0 {
            accountId = json["AccountId"] as? String ?? ""
        }
        
        if contactId.count > 0{
            contactId = json["ContactId"] as? String ?? ""
            contactName = json["Contact.name"] as? String ?? ""
            
        }
        
        if contactName.count > 0 {
            contactName = json["Contact.name"] as? String ?? ""
        }
        
        if sgwsSiteNumber.count > 0 {
            sgwsSiteNumber = json["SGWS_Account_Site_Number__c"] as? String ?? ""
        }
        
        return json
    }
}
