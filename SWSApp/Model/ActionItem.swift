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
    
//    fileprivate func createNewActionItem() {
//        // Create new actionItem Locally...
//        let actionItemSample = ActionItem(for: "newActionItem")
//        actionItemSample.Id = "223344"
//        actionItemSample.accountId = "86328932"
//        actionItemSample.subject = "Ravi Action Item 2"
//        actionItemSample.description = "Ravi to get Badam Milk"
//        actionItemSample.status = "Close"
//        actionItemSample.activityDate = DateTimeUtility.sendCurrentDateToServer()!
//        actionItemSample.isUrgent = "No"
//        actionItemSample.lastModifiedDate = DateTimeUtility.sendCurrentDateToServer()!
//        actionItemSample.recordTypeId = "TASK"
//        let attributeDict = ["type":"Task"]
//
//        let addNewDict:[String:Any] = [
//            ActionItem.AccountActionItemFields[0]: actionItemSample.Id,
//            ActionItem.AccountActionItemFields[1]: actionItemSample.accountId,
//            ActionItem.AccountActionItemFields[2]: actionItemSample.subject,
//            ActionItem.AccountActionItemFields[3]: actionItemSample.description,
//            ActionItem.AccountActionItemFields[4]: actionItemSample.status,
//            ActionItem.AccountActionItemFields[5]: actionItemSample.activityDate,
//            ActionItem.AccountActionItemFields[6]: actionItemSample.isUrgent,
//            ActionItem.AccountActionItemFields[7]: actionItemSample.lastModifiedDate,
//            ActionItem.AccountActionItemFields[8]: actionItemSample.recordTypeId,
//            //Use it for Saving loacly on DB
//            kSyncTargetLocal:true,
//            kSyncTargetLocallyCreated:true,
//            kSyncTargetLocallyUpdated:false,
//            kSyncTargetLocallyDeleted:false,
//            "attributes":attributeDict]
//
//        let success = actionItemViewModel.createNewActionItemLocally(fields: addNewDict)
//        print("Create new action item success \(success)")
//
//        let SmartStoreViewController = SFSmartStoreInspectorViewController.init(store:  SFSmartStore.sharedStore(withName: StoreDispatcher.SFADB) as! SFSmartStore)
//        present(SmartStoreViewController, animated: true, completion: nil)
//    }
//    // SyncDown Action items
//    actionitem = actionItemViewModel.getAcctionItemForUser()
//    createNewActionItem()
}
