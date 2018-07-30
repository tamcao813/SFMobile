//
//  DateTimeUtilityTests.swift
//  SWSAppTests
//
//  Created by Krishna, Kamya on 7/30/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import XCTest
@testable import SWSApp

class DateTimeUtilityTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testconvertUtcDatetoReadableDate(){
        let date =  DateTimeUtility.convertUtcDatetoReadableDate(dateStringfromAccountNotes: "")
        XCTAssertNotNil(date, "")
    }
    
    func testconvertUtcDatetoReadableDateLikeStrategy(){
        let date = DateTimeUtility.convertUtcDatetoReadableDateLikeStrategy(dateString: "")
        XCTAssertNotNil(date, "")
    }
    
    func testgetEEEEMMMdFormattedDateString(){
        let time = Date()
        let date = DateTimeUtility.getEEEEMMMdFormattedDateString(date: time)
        XCTAssertNotNil(date, date)
    }
    
    func testgetDateFromyyyyMMddTimeFormattedDateString(){
        let date = DateTimeUtility.getDDMMYYYFormattedDateString(dateStringfromAccountObject: "")
        XCTAssertNotNil(date)
    }
    
    func testConvertUtcDatetoReadableDateMMDDYYYY(){
        let date = DateTimeUtility.convertUtcDatetoReadableDateMMDDYYYY(dateString: "")
        XCTAssertNotNil(date)
    }
    
    func testIsWeekend() {
        _ = DateTimeUtility.isWeekend(date: Date())
    }
    
    func testGetDateFromStringFormat() {
        _ = DateTimeUtility.getDateFromStringFormat(dateStr: "17-7-201")
        
    }
}
