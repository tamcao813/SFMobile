//
//  AccountVisitsUITests.swift
//  SWSAppUITests
//
//  Created by Krishna, Kamya on 7/26/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import XCTest

class AccountVisitsUITests: XCTestCase {
        
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
    
    func testACreateScheduleVisit1(){
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["More ..."]/*[[".staticTexts.buttons[\"More ...\"]",".buttons[\"More ...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["  Account Visits"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"  Account Visits\"]",".staticTexts[\"  Account Visits\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
        app.buttons["Add New  +"].tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["Visit"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"Visit\"]",".staticTexts[\"Visit\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Schedule and Close"].tap()
        
        let searchField = app.tables/*@START_MENU_TOKEN@*/.textFields["Search by Account Name or ID"]/*[[".cells.textFields[\"Search by Account Name or ID\"]",".textFields[\"Search by Account Name or ID\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        searchField.tap()
        searchField.typeText("Kala")
        XCUIApplication().otherElements["drop_down"].tables.staticTexts["#KALAPAKI JOE'S BILL TO#"].tap()
        
        //XCUIApplication().tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"11112222")/*[[".cells.containing(.button, identifier:\"Close\")",".cells.containing(.staticText, identifier:\"P.O. BOX 1231345 White River Junction, New Hampshire 96766\")",".cells.containing(.staticText, identifier:\"11112222\")"],[[[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.staticTexts["#KALAPAKI JOE'S BILL TO#"].tap()
        
        let contact = app.tables/*@START_MENU_TOKEN@*/.textFields["Search for Contacts"]/*[[".cells.textFields[\"Search for Contacts\"]",".textFields[\"Search for Contacts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        contact.tap()
        contact.typeText("Thomas")
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["Thomas Cook"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"Thomas Cook\"]",".staticTexts[\"Thomas Cook\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        //app.tables/*@START_MENU_TOKEN@*/.staticTexts["Becky Bambara"]/*[[".cells.staticTexts[\"Becky Bambara\"]",".staticTexts[\"Becky Bambara\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Schedule and Close"].tap()
        
        XCUIApplication().tables/*@START_MENU_TOKEN@*/.textFields["MM/DD/YYYY"]/*[[".cells.textFields[\"MM\/DD\/YYYY\"]",".textFields[\"MM\/DD\/YYYY\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.toolbars["Toolbar"].buttons["Done"].tap()
        app.buttons["Schedule and Close"].tap()
        
        app.tables/*@START_MENU_TOKEN@*/.cells.containing(.textField, identifier:"HH:MM")/*[[".cells.containing(.staticText, identifier:\"Schedule Appointment*\")",".cells.containing(.staticText, identifier:\"End Time\")",".cells.containing(.staticText, identifier:\"Start Time\")",".cells.containing(.staticText, identifier:\"Date of Visit\")",".cells.containing(.textField, identifier:\"HH:MM\")"],[[[-1,4],[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .textField).matching(identifier: "HH:MM").element(boundBy: 0).tap()
        app.toolbars["Toolbar"].buttons["Done"].tap()
        
        let tablesQuery = app.tables
        tablesQuery.cells.containing(.staticText, identifier:"Location").children(matching: .textField).element.tap()
        app/*@START_MENU_TOKEN@*/.buttons["Hide keyboard"]/*[[".keyboards.buttons[\"Hide keyboard\"]",".buttons[\"Hide keyboard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["No"]/*[[".cells",".segmentedControls.buttons[\"No\"]",".buttons[\"No\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Yes"]/*[[".cells",".segmentedControls.buttons[\"Yes\"]",".buttons[\"Yes\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Schedule and Close"].tap()
        
        XCUIApplication().tables/*@START_MENU_TOKEN@*/.textFields["HH:MM"]/*[[".cells.textFields[\"HH:MM\"]",".textFields[\"HH:MM\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let datePickersQuery = app.datePickers
        datePickersQuery.pickerWheels.element(boundBy: 0).adjust(toPickerWheelValue: "11")
        datePickersQuery.pickerWheels.element(boundBy: 1).adjust(toPickerWheelValue: "00")
        datePickersQuery.pickerWheels.element(boundBy: 2).adjust(toPickerWheelValue: "PM")
        app.toolbars["Toolbar"].buttons["Done"].tap()
        app.tables/*@START_MENU_TOKEN@*/.buttons["No"]/*[[".cells",".segmentedControls.buttons[\"No\"]",".buttons[\"No\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app.buttons["Schedule and Close"].tap()
        
    }
    
    func testBNavigateToContactDetails() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["More ..."]/*[[".staticTexts.buttons[\"More ...\"]",".buttons[\"More ...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["  Account Visits"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"  Account Visits\"]",".staticTexts[\"  Account Visits\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        let searchField = app.searchFields["Search"]
        searchField.tap()
        searchField.typeText("Kalap")
        
        app/*@START_MENU_TOKEN@*/.buttons["Hide keyboard"]/*[[".keyboards.buttons[\"Hide keyboard\"]",".buttons[\"Hide keyboard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.buttons["submitButton"]/*[[".buttons[\"Submit\"]",".buttons[\"submitButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"#KALAPAKI JOE'S BILL TO#")/*[[".cells.containing(.staticText, identifier:\"12:26:PM\")",".cells.containing(.staticText, identifier:\"Scheduled\")",".cells.containing(.staticText, identifier:\"P.O. BOX 1231345 White River Junction, New Hampshire 96766\")",".cells.containing(.staticText, identifier:\"11112222\")",".cells.containing(.staticText, identifier:\"#KALAPAKI JOE'S BILL TO#\")"],[[[-1,4],[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .staticText).matching(identifier: "#KALAPAKI JOE'S BILL TO#").element(boundBy: 1).tap()
        XCUIApplication().tables/*@START_MENU_TOKEN@*/.staticTexts["Thomas Cook"]/*[[".cells.staticTexts[\"Thomas Cook\"]",".staticTexts[\"Thomas Cook\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        //tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Becky Bambara"]/*[[".cells.staticTexts[\"Becky Bambara\"]",".staticTexts[\"Becky Bambara\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
    }
    
    func testNavigateToAccountDetails() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["More ..."]/*[[".staticTexts.buttons[\"More ...\"]",".buttons[\"More ...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["  Account Visits"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"  Account Visits\"]",".staticTexts[\"  Account Visits\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        let searchField = app.searchFields["Search"]
        searchField.tap()
        searchField.typeText("Kalap")
        
        app/*@START_MENU_TOKEN@*/.buttons["Hide keyboard"]/*[[".keyboards.buttons[\"Hide keyboard\"]",".buttons[\"Hide keyboard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.buttons["submitButton"]/*[[".buttons[\"Submit\"]",".buttons[\"submitButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"#KALAPAKI JOE'S BILL TO#")/*[[".cells.containing(.staticText, identifier:\"12:26:PM\")",".cells.containing(.staticText, identifier:\"Scheduled\")",".cells.containing(.staticText, identifier:\"P.O. BOX 1231345 White River Junction, New Hampshire 96766\")",".cells.containing(.staticText, identifier:\"11112222\")",".cells.containing(.staticText, identifier:\"#KALAPAKI JOE'S BILL TO#\")"],[[[-1,4],[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .staticText).matching(identifier: "#KALAPAKI JOE'S BILL TO#").element(boundBy: 1).tap()
        app.tables.containing(.other, identifier:"Location")/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"#KALAPAKI JOE'S BILL TO#")/*[[".cells.containing(.staticText, identifier:\"P.O. BOX 1231345 White River Junction, New Hampshire 96766\")",".cells.containing(.staticText, identifier:\"11112222\")",".cells.containing(.staticText, identifier:\"#KALAPAKI JOE'S BILL TO#\")"],[[[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .button).element.tap()
        app.buttons["Details"].tap()
        
    }
    
    func testCCloseScheduledVisit() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["More ..."]/*[[".staticTexts.buttons[\"More ...\"]",".buttons[\"More ...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["  Account Visits"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"  Account Visits\"]",".staticTexts[\"  Account Visits\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        let searchField = app.searchFields["Search"]
        searchField.tap()
        searchField.typeText("Kalap")
        
        app/*@START_MENU_TOKEN@*/.buttons["Hide keyboard"]/*[[".keyboards.buttons[\"Hide keyboard\"]",".buttons[\"Hide keyboard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.buttons["submitButton"]/*[[".buttons[\"Submit\"]",".buttons[\"submitButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"#KALAPAKI JOE'S BILL TO#")/*[[".cells.containing(.staticText, identifier:\"12:26:PM\")",".cells.containing(.staticText, identifier:\"Scheduled\")",".cells.containing(.staticText, identifier:\"P.O. BOX 1231345 White River Junction, New Hampshire 96766\")",".cells.containing(.staticText, identifier:\"11112222\")",".cells.containing(.staticText, identifier:\"#KALAPAKI JOE'S BILL TO#\")"],[[[-1,4],[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .staticText).matching(identifier: "#KALAPAKI JOE'S BILL TO#").element(boundBy: 1).tap()
        XCUIApplication().buttons["Close"].tap()
        
    }
    
    //Edit account strategy and save
    func testDEditSaveStrategyForScheduledVisit() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["More ..."]/*[[".staticTexts.buttons[\"More ...\"]",".buttons[\"More ...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["  Account Visits"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"  Account Visits\"]",".staticTexts[\"  Account Visits\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        let searchField = app.searchFields["Search"]
        searchField.tap()
        searchField.typeText("Kalap")
        
        app/*@START_MENU_TOKEN@*/.buttons["Hide keyboard"]/*[[".keyboards.buttons[\"Hide keyboard\"]",".buttons[\"Hide keyboard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.buttons["submitButton"]/*[[".buttons[\"Submit\"]",".buttons[\"submitButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"#KALAPAKI JOE'S BILL TO#")/*[[".cells.containing(.staticText, identifier:\"12:26:PM\")",".cells.containing(.staticText, identifier:\"Scheduled\")",".cells.containing(.staticText, identifier:\"P.O. BOX 1231345 White River Junction, New Hampshire 96766\")",".cells.containing(.staticText, identifier:\"11112222\")",".cells.containing(.staticText, identifier:\"#KALAPAKI JOE'S BILL TO#\")"],[[[-1,4],[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .staticText).matching(identifier: "#KALAPAKI JOE'S BILL TO#").element(boundBy: 1).tap()
        
        app.buttons["Account Strategy"].tap()
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 1).buttons["Edit"].tap()
        
        let collectionViewsQuery = XCUIApplication().collectionViews
        collectionViewsQuery.cells.otherElements.containing(.staticText, identifier:"Consumers Are Changing Very Little").element.tap()
        collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts["Blaze its own path"]/*[[".cells.staticTexts[\"Blaze its own path\"]",".staticTexts[\"Blaze its own path\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 1).children(matching: .other).element(boundBy: 1).children(matching: .other).element(boundBy: 1).buttons["Close"].tap()
        app.alerts["Any changes will not be saved"].buttons["No"].tap()
        
        app.swipeUp()
        
        let respectForExpertiseElement = collectionViewsQuery.cells.otherElements.containing(.staticText, identifier:"Respect(For Expertise)").element
        respectForExpertiseElement.tap()
        respectForExpertiseElement.tap()
        let editStrategyField = collectionViewsQuery/*@START_MENU_TOKEN@*/.textViews["strategyNotes"]/*[[".cells.textViews[\"strategyNotes\"]",".textViews[\"strategyNotes\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        editStrategyField.tap()
        editStrategyField.typeText("Edited Account strategy")
        
        app/*@START_MENU_TOKEN@*/.buttons["Hide keyboard"]/*[[".keyboards.buttons[\"Hide keyboard\"]",".buttons[\"Hide keyboard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.collectionViews/*@START_MENU_TOKEN@*/.buttons["Save"]/*[[".cells.buttons[\"Save\"]",".buttons[\"Save\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
    }
    
    //Edit account strategy and close
    func testEEditCloseStrategy() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["More ..."]/*[[".staticTexts.buttons[\"More ...\"]",".buttons[\"More ...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["  Account Visits"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"  Account Visits\"]",".staticTexts[\"  Account Visits\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        let searchField = app.searchFields["Search"]
        searchField.tap()
        searchField.typeText("Kalap")
        
        app/*@START_MENU_TOKEN@*/.buttons["Hide keyboard"]/*[[".keyboards.buttons[\"Hide keyboard\"]",".buttons[\"Hide keyboard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.buttons["submitButton"]/*[[".buttons[\"Submit\"]",".buttons[\"submitButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"#KALAPAKI JOE'S BILL TO#")/*[[".cells.containing(.staticText, identifier:\"12:26:PM\")",".cells.containing(.staticText, identifier:\"Scheduled\")",".cells.containing(.staticText, identifier:\"P.O. BOX 1231345 White River Junction, New Hampshire 96766\")",".cells.containing(.staticText, identifier:\"11112222\")",".cells.containing(.staticText, identifier:\"#KALAPAKI JOE'S BILL TO#\")"],[[[-1,4],[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .staticText).matching(identifier: "#KALAPAKI JOE'S BILL TO#").element(boundBy: 1).tap()
        
        app.buttons["Account Strategy"].tap()
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 1).buttons["Edit"].tap()
        
        let collectionViewsQuery = app.collectionViews
        collectionViewsQuery.cells.otherElements.containing(.staticText, identifier:"Consumers Are Changing Very Little").element.tap()
        collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts["Blaze its own path"]/*[[".cells.staticTexts[\"Blaze its own path\"]",".staticTexts[\"Blaze its own path\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 1).children(matching: .other).element(boundBy: 1).children(matching: .other).element(boundBy: 1).buttons["Close"].tap()
        app.alerts["Any changes will not be saved"].buttons["Yes"].tap()
        XCUIApplication().children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 1).children(matching: .other).element(boundBy: 1).buttons["Close"].tap()
        
    }
    
    // Edit account strategy and cancel the changes
    func testFEditCancelStrategy() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["More ..."]/*[[".staticTexts.buttons[\"More ...\"]",".buttons[\"More ...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["  Account Visits"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"  Account Visits\"]",".staticTexts[\"  Account Visits\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        let searchField = app.searchFields["Search"]
        searchField.tap()
        searchField.typeText("Kalap")
        
        app/*@START_MENU_TOKEN@*/.buttons["Hide keyboard"]/*[[".keyboards.buttons[\"Hide keyboard\"]",".buttons[\"Hide keyboard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.buttons["submitButton"]/*[[".buttons[\"Submit\"]",".buttons[\"submitButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"#KALAPAKI JOE'S BILL TO#")/*[[".cells.containing(.staticText, identifier:\"12:26:PM\")",".cells.containing(.staticText, identifier:\"Scheduled\")",".cells.containing(.staticText, identifier:\"P.O. BOX 1231345 White River Junction, New Hampshire 96766\")",".cells.containing(.staticText, identifier:\"11112222\")",".cells.containing(.staticText, identifier:\"#KALAPAKI JOE'S BILL TO#\")"],[[[-1,4],[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .staticText).matching(identifier: "#KALAPAKI JOE'S BILL TO#").element(boundBy: 1).tap()
        
        app.buttons["Account Strategy"].tap()
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 1).buttons["Edit"].tap()
        XCUIApplication().collectionViews/*@START_MENU_TOKEN@*/.staticTexts["Limited Storage Space"]/*[[".cells.staticTexts[\"Limited Storage Space\"]",".staticTexts[\"Limited Storage Space\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.swipeUp()
        
        let cancelButton = app.collectionViews/*@START_MENU_TOKEN@*/.buttons["Cancel"]/*[[".cells.buttons[\"Cancel\"]",".buttons[\"Cancel\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        cancelButton.tap()
        
        let anyChangesWillNotBeSavedAlert = app.alerts["Any changes will not be saved"]
        anyChangesWillNotBeSavedAlert.buttons["No"].tap()
        cancelButton.tap()
        anyChangesWillNotBeSavedAlert.buttons["Yes"].tap()
        
    }
    
    // Edit scheduled visit and change status to planned.
    func testGEditAndPlanVisitScheduled() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["More ..."]/*[[".staticTexts.buttons[\"More ...\"]",".buttons[\"More ...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["  Account Visits"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"  Account Visits\"]",".staticTexts[\"  Account Visits\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
        let searchField = app.searchFields["Search"]
        searchField.tap()
        searchField.typeText("kalapa")
        
        app/*@START_MENU_TOKEN@*/.buttons["Hide keyboard"]/*[[".keyboards.buttons[\"Hide keyboard\"]",".buttons[\"Hide keyboard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Submit"].tap()
        XCUIApplication().tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Scheduled")/*[[".cells.containing(.staticText, identifier:\"06:39:PM\")",".cells.containing(.staticText, identifier:\"Scheduled\")"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .staticText).matching(identifier: "#KALAPAKI JOE'S BILL TO#").element(boundBy: 1).tap()
        app.buttons["Edit Visit"].tap()
        
        //        XCUIApplication().children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 2).tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"#KALAPAKI JOE'S BILL TO#")/*[[".cells.containing(.staticText, identifier:\"P.O. BOX 1231345 White River Junction, New Hampshire 96766\")",".cells.containing(.staticText, identifier:\"11112222\")",".cells.containing(.staticText, identifier:\"#KALAPAKI JOE'S BILL TO#\")"],[[[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.buttons["Close"].tap()
        //
        //        app.tables/*@START_MENU_TOKEN@*/.textFields["Search by Account Name or ID"]/*[[".cells.textFields[\"Search by Account Name or ID\"]",".textFields[\"Search by Account Name or ID\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        //        XCUIApplication().otherElements["drop_down"].tables/*@START_MENU_TOKEN@*/.staticTexts["#KALAPAKI JOE'S BILL TO#"]/*[[".cells.staticTexts[\"#KALAPAKI JOE'S BILL TO#\"]",".staticTexts[\"#KALAPAKI JOE'S BILL TO#\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        XCUIApplication().children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 2).tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Thomas Cook")/*[[".cells.containing(.staticText, identifier:\"TC\")",".cells.containing(.staticText, identifier:\"cook@texas.com\")",".cells.containing(.staticText, identifier:\"Email\")",".cells.containing(.staticText, identifier:\"(506) 201-0085\")",".cells.containing(.staticText, identifier:\"Phone\")",".cells.containing(.staticText, identifier:\"Thomas Cook\")"],[[[-1,5],[-1,4],[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .button).element.tap()
        let contact = app.tables/*@START_MENU_TOKEN@*/.textFields["Search for Contacts"]/*[[".cells.textFields[\"Search for Contacts\"]",".textFields[\"Search for Contacts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        contact.tap()
        contact.typeText("Thomas")
        //XCUIApplication().tables/*@START_MENU_TOKEN@*/.textFields["Search for Contacts"]/*[[".cells.textFields[\"Search for Contacts\"]",".textFields[\"Search for Contacts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCUIApplication().otherElements["drop_down"].tables/*@START_MENU_TOKEN@*/.staticTexts["Thomas Cook"]/*[[".cells.staticTexts[\"Thomas Cook\"]",".staticTexts[\"Thomas Cook\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        XCUIApplication().children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 2).tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Thomas Cook")/*[[".cells.containing(.staticText, identifier:\"TC\")",".cells.containing(.staticText, identifier:\"cook@texas.com\")",".cells.containing(.staticText, identifier:\"Email\")",".cells.containing(.staticText, identifier:\"(506) 201-0085\")",".cells.containing(.staticText, identifier:\"Phone\")",".cells.containing(.staticText, identifier:\"Thomas Cook\")"],[[[-1,5],[-1,4],[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .button).element.tap()
        
        app.buttons["Plan"].tap()
        app.buttons["Back"].tap()
        app.buttons["Plan"].tap()
        app.buttons["Next"].tap()
        app.buttons["Back"].tap()
        app.buttons["Next"].tap()
        
        let collectionViewsQuery = app.collectionViews
        collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts["Point of Sale"]/*[[".cells.staticTexts[\"Point of Sale\"]",".staticTexts[\"Point of Sale\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts["Payment Pick-Up"]/*[[".cells.staticTexts[\"Payment Pick-Up\"]",".staticTexts[\"Payment Pick-Up\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Save and Close"].tap()
        
    }
    
    //Schedule the visit planned
    func testHEditAndScheduleCloseVisitPlanned() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["More ..."]/*[[".staticTexts.buttons[\"More ...\"]",".buttons[\"More ...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["  Account Visits"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"  Account Visits\"]",".staticTexts[\"  Account Visits\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
        let searchField = app.searchFields["Search"]
        searchField.tap()
        searchField.typeText("kalapa")
        
        app/*@START_MENU_TOKEN@*/.buttons["Hide keyboard"]/*[[".keyboards.buttons[\"Hide keyboard\"]",".buttons[\"Hide keyboard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Submit"].tap()
        
        app.tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"#KALAPAKI JOE'S BILL TO#")/*[[".cells.containing(.staticText, identifier:\"12:26:PM\")",".cells.containing(.staticText, identifier:\"Planned\")",".cells.containing(.staticText, identifier:\"P.O. BOX 1231345 White River Junction, New Hampshire 96766\")",".cells.containing(.staticText, identifier:\"11112222\")",".cells.containing(.staticText, identifier:\"#KALAPAKI JOE'S BILL TO#\")"],[[[-1,4],[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .staticText).matching(identifier: "#KALAPAKI JOE'S BILL TO#").element(boundBy: 1).tap()
        app.buttons["Edit Visit"].tap()
        app.buttons["Schedule and Close"].tap()
        app.buttons["Close"].tap()
        
    }
    
    func testIEditStrategyInPlanVisit() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["More ..."]/*[[".staticTexts.buttons[\"More ...\"]",".buttons[\"More ...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["  Account Visits"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"  Account Visits\"]",".staticTexts[\"  Account Visits\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
        let searchField = app.searchFields["Search"]
        searchField.tap()
        searchField.typeText("kalapa")
        
        app/*@START_MENU_TOKEN@*/.buttons["Hide keyboard"]/*[[".keyboards.buttons[\"Hide keyboard\"]",".buttons[\"Hide keyboard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Submit"].tap()
        XCUIApplication().tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Scheduled")/*[[".cells.containing(.staticText, identifier:\"06:39:PM\")",".cells.containing(.staticText, identifier:\"Scheduled\")"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .staticText).matching(identifier: "#KALAPAKI JOE'S BILL TO#").element(boundBy: 1).tap()
        
        app.buttons["Edit Visit"].tap()
        
        let planButton = app.buttons["Plan"]
        planButton.tap()
        app.buttons["Next"].tap()
        
        let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 4)
        element.buttons["Account Strategy"].tap()
        element.buttons["Edit"].tap()
        
        let element2 = element.children(matching: .other).element(boundBy: 1)
        element2.children(matching: .other).element(boundBy: 1).buttons["Close"].tap()
        app.alerts["Any changes will not be saved"].buttons["Yes"].tap()
        element2.buttons["Close"].tap()
        app.buttons["Save and Close"].tap()
        
    }
    
    //Start planned visit, edit, cancel and close account strategy
    func testJEditCloseStrategyPlannedVisit() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["More ..."]/*[[".staticTexts.buttons[\"More ...\"]",".buttons[\"More ...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["  Account Visits"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"  Account Visits\"]",".staticTexts[\"  Account Visits\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        let searchField = app.searchFields["Search"]
        searchField.tap()
        searchField.typeText("Kalap")
        
        app/*@START_MENU_TOKEN@*/.buttons["Hide keyboard"]/*[[".keyboards.buttons[\"Hide keyboard\"]",".buttons[\"Hide keyboard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.buttons["submitButton"]/*[[".buttons[\"Submit\"]",".buttons[\"submitButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"#KALAPAKI JOE'S BILL TO#")/*[[".cells.containing(.staticText, identifier:\"12:26:PM\")",".cells.containing(.staticText, identifier:\"Scheduled\")",".cells.containing(.staticText, identifier:\"P.O. BOX 1231345 White River Junction, New Hampshire 96766\")",".cells.containing(.staticText, identifier:\"11112222\")",".cells.containing(.staticText, identifier:\"#KALAPAKI JOE'S BILL TO#\")"],[[[-1,4],[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .staticText).matching(identifier: "#KALAPAKI JOE'S BILL TO#").element(boundBy: 1).tap()
        
        app.buttons["Start Visit"].tap()
        let accountsButton = XCUIApplication().collectionViews/*@START_MENU_TOKEN@*/.staticTexts["#KALAPAKI JOE'S BILL TO#"]/*[[".cells.staticTexts[\"#KALAPAKI JOE'S BILL TO#\"]",".staticTexts[\"#KALAPAKI JOE'S BILL TO#\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        accountsButton.tap()
        
        let anyChangesWillNotBeSavedAlert = app.alerts["Any changes will not be saved"]
        anyChangesWillNotBeSavedAlert.buttons["No"].tap()
        
        app.buttons["Edit Account Strategy"].tap()
        
        let collectionViewsQuery = app.collectionViews
        collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts["Consumers Are Changing Alot"]/*[[".cells.staticTexts[\"Consumers Are Changing Alot\"]",".staticTexts[\"Consumers Are Changing Alot\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let closeButton = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 1).children(matching: .other).element(boundBy: 1).children(matching: .other).element(boundBy: 1).buttons["Close"]
        closeButton.tap()
        app.alerts["Any changes will not be saved"].buttons["No"].tap()
        closeButton.tap()
        app.alerts["Any changes will not be saved"].buttons["Yes"].tap()
        //add createActionItem button
        app.buttons["Edit Account Strategy"].tap()
        
        collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts["Consumers Are Changing Alot"]/*[[".cells.staticTexts[\"Consumers Are Changing Alot\"]",".staticTexts[\"Consumers Are Changing Alot\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts["Inventory Is Hard To Manage"]/*[[".cells.staticTexts[\"Inventory Is Hard To Manage\"]",".staticTexts[\"Inventory Is Hard To Manage\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts["Limited Storage Space"]/*[[".cells.staticTexts[\"Limited Storage Space\"]",".staticTexts[\"Limited Storage Space\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app.swipeUp()
        
        let cancelButton = app.collectionViews/*@START_MENU_TOKEN@*/.buttons["Cancel"]/*[[".cells.buttons[\"Cancel\"]",".buttons[\"Cancel\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        cancelButton.tap()
        
        anyChangesWillNotBeSavedAlert.buttons["No"].tap()
        cancelButton.tap()
        anyChangesWillNotBeSavedAlert.buttons["Yes"].tap()
        
        accountsButton.tap()
        anyChangesWillNotBeSavedAlert.buttons["Yes"].tap()
        
    }
    
    //Change the status of visit from planned to In-progress
    func testKSaveEditedStrategy() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["More ..."]/*[[".staticTexts.buttons[\"More ...\"]",".buttons[\"More ...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["  Account Visits"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"  Account Visits\"]",".staticTexts[\"  Account Visits\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        let searchField = app.searchFields["Search"]
        searchField.tap()
        searchField.typeText("Kalap")
        
        app/*@START_MENU_TOKEN@*/.buttons["Hide keyboard"]/*[[".keyboards.buttons[\"Hide keyboard\"]",".buttons[\"Hide keyboard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.buttons["submitButton"]/*[[".buttons[\"Submit\"]",".buttons[\"submitButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Planned")/*[[".cells.containing(.staticText, identifier:\"01:35:PM\")",".cells.containing(.staticText, identifier:\"Planned\")"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .staticText).matching(identifier: "#KALAPAKI JOE'S BILL TO#").element(boundBy: 1).tap()
        
        app.buttons["Start Visit"].tap()
        app.buttons["Edit Account Strategy"].tap()
        
        let collectionViewsQuery = XCUIApplication().collectionViews
        let cellsQuery = collectionViewsQuery.cells
        cellsQuery.otherElements.containing(.staticText, identifier:"Consumers Are Changing Alot").element.tap()
        
        let inventoryIsHardToManageElement = cellsQuery.otherElements.containing(.staticText, identifier:"Inventory Is Hard To Manage").element
        inventoryIsHardToManageElement.tap()
        inventoryIsHardToManageElement.tap()
        
        app.swipeUp()
        let strategyNotes = app.collectionViews/*@START_MENU_TOKEN@*/.textViews["strategyNotes"]/*[[".cells.textViews[\"strategyNotes\"]",".textViews[\"strategyNotes\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        strategyNotes.tap()
        strategyNotes.typeText("New strategy Notes")
        
        app/*@START_MENU_TOKEN@*/.buttons["Hide keyboard"]/*[[".keyboards.buttons[\"Hide keyboard\"]",".buttons[\"Hide keyboard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.collectionViews/*@START_MENU_TOKEN@*/.buttons["Save"]/*[[".cells.buttons[\"Save\"]",".buttons[\"Save\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let saveAndContinueButton = app.buttons["Save and Continue"]
        saveAndContinueButton.tap()
        app.buttons["Back"].tap()
        saveAndContinueButton.tap()
        
        //clicking on account name
        let accountsButton = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 1).children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element.children(matching: .button).element
        accountsButton.tap()
        
        let anyChangesWillNotBeSavedAlert = app.alerts["Any changes will not be saved"]
        anyChangesWillNotBeSavedAlert.buttons["No"].tap()
        
        //editAccountStrategy button action
        app.buttons["Edit Account Strategy"].tap()
        
        app.collectionViews/*@START_MENU_TOKEN@*/.staticTexts["Blaze its own path"]/*[[".cells.staticTexts[\"Blaze its own path\"]",".staticTexts[\"Blaze its own path\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let close = XCUIApplication().children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 1).children(matching: .other).element(boundBy: 1).children(matching: .other).element(boundBy: 1).buttons["Close"]
        close.tap()
        anyChangesWillNotBeSavedAlert.buttons["No"].tap()
        close.tap()
        anyChangesWillNotBeSavedAlert.buttons["Yes"].tap()
        
        let closeButton = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 1).children(matching: .other).element(boundBy: 1).buttons["Close"]
        closeButton.tap()
        
        anyChangesWillNotBeSavedAlert.buttons["No"].tap()
        closeButton.tap()
        anyChangesWillNotBeSavedAlert.buttons["Yes"].tap()
        
    }
    
    //Continue visit in progress and complete
    func testLContinueVisitInProgress() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["More ..."]/*[[".staticTexts.buttons[\"More ...\"]",".buttons[\"More ...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["  Account Visits"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"  Account Visits\"]",".staticTexts[\"  Account Visits\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        let searchField = app.searchFields["Search"]
        searchField.tap()
        searchField.typeText("Kalap")
        
        app/*@START_MENU_TOKEN@*/.buttons["Hide keyboard"]/*[[".keyboards.buttons[\"Hide keyboard\"]",".buttons[\"Hide keyboard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.buttons["submitButton"]/*[[".buttons[\"Submit\"]",".buttons[\"submitButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app.tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"#KALAPAKI JOE'S BILL TO#")/*[[".cells.containing(.staticText, identifier:\"12:26:PM\")",".cells.containing(.staticText, identifier:\"In-Progress\")",".cells.containing(.staticText, identifier:\"P.O. BOX 1231345 White River Junction, New Hampshire 96766\")",".cells.containing(.staticText, identifier:\"11112222\")",".cells.containing(.staticText, identifier:\"#KALAPAKI JOE'S BILL TO#\")"],[[[-1,4],[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .staticText).matching(identifier: "#KALAPAKI JOE'S BILL TO#").element(boundBy: 1).tap()
        
        let continueVisitButton = app.buttons["Continue Visit"]
        continueVisitButton.tap()
        
        let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 1).children(matching: .other).element(boundBy: 1)
        let closeButton = element.buttons["Close"]
        closeButton.tap()
        
        let anyChangesWillNotBeSavedAlert = app.alerts["Any changes will not be saved"]
        anyChangesWillNotBeSavedAlert.buttons["No"].tap()
        closeButton.tap()
        let yesButton = anyChangesWillNotBeSavedAlert.buttons["Yes"]
        yesButton.tap()
        
        continueVisitButton.tap()
        app.buttons["Save and Continue"].tap()
        app.buttons["Edit Account Strategy"].tap()
        element.children(matching: .other).element(boundBy: 1).buttons["Close"].tap()
        yesButton.tap()
        app.buttons["Complete"].tap()
        
    }
    
    func testMEditNotesForVisitsCompleted() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["More ..."]/*[[".staticTexts.buttons[\"More ...\"]",".buttons[\"More ...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["  Account Visits"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"  Account Visits\"]",".staticTexts[\"  Account Visits\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        let searchField = app.searchFields["Search"]
        searchField.tap()
        searchField.typeText("Kalap")
        
        app/*@START_MENU_TOKEN@*/.buttons["Hide keyboard"]/*[[".keyboards.buttons[\"Hide keyboard\"]",".buttons[\"Hide keyboard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.buttons["submitButton"]/*[[".buttons[\"Submit\"]",".buttons[\"submitButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app.tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"#KALAPAKI JOE'S BILL TO#")/*[[".cells.containing(.staticText, identifier:\"12:26:PM\")",".cells.containing(.staticText, identifier:\"Completed\")",".cells.containing(.staticText, identifier:\"P.O. BOX 1231345 White River Junction, New Hampshire 96766\")",".cells.containing(.staticText, identifier:\"11112222\")",".cells.containing(.staticText, identifier:\"#KALAPAKI JOE'S BILL TO#\")"],[[[-1,4],[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .staticText).matching(identifier: "#KALAPAKI JOE'S BILL TO#").element(boundBy: 1).tap()
        app.buttons["Edit Notes"].tap()
        
        //close without editing
        let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 1).children(matching: .other).element(boundBy: 1)
        element.buttons["Close"].tap()
        app.buttons["Edit Notes"].tap()
        
        let editNotesField = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 1).children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element.children(matching: .textView).element
        editNotesField.tap()
        editNotesField.typeText("Editing Notes")
        XCUIApplication()/*@START_MENU_TOKEN@*/.buttons["Hide keyboard"]/*[[".keyboards.buttons[\"Hide keyboard\"]",".buttons[\"Hide keyboard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app.buttons["Save and Close"].tap()
        app.buttons["Edit Notes"].tap()
        
        //Edit the notes which are already edited and close
        let editedField = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 1).children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element.children(matching: .textView).element
        editedField.tap()
        editedField.typeText(" for visits completed")
        app/*@START_MENU_TOKEN@*/.buttons["Hide keyboard"]/*[[".keyboards.buttons[\"Hide keyboard\"]",".buttons[\"Hide keyboard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let closeButton = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 1).children(matching: .other).element(boundBy: 1).buttons["Close"]
        closeButton.tap()
        
        let anyChangesWillNotBeSavedAlert = app.alerts["Any changes will not be saved"]
        anyChangesWillNotBeSavedAlert.buttons["No"].tap()
        closeButton.tap()
        anyChangesWillNotBeSavedAlert.buttons["Yes"].tap()
        
    }
    
    //plan new visit
    func testNPlanNewVisit() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["More ..."]/*[[".staticTexts.buttons[\"More ...\"]",".buttons[\"More ...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["  Account Visits"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"  Account Visits\"]",".staticTexts[\"  Account Visits\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
        app.buttons["Add New  +"].tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["Visit"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"Visit\"]",".staticTexts[\"Visit\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
        let accountSearchField = app.tables/*@START_MENU_TOKEN@*/.textFields["Search by Account Name or ID"]/*[[".cells.textFields[\"Search by Account Name or ID\"]",".textFields[\"Search by Account Name or ID\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        accountSearchField.tap()
        accountSearchField.typeText("fost")
        XCUIApplication().otherElements["drop_down"].tables/*@START_MENU_TOKEN@*/.staticTexts["Fosters Beer Parlour"]/*[[".cells.staticTexts[\"Fosters Beer Parlour\"]",".staticTexts[\"Fosters Beer Parlour\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let contactField = app.tables/*@START_MENU_TOKEN@*/.textFields["Search for Contacts"]/*[[".cells.textFields[\"Search for Contacts\"]",".textFields[\"Search for Contacts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        contactField.tap()
        XCUIApplication().tables/*@START_MENU_TOKEN@*/.staticTexts["Tyler Elmes"]/*[[".cells.staticTexts[\"Tyler Elmes\"]",".staticTexts[\"Tyler Elmes\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCUIApplication().tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Tyler Elmes")/*[[".cells.containing(.staticText, identifier:\"TE\")",".cells.containing(.staticText, identifier:\"tyler@roadhouse.com\")",".cells.containing(.staticText, identifier:\"Email\")",".cells.containing(.staticText, identifier:\"(502) 338-8878\")",".cells.containing(.staticText, identifier:\"Phone\")",".cells.containing(.staticText, identifier:\"Tyler Elmes\")"],[[[-1,5],[-1,4],[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .button).element.tap()
        contactField.tap()
        XCUIApplication().tables/*@START_MENU_TOKEN@*/.staticTexts["Tyler Elmes"]/*[[".cells.staticTexts[\"Tyler Elmes\"]",".staticTexts[\"Tyler Elmes\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        XCUIApplication().tables/*@START_MENU_TOKEN@*/.textFields["MM/DD/YYYY"]/*[[".cells.textFields[\"MM\/DD\/YYYY\"]",".textFields[\"MM\/DD\/YYYY\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.toolbars["Toolbar"].buttons["Done"].tap()
        
        app.tables/*@START_MENU_TOKEN@*/.cells.containing(.textField, identifier:"HH:MM")/*[[".cells.containing(.staticText, identifier:\"Schedule Appointment*\")",".cells.containing(.staticText, identifier:\"End Time\")",".cells.containing(.staticText, identifier:\"Start Time\")",".cells.containing(.staticText, identifier:\"Date of Visit\")",".cells.containing(.textField, identifier:\"HH:MM\")"],[[[-1,4],[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .textField).matching(identifier: "HH:MM").element(boundBy: 0).tap()
        app.toolbars["Toolbar"].buttons["Done"].tap()
        
        XCUIApplication().tables/*@START_MENU_TOKEN@*/.textFields["HH:MM"]/*[[".cells.textFields[\"HH:MM\"]",".textFields[\"HH:MM\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let datePickersQuery = app.datePickers
        datePickersQuery.pickerWheels.element(boundBy: 0).adjust(toPickerWheelValue: "11")
        datePickersQuery.pickerWheels.element(boundBy: 1).adjust(toPickerWheelValue: "45")
        datePickersQuery.pickerWheels.element(boundBy: 2).adjust(toPickerWheelValue: "PM")
        app.toolbars["Toolbar"].buttons["Done"].tap()
        
        app.buttons["Plan"].tap()
        app.buttons["Back"].tap()
        app.buttons["Plan"].tap()
        app.buttons["Insights"].tap()
        app.buttons["Button"].tap()
        app.buttons["Account Strategy"].tap()
        app.buttons["closeButtonID"].tap()
        app.buttons["Next"].tap()
        app.buttons["Back"].tap()
        app.buttons["Next"].tap()
        app.buttons["Save and Close"].tap()
        
    }
    
    //Mark: Menu options in Edit Visit Screen
    func testOScheduleEditStartContacts(){
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["More ..."]/*[[".staticTexts.buttons[\"More ...\"]",".buttons[\"More ...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["  Account Visits"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"  Account Visits\"]",".staticTexts[\"  Account Visits\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        let searchField = app.searchFields["Search"]
        searchField.tap()
        searchField.typeText("Fost")
        
        app/*@START_MENU_TOKEN@*/.buttons["Hide keyboard"]/*[[".keyboards.buttons[\"Hide keyboard\"]",".buttons[\"Hide keyboard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.buttons["submitButton"]/*[[".buttons[\"Submit\"]",".buttons[\"submitButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app.tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Planned")/*[[".cells.containing(.staticText, identifier:\"01:35:PM\")",".cells.containing(.staticText, identifier:\"Planned\")"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .staticText).matching(identifier: "Fosters Beer Parlour").element(boundBy: 1).tap()
        app.buttons["Start Visit"].tap()
        app.buttons["Insights"].tap()
        app.buttons["Button"].tap()
        
        let contactsButton = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 1).buttons["Contacts"]
        contactsButton.tap()
        
        let anyChangesWillNotBeSavedAlert = app.alerts["Any changes will not be saved"]
        anyChangesWillNotBeSavedAlert.buttons["No"].tap()
        contactsButton.tap()
        anyChangesWillNotBeSavedAlert.buttons["Yes"].tap()
        
    }
    
    func testPScheduleEditStartTransactions(){
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["More ..."]/*[[".staticTexts.buttons[\"More ...\"]",".buttons[\"More ...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["  Account Visits"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"  Account Visits\"]",".staticTexts[\"  Account Visits\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        let searchField = app.searchFields["Search"]
        searchField.tap()
        searchField.typeText("Fost")
        app/*@START_MENU_TOKEN@*/.buttons["Hide keyboard"]/*[[".keyboards.buttons[\"Hide keyboard\"]",".buttons[\"Hide keyboard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.buttons["submitButton"]/*[[".buttons[\"Submit\"]",".buttons[\"submitButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app.tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Planned")/*[[".cells.containing(.staticText, identifier:\"01:35:PM\")",".cells.containing(.staticText, identifier:\"Planned\")"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .staticText).matching(identifier: "Fosters Beer Parlour").element(boundBy: 1).tap()
        app.buttons["Start Visit"].tap()
        
        app.buttons["Transactions (Topaz)"].tap()
        app.alerts["Alert"].buttons["OK"].tap()
        
        //        XCUIApplication().buttons["Transactions (Topaz)"].tap()
        //        XCUIDevice.shared.orientation = .portrait
        //        XCUIDevice.shared.orientation = .portrait
    }
    
    func testQScheduleEditStartGoSpotCheck(){
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["More ..."]/*[[".staticTexts.buttons[\"More ...\"]",".buttons[\"More ...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["  Account Visits"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"  Account Visits\"]",".staticTexts[\"  Account Visits\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        let searchField = app.searchFields["Search"]
        searchField.tap()
        searchField.typeText("Fost")
        app/*@START_MENU_TOKEN@*/.buttons["Hide keyboard"]/*[[".keyboards.buttons[\"Hide keyboard\"]",".buttons[\"Hide keyboard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.buttons["submitButton"]/*[[".buttons[\"Submit\"]",".buttons[\"submitButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app.tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Planned")/*[[".cells.containing(.staticText, identifier:\"01:35:PM\")",".cells.containing(.staticText, identifier:\"Planned\")"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .staticText).matching(identifier: "Fosters Beer Parlour").element(boundBy: 1).tap()
        app.buttons["Start Visit"].tap()
        XCUIApplication().buttons["GoSpotCheck"].tap()
        
        //        XCUIApplication().buttons["GoSpotCheck"].tap()
        //        XCUIDevice.shared.orientation = .portrait
        //        XCUIDevice.shared.orientation = .portrait
        
    }
    
    func testRScheduleEditStartChatter(){
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["More ..."]/*[[".staticTexts.buttons[\"More ...\"]",".buttons[\"More ...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["  Account Visits"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"  Account Visits\"]",".staticTexts[\"  Account Visits\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        let searchField = app.searchFields["Search"]
        searchField.tap()
        searchField.typeText("Fost")
        app/*@START_MENU_TOKEN@*/.buttons["Hide keyboard"]/*[[".keyboards.buttons[\"Hide keyboard\"]",".buttons[\"Hide keyboard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.buttons["submitButton"]/*[[".buttons[\"Submit\"]",".buttons[\"submitButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app.tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Planned")/*[[".cells.containing(.staticText, identifier:\"01:35:PM\")",".cells.containing(.staticText, identifier:\"Planned\")"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .staticText).matching(identifier: "Fosters Beer Parlour").element(boundBy: 1).tap()
        app.buttons["Start Visit"].tap()
        
        let chatterButton = app.buttons["Chatter"]
        chatterButton.tap()
        
        let anyChangesWillNotBeSavedAlert = app.alerts["Any changes will not be saved"]
        anyChangesWillNotBeSavedAlert.buttons["No"].tap()
        chatterButton.tap()
        anyChangesWillNotBeSavedAlert.buttons["Yes"].tap()
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 2).buttons["Close"].tap()
        
    }
    
    func testSScheduleEditStartActionItems(){
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["More ..."]/*[[".staticTexts.buttons[\"More ...\"]",".buttons[\"More ...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["  Account Visits"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"  Account Visits\"]",".staticTexts[\"  Account Visits\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        let searchField = app.searchFields["Search"]
        searchField.tap()
        searchField.typeText("Fost")
        app/*@START_MENU_TOKEN@*/.buttons["Hide keyboard"]/*[[".keyboards.buttons[\"Hide keyboard\"]",".buttons[\"Hide keyboard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.buttons["submitButton"]/*[[".buttons[\"Submit\"]",".buttons[\"submitButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app.tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Planned")/*[[".cells.containing(.staticText, identifier:\"01:35:PM\")",".cells.containing(.staticText, identifier:\"Planned\")"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .staticText).matching(identifier: "Fosters Beer Parlour").element(boundBy: 1).tap()
        app.buttons["Start Visit"].tap()
        
        let actionItemsButton = app.buttons["Action Items"]
        actionItemsButton.tap()
        app.buttons["duringVisitActionItemCloseButton"].tap()
        actionItemsButton.tap()
        let viewAccountActionItemsButton = XCUIApplication().buttons["View Account Action Items"]
        viewAccountActionItemsButton.tap()
        let anyChangesWillNotBeSavedAlert = app.alerts["Any changes will not be saved"]
        anyChangesWillNotBeSavedAlert.buttons["No"].tap()
        viewAccountActionItemsButton.tap()
        anyChangesWillNotBeSavedAlert.buttons["Yes"].tap()
        //app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Accounts"]/*[[".staticTexts.buttons[\"Accounts\"]",".buttons[\"Accounts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
    }
    
    func testSScheduleEditStartInsights() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["More ..."]/*[[".staticTexts.buttons[\"More ...\"]",".buttons[\"More ...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["  Account Visits"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"  Account Visits\"]",".staticTexts[\"  Account Visits\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        let searchField = app.searchFields["Search"]
        searchField.tap()
        searchField.typeText("Fost")
        app/*@START_MENU_TOKEN@*/.buttons["Hide keyboard"]/*[[".keyboards.buttons[\"Hide keyboard\"]",".buttons[\"Hide keyboard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.buttons["submitButton"]/*[[".buttons[\"Submit\"]",".buttons[\"submitButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app.tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Planned")/*[[".cells.containing(.staticText, identifier:\"01:35:PM\")",".cells.containing(.staticText, identifier:\"Planned\")"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .staticText).matching(identifier: "Fosters Beer Parlour").element(boundBy: 1).tap()
        app.buttons["Start Visit"].tap()
        
        app.buttons["Insights"].tap()
        app.buttons["Button"].tap()
        
    }
    
    func testTScheduleEditStartNotification(){
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["More ..."]/*[[".staticTexts.buttons[\"More ...\"]",".buttons[\"More ...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["  Account Visits"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"  Account Visits\"]",".staticTexts[\"  Account Visits\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        let searchField = app.searchFields["Search"]
        searchField.tap()
        searchField.typeText("Fost")
        app/*@START_MENU_TOKEN@*/.buttons["Hide keyboard"]/*[[".keyboards.buttons[\"Hide keyboard\"]",".buttons[\"Hide keyboard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.buttons["submitButton"]/*[[".buttons[\"Submit\"]",".buttons[\"submitButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app.tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Planned")/*[[".cells.containing(.staticText, identifier:\"01:35:PM\")",".cells.containing(.staticText, identifier:\"Planned\")"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .staticText).matching(identifier: "Fosters Beer Parlour").element(boundBy: 1).tap()
        app.buttons["Start Visit"].tap()
        
        let notificationButton = app.buttons["Notifications"]
        notificationButton.tap()
        app.buttons["duringVisitNotificationCloseButotnID"].tap()
        notificationButton.tap()
        let viewAccountNotifications = app.buttons["View Account Notifications"]
        viewAccountNotifications.tap()
        let anyChangesWillNotBeSavedAlert = app.alerts["Any changes will not be saved"]
        anyChangesWillNotBeSavedAlert.buttons["No"].tap()
        viewAccountNotifications.tap()
        anyChangesWillNotBeSavedAlert.buttons["Yes"].tap()
        //app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Accounts"]/*[[".staticTexts.buttons[\"Accounts\"]",".buttons[\"Accounts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
    }
    
    //Validation check for edit account strategy save
    func testUScheduleEditStartStrategy() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["More ..."]/*[[".staticTexts.buttons[\"More ...\"]",".buttons[\"More ...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["  Account Visits"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"  Account Visits\"]",".staticTexts[\"  Account Visits\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        let searchField = app.searchFields["Search"]
        searchField.tap()
        searchField.typeText("Fost")
        app/*@START_MENU_TOKEN@*/.buttons["Hide keyboard"]/*[[".keyboards.buttons[\"Hide keyboard\"]",".buttons[\"Hide keyboard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.buttons["submitButton"]/*[[".buttons[\"Submit\"]",".buttons[\"submitButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app.tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Planned")/*[[".cells.containing(.staticText, identifier:\"01:35:PM\")",".cells.containing(.staticText, identifier:\"Planned\")"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .staticText).matching(identifier: "Fosters Beer Parlour").element(boundBy: 1).tap()
        app.buttons["Start Visit"].tap()
        
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 1).children(matching: .other).element(boundBy: 1).buttons["Account Strategy"].tap()
        app.buttons["Edit"].tap()
        
        let collectionViewsQuery = app.collectionViews
        collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts["Blaze its own path"]/*[[".cells.staticTexts[\"Blaze its own path\"]",".staticTexts[\"Blaze its own path\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts["Consumers Are Changing Very Little"]/*[[".cells.staticTexts[\"Consumers Are Changing Very Little\"]",".staticTexts[\"Consumers Are Changing Very Little\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let cellsQuery = collectionViewsQuery.cells
        cellsQuery.otherElements.containing(.staticText, identifier:"Meet the needs of its regulars").element.tap()
        cellsQuery.otherElements.containing(.staticText, identifier:"Consumers Are Changing Alot").element.tap()
        collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts["Consumers Are Changing Somewhat"]/*[[".cells.staticTexts[\"Consumers Are Changing Somewhat\"]",".staticTexts[\"Consumers Are Changing Somewhat\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts["Limited Storage Space"]/*[[".cells.staticTexts[\"Limited Storage Space\"]",".staticTexts[\"Limited Storage Space\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts["Inventory Is Hard To Manage"]/*[[".cells.staticTexts[\"Inventory Is Hard To Manage\"]",".staticTexts[\"Inventory Is Hard To Manage\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts["Limited Cash Flow"]/*[[".cells.staticTexts[\"Limited Cash Flow\"]",".staticTexts[\"Limited Cash Flow\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.swipeUp()
        collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts["Recognition"]/*[[".cells.staticTexts[\"Recognition\"]",".staticTexts[\"Recognition\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts["Respect(For Expertise)"]/*[[".cells.staticTexts[\"Respect(For Expertise)\"]",".staticTexts[\"Respect(For Expertise)\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let saveButton = app.collectionViews/*@START_MENU_TOKEN@*/.buttons["Save"]/*[[".cells.buttons[\"Save\"]",".buttons[\"Save\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        saveButton.tap()
        app.swipeDown()
        
        collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts["Blaze its own path"]/*[[".cells.staticTexts[\"Blaze its own path\"]",".staticTexts[\"Blaze its own path\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        cellsQuery.otherElements.containing(.staticText, identifier:"Meet the needs of its regulars").element.tap()
        
        app.swipeUp()
        saveButton.tap()
        app.swipeDown()
        
        collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts["Consumers Are Changing Very Little"]/*[[".cells.staticTexts[\"Consumers Are Changing Very Little\"]",".staticTexts[\"Consumers Are Changing Very Little\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        cellsQuery.otherElements.containing(.staticText, identifier:"Consumers Are Changing Alot").element.tap()
        collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts["Consumers Are Changing Somewhat"]/*[[".cells.staticTexts[\"Consumers Are Changing Somewhat\"]",".staticTexts[\"Consumers Are Changing Somewhat\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app.swipeUp()
        saveButton.tap()
        app.swipeDown()
        
        collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts["Limited Storage Space"]/*[[".cells.staticTexts[\"Limited Storage Space\"]",".staticTexts[\"Limited Storage Space\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts["Inventory Is Hard To Manage"]/*[[".cells.staticTexts[\"Inventory Is Hard To Manage\"]",".staticTexts[\"Inventory Is Hard To Manage\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts["Limited Cash Flow"]/*[[".cells.staticTexts[\"Limited Cash Flow\"]",".staticTexts[\"Limited Cash Flow\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app.swipeUp()
        saveButton.tap()
        
        collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts["Recognition"]/*[[".cells.staticTexts[\"Recognition\"]",".staticTexts[\"Recognition\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts["Respect(For Expertise)"]/*[[".cells.staticTexts[\"Respect(For Expertise)\"]",".staticTexts[\"Respect(For Expertise)\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 1).children(matching: .other).element(boundBy: 1).children(matching: .other).element(boundBy: 1).children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .button).element.tap()
        app.alerts["Any changes will not be saved"].buttons["No"].tap()
        collectionViewsQuery/*@START_MENU_TOKEN@*/.buttons["Save"]/*[[".cells.buttons[\"Save\"]",".buttons[\"Save\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
    }
    
    func testVVisitNotesEdit() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["More ..."]/*[[".staticTexts.buttons[\"More ...\"]",".buttons[\"More ...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["  Account Visits"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"  Account Visits\"]",".staticTexts[\"  Account Visits\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        let searchField = app.searchFields["Search"]
        searchField.tap()
        searchField.typeText("Fost")
        app/*@START_MENU_TOKEN@*/.buttons["Hide keyboard"]/*[[".keyboards.buttons[\"Hide keyboard\"]",".buttons[\"Hide keyboard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.buttons["submitButton"]/*[[".buttons[\"Submit\"]",".buttons[\"submitButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app.tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Planned")/*[[".cells.containing(.staticText, identifier:\"01:35:PM\")",".cells.containing(.staticText, identifier:\"Planned\")"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .staticText).matching(identifier: "Fosters Beer Parlour").element(boundBy: 1).tap()
        app.buttons["Start Visit"].tap()
        
        let visitNotesField = app.collectionViews.cells.otherElements.containing(.staticText, identifier:"Visit Notes").children(matching: .other).element.children(matching: .textView).element
        visitNotesField.tap()
        visitNotesField.typeText("Visit Notes Added")
        app/*@START_MENU_TOKEN@*/.buttons["Hide keyboard"]/*[[".keyboards.buttons[\"Hide keyboard\"]",".buttons[\"Hide keyboard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        XCUIApplication().children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 1).children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element(boundBy: 0).children(matching: .button).element(boundBy: 8).tap()
        app.alerts["Any changes will not be saved"].buttons["No"].tap()
        
        XCUIApplication().children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 1).children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element(boundBy: 0).children(matching: .button).element(boundBy: 8).tap()
        app.alerts["Any changes will not be saved"].buttons["Yes"].tap()
        
    }
    
    func testWDeleteVisit() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["More ..."]/*[[".staticTexts.buttons[\"More ...\"]",".buttons[\"More ...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["  Account Visits"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"  Account Visits\"]",".staticTexts[\"  Account Visits\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        let searchField = app.searchFields["Search"]
        searchField.tap()
        searchField.typeText("Fost")
        app/*@START_MENU_TOKEN@*/.buttons["Hide keyboard"]/*[[".keyboards.buttons[\"Hide keyboard\"]",".buttons[\"Hide keyboard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.buttons["submitButton"]/*[[".buttons[\"Submit\"]",".buttons[\"submitButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app.tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Planned")/*[[".cells.containing(.staticText, identifier:\"01:35:PM\")",".cells.containing(.staticText, identifier:\"Planned\")"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .staticText).matching(identifier: "Fosters Beer Parlour").element(boundBy: 1).tap()
        
        let deleteVisitButton = app.buttons["    Delete Visit"]
        deleteVisitButton.tap()
        
        let visitDeleteAlert = app.alerts["Visit Delete"]
        visitDeleteAlert.buttons["Cancel"].tap()
        deleteVisitButton.tap()
        visitDeleteAlert.buttons["Delete"].tap()
        sleep(10)
        
    }
    
    // Test picker in New Visit
    func testDatePicker() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["More ..."]/*[[".staticTexts.buttons[\"More ...\"]",".buttons[\"More ...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["  Account Visits"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"  Account Visits\"]",".staticTexts[\"  Account Visits\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
        app.buttons["Add New  +"].tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["Visit"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"Visit\"]",".staticTexts[\"Visit\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
        XCUIApplication().tables/*@START_MENU_TOKEN@*/.textFields["MM/DD/YYYY"]/*[[".cells.textFields[\"MM\/DD\/YYYY\"]",".textFields[\"MM\/DD\/YYYY\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.toolbars["Toolbar"].buttons["Cancel"].tap()
        
        XCUIApplication().tables/*@START_MENU_TOKEN@*/.textFields["MM/DD/YYYY"]/*[[".cells.textFields[\"MM\/DD\/YYYY\"]",".textFields[\"MM\/DD\/YYYY\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.toolbars["Toolbar"].buttons["Done"].tap()
        
    }
    
    func testStartTime() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["More ..."]/*[[".staticTexts.buttons[\"More ...\"]",".buttons[\"More ...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["  Account Visits"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"  Account Visits\"]",".staticTexts[\"  Account Visits\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
        app.buttons["Add New  +"].tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["Visit"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"Visit\"]",".staticTexts[\"Visit\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
        app.tables/*@START_MENU_TOKEN@*/.cells.containing(.textField, identifier:"HH:MM")/*[[".cells.containing(.staticText, identifier:\"Schedule Appointment*\")",".cells.containing(.textField, identifier:\"MM\/DD\/YYYY\")",".cells.containing(.staticText, identifier:\"End Time\")",".cells.containing(.staticText, identifier:\"Start Time\")",".cells.containing(.staticText, identifier:\"Date of Visit\")",".cells.containing(.textField, identifier:\"HH:MM\")"],[[[-1,5],[-1,4],[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .textField).matching(identifier: "HH:MM").element(boundBy: 0).tap()
        app.toolbars["Toolbar"].buttons["Cancel"].tap()
        
        app.tables/*@START_MENU_TOKEN@*/.cells.containing(.textField, identifier:"HH:MM")/*[[".cells.containing(.staticText, identifier:\"Schedule Appointment*\")",".cells.containing(.textField, identifier:\"MM\/DD\/YYYY\")",".cells.containing(.staticText, identifier:\"End Time\")",".cells.containing(.staticText, identifier:\"Start Time\")",".cells.containing(.staticText, identifier:\"Date of Visit\")",".cells.containing(.textField, identifier:\"HH:MM\")"],[[[-1,5],[-1,4],[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .textField).matching(identifier: "HH:MM").element(boundBy: 0).tap()
        app.toolbars["Toolbar"].buttons["Done"].tap()
        
    }
    
    func testEndTime() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["More ..."]/*[[".staticTexts.buttons[\"More ...\"]",".buttons[\"More ...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["  Account Visits"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"  Account Visits\"]",".staticTexts[\"  Account Visits\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
        app.buttons["Add New  +"].tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["Visit"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"Visit\"]",".staticTexts[\"Visit\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
        app.tables/*@START_MENU_TOKEN@*/.cells.containing(.textField, identifier:"HH:MM")/*[[".cells.containing(.staticText, identifier:\"Schedule Appointment*\")",".cells.containing(.textField, identifier:\"MM\/DD\/YYYY\")",".cells.containing(.staticText, identifier:\"End Time\")",".cells.containing(.staticText, identifier:\"Start Time\")",".cells.containing(.staticText, identifier:\"Date of Visit\")",".cells.containing(.textField, identifier:\"HH:MM\")"],[[[-1,5],[-1,4],[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .textField).matching(identifier: "HH:MM").element(boundBy: 1).tap()
        app.toolbars["Toolbar"].buttons["Cancel"].tap()
        
        app.tables/*@START_MENU_TOKEN@*/.cells.containing(.textField, identifier:"HH:MM")/*[[".cells.containing(.staticText, identifier:\"Schedule Appointment*\")",".cells.containing(.textField, identifier:\"MM\/DD\/YYYY\")",".cells.containing(.staticText, identifier:\"End Time\")",".cells.containing(.staticText, identifier:\"Start Time\")",".cells.containing(.staticText, identifier:\"Date of Visit\")",".cells.containing(.textField, identifier:\"HH:MM\")"],[[[-1,5],[-1,4],[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .textField).matching(identifier: "HH:MM").element(boundBy: 1).tap()
        app.toolbars["Toolbar"].buttons["Done"].tap()
        
    }
    
    func testTimeAlert() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["More ..."]/*[[".staticTexts.buttons[\"More ...\"]",".buttons[\"More ...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["  Account Visits"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"  Account Visits\"]",".staticTexts[\"  Account Visits\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
        app.buttons["Add New  +"].tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["Visit"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"Visit\"]",".staticTexts[\"Visit\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
        //Start time and end time are same
        app.tables/*@START_MENU_TOKEN@*/.cells.containing(.textField, identifier:"HH:MM")/*[[".cells.containing(.textField, identifier:\"MM\/DD\/YYYY\")",".cells.containing(.staticText, identifier:\"Schedule Appointment*\")",".cells.containing(.staticText, identifier:\"End Time\")",".cells.containing(.staticText, identifier:\"Start Time\")",".cells.containing(.staticText, identifier:\"Date of Visit\")",".cells.containing(.textField, identifier:\"HH:MM\")"],[[[-1,5],[-1,4],[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .textField).matching(identifier: "HH:MM").element(boundBy: 0).tap()
        app.toolbars["Toolbar"].buttons["Done"].tap()
        
        XCUIApplication().tables/*@START_MENU_TOKEN@*/.textFields["HH:MM"]/*[[".cells.textFields[\"HH:MM\"]",".textFields[\"HH:MM\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.toolbars["Toolbar"].buttons["Done"].tap()
        
        XCUIApplication().alerts["Alert"].buttons["OK"].tap()
        
        //Start time is greater than end time
        XCUIApplication().tables/*@START_MENU_TOKEN@*/.textFields["HH:MM"]/*[[".cells.textFields[\"HH:MM\"]",".textFields[\"HH:MM\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let datePickersQuery = app.datePickers
        datePickersQuery.pickerWheels.element(boundBy: 0).adjust(toPickerWheelValue: "10")
        datePickersQuery.pickerWheels.element(boundBy: 1).adjust(toPickerWheelValue: "30")
        datePickersQuery.pickerWheels.element(boundBy: 2).adjust(toPickerWheelValue: "PM")
        app.toolbars["Toolbar"].buttons["Done"].tap()
        
        XCUIApplication().tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Date of Visit")/*[[".cells.containing(.staticText, identifier:\"Schedule Appointment*\")",".cells.containing(.textField, identifier:\"MM\/DD\/YYYY\")",".cells.containing(.staticText, identifier:\"End Time\")",".cells.containing(.staticText, identifier:\"Start Time\")",".cells.containing(.staticText, identifier:\"Date of Visit\")"],[[[-1,4],[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .textField).element(boundBy: 0).tap()
        datePickersQuery.pickerWheels.element(boundBy: 0).adjust(toPickerWheelValue: "11")
        datePickersQuery.pickerWheels.element(boundBy: 1).adjust(toPickerWheelValue: "30")
        datePickersQuery.pickerWheels.element(boundBy: 2).adjust(toPickerWheelValue: "PM")
        app.toolbars["Toolbar"].buttons["Done"].tap()
        
        XCUIApplication().alerts["Alert"].buttons["OK"].tap()
        
    }
    
    func testScheduleNewVisitValidationCheck() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["More ..."]/*[[".staticTexts.buttons[\"More ...\"]",".buttons[\"More ...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["  Account Visits"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"  Account Visits\"]",".staticTexts[\"  Account Visits\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
        app.buttons["Add New  +"].tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["Visit"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"Visit\"]",".staticTexts[\"Visit\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
        app.buttons["Close"].tap()
        
        app.buttons["Add New  +"].tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["Visit"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"Visit\"]",".staticTexts[\"Visit\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Schedule and Close"].tap()
        XCUIApplication().tables/*@START_MENU_TOKEN@*/.textFields["Search by Account Name or ID"]/*[[".cells.textFields[\"Search by Account Name or ID\"]",".textFields[\"Search by Account Name or ID\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["Aus Lounge Bar"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"Aus Lounge Bar\"]",".staticTexts[\"Aus Lounge Bar\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Schedule and Close"].tap()
        
        XCUIApplication().children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .button)["Close"].tap()
        let anyChangesWillNotBeSavedAlert = app.alerts["Any changes will not be saved"]
        anyChangesWillNotBeSavedAlert.buttons["No"].tap()
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .button)["Close"].tap()
        anyChangesWillNotBeSavedAlert.buttons["Yes"].tap()
        
    }
    
    func testPlanNewVisitValidationCheck() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["More ..."]/*[[".staticTexts.buttons[\"More ...\"]",".buttons[\"More ...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["  Account Visits"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"  Account Visits\"]",".staticTexts[\"  Account Visits\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
        app.buttons["Add New  +"].tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["Visit"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"Visit\"]",".staticTexts[\"Visit\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
        app.buttons["Plan"].tap()
        app.buttons["Close"].tap()
        
    }

}
