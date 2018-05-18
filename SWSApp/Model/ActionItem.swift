//
//  ActionItem.swift
//  SWSApp
//
//  Created by Jagadeeshwar Reddy on 27/04/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation

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
    static let AccountActionItemFields: [String] =  ["Id","AccountId","Subject","Description","Status","ActivityDate","SGWS_Urgent__c","SGWS_AppModified_DateTime__c","RecordTypeId"]
    
    var Id:String
    var accountId:String
    var subject: String
    var description: String
    var status: String
    var activityDate: String
    var isUrgent:String
    var lastModifiedDate: String
    var recordTypeId: String
    var _soupEntryId: Int
    
    convenience init(withAry ary: [Any]) {
        let resultDict = Dictionary(uniqueKeysWithValues: zip(ActionItem.AccountActionItemFields, ary))
        self.init(json: resultDict)
    }
    
    init(json: [String: Any]) {
        Id = json["Id"] as? String ?? ""
        accountId = json["AccountId"] as? String ?? ""
        subject = json["Subject"] as? String ?? ""
        description = json["Description"] as? String ?? ""
        status = json["Status"] as? String ?? ""
        activityDate = json["ActivityDate"] as? String ?? ""
        isUrgent = json["SGWS_Urgent__c"] as? String ?? ""
        lastModifiedDate = json["SGWS_AppModified_DateTime__c"] as? String ?? ""
        recordTypeId = json["RecordTypeId"] as? String ?? ""
        _soupEntryId = json["_soupEntryId"] as? Int ?? 0
    }
    
    init(for: String) {
        Id = ""
        accountId = ""
        subject = ""
        description = ""
        status = ""
        activityDate = ""
        isUrgent = ""
        lastModifiedDate = ""
        recordTypeId = ""
        _soupEntryId = 0
    }
    
    static func mockActionItem() -> ActionItem {
        let actionItemSample = ActionItem(for: "mockUp")
        actionItemSample.Id = "223344"
        actionItemSample.accountId = "8818181818"
        actionItemSample.subject = "Shubhams Action Item"
        actionItemSample.description = "Shubham to get JD"
        actionItemSample.status = "Open"
        actionItemSample.activityDate = DateTimeUtility.sendCurrentDateToServer()!
        actionItemSample.isUrgent = "YES"
        actionItemSample.lastModifiedDate = DateTimeUtility.sendCurrentDateToServer()!
        actionItemSample.recordTypeId = "TASK"
        actionItemSample._soupEntryId = 0
        return actionItemSample
    }
}
