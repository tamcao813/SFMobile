//
//  StrategyAnswersTests.swift
//  SWSAppTests
//
//  Created by Krishna, Kamya on 7/30/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import XCTest
@testable import SWSApp

class StrategyAnswersTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testStrategyAnswerInit(){
        let strategy = StrategyAnswers.init(for: "")
        XCTAssertEqual(strategy.Id, "")
        XCTAssertEqual(strategy.Name, "")
        XCTAssertEqual(strategy.SGWS_Answer_Description__c, "")
        XCTAssertEqual(strategy.SGWS_Deactivate_Answer__c, "")
        XCTAssertEqual(strategy.SGWS_Question_Description__c, "")
        XCTAssertEqual(strategy.SGWS_Question__c, "")
    }
    
    //StrategyAnswers init(json) test
    func testStrategyAnswersInitJson(){
        
        let strategyAnswersFields: [String: Any] = ["Id": "","Name": "","SGWS_Answer_Description__c": "","SGWS_Deactivate_Answer__c": "","SGWS_Question_Description__c": "","SGWS_Question__c": ""]
        
        let strategyA = StrategyAnswers.init(json: strategyAnswersFields)
        
        XCTAssertEqual(strategyA.Id, strategyAnswersFields["Id"] as! String)
        XCTAssertEqual(strategyA.Name, strategyAnswersFields["Name"] as! String)
        XCTAssertEqual(strategyA.SGWS_Answer_Description__c, strategyAnswersFields["SGWS_Answer_Description__c"] as! String)
        XCTAssertEqual(strategyA.SGWS_Deactivate_Answer__c, strategyAnswersFields["SGWS_Deactivate_Answer__c"] as! String)
        XCTAssertEqual(strategyA.SGWS_Question_Description__c, strategyAnswersFields["SGWS_Question_Description__c"] as! String)
        XCTAssertEqual(strategyA.SGWS_Question__c, strategyAnswersFields["SGWS_Question__c"] as! String)
        
    }
    
}
