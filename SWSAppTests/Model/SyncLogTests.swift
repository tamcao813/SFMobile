//
//  SyncLogTests.swift
//  SWSAppTests
//
//  Created by Krishna, Kamya on 7/30/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import XCTest
@testable import SWSApp

class SyncLogTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSyncLogCInit(){
        let syncLogFields: [String] =  ["Id","SGWS_Session_ID__c","SGWS_Activity__c","SGWS_Activity_Timestamp__c","SGWS_User_Id__c","SGWS_Activity_Detail__c"]
        XCTAssertNotNil(SyncLog.init(withAry: syncLogFields))
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
    
}
