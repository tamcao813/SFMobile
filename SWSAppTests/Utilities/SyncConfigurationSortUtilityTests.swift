//
//  SyncConfigurationSortUtilityTests.swift
//  SWSAppTests
//
//  Created by Krishna, Kamya on 7/30/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import XCTest
@testable import SWSApp

class SyncConfigurationSortUtilityTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSearchSyncConfigurationByRecordTypeId() {
        
        _ = SyncConfigurationSortUtility.searchSyncConfigurationByRecordTypeId(syncConfigurationList:  SyncConfigurationViewModel().syncConfiguration(), recordTypeId:"a4z0t000000A8DdAAK")
        
        _ = SyncConfigurationSortUtility.searchSyncConfigurationByRecordTypeId(syncConfigurationList:  SyncConfigurationViewModel().syncConfiguration(), recordTypeId:"0120t0000008cMBAAY")
        
    }
    
}
