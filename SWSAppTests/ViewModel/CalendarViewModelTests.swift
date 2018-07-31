//
//  CalendarViewModelTests.swift
//  SWSAppTests
//
//  Created by Krishna, Kamya on 7/30/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import XCTest
@testable import SWSApp

class CalendarViewModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCalendarViewModelLoadVisitData(){
        let cal = CalendarViewModel.init()
        XCTAssertNotNil(cal.loadVisitData())
    }
    
    func testCalendarViewModelLoadVisitsToCalendarEvents(){
        let cal = CalendarViewModel.init()
        let workOrderUserObjectFields: [Any] = ["Id","Subject","SGWS_WorkOrder_Location__c","AccountId","Account.Name","Account.AccountNumber","Account.ShippingCity","Account.ShippingCountry","Account.ShippingPostalCode","Account.ShippingState","Account.ShippingStreet","SGWS_Appointment_Status__c","StartDate","EndDate","SGWS_Visit_Purpose__c","Description","SGWS_Agenda_Notes__c","Status","SGWS_AppModified_DateTime__c","ContactId", "Name","FirstName","LastName","Phone","Email","RecordTypeId","_soupEntryId","SGWS_All_Day_Event__c","OwnerId","SGWS_Start_Latitude__c","SGWS_Start_Longitude__c","SGWS_Start_Time_of_Visit__c","SGWS_End_Latitude__c","SGWS_End_Longitude__c","SGWS_End_Time_of_Visit__c"]
        XCTAssertNotNil(cal.loadVisitsToCalendarEvents(visitArray: [WorkOrderUserObject.init(withAry: workOrderUserObjectFields)]))
    }
    
}
