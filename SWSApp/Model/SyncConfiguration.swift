//
//  SyncConfiguration.swift
//  SWSApp
//
//  Created by soumin.nikhra on 5/14/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation

class SyncConfiguration {
    
    static let syncConfigurationFields: [String] = ["Id", "SGWS_RecordTypeId__c", "SGWS_RecordType_DeveloperName__c", "SGWS_SalesConsultantSyncFrom__c", "SGWS_SalesConsultantSyncTo__c", "SGWS_SalesManagerSyncFrom__c", "SGWS_SalesManagerSyncTo__c", "SGWS_sObject__c"]
    
    var id: String
    var recordTypeId: String
    var developerName: String
    var salesConsultantSyncFrom: String
    var salesConsultantSyncTo: String
    var salesManagerSyncFrom: String
    var salesManagerSyncTo: String
    var sObjectType: String
    
    convenience init(withAry ary: [Any]) {
        let resultDict = Dictionary(uniqueKeysWithValues: zip(SyncConfiguration.syncConfigurationFields, ary))
        self.init(json: resultDict)
    }
    
    init(json: [String: Any]) {
        
        print("SyncConfiguration : Json coming here is*** \(json)")
        
        id = json["Id"] as? String ?? ""
        recordTypeId = json["SGWS_RecordTypeId__c"] as? String ?? ""
        developerName = json["SGWS_RecordType_DeveloperName__c"] as? String ?? ""
        salesConsultantSyncFrom = json["SGWS_SalesConsultantSyncFrom__c"] as? String ?? ""
        salesConsultantSyncTo = json["SGWS_SalesConsultantSyncTo__c"] as? String ?? ""
        salesManagerSyncFrom = json["SGWS_SalesManagerSyncFrom__c"] as? String ?? ""
        salesManagerSyncTo = json["SGWS_SalesManagerSyncTo__c"] as? String ?? ""
        sObjectType = json["SGWS_sObject__c"] as? String ?? ""
        
    }
    
    init(for: String) {
        
        id = ""
        recordTypeId = ""
        developerName = ""
        salesConsultantSyncFrom = ""
        salesConsultantSyncTo = ""
        salesManagerSyncFrom = ""
        salesManagerSyncTo = ""
        sObjectType = ""
        
    }
    
}
