//
//  OpportunitiesWorkOrderTests.swift
//  SWSAppTests
//
//  Created by Krishna, Kamya on 7/26/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import XCTest
@testable import SWSApp

class OpportunitiesWorkOrderTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testOpportunityWorkOrderInit() {
        let opprtunitiesWorkOrder = OpportunityWorkorder.init(for: "")
        XCTAssertEqual(opprtunitiesWorkOrder.id, "" )
        XCTAssertEqual(opprtunitiesWorkOrder.opportunityId, "" )
        XCTAssertEqual(opprtunitiesWorkOrder.workOrder, "" )
        XCTAssertEqual(opprtunitiesWorkOrder.outcome, "" )
        
    }
    
    func testOpportunityWorkOrderInitJson(){
        
        let opportunityWorkorderFields: [String: Any] = [ "Id": "", "SGWS_Opportunity__c": "", "SGWS_Work_Order__c": "", "SGWS_Outcome__c": ""]
        let opprtunitiesWorkOrder = OpportunityWorkorder.init(json: opportunityWorkorderFields)
        XCTAssertEqual(opprtunitiesWorkOrder.id, opportunityWorkorderFields["Id"] as! String)
        XCTAssertEqual(opprtunitiesWorkOrder.opportunityId, opportunityWorkorderFields["SGWS_Opportunity__c"] as! String)
        XCTAssertEqual(opprtunitiesWorkOrder.workOrder, opportunityWorkorderFields["SGWS_Work_Order__c"] as! String)
        XCTAssertEqual(opprtunitiesWorkOrder.outcome, opportunityWorkorderFields["SGWS_Outcome__c"] as! String)
        
    }
    
    func testOpportunityWorkOrderCInit(){
        
        let opportunityWorkorderFields: [Any] = [ "Id", "SGWS_Opportunity__c", "SGWS_Work_Order__c", "SGWS_Outcome__c"]
        let opportunity = OpportunityWorkorder.init(withAry: opportunityWorkorderFields)
        XCTAssertNotNil(opportunity)
    }
    
}
