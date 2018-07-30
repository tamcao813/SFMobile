//
//  CalendarUITests.swift
//  SWSAppUITests
//
//  Created by Krishna, Kamya on 7/26/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import XCTest

class CalendarUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()
        sleep(20)

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCalendarNewVisit(){
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Calendar"]/*[[".staticTexts.buttons[\"Calendar\"]",".buttons[\"Calendar\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Add New  +"].tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["Visit"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"Visit\"]",".staticTexts[\"Visit\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Close"].tap()
    }
    
    func testCalendarNewEvent(){
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Calendar"]/*[[".staticTexts.buttons[\"Calendar\"]",".buttons[\"Calendar\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Add New  +"].tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["Event"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"Event\"]",".staticTexts[\"Event\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
    }
    
    func testCalendarDayView(){
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Calendar"]/*[[".staticTexts.buttons[\"Calendar\"]",".buttons[\"Calendar\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Week View    "].tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["Day View"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"Day View\"]",".staticTexts[\"Day View\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        let element = app.otherElements.containing(.navigationBar, identifier:"SWSApp.ParentView").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1)
        element.buttons["  "].tap()
        element.children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .button).element(boundBy: 0).tap()
        
    }
    
    func testCalendarWeekView(){
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Calendar"]/*[[".staticTexts.buttons[\"Calendar\"]",".buttons[\"Calendar\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Week View    "].tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["Week View"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"Week View\"]",".staticTexts[\"Week View\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
        let element = app.otherElements.containing(.navigationBar, identifier:"SWSApp.ParentView").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1)
        element.buttons["  "].tap()
        element.children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .button).element(boundBy: 0).tap()
        
    }
    
    func testCalendarMonthView(){
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Calendar"]/*[[".staticTexts.buttons[\"Calendar\"]",".buttons[\"Calendar\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Week View    "].tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["Month View"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"Month View\"]",".staticTexts[\"Month View\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
        let collectionViewsQuery = app.collectionViews
        collectionViewsQuery.buttons["Next"].tap()
        collectionViewsQuery.buttons["Previous"].tap()
        
    }
    
    func testIncludeWeekends() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Calendar"]/*[[".staticTexts.buttons[\"Calendar\"]",".buttons[\"Calendar\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Button"].tap()
        app.buttons["Button"].tap()
        
        //For month view
        app.buttons["Week View    "].tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["Month View"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"Month View\"]",".staticTexts[\"Month View\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Button"].tap()
        app.buttons["Button"].tap()
        
    }
    
    func testShowToday() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Calendar"]/*[[".staticTexts.buttons[\"Calendar\"]",".buttons[\"Calendar\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        //For week view
        let element = app.otherElements.containing(.navigationBar, identifier:"SWSApp.ParentView").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1)
        element.buttons["  "].tap()
        element.children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .button).element(boundBy: 0).tap()
        element.buttons["  "].tap()
        app.buttons["Today "].tap()
        
        //For day view
        app.buttons["Week View    "].tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["Day View"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"Day View\"]",".staticTexts[\"Day View\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        let button = app.otherElements.containing(.navigationBar, identifier:"SWSApp.ParentView").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .button).element(boundBy: 0)
        button.tap()
        button.tap()
        let todayButton = app.buttons["Today "]
        todayButton.tap()
        
        //For month view
        app.buttons["Day View    "].tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["Month View"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"Month View\"]",".staticTexts[\"Month View\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Button"].tap()
        app.collectionViews.buttons["Previous"].tap()
        todayButton.tap()
        
    }
    
    //Calendar filters
    func testFilterAppointmentType() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Calendar"]/*[[".staticTexts.buttons[\"Calendar\"]",".buttons[\"Calendar\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let tablesQuery = app.tables
        let appointmentTypeStaticText = tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Appointment Type"]/*[[".otherElements[\"Appointment Type\"].staticTexts[\"Appointment Type\"]",".staticTexts[\"Appointment Type\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        appointmentTypeStaticText.tap()
        appointmentTypeStaticText.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Events"]/*[[".cells.staticTexts[\"Events\"]",".staticTexts[\"Events\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Events"]/*[[".cells.staticTexts[\"Events\"]",".staticTexts[\"Events\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Events"]/*[[".cells.staticTexts[\"Events\"]",".staticTexts[\"Events\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Submit"].tap()
        app.buttons["Clear"].tap()
        
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Visits"]/*[[".cells.staticTexts[\"Visits\"]",".staticTexts[\"Visits\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Events"]/*[[".cells.staticTexts[\"Events\"]",".staticTexts[\"Events\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Events"]/*[[".cells.staticTexts[\"Events\"]",".staticTexts[\"Events\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Submit"].tap()
        app.buttons["Clear"].tap()
        
    }
    
    func testEventsAppointmentFilterSubmitClear() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Calendar"]/*[[".staticTexts.buttons[\"Calendar\"]",".buttons[\"Calendar\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let tablesQuery = app.tables
        let appointmentTypeStaticText = tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Appointment Type"]/*[[".otherElements[\"Appointment Type\"].staticTexts[\"Appointment Type\"]",".staticTexts[\"Appointment Type\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        appointmentTypeStaticText.tap()
        appointmentTypeStaticText.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Visits"]/*[[".cells.staticTexts[\"Visits\"]",".staticTexts[\"Visits\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Visits"]/*[[".cells.staticTexts[\"Visits\"]",".staticTexts[\"Visits\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Visits"]/*[[".cells.staticTexts[\"Visits\"]",".staticTexts[\"Visits\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Submit"].tap()
        app.buttons["Clear"].tap()
        
    }
    
    //create visit from calender
    func testCreateVisitInCalender(){
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Calendar"]/*[[".staticTexts.buttons[\"Calendar\"]",".buttons[\"Calendar\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Add New  +"].tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["Visit"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"Visit\"]",".staticTexts[\"Visit\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
        let accountSearchField = app.tables/*@START_MENU_TOKEN@*/.textFields["Search by Account Name or ID"]/*[[".cells.textFields[\"Search by Account Name or ID\"]",".textFields[\"Search by Account Name or ID\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        accountSearchField.tap()
        accountSearchField.typeText("aus")
        XCUIApplication()/*@START_MENU_TOKEN@*/.tables.staticTexts["Aus Lounge Bar"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"Aus Lounge Bar\"]",".staticTexts[\"Aus Lounge Bar\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
        let searchContactField = app.tables/*@START_MENU_TOKEN@*/.textFields["Search for Contacts"]/*[[".cells.textFields[\"Search for Contacts\"]",".textFields[\"Search for Contacts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        searchContactField.tap()
        searchContactField.typeText("melody")
        XCUIApplication().tables/*@START_MENU_TOKEN@*/.staticTexts["Melody Windhaus"]/*[[".cells.staticTexts[\"Melody Windhaus\"]",".staticTexts[\"Melody Windhaus\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Schedule and Close"].tap()
        
        app.tables/*@START_MENU_TOKEN@*/.textFields["MM/DD/YYYY"]/*[[".cells.textFields[\"MM\/DD\/YYYY\"]",".textFields[\"MM\/DD\/YYYY\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.toolbars["Toolbar"].buttons["Done"].tap()
        app.buttons["Schedule and Close"].tap()
        
        app.tables/*@START_MENU_TOKEN@*/.cells.containing(.textField, identifier:"HH:MM")/*[[".cells.containing(.staticText, identifier:\"Schedule Appointment*\")",".cells.containing(.staticText, identifier:\"End Time\")",".cells.containing(.staticText, identifier:\"Start Time\")",".cells.containing(.staticText, identifier:\"Date of Visit\")",".cells.containing(.textField, identifier:\"HH:MM\")"],[[[-1,4],[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .textField).matching(identifier: "HH:MM").element(boundBy: 0).tap()
        app.toolbars["Toolbar"].buttons["Done"].tap()
        
        XCUIApplication().tables/*@START_MENU_TOKEN@*/.textFields["HH:MM"]/*[[".cells.textFields[\"HH:MM\"]",".textFields[\"HH:MM\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let datePickersQuery = app.datePickers
        datePickersQuery.pickerWheels.element(boundBy: 0).adjust(toPickerWheelValue: "11")
        datePickersQuery.pickerWheels.element(boundBy: 1).adjust(toPickerWheelValue: "30")
        datePickersQuery.pickerWheels.element(boundBy: 2).adjust(toPickerWheelValue: "PM")
        app.toolbars["Toolbar"].buttons["Done"].tap()
        app.buttons["Schedule and Close"].tap()
        
    }
    
    func testXSearchVisitInCalendar() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Calendar"]/*[[".staticTexts.buttons[\"Calendar\"]",".buttons[\"Calendar\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let searchField = app.searchFields["Name, Account, ID"]
        searchField.tap()
        searchField.typeText("aus")
        app/*@START_MENU_TOKEN@*/.buttons["Done"]/*[[".keyboards.buttons[\"Done\"]",".buttons[\"Done\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Submit"].tap()
        
        app.otherElements.containing(.navigationBar, identifier:"SWSApp.ParentView").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).collectionViews/*@START_MENU_TOKEN@*/.staticTexts["Aus Lounge Bar: ACC111"]/*[[".cells.staticTexts[\"Aus Lounge Bar: ACC111\"]",".staticTexts[\"Aus Lounge Bar: ACC111\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["    Delete Visit"].tap()
        app.alerts["Visit Delete"].buttons["Delete"].tap()
        sleep(10)
        
    }
    
    func testViewVisitInHomeCalendar() {
        
        let app = XCUIApplication()
        let collectionViewsQuery = XCUIApplication().scrollViews.otherElements.collectionViews
        collectionViewsQuery.cells.otherElements.containing(.staticText, identifier:"Aus Lounge Bar: ACC111").element.swipeUp()
        collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts["Aus Lounge Bar: ACC111"]/*[[".cells.staticTexts[\"Aus Lounge Bar: ACC111\"]",".staticTexts[\"Aus Lounge Bar: ACC111\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Close"].tap()
        
    }
    
    func testSearchByContactName() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Calendar"]/*[[".staticTexts.buttons[\"Calendar\"]",".buttons[\"Calendar\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app.buttons["Week View    "].tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["Month View"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"Month View\"]",".staticTexts[\"Month View\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
        let searchField = app.searchFields["Name, Account, ID"]
        searchField.tap()
        searchField.typeText("pointer")
        XCUIApplication()/*@START_MENU_TOKEN@*/.buttons["Hide keyboard"]/*[[".keyboards.buttons[\"Hide keyboard\"]",".buttons[\"Hide keyboard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let collectionViewsQuery = app.collectionViews
        collectionViewsQuery/*@START_MENU_TOKEN@*/.buttons["2:27 PM testone"]/*[[".cells.buttons[\"2:27 PM testone\"]",".buttons[\"2:27 PM testone\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
    }
    
    func testNavigateToPlanSummary() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Calendar"]/*[[".staticTexts.buttons[\"Calendar\"]",".buttons[\"Calendar\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app.buttons["Week View    "].tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["Month View"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"Month View\"]",".staticTexts[\"Month View\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
        let collectionViewsQuery = app.collectionViews
        collectionViewsQuery/*@START_MENU_TOKEN@*/.buttons["2:27 PM testone"]/*[[".cells.buttons[\"2:27 PM testone\"]",".buttons[\"2:27 PM testone\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let closeButton = app.buttons["Close"]
        closeButton.tap()
        collectionViewsQuery/*@START_MENU_TOKEN@*/.buttons["6:40 PM Blenders Pride: 776554"]/*[[".cells.buttons[\"6:40 PM Blenders Pride: 776554\"]",".buttons[\"6:40 PM Blenders Pride: 776554\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        closeButton.tap()
        
    }
    
}
