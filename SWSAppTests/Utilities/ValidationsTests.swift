//
//  ValidationsTests.swift
//  SWSAppTests
//
//  Created by Krishna, Kamya on 7/30/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import XCTest
@testable import SWSApp

class ValidationsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testValidDate(){
        let validate = Validations()
        XCTAssertTrue(validate.isValidDate(dateString: "04-23-2018"))
        XCTAssertFalse(validate.isValidDate(dateString: "23-04-2018"))
    }
    
    func testValidateEmail(){
        let validate = Validations()
        XCTAssertTrue(validate.isValidEmail(testStr: "abc@gmail.com"))
    }
    
    func testPhoneNumnber(){
        let validate = Validations()
        XCTAssertEqual(validate.validatePhoneNumber(phoneNumber: "(541) 754-3010"),"(541) 754-3010")
    }
    
    func testremoveSpecialCharsFromString(){
        let validObj = Validations()
        let result = validObj.removeSpecialCharsFromString(text: "#12334")
        XCTAssertEqual(result, "12334")
    }
    
    func testGetInitials(){
        let testVal = Validations()
        XCTAssertEqual(testVal.getIntials(name: "Daniel Brown"), "DB")
        XCTAssertEqual(testVal.getIntials(name: "Justin Timber"), "JT")
        XCTAssertNotEqual(testVal.getIntials(name: "Rosh Jacob"), "JR")
    }
    
}
