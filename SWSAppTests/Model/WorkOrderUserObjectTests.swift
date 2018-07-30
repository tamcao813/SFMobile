//
//  WorkOrderUserObjectTests.swift
//  SWSAppTests
//
//  Created by Krishna, Kamya on 7/26/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import XCTest
@testable import SWSApp

class WorkOrderUserObjectTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testWorkOrderUserObjectInitJson(){
        
        let workOrderUserObjectFields: [String: Any] = ["Id": "","Subject": "","SGWS_WorkOrder_Location__c": "","AccountId": "","Account.Name": "","Account.AccountNumber": "","Account.ShippingCity": "","Account.ShippingCountry": "","Account.ShippingPostalCode": "","Account.ShippingState": "","Account.ShippingStreet": "","SGWS_Appointment_Status__c": "","StartDate": "","EndDate": "","SGWS_Visit_Purpose__c": "","Description": "","SGWS_Agenda_Notes__c": "","Status": "","SGWS_AppModified_DateTime__c": "","ContactId": "", "Name": " ","FirstName": "","LastName": "","Phone": "","Email": "","RecordTypeId": "","_soupEntryId": 0,"SGWS_All_Day_Event__c": "","OwnerId": "","SGWS_Start_Latitude__c": 0.0,"SGWS_Start_Longitude__c": 0.0,"SGWS_Start_Time_of_Visit__c": "","SGWS_End_Latitude__c": 0.0,"SGWS_End_Longitude__c": 0.0,"SGWS_End_Time_of_Visit__c": ""]
        let workOrderUserObject = WorkOrderUserObject.init(json: workOrderUserObjectFields)
        
        XCTAssertEqual(workOrderUserObject.Id, workOrderUserObjectFields["Id"] as! String)
        XCTAssertEqual(workOrderUserObject.subject, workOrderUserObjectFields["Subject"] as! String)
        XCTAssertEqual(workOrderUserObject.location, workOrderUserObjectFields["SGWS_WorkOrder_Location__c"] as! String)
        XCTAssertEqual(workOrderUserObject.accountId, workOrderUserObjectFields["AccountId"] as! String)
        XCTAssertEqual(workOrderUserObject.accountName, workOrderUserObjectFields["Account.Name"] as! String)
        XCTAssertEqual(workOrderUserObject.accountNumber, workOrderUserObjectFields["Account.AccountNumber"] as! String)
        XCTAssertEqual(workOrderUserObject.shippingCity, workOrderUserObjectFields["Account.ShippingCity"] as! String)
        XCTAssertEqual(workOrderUserObject.shippingCountry, workOrderUserObjectFields["Account.ShippingCountry"] as! String)
        XCTAssertEqual(workOrderUserObject.shippingPostalCode, workOrderUserObjectFields["Account.ShippingPostalCode"] as! String)
        XCTAssertEqual(workOrderUserObject.shippingState, workOrderUserObjectFields["Account.ShippingState"] as! String)
        XCTAssertEqual(workOrderUserObject.shippingStreet, workOrderUserObjectFields["Account.ShippingStreet"] as! String)
        XCTAssertNotEqual(workOrderUserObject.sgwsAppointmentStatus, (workOrderUserObjectFields["SGWS_Appointment_Status__c"] != nil))
        XCTAssertEqual(workOrderUserObject.startDate, workOrderUserObjectFields["StartDate"] as! String)
        XCTAssertEqual(workOrderUserObject.endDate, workOrderUserObjectFields["EndDate"] as! String)
        XCTAssertEqual(workOrderUserObject.sgwsVisitPurpose, workOrderUserObjectFields["SGWS_Visit_Purpose__c"] as! String)
        XCTAssertEqual(workOrderUserObject.description, workOrderUserObjectFields["Description"] as! String)
        XCTAssertEqual(workOrderUserObject.sgwsAgendaNotes, workOrderUserObjectFields["SGWS_Agenda_Notes__c"] as! String)
        XCTAssertEqual(workOrderUserObject.status, workOrderUserObjectFields["Status"] as! String)
        XCTAssertEqual(workOrderUserObject.lastModifiedDate, workOrderUserObjectFields["SGWS_AppModified_DateTime__c"] as! String)
        XCTAssertEqual(workOrderUserObject.contactId, workOrderUserObjectFields["ContactId"] as! String)
        XCTAssertEqual(workOrderUserObject.name, workOrderUserObjectFields["Name"] as! String)
        XCTAssertEqual(workOrderUserObject.firstName, workOrderUserObjectFields["FirstName"] as! String)
        XCTAssertEqual(workOrderUserObject.lastName, workOrderUserObjectFields["LastName"] as! String)
        XCTAssertEqual(workOrderUserObject.phone, workOrderUserObjectFields["Phone"] as! String)
        XCTAssertEqual(workOrderUserObject.email, workOrderUserObjectFields["Email"] as! String)
        XCTAssertEqual(workOrderUserObject.recordTypeId, workOrderUserObjectFields["RecordTypeId"] as! String)
        XCTAssertEqual(workOrderUserObject.soupEntryId, workOrderUserObjectFields["_soupEntryId"] as! Int)
        XCTAssertNotEqual(workOrderUserObject.sgwsAlldayEvent, (workOrderUserObjectFields["SGWS_All_Day_Event__c"] != nil))
        XCTAssertEqual(workOrderUserObject.ownerId, workOrderUserObjectFields["OwnerId"] as! String)
        XCTAssertEqual(workOrderUserObject.startLatitude, workOrderUserObjectFields["SGWS_Start_Latitude__c"] as! Double)
        XCTAssertEqual(workOrderUserObject.startLongitude, workOrderUserObjectFields["SGWS_Start_Longitude__c"] as! Double)
        XCTAssertEqual(workOrderUserObject.startTime_of_Visit, workOrderUserObjectFields["SGWS_Start_Time_of_Visit__c"] as! String)
        XCTAssertEqual(workOrderUserObject.endLatitude, workOrderUserObjectFields["SGWS_End_Latitude__c"] as! Double)
        XCTAssertEqual(workOrderUserObject.endLongitude, workOrderUserObjectFields["SGWS_End_Longitude__c"] as! Double)
        XCTAssertEqual(workOrderUserObject.endTimeOfVisit, workOrderUserObjectFields["SGWS_End_Time_of_Visit__c"] as! String)
        
    }
    
    func testWorkOrderUserObjectInit(){
        
        let workOrderUserObject = WorkOrderUserObject.init(for: "")
        XCTAssertEqual(workOrderUserObject.Id, "")
        XCTAssertEqual(workOrderUserObject.accountId, "")
        XCTAssertEqual(workOrderUserObject.accountName, "")
        XCTAssertEqual(workOrderUserObject.accountNumber, "")
        XCTAssertEqual(workOrderUserObject.shippingCity, "")
        XCTAssertEqual(workOrderUserObject.shippingCountry, "")
        XCTAssertEqual(workOrderUserObject.shippingPostalCode, "")
        XCTAssertEqual(workOrderUserObject.shippingState, "")
        XCTAssertEqual(workOrderUserObject.shippingStreet, "")
        XCTAssertEqual(workOrderUserObject.sgwsAppointmentStatus, false)
        XCTAssertEqual(workOrderUserObject.startDate, "")
        XCTAssertEqual(workOrderUserObject.endDate, "")
        XCTAssertEqual(workOrderUserObject.sgwsVisitPurpose, "")
        XCTAssertEqual(workOrderUserObject.description, "")
        XCTAssertEqual(workOrderUserObject.sgwsAgendaNotes, "")
        XCTAssertEqual(workOrderUserObject.status, "")
        XCTAssertEqual(workOrderUserObject.lastModifiedDate, "")
        XCTAssertEqual(workOrderUserObject.contactId, "")
        XCTAssertEqual(workOrderUserObject.name, "")
        XCTAssertEqual(workOrderUserObject.firstName, "")
        XCTAssertEqual(workOrderUserObject.lastName, "")
        XCTAssertEqual(workOrderUserObject.recordTypeId, "")
        XCTAssertEqual(workOrderUserObject.email, "")
        XCTAssertEqual(workOrderUserObject.phone, "")
        XCTAssertEqual(workOrderUserObject.ownerId, "")
        XCTAssertEqual(workOrderUserObject.soupEntryId, 0)
        XCTAssertEqual(workOrderUserObject.location, "")
        XCTAssertEqual(workOrderUserObject.sgwsAlldayEvent, false)
        XCTAssertEqual(workOrderUserObject.startLatitude, 0.0)
        XCTAssertEqual(workOrderUserObject.startLongitude, 0.0)
        XCTAssertEqual(workOrderUserObject.startTime_of_Visit, "")
        XCTAssertEqual(workOrderUserObject.endLatitude, 0.0)
        XCTAssertEqual(workOrderUserObject.endLongitude, 0.0)
        XCTAssertEqual(workOrderUserObject.endTimeOfVisit, "")
        XCTAssertNil(workOrderUserObject.dateStart)
        XCTAssertNil(workOrderUserObject.dateEnd)
    }
    
    func testWorkOrderUserObjectConvinienceInit(){
        let workOrderUserObjectFields: [Any] = ["Id","Subject","SGWS_WorkOrder_Location__c","AccountId","Account.Name","Account.AccountNumber","Account.ShippingCity","Account.ShippingCountry","Account.ShippingPostalCode","Account.ShippingState","Account.ShippingStreet","SGWS_Appointment_Status__c","StartDate","EndDate","SGWS_Visit_Purpose__c","Description","SGWS_Agenda_Notes__c","Status","SGWS_AppModified_DateTime__c","ContactId", "Name","FirstName","LastName","Phone","Email","RecordTypeId","_soupEntryId","SGWS_All_Day_Event__c","OwnerId","SGWS_Start_Latitude__c","SGWS_Start_Longitude__c","SGWS_Start_Time_of_Visit__c","SGWS_End_Latitude__c","SGWS_End_Longitude__c","SGWS_End_Time_of_Visit__c"]
        
        XCTAssertNotNil(WorkOrderUserObject.init(withAry: workOrderUserObjectFields))
    }
    
    func testLoadVisitsToCalendarEvents() {
        
        
        let workOrderUserObjectFields: [String: Any] = ["Id": "001m000000cHLmDAAW","Subject": "test","SGWS_WorkOrder_Location__c": "Bangalore","AccountId": "262626","Account.Name": "Test Account","Account.AccountNumber": "j89393","Account.ShippingCity": "Banaglore","Account.ShippingCountry": "India","Account.ShippingPostalCode": "560037","Account.ShippingState": "Karnataka","Account.ShippingStreet": "7th","SGWS_Appointment_Status__c": "Open","StartDate": "2018-07-17T11:30:00.000+0000","EndDate": "2018-07-19T11:30:00.000+0000","SGWS_Visit_Purpose__c": "","Description": "","SGWS_Agenda_Notes__c": "","Status": "","SGWS_AppModified_DateTime__c": "","ContactId": "", "Name": " ","FirstName": "","LastName": "","Phone": "","Email": "","RecordTypeId": "","_soupEntryId": 0,"SGWS_All_Day_Event__c": "","OwnerId": "","SGWS_Start_Latitude__c": 0.0,"SGWS_Start_Longitude__c": 0.0,"SGWS_Start_Time_of_Visit__c": "","SGWS_End_Latitude__c": 0.0,"SGWS_End_Longitude__c": 0.0,"SGWS_End_Time_of_Visit__c": ""]
        let workOrderUserObject = WorkOrderUserObject.init(json: workOrderUserObjectFields)
        
        
        let calendaModel = CalendarViewModel()
        _ = calendaModel.loadVisitsToCalendarEvents(visitArray: [workOrderUserObject])
        
    }
    
}
