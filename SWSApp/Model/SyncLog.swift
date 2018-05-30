//
//  SyncLog.swift
//  SWSApp
//
//  Created by saagar.manohar.kale on 5/28/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation

//Following parameters will be Created and synced up, there will be no sync down or edit.
//   1 SessionID: SGWS_Session_ID__c
//   2 Activity: SGWS_Activity__c
//   3 ActivityTimestamp: SGWS_Activity_Timestamp__c
//   4 UserId: SGWS_User_Id__c
//   5 Activity Detail: SGWS_Activity_Detail__c
class SyncLog {
    static let SyncLogFields: [String] =  ["Id","SGWS_Session_ID__c","SGWS_Activity__c","SGWS_Activity_Timestamp__c","SGWS_User_Id__c","SGWS_Activity_Detail__c"]
    
    var Id:String
    var sessionID:String
    var activityType: String
    var activityTime: String
    var userId: String
    var activityDetails: String
    
    convenience init(withAry ary: [Any]) {
        let resultDict = Dictionary(uniqueKeysWithValues: zip(SyncLog.SyncLogFields, ary))
        self.init(json: resultDict)
    }
    
    init(json: [String: Any]) {
        Id = json["Id"] as? String ?? ""
        sessionID = json["SGWS_Session_ID__c"] as? String ?? ""
        activityType = json["SGWS_Activity__c"] as? String ?? ""
        activityTime = json["SGWS_Activity_Timestamp__c"] as? String ?? ""
        userId = json["SGWS_User_Id__c"] as? String ?? ""
        activityDetails = json["SGWS_Activity_Detail__c"] as? String ?? ""
    }
    
    init(for: String) {
        Id = ""
        sessionID = ""
        activityType = ""
        activityTime = ""
        userId = ""
        activityDetails = ""
    }
}

