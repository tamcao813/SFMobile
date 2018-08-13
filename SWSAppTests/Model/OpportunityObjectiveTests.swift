//
//  OpportunityObjectiveTests.swift
//  SWSAppTests
//
//  Created by Krishna, Kamya on 7/30/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import XCTest
@testable import SWSApp

class OpportunityObjectiveTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testOpportunityObjectiveInit(){
        let opportunity = OpportunityObjective.init(for: "")
        XCTAssertEqual(opportunity.recordId, "")
        XCTAssertEqual(opportunity.OpportunityId, "")
        XCTAssertEqual(opportunity.ObjectiveName, "")
        XCTAssertEqual(opportunity.ObjectiveType, "")
    }
    
    //To be tested
    
    func testOpportunityObjectiveJsonInit(){
        
        let objectiveStr = "{\"attributes\":{\"type\":\"SGWS_Objectives__c\",\"url\":\"/services/data/v42.0/sobjects/SGWS_Objectives__c/a4v0t0000007ovsAAA\"},\"Name\":\"TestObjectives\",\"SGWS_Select_Objective_Type__c\":\"Decimal Case\"}"
        let opportunityStr = "{\"attributes\":{\"type\":\"Opportunity\",\"url\":\"/services/data/v42.0/sobjects/Opportunity/0060t00000AdDH4AAN\"},\"Id\":\"0060t00000AdDH4AAN\"}"
        
        let opportunityObjectiveFields: [String:Any] = [ "Id":"a4w0t000000CcfwAAC", "SGWS_Opportunity__r":opportunityStr, "SGWS_Objectives__r": objectiveStr]
        
        let opportunity = OpportunityObjective.init(json: opportunityObjectiveFields)
        XCTAssertEqual(opportunity.recordId, opportunityObjectiveFields["Id"] as! String)
        XCTAssertEqual(opportunity.OpportunityId, opportunity.OpportunityId)
        //XCTAssertEqual(opportunity.ObjectiveName, "")
        //XCTAssertEqual(opportunity.ObjectiveType, "")
    }
    
}
