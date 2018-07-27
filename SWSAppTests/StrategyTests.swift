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
    
    func testInitStrategy(){
        
        let strategy = StrategyQA.init(for: "")
        XCTAssertEqual(strategy.Id, "")
        XCTAssertEqual(strategy.SGWS_Account__c, "")
        XCTAssertEqual(strategy.SGWS_Notes__c, "")
        XCTAssertEqual(strategy.LastModifiedById, "")
        XCTAssertEqual(strategy.LastModifiedDate, "")
        XCTAssertEqual(strategy.OwnerId, "")
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
    
    func testStrategyAnswerInit(){
        let strategy = StrategyAnswers.init(for: "")
        XCTAssertEqual(strategy.Id, "")
        XCTAssertEqual(strategy.Name, "")
        XCTAssertEqual(strategy.SGWS_Answer_Description__c, "")
        XCTAssertEqual(strategy.SGWS_Deactivate_Answer__c, "")
        XCTAssertEqual(strategy.SGWS_Question_Description__c, "")
        XCTAssertEqual(strategy.SGWS_Question__c, "")
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
