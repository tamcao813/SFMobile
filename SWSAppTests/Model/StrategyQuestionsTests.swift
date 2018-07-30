//
//  StrategyTests.swift
//  SWSAppTests
//
//  Created by Krishna, Kamya on 7/26/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import XCTest
@testable import SWSApp

class StrategyTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testStrategyQuestionsInit(){
        let strategy = StrategyQuestions.init(for: "")
        XCTAssertEqual(strategy.Id, "")
        XCTAssertEqual(strategy.Name, "")
        XCTAssertEqual(strategy.SGWS_Deactivate__c, "")
        XCTAssertEqual(strategy.SGWS_Question_Description__c, "")
        XCTAssertEqual(strategy.SGWS_Question_Sub_Type__c, "")
        XCTAssertEqual(strategy.SGWS_Question_Type__c, "")
        XCTAssertEqual(strategy.SGWS_Sorting_Order__c, "")
        XCTAssertEqual(strategy.SGWS_Survey_ID__c, "")
    }
    
    func testStrategyQuestionsInitJson(){
        
        let strategyQuestionsFields: [String: Any] = ["Id": "","Name": "","SGWS_Deactivate__c": "","SGWS_Question_Description__c": "","SGWS_Question_Sub_Type__c": "","SGWS_Question_Type__c": "","SGWS_Sorting_Order__c": "","SGWS_Survey_ID__c": "","SGWS_Answer__c": ""]
        
        let strategyQ = StrategyQuestions.init(json: strategyQuestionsFields)
        
        XCTAssertEqual(strategyQ.Id, strategyQuestionsFields["Id"] as! String)
        XCTAssertEqual(strategyQ.SGWS_Deactivate__c, strategyQuestionsFields["SGWS_Deactivate__c"] as! String)
        XCTAssertEqual(strategyQ.SGWS_Question_Description__c, strategyQuestionsFields["SGWS_Question_Description__c"] as! String)
        XCTAssertEqual(strategyQ.SGWS_Question_Type__c, strategyQuestionsFields["SGWS_Question_Type__c"] as! String)
        XCTAssertEqual(strategyQ.SGWS_Question_Sub_Type__c, strategyQuestionsFields["SGWS_Question_Sub_Type__c"] as! String)
        XCTAssertEqual(strategyQ.Id, strategyQuestionsFields["Id"] as! String)
        XCTAssertEqual(strategyQ.SGWS_Sorting_Order__c, strategyQuestionsFields["SGWS_Sorting_Order__c"] as! String)
        XCTAssertEqual(strategyQ.SGWS_Survey_ID__c, strategyQuestionsFields["SGWS_Survey_ID__c"] as! String)
        XCTAssertEqual(strategyQ.SGWS_Answer__c, strategyQuestionsFields["SGWS_Answer__c"] as! String)
        
    }
    
}
