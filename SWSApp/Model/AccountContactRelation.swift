//
//  AccountContactRelation.swift
//  SWSApp
//
//  Created by soumin.nikhra on 4/23/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation

class AccountContactRelation {
    static let AccountContactRelationFields: [String] = ["Id", "SGWS_Account__c", "SGWS_Contact__c", "Name", //"SGWS_Account_Site_Number__c",
        "SGWS_Other_Specification__c", "SGWS_IsActive__c", "SGWS_Buying_Power__c", "SGWS_Roles__c", "SGWS_Contact_Classification__c"] //Roles and SGWS_Contact_Classification__c are plists, put them at the end and handle them in registerACRsoup
    
    var acrId:String
    //var accountName: String
    var accountId: String
    var contactId: String
    var contactName: String
    //var sgwsSiteNumber: String
    var isActive: Int
    var buyingPower: Int
    var roles: String
    var contactClassification: String
    var otherSpecification: String
    
    convenience init(withAry ary: [Any]) {
        let resultDict = Dictionary(uniqueKeysWithValues: zip(AccountContactRelation.AccountContactRelationFields, ary))
        self.init(json: resultDict)
    }
    
    init(json: [String: Any]) {
        acrId = json["Id"] as? String ?? ""
        //accountName = json["Account.Name"] as? String ?? ""
        accountId = json["SGWS_Account__c"] as? String ?? ""
        contactId = json["SGWS_Contact__c"] as? String ?? ""
        contactName = json["Name"] as? String ?? ""
        //sgwsSiteNumber = json["SGWS_Account_Site_Number__c"] as? String ?? ""
        roles = json["SGWS_Roles__c"] as? String ?? ""
        isActive = json["SGWS_IsActive__c"] as? Int ?? 0
        buyingPower = json["SGWS_Buying_Power__c"] as? Int ?? 0
        contactClassification = json["SGWS_Contact_Classification__c"] as? String ?? ""
        otherSpecification = json["SGWS_Other_Specification__c"] as? String ?? ""
    }
    
    init(for: String) {
        let n = Int(arc4random_uniform(100000000))
        acrId = "NEW" + "\(n)"
        //accountName = ""
        roles = ""
        accountId = ""
        contactId = ""
        contactName = ""
        //sgwsSiteNumber = ""
        isActive = 1
        buyingPower = 1
        contactClassification = ""
        otherSpecification = ""
    }
    
    func toJson() -> [String:Any] {
        var json = [String:Any]()
        
        json["Id"] = acrId //must have
        
        if roles.count > 0 {
            json["SGWS_Roles__c"] = roles
        }
        
        if accountId.count > 0 { //must have
            json["SGWS_Account__c"] = accountId
        }
        
        if contactId.count > 0 { //must have
            json["SGWS_Contact__c"] = contactId
        }
        
        if contactName.count > 0 {
            json["Name"] = contactName
        }
        
        json["SGWS_Other_Specification__c"] = otherSpecification
        
        json["SGWS_IsActive__c"] = isActive
        
        json["SGWS_Buying_Power__c"] = buyingPower
        
        if contactClassification.count > 0 {
            json["SGWS_Contact_Classification__c"] = contactClassification
        }
        
        return json
    }
}
