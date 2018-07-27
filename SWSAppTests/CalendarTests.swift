//
//  CalendarTests.swift
//  SWSAppTests
//
//  Created by Krishna, Kamya on 7/26/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import XCTest
@testable import SWSApp

class CalendarTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    //WRCurrentTimeIndicator
    func testWRCurrentTimeIndicator(){
        let rect = CGRect(x: 0, y: 0, width: 100, height: 100)
        let test = WRCurrentTimeIndicator.init(frame: rect)
        XCTAssertNotNil(test)
    }
    
    //WRCornerHeader
    func testWRCornerHeader(){
        let rect = CGRect(x: 0, y: 0, width: 100, height: 100)
        let test = WRCornerHeader.init(frame: rect)
        XCTAssertNotNil(test)
    }
    
    func testCalendarDidRecieveMemoryWarning(){
        let calendar =  CalendarListViewController()
        XCTAssertNotNil(calendar.didReceiveMemoryWarning())
    }
    
    func testgetDayFromAction(){
        let visit = AccountOverViewViewController()
        XCTAssertNotNil(visit.getDayForActionCurrentWeek(dateToConvert: "07/01/2018"))
        XCTAssertNotNil(visit.getDayForActionCurrentWeek(dateToConvert: "07/02/2018"))
        XCTAssertNotNil(visit.getDayForActionCurrentWeek(dateToConvert: "07/03/2018"))
        XCTAssertNotNil(visit.getDayForActionCurrentWeek(dateToConvert: "07/04/2018"))
        XCTAssertNotNil(visit.getDayForActionCurrentWeek(dateToConvert: "07/05/2018"))
        XCTAssertNotNil(visit.getDayForActionCurrentWeek(dateToConvert: "07/06/2018"))
        XCTAssertNotNil(visit.getDayForActionCurrentWeek(dateToConvert: "07/07/2018"))
        
    }
//    func testWRCurrentTimeGridlineInit(){
//        let wr = WRCurrentTimeGridline(coder: NSCoder())
//        XCTAssertNil(wr)
//    }
    
//    func testWRWeekViewFlowLayoutInit(){
//        let wr = WRWeekViewFlowLayout(coder: NSCoder())
//        XCTAssertNil(wr)
//    }
//    func testWRRowHeaderBackgroundInit(){
//        let wr = WRRowHeaderBackground(coder: NSCoder())
//        XCTAssertNil(wr)
//    }
//    func testWRGridLineInit(){
//        let wr = WRGridLine(coder: NSCoder())
//        XCTAssertNil(wr)
//    }
//    func testWRTodayBackgroundInit(){
//        let wr = WRTodayBackground(coder: NSCoder())
//        XCTAssertNil(wr)
//    }
//    func testWRColumnHeaderBackgroundInit(){
//        let wr = WRColumnHeaderBackground(coder: NSCoder())
//        XCTAssertNil(wr)
//    }
//    func testWRCornerHeaderInit(){
//        let wr = WRCornerHeader(coder: NSCoder())
//        XCTAssertNil(wr)
//    }
    
    func testSortCalendarData(){
        let calendarObj = CalendarListViewController()
        XCTAssertNotNil(calendarObj.sortCalendarData(searchString: "Blender"))
    }
    //DayHomeCalendarViewController
    func testTapDate(){
        let calendar = DayHomeCalendarViewController()
        let date = Date()
        XCTAssertNotNil(calendar.tap(date: date))
    }
    
    //CalendarMonthViewController
    
    func testCalendarMonthViewController(){
        let cal = CalendarMonthViewController()
        XCTAssertNotNil(cal.didReceiveMemoryWarning())
    }
    
    func testNavigateTheScreenToContactsInPersistantMenu() {
        let calendarObj = CalendarMonthViewController()
        let temp = LoadThePersistantMenuScreen.contacts
        let temp1 = LoadThePersistantMenuScreen.actionItems
        XCTAssertNotNil(calendarObj.navigateTheScreenToContactsInPersistantMenu(data: temp))
        XCTAssertNotNil(calendarObj.navigateTheScreenToContactsInPersistantMenu(data: temp1))
        XCTAssertNotNil(calendarObj.navigateTheScreenToActionItemsInPersistantMenu(data: temp1))
        XCTAssertNotNil(calendarObj.navigateToAccountScreen())
        XCTAssertNotNil(calendarObj.navigateToVisitListing())
    }
    
}
