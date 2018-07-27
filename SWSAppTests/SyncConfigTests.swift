//
//  SyncConfigTests.swift
//  SWSAppTests
//
//  Created by Krishna, Kamya on 7/26/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import XCTest
@testable import SWSApp

class SyncConfigTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSyncConfigurationInitJson(){
        
        let syncConfigurationFields: [String: Any] = ["Id": "", "SGWS_RecordTypeId__c": "", "SGWS_RecordType_DeveloperName__c": "", "SGWS_SalesConsultantSyncFrom__c": "", "SGWS_SalesConsultantSyncTo__c": "", "SGWS_SalesManagerSyncFrom__c": "", "SGWS_SalesManagerSyncTo__c": "", "SGWS_sObject__c": ""]
        
        let synConfig = SyncConfiguration.init(json: syncConfigurationFields)
        XCTAssertEqual(synConfig.id, syncConfigurationFields["Id"] as! String)
        XCTAssertEqual(synConfig.recordTypeId, syncConfigurationFields["SGWS_RecordTypeId__c"] as! String)
        XCTAssertEqual(synConfig.developerName, syncConfigurationFields["SGWS_RecordType_DeveloperName__c"] as! String)
        XCTAssertEqual(synConfig.salesConsultantSyncFrom, syncConfigurationFields["SGWS_SalesConsultantSyncFrom__c"] as! String)
        XCTAssertEqual(synConfig.salesConsultantSyncTo, syncConfigurationFields["SGWS_SalesConsultantSyncTo__c"] as! String)
        XCTAssertEqual(synConfig.salesManagerSyncFrom, syncConfigurationFields["SGWS_SalesManagerSyncFrom__c"] as! String)
        XCTAssertEqual(synConfig.salesManagerSyncTo, syncConfigurationFields["SGWS_SalesManagerSyncTo__c"] as! String)
        XCTAssertEqual(synConfig.sObjectType, syncConfigurationFields["SGWS_sObject__c"] as! String)
        
    }
    
    func testSyncConfigurationInit(){
        
        let syncConfig = SyncConfiguration.init(for: "")
        XCTAssertEqual(syncConfig.id, "")
        XCTAssertEqual(syncConfig.recordTypeId, "")
        XCTAssertEqual(syncConfig.developerName, "")
        XCTAssertEqual(syncConfig.salesConsultantSyncFrom, "")
        XCTAssertEqual(syncConfig.salesConsultantSyncTo, "")
        XCTAssertEqual(syncConfig.salesManagerSyncFrom, "")
        XCTAssertEqual(syncConfig.salesManagerSyncTo, "")
        XCTAssertEqual(syncConfig.sObjectType, "")
    }
    
    func testSyncConfigurationCInit(){
        
        let syncConfigurationFields: [Any] = ["Id", "SGWS_RecordTypeId__c", "SGWS_RecordType_DeveloperName__c", "SGWS_SalesConsultantSyncFrom__c", "SGWS_SalesConsultantSyncTo__c", "SGWS_SalesManagerSyncFrom__c", "SGWS_SalesManagerSyncTo__c", "SGWS_sObject__c"]
        XCTAssertNotNil(SyncConfiguration.init(withAry: syncConfigurationFields))
        
    }
    
    func testSearchSyncConfigurationByRecordTypeId() {
        
        _ = SyncConfigurationSortUtility.searchSyncConfigurationByRecordTypeId(syncConfigurationList:  SyncConfigurationViewModel().syncConfiguration(), recordTypeId:"a4z0t000000A8DdAAK")
        
        _ = SyncConfigurationSortUtility.searchSyncConfigurationByRecordTypeId(syncConfigurationList:  SyncConfigurationViewModel().syncConfiguration(), recordTypeId:"0120t0000008cMBAAY")
        
    }
    
    func testSyncLogInitJson(){
        let syncLogFields: [String: Any] =  ["Id": "","SGWS_Session_ID__c": ""
            ,"SGWS_Activity__c": "","SGWS_Activity_Timestamp__c": "","SGWS_User_Id__c": "","SGWS_Activity_Detail__c": ""]
        
        let syncLog = SyncLog.init(json: syncLogFields)
        XCTAssertEqual(syncLog.Id, syncLogFields["Id"] as! String)
        XCTAssertEqual(syncLog.sessionID, syncLogFields["SGWS_Session_ID__c"] as! String)
        XCTAssertEqual(syncLog.activityType, syncLogFields["SGWS_Activity__c"] as! String)
        XCTAssertEqual(syncLog.activityTime, syncLogFields["SGWS_Activity_Timestamp__c"] as! String)
        XCTAssertEqual(syncLog.userId, syncLogFields["SGWS_User_Id__c"] as! String)
        XCTAssertEqual(syncLog.activityDetails, syncLogFields["SGWS_Activity_Detail__c"] as! String)
    }
    
    func testSyncLogInit(){
        let syncLog = SyncLog.init(for: "")
        XCTAssertEqual(syncLog.Id, "")
        XCTAssertEqual(syncLog.sessionID, "")
        XCTAssertEqual(syncLog.activityType, "")
        XCTAssertEqual(syncLog.activityTime, "")
        XCTAssertEqual(syncLog.userId, "")
        XCTAssertEqual(syncLog.activityDetails, "")
    }
    
    func testSyncLogCInit(){
        let syncLogFields: [String] =  ["Id","SGWS_Session_ID__c","SGWS_Activity__c","SGWS_Activity_Timestamp__c","SGWS_User_Id__c","SGWS_Activity_Detail__c"]
        XCTAssertNotNil(SyncLog.init(withAry: syncLogFields))
    }
    
}
