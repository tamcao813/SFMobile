//
//  StrategyQAViewModelTests.swift
//  SWSAppTests
//
//  Created by Krishna, Kamya on 7/30/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import XCTest
@testable import SWSApp

class StrategyQAViewModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testFetchStrategy(){
        let strategy = "Competition Is About The Same"
        let test = StrategyQAViewModel()
        test.syncStrategyWithServer{error in
            
        }
        _ = test.editStrategyQALocally(fields: ["":""])
        
        
        let expectation = XCTestExpectation(description: "resyncStrategyAnswers")
        test.syncStrategyQuestionsWithServer{error in
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
        
        
        //completion handler test case
        let expectation1 = XCTestExpectation(description: "resyncStrategyAnswers")
        test.syncStrategyAnswersWithServer{ error in
            expectation1.fulfill()
        }
        wait(for: [expectation1], timeout: 10.0)
        //
        XCTAssertNotNil(test.fetchStrategy(acc: strategy))
    }
    
}
