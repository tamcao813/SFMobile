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
    
    func testEeventViewDidLoad(){
        let event = EventSummaryViewController()
        XCTAssertNotNil(event.viewDidLoad())
    }
    
    //ButtonTableViewCell
    func testButtonTableViewCellAwakeFromNib(){
        let button =  ButtonTableViewCell()
        XCTAssertNotNil(button.awakeFromNib())
    }
    
    func testButtonTableViewCellSetSelected(){
        let button =  ButtonTableViewCell()
        XCTAssertNotNil(button.setSelected(true, animated: true))
    }
    
    //InsightsSourceUnderSoldTableViewCell
    func testInsightsUnderSoldAwakeFromNib(){
        let insights = InsightsSourceUnderSoldTableViewCell()
        XCTAssertNotNil(insights.awakeFromNib())
    }
    
    func testInsightsUnderSoldShowDropDownMenu(){
        let insights = InsightsSourceUnderSoldTableViewCell()
        let button = UIButton()
        XCTAssertNotNil(insights.showDropDownMenu(sender: button))
    }
    
    //InsightsSourceTopSellerTableViewCell
    
    func testInsightsTopSellerAwakeFromNib(){
        let insights = InsightsSourceTopSellerTableViewCell()
        XCTAssertNotNil(insights.awakeFromNib())
    }
    
    func testInsightsTopSellerShowDropDownMenu(){
        let insights = InsightsSourceTopSellerTableViewCell()
        let button = UIButton()
        XCTAssertNotNil(insights.showDropDownMenu(sender: button))
    }
    
    //AccountsUndersoldTableViewCell
    func testAccountAwakeFromNib(){
        let undersold = AccountsUndersoldTableViewCell()
        XCTAssertNotNil(undersold.awakeFromNib())
    }
    
    //TitleDepartmentTableViewCell
    func testTextFieldShouldReturn(){
        let title = TitleDepartmentTableViewCell()
        let textField = UITextField()
        XCTAssertNotNil(title.textFieldShouldReturn(textField))
    }
    
    //DuringVisitsInsightsViewController
    func testProductNameButtonCLicked(){
        let visit = DuringVisitsInsightsViewController()
        let button = UIButton()
        XCTAssertNotNil(visit.productNameButtonCLicked(sender: button))
    }
    
    func testSourceButtonClicked(){
        let visit = DuringVisitsInsightsViewController()
        let button = UIButton()
        XCTAssertNotNil(visit.sourceButtonCLicked(sender: button))
    }
    
    func testCommitAmtButtonCLicked(){
        let visit = DuringVisitsInsightsViewController()
        let button = UIButton()
        XCTAssertNotNil(visit.commitAmtButtonCLicked(sender: button))
    }
    
    func testOutcomeButtonCLicked(){
        let visit = DuringVisitsInsightsViewController()
        let button = UIButton()
        XCTAssertNotNil(visit.outcomeButtonCLicked(sender: button))
    }
    
    func testVisitViewModel() {
        let visitViewModel = VisitsViewModel()
        _ = visitViewModel.visitsForUserFourMonthsSorted()
        _ = visitViewModel.visitsForUserTwoWeeksUpcoming
        _ = visitViewModel.visitsForUserOneWeeksPast()
        _ = visitViewModel.visitsForUser()
    }
    
    func testAccountOverViewViewController(){
        let acc = AccountOverViewViewController()
        let temp = LoadThePersistantMenuScreen.chatter
        XCTAssertNotNil(acc.navigateTheScreenToActionItemsInPersistantMenu(data: temp))
        XCTAssertNotNil(acc.navigateToVisitListing())
        let temp2 = LoadThePersistantMenuScreen.contacts
        XCTAssertNotNil(acc.navigateTheScreenToContactsInPersistantMenu(data: temp2))
        XCTAssertNotNil(acc.navigateToAccountScreen())
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
