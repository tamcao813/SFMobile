//
//  PlanVisitsTests.swift
//  SWSAppTests
//
//  Created by Krishna, Kamya on 7/26/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import XCTest
@testable import SWSApp

class PlanVisitsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testPlanInit(){
        let plan = PlanVisit.init(for: "")
        XCTAssertEqual(plan.Id, "")
        XCTAssertEqual(plan.subject, "")
        XCTAssertEqual(plan.accountId, "")
        XCTAssertEqual(plan.accountId, "")
        XCTAssertEqual(plan.lastModifiedDate, "")
        XCTAssertEqual(plan.accountId, "")
        //XCTAssertEqual(plan.sgwsAppointmentStatus, "")
        XCTAssertEqual(plan.startDate, "")
        XCTAssertEqual(plan.endDate, "")
        XCTAssertEqual(plan.sgwsVisitPurpose, "")
        XCTAssertEqual(plan.description, "")
        XCTAssertEqual(plan.sgwsAgendaNotes, "")
        XCTAssertEqual(plan.status, "")
        XCTAssertEqual(plan.lastModifiedDate, "")
    }
    
    func testPlanVisitInitJson(){
        
        let planVisitFields: [String: Any] = ["Id": "","Subject": "","AccountId": "","SGWS_Appointment_Status__c": "","StartDate": "","EndDate": "","SGWS_Visit_Purpose__c": "","Description": "","SGWS_Agenda_Notes__c": "","Status": "","SGWS_AppModified_DateTime__c": "","ContactId": ""]
        
        let planVisit = PlanVisit.init(json: planVisitFields)
        
        XCTAssertEqual(planVisit.Id, planVisitFields["Id"] as! String)
        XCTAssertEqual(planVisit.subject, planVisitFields["Subject"] as! String)
        XCTAssertEqual(planVisit.accountId, planVisitFields["AccountId"] as! String)
        XCTAssertEqual(planVisit.startDate, planVisitFields["StartDate"] as! String)
        XCTAssertEqual(planVisit.endDate, planVisitFields["EndDate"] as! String)
        XCTAssertEqual(planVisit.sgwsVisitPurpose, planVisitFields["SGWS_Visit_Purpose__c"] as! String)
        XCTAssertEqual(planVisit.description, planVisitFields["Description"] as! String)
        XCTAssertEqual(planVisit.sgwsAgendaNotes, planVisitFields["SGWS_Agenda_Notes__c"] as! String)
        XCTAssertEqual(planVisit.status, planVisitFields["Status"] as! String)
        XCTAssertEqual(planVisit.lastModifiedDate, planVisitFields["SGWS_AppModified_DateTime__c"] as! String)
        XCTAssertEqual(planVisit.contactId, planVisitFields["ContactId"] as! String)
        
    }
    
}
