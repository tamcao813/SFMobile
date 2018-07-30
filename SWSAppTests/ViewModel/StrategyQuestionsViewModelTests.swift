//
//  StrategyQuestionsViewModelTests.swift
//  SWSAppTests
//
//  Created by Krishna, Kamya on 7/30/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import XCTest
@testable import SWSApp

class StrategyQuestionsViewModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetStrategyQuestions(){
        let strQ = StrategyQuestionsViewModel()
        XCTAssertNotNil(strQ.getStrategyQuestions(accountId: "0060t00000AbqZnAAJ"))
    }
    
}
