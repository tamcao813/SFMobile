//
//  OpportunityViewModelTests.swift
//  SWSAppTests
//
//  Created by Krishna, Kamya on 7/30/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import XCTest
@testable import SWSApp

class OpportunityViewModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func getRandomId() -> String {
        
        //  Make a variable equal to a random number....
        let randomNum:UInt32 = arc4random_uniform(99999999) // range is 0 to 99
        // convert the UInt32 to some other  types
        let someString:String = String(randomNum)
        
        return someString
    }
    
    func testCreateNewOpportunityWorkorderLocally() {
        let attributeDict = ["type":"SGWS_Opportunity_WorkOrder__c"]
        let addNewDict: [String:Any] = [
            OpportunityWorkorder.opportunityWorkorderFields[0]: getRandomId(),
            OpportunityWorkorder.opportunityWorkorderFields[1]: "0060t00000AdAveAAF",
            OpportunityWorkorder.opportunityWorkorderFields[2]: getRandomId(),
            OpportunityWorkorder.opportunityWorkorderFields[3]: "",
            "attributes":attributeDict]
        
        _ = StoreDispatcher.shared.createNewOpportunityWorkorderLocally(fieldsToUpload: addNewDict)
        _ = StoreDispatcher.shared.deleteOpportunityWorkorderLocally(fieldsToUpload: addNewDict)
        let opportunityViewModel = OpportunityViewModel()
        _ = opportunityViewModel.createNewOpportunityWorkorderLocally(fields: addNewDict)
    }
    
    func testGlobalOpportunityViewModel(){
        let opp1 = OpportunityViewModel()
        XCTAssertNotNil(opp1.globalOpportunity())
        XCTAssertNotNil(opp1.globalOpportunityObjective())
        XCTAssertNotNil(opp1.globalOpportunityReload())
        XCTAssertNotNil(opp1.globalOpportunityWorkorder())
    }
    
    func testSyncOpportunitysWithServer() {
        let oppoObj = OpportunityViewModel()
        let expectation = XCTestExpectation(description: "resync opportunity")
        oppoObj.syncOpportunitysWithServer{ error in
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
}
