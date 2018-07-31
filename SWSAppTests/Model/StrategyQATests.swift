//
//  StrategyQATests.swift
//  SWSAppTests
//
//  Created by Krishna, Kamya on 7/30/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import XCTest
@testable import SWSApp

class StrategyQATests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInitStrategy(){
        
        let strategy = StrategyQA.init(for: "")
        XCTAssertEqual(strategy.Id, "")
        XCTAssertEqual(strategy.SGWS_Account__c, "")
        XCTAssertEqual(strategy.SGWS_Notes__c, "")
        XCTAssertEqual(strategy.LastModifiedById, "")
        XCTAssertEqual(strategy.LastModifiedDate, "")
        XCTAssertEqual(strategy.OwnerId, "")
    }
    
    func testStrategyQAinit(){
        
        let strategyQAFields: [String: Any] = ["Id": "","SGWS_Account__c": "","SGWS_Question_Sub_Type__c": "","SGWS_Question__c": "","SGWS_Notes__c": "","LastModifiedById": "","SGWS_AppModified_DateTime__c": "","OwnerId": "","SGWS_Answer_Description_List__c": ""]
        
        let strategyQa = StrategyQA.init(json: strategyQAFields)
        
        XCTAssertEqual(strategyQa.Id, strategyQAFields["Id"] as! String)
        XCTAssertEqual(strategyQa.SGWS_Account__c, strategyQAFields["SGWS_Account__c"] as! String)
        XCTAssertEqual(strategyQa.SGWS_Question__c, strategyQAFields["SGWS_Question__c"] as! String)
        XCTAssertEqual(strategyQa.SGWS_Question_Sub_Type__c, strategyQAFields["SGWS_Question_Sub_Type__c"] as! String)
        XCTAssertEqual(strategyQa.SGWS_Notes__c, strategyQAFields["SGWS_Notes__c"] as! String)
        XCTAssertEqual(strategyQa.LastModifiedById, strategyQAFields["LastModifiedById"] as! String)
        XCTAssertEqual(strategyQa.LastModifiedDate, strategyQAFields["SGWS_AppModified_DateTime__c"] as! String)
        XCTAssertEqual(strategyQa.OwnerId, strategyQAFields["OwnerId"] as! String)
        XCTAssertEqual(strategyQa.SGWS_Answer_Description_List__c, strategyQAFields["SGWS_Answer_Description_List__c"] as! String)
        
    }
    
}
