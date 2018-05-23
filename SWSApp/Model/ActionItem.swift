//
//  ActionItem.swift
//  SWSApp
//
//  Created by saagar.manohar.kale on 14/05/18.
//  Copyright © 2018 saagar.manohar.kale All rights reserved.
//

import Foundation
//Collect all data in Enum can be used in later improvement not used now
enum ActionItemTable: Int, CustomStringConvertible {
    case Id = 0
    case AccountId
    case Subject
    case Description
    case Status
    case ActivityDate
    case IsUrgent
    case AppModifiedDate
    case RecordTypeId
    
    var description: String {
        switch self {
        case .Id:
            return "Id"
        case .AccountId:
            return "AccountId"
        case .Subject:
            return "Subject"
        case .Description:
            return "Description"
        case .Status:
            return "Status"
        case .ActivityDate:
            return "ActivityDate"
        case .IsUrgent:
            return "SGWS_Urgent__c"
        case .AppModifiedDate:
            return "SGWS_AppModified_DateTime__c"
        case .RecordTypeId:
            return "RecordTypeId"
        }
    }
}

class ActionItem {
    static let AccountActionItemFields: [String] =  ["Id","SGWS_Account__c","Subject","Description","Status","ActivityDate","SGWS_Urgent__c","SGWS_AppModified_DateTime__c","RecordTypeId","Account.Name","Account.AccountNumber","Account.ShippingCity","Account.ShippingCountry","Account.ShippingPostalCode","Account.ShippingState","Account.ShippingStreet"]
    
    var Id:String
    var accountId:String
    var subject: String
    var description: String
    var status: String
    var activityDate: String
    var isUrgent:Bool
    var lastModifiedDate: String
    var recordTypeId: String
    var _soupEntryId: Int
    
    var accountName: String
    var accountNumber: String
    var shippingCity: String
    var shippingCountry: String
    var shippingPostalCode: String
    var shippingState: String
    var shippingStreet: String
    
    convenience init(withAry ary: [Any]) {
        let resultDict = Dictionary(uniqueKeysWithValues: zip(ActionItem.AccountActionItemFields, ary))
        self.init(json: resultDict)
    }
    
    init(json: [String: Any]) {
        Id = json["Id"] as? String ?? ""
        accountId = json["SGWS_Account__c"] as? String ?? ""
        subject = json["Subject"] as? String ?? ""
        description = json["Description"] as? String ?? ""
        status = json["Status"] as? String ?? ""
        activityDate = json["ActivityDate"] as? String ?? ""
        isUrgent = json["SGWS_Urgent__c"] as? Bool ?? false
        let isUrgentString = json["SGWS_Urgent__c"] as? String ?? ""
        if isUrgentString == "true" {
            isUrgent = true
        }
        if isUrgentString == "1" {
            isUrgent = true
        }
        
        lastModifiedDate = json["SGWS_AppModified_DateTime__c"] as? String ?? ""
        recordTypeId = json["RecordTypeId"] as? String ?? ""
        _soupEntryId = json["_soupEntryId"] as? Int ?? 0
        
        accountName = json["Account.Name"] as? String ?? ""
        shippingCity = json["Account.ShippingCity"] as? String ?? ""
        shippingCountry = json["Account.ShippingCountry"] as? String ?? ""
        shippingPostalCode = json["Account.ShippingPostalCode"] as? String ?? ""
        shippingState = json["Account.ShippingState"] as? String ?? ""
        shippingStreet = json["Account.ShippingStreet"] as? String ?? ""
        accountNumber = json["Account.AccountNumber"] as? String ?? ""
        
        
        
    }
    
    init(for: String) {
        Id = ""
        accountId = ""
        subject = ""
        description = ""
        status = ""
        activityDate = ""
        isUrgent = false
        lastModifiedDate = ""
        recordTypeId = ""
        _soupEntryId = 0
        
        accountName = ""
        accountNumber = ""
        shippingCity = ""
        shippingCountry = ""
        shippingPostalCode = ""
        shippingState = ""
        shippingStreet = ""   
    }
}

extension ActionItem: Equatable,Hashable {
    var hashValue: Int {
        return Id.hashValue
    }
    
    static func == (lhs: ActionItem, rhs: ActionItem) -> Bool {
        return lhs.Id == rhs.Id
    }
}

