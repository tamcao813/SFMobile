//
//  VisitsTests.swift
//  SWSAppTests
//
//  Created by Krishna, Kamya on 7/26/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import XCTest
@testable import SWSApp

class VisitsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testVisitInit(){
        
        let visit = Visit.init(for: "")
        XCTAssertEqual(visit.Id, "")
        XCTAssertEqual(visit.subject, "")
        XCTAssertEqual(visit.accountId, "")
        //XCTAssertEqual(visit.accountName, "")
        //XCTAssertEqual(visit.accountNumber, "")
        //XCTAssertEqual(visit.accountBillingAddress, "")
        XCTAssertEqual(visit.contactId, "")
        //XCTAssertEqual(visit.contactName, "")
        //XCTAssertEqual(visit.contactPhone, "")
        //XCTAssertEqual(visit.contactEmail, "")
        //XCTAssertEqual(visit.contactSGWS_Roles, "")
        //XCTAssertEqual(visit.sgwsAppointmentStatus, "")
        XCTAssertEqual(visit.startDate, "")
        XCTAssertEqual(visit.endDate, "")
        XCTAssertEqual(visit.sgwsVisitPurpose, "")
        XCTAssertEqual(visit.description, "")
        XCTAssertEqual(visit.sgwsAgendaNotes, "")
        XCTAssertEqual(visit.status, "")
        XCTAssertEqual(visit.lastModifiedDate, "")
    }
    
    func testVisitInitJson(){
        
        let visitsFields: [String: Any] = ["Id": "","Subject": "","AccountId": "","Account.Name": "","Account.AccountNumber": "","Account.BillingAddress": "","ContactId": "","Contact.Name": "","Contact.Phone": "","Contact.Email": "","Contact.SGWS_Roles__c": "","SGWS_Appointment_Status__c": "","StartDate": "","EndDate": "","SGWS_Visit_Purpose__c": "","Description": "","SGWS_Agenda_Notes__c": "","Status": "","SGWS_AppModified_DateTime__c": ""]
        
        let visit = Visit.init(json: visitsFields)
        
        XCTAssertEqual(visit.Id, visitsFields["Id"] as! String)
        XCTAssertEqual(visit.subject, visitsFields["Subject"] as! String)
        XCTAssertEqual(visit.accountId, visitsFields["AccountId"] as! String)
        //XCTAssertEqual(visit.accountName, visitsFields["Account.Name"] as! String)
        //XCTAssertEqual(visit.accountNumber, visitsFields["Account.AccountNumber"] as! String)
        //XCTAssertEqual(visit.accountBillingAddress, visitsFields["Account.BillingAddress"] as! String)
        XCTAssertEqual(visit.contactId, visitsFields["ContactId"] as! String)
        //XCTAssertEqual(visit.contactName, visitsFields["Contact.Name"] as! String)
        //XCTAssertEqual(visit.contactPhone, visitsFields["Contact.Phone"] as! String)
        //XCTAssertEqual(visit.contactEmail, visitsFields["Contact.Email"] as! String)
        //XCTAssertEqual(visit.contactSGWS_Roles, visitsFields["Contact.SGWS_Roles__c"] as! String)
        //XCTAssertEqual(visit.sgwsAppointmentStatus, visitsFields["SGWS_Appointment_Status__c"] as! String)
        XCTAssertEqual(visit.startDate, visitsFields["StartDate"] as! String)
        XCTAssertEqual(visit.endDate, visitsFields["EndDate"] as! String)
        XCTAssertEqual(visit.sgwsVisitPurpose, visitsFields["SGWS_Visit_Purpose__c"] as! String)
        XCTAssertEqual(visit.description, visitsFields["Description"] as! String)
        XCTAssertEqual(visit.sgwsAgendaNotes, visitsFields["SGWS_Agenda_Notes__c"] as! String)
        XCTAssertEqual(visit.status, visitsFields["Status"] as! String)
        XCTAssertEqual(visit.lastModifiedDate, visitsFields["SGWS_AppModified_DateTime__c"] as! String)
    }
    
}
