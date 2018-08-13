//
//  VisitSchedulerViewModelTests.swift
//  SWSAppTests
//
//  Created by Krishna, Kamya on 7/30/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import XCTest
import SmartSync
@testable import SWSApp

class VisitSchedulerViewModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCreateContactToSoup() {
        _ = VisitSchedulerViewModel().createNewContactToSoup(object:MockContactDataProvider.mockTestContact1())
    }
    
    func testEditVisitToSoup() {
        
        let attributeDict = ["type":"WorkOrder"]
        let addNewDict: [String:Any] = [
            PlanVisit.planVisitFields[0]: "0WO0t000000L1LQGA0",
            PlanVisit.planVisitFields[1]: "",
            PlanVisit.planVisitFields[2]: "001i000001IUjJCAA1",
            PlanVisit.planVisitFields[3]: false,
            PlanVisit.planVisitFields[4]: "2018-07-17T08:30:00.000+0000",
            PlanVisit.planVisitFields[5]: "2018-07-17T11:30:00.000+0000",
            PlanVisit.planVisitFields[6]: "Sample and Tasting",
            PlanVisit.planVisitFields[7]: "",
            PlanVisit.planVisitFields[8]: "",
            PlanVisit.planVisitFields[9]: "Planned",
            PlanVisit.planVisitFields[10]:"2018-07-17T12:13:33.000+0000",
            PlanVisit.planVisitFields[11]: "",
            PlanVisit.planVisitFields[12]:"0120t0000008cMEAAY",
            PlanVisit.planVisitFields[13]:"47",
            PlanVisit.planVisitFields[14]:"",
            PlanVisit.planVisitFields[15]:"False",
            PlanVisit.planVisitFields[21]:"0.0",
            PlanVisit.planVisitFields[22]:"0.0",
            PlanVisit.planVisitFields[23]:"",
            PlanVisit.planVisitFields[24]:"0.0",
            PlanVisit.planVisitFields[25]:"0.0",
            PlanVisit.planVisitFields[26]:"",
            
            kSyncTargetLocal:true,
            kSyncTargetLocallyCreated:true,
            kSyncTargetLocallyUpdated:false,
            kSyncTargetLocallyDeleted:false,
            "attributes":attributeDict]
        
        _ = VisitSchedulerViewModel().editVisitToSoup(fields: addNewDict)
    }
    
    func testEditVisitEx() {
        let attributeDict = ["type":"WorkOrder"]
        
        let addNewDict: [String:Any] = [
            
            PlanVisit.planVisitFields[13]:"49",
            kSyncTargetLocal:true,
            kSyncTargetLocallyCreated:true,
            kSyncTargetLocallyUpdated:false,
            kSyncTargetLocallyDeleted:false,
            "attributes":attributeDict]
        _ = VisitSchedulerViewModel().editVisitToSoupEx(fields: addNewDict)
        
    }
    
    func testVisitSchedulerViewModel(){
        let visit = VisitSchedulerViewModel()
        XCTAssertNotNil(visit.visitsForUser())
    }
    
    func testSyncVisitsWithServer() {
        let visitsObj = VisitSchedulerViewModel()
        let expectation = XCTestExpectation(description: "Visits sync")
        visitsObj.syncVisitsWithServer{ error in
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
}
