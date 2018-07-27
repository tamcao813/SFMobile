//
//  ExtensionTests.swift
//  SWSAppTests
//
//  Created by Krishna, Kamya on 7/26/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import XCTest
@testable import SWSApp

class ExtensionTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSafelyLimitedTo() {
        let str :String = "1234566777"
        let invalidPhoneNum = "Welcome"
        _ = str.safelyLimitedTo(length: 3)
        _ = str.safelyLimitedTo(length: str.count)
        _ = str.isPhoneNumber
        _ = invalidPhoneNum.isPhoneNumber
        
    }
    
    func testCornerRadius() {
        let view = UIView()
        view.cornerRadius = 10
        view.borderWidth = 10
        view.borderColor = UIColor.red
        view.shadowRadius = 10
        view.shake()
        view.dropShadow()
        view.backgroundColor = UIColor(hexString: "#4287C2FF")
    }
    
    func testUITextFieldExtension() {
        let textField = UITextField()
        textField.text = "1272772727272"
        _ = textField.maxLength
        textField.maxLength = 10
        textField.fix(textField: textField)
        
    }
    
}
