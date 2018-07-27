//
//  ViewModelTests.swift
//  SWSAppTests
//
//  Created by Krishna, Kamya on 7/26/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import XCTest
@testable import SWSApp
import Reachability

class ViewModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    //VisitsViewModel-19-07
    func testVisitsViewModelVisitsForUser(){
        let visit = VisitsViewModel()
        XCTAssertNotNil(visit.visitsForUser())
    }
    
    func testVisitsViewModelVisitsForUserFourMonthsSorted(){
        let visit = VisitsViewModel()
        XCTAssertNotNil(visit.visitsForUserFourMonthsSorted())
    }
    
    func testVisitsViewModelVisitsForUserTwoWeeksUpcoming(){
        let visit = VisitsViewModel()
        XCTAssertNotNil(visit.visitsForUserTwoWeeksUpcoming())
    }
    
    func testVisitsViewModelVisitsForUserOneWeeksPast(){
        let visit = VisitsViewModel()
        XCTAssertNotNil(visit.visitsForUserOneWeeksPast())
    }
    
    //SyncConfigurationViewModel
    
    func testSyncConfigurationViewModelSyncConfigurationRecordIdforEvent(){
        let sync = SyncConfigurationViewModel()
        XCTAssertNotNil(sync.syncConfigurationRecordIdforEvent())
    }
    
    func testSyncConfigurationViewModelSyncConfigurationRecordIdfor(){
        let sync = SyncConfigurationViewModel()
        XCTAssertNotNil(sync.syncConfigurationRecordIdfor(developerName: "abc", object: "xyz"))
    }
    
    func testSyncConfigurationViewModelSyncConfigurationRecordIdforVisit(){
        let sync = SyncConfigurationViewModel()
        XCTAssertNotNil(sync.syncConfigurationRecordIdforVisit())
    }
    
    //CalendarViewModel
    
    func testCalendarViewModelLoadVisitData(){
        let cal = CalendarViewModel.init()
        XCTAssertNotNil(cal.loadVisitData())
    }
    
    func testCalendarViewModelLoadVisitsToCalendarEvents(){
        let cal = CalendarViewModel.init()
        let workOrderUserObjectFields: [Any] = ["Id","Subject","SGWS_WorkOrder_Location__c","AccountId","Account.Name","Account.AccountNumber","Account.ShippingCity","Account.ShippingCountry","Account.ShippingPostalCode","Account.ShippingState","Account.ShippingStreet","SGWS_Appointment_Status__c","StartDate","EndDate","SGWS_Visit_Purpose__c","Description","SGWS_Agenda_Notes__c","Status","SGWS_AppModified_DateTime__c","ContactId", "Name","FirstName","LastName","Phone","Email","RecordTypeId","_soupEntryId","SGWS_All_Day_Event__c","OwnerId","SGWS_Start_Latitude__c","SGWS_Start_Longitude__c","SGWS_Start_Time_of_Visit__c","SGWS_End_Latitude__c","SGWS_End_Longitude__c","SGWS_End_Time_of_Visit__c"]
        XCTAssertNotNil(cal.loadVisitsToCalendarEvents(visitArray: [WorkOrderUserObject.init(withAry: workOrderUserObjectFields)]))
    }
    
    //CalendarFilter, Filter, AccountVisitListFilter
    
    func testFilterSectionNames(){
        let calfil = CalendarFilter()
        XCTAssertNotNil(calfil.sectionNames(isManager: false))
        XCTAssertNotNil(calfil.sectionNames(isManager: true))
        
        let fil = Filter()
        XCTAssertNotNil(fil.sectionNames(isManager: false))
        XCTAssertNotNil(fil.sectionNames(isManager: true))
        
        let filt = AccountVisitListFilter()
        XCTAssertNotNil(filt.sectionNames(isManager: false))
        XCTAssertNotNil(filt.sectionNames(isManager: true))
    }
    
    //AccountsViewModel
    
    func testAccountsViewModelAccountsForSelectedUser(){
        let acc = AccountsViewModel()
        XCTAssertNotNil(acc.accountsForSelectedUser())
    }
    
    func testAccountsViewModelAccountNameFor(){
        let acc = AccountsViewModel()
        XCTAssertNotNil(acc.accountNameFor(accountId: "0060t00000AbqZnAAJ"))
    }
    
    //StrategyQuestionsViewModel, StrategyAnswersViewModel
    
    func testStrategyQuestionsAnswersViewModel(){
        let strQ = StrategyQuestionsViewModel()
        XCTAssertNotNil(strQ.getStrategyQuestions(accountId: "0060t00000AbqZnAAJ"))
        
        let strA = StrategyAnswersViewModel()
        XCTAssertNotNil(strA.getStrategyAnswers())
    }
    
    //RecordTypeViewModel
    
    func testRecordTypeViewModelGetRecordTypeForDeveloper(){
        let rec = RecordTypeViewModel()
        XCTAssertNotNil(rec.getRecordTypeForDeveloper())
    }
    
    //OpportunityViewModel
    
    func testOpportunityViewModel(){
        let opp1 = OpportunityViewModel()
        XCTAssertNotNil(opp1.globalOpportunity())
        XCTAssertNotNil(opp1.globalOpportunityObjective())
        XCTAssertNotNil(opp1.globalOpportunityReload())
        XCTAssertNotNil(opp1.globalOpportunityWorkorder())
    }
    
    //NotificationsViewModel
    func testNotificationsViewModel(){
        let note = NotificationsViewModel()
        XCTAssertNotNil(note.notificationsForUser())
    }
    
    //VisitSchedulerViewModel
    func testVisitSchedulerViewModel(){
        let visit = VisitSchedulerViewModel()
        XCTAssertNotNil(visit.visitsForUser())
    }
    
}
