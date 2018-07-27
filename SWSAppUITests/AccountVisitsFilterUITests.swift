//
//  AccountVisitsFilterUITests.swift
//  SWSAppUITests
//
//  Created by Krishna, Kamya on 7/26/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import XCTest

class AccountVisitsFilterUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()
        sleep(15)

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testFilterType() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["More ..."]/*[[".staticTexts.buttons[\"More ...\"]",".buttons[\"More ...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["  Account Visits"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"  Account Visits\"]",".staticTexts[\"  Account Visits\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
        let tablesQuery = app.tables
        let typeStaticText = tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Type"]/*[[".otherElements[\"Type\"].staticTexts[\"Type\"]",".staticTexts[\"Type\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        typeStaticText.tap()
        typeStaticText.tap()
        typeStaticText.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Visit"]/*[[".cells.staticTexts[\"Visit\"]",".staticTexts[\"Visit\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Visit"]/*[[".cells.staticTexts[\"Visit\"]",".staticTexts[\"Visit\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Visit"]/*[[".cells.staticTexts[\"Visit\"]",".staticTexts[\"Visit\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["submitButton"].tap()
        app.buttons["clearButton"].tap()
        
        typeStaticText.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Event"]/*[[".cells.staticTexts[\"Event\"]",".staticTexts[\"Event\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Event"]/*[[".cells.staticTexts[\"Event\"]",".staticTexts[\"Event\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Event"]/*[[".cells.staticTexts[\"Event\"]",".staticTexts[\"Event\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app.buttons["submitButton"].tap()
        app.buttons["clearButton"].tap()
    }
    
    func testDateRangeFilterSubmitClear() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["More ..."]/*[[".staticTexts.buttons[\"More ...\"]",".buttons[\"More ...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["  Account Visits"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"  Account Visits\"]",".staticTexts[\"  Account Visits\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
        let dateRangeStaticText = app.tables/*@START_MENU_TOKEN@*/.staticTexts["Date Range"]/*[[".otherElements[\"Date Range\"].staticTexts[\"Date Range\"]",".staticTexts[\"Date Range\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        dateRangeStaticText.tap()
        dateRangeStaticText.tap()
        dateRangeStaticText.tap()
        
        let tablesQuery = XCUIApplication().tables
        tablesQuery/*@START_MENU_TOKEN@*/.textFields["Start"]/*[[".cells.textFields[\"Start\"]",".textFields[\"Start\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let datePickersQuery = app.datePickers
        datePickersQuery.pickerWheels.element(boundBy: 0).adjust(toPickerWheelValue: "March")
        datePickersQuery.pickerWheels.element(boundBy: 1).adjust(toPickerWheelValue: "10")
        datePickersQuery.pickerWheels.element(boundBy: 2).adjust(toPickerWheelValue: "2018")
        app.toolbars["Toolbar"].buttons["Done"].tap()
        
        tablesQuery/*@START_MENU_TOKEN@*/.textFields["End"]/*[[".cells.textFields[\"End\"]",".textFields[\"End\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        datePickersQuery.pickerWheels.element(boundBy: 0).adjust(toPickerWheelValue: "June")
        datePickersQuery.pickerWheels.element(boundBy: 1).adjust(toPickerWheelValue: "8")
        datePickersQuery.pickerWheels.element(boundBy: 2).adjust(toPickerWheelValue: "2018")
        app.toolbars["Toolbar"].buttons["Done"].tap()
        
        app.buttons["submitButton"].tap()
        app.buttons["clearButton"].tap()
        
    }
    
    func testPerformDateRangeOperation() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["More ..."]/*[[".staticTexts.buttons[\"More ...\"]",".buttons[\"More ...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["  Account Visits"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"  Account Visits\"]",".staticTexts[\"  Account Visits\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
        let dateRangeStaticText = app.tables/*@START_MENU_TOKEN@*/.staticTexts["Date Range"]/*[[".otherElements[\"Date Range\"].staticTexts[\"Date Range\"]",".staticTexts[\"Date Range\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        dateRangeStaticText.tap()
        
        let tablesQuery = XCUIApplication().tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Today"]/*[[".cells.staticTexts[\"Today\"]",".staticTexts[\"Today\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["submitButton"].tap()
        app.buttons["clearButton"].tap()
        
        dateRangeStaticText.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Tomorrow"]/*[[".cells.staticTexts[\"Tomorrow\"]",".staticTexts[\"Tomorrow\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["submitButton"].tap()
        app.buttons["clearButton"].tap()
        
        dateRangeStaticText.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["This Week"]/*[[".cells.staticTexts[\"This Week\"]",".staticTexts[\"This Week\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["submitButton"].tap()
        app.buttons["clearButton"].tap()
        
    }
    
    func testFilterStatus() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["More ..."]/*[[".staticTexts.buttons[\"More ...\"]",".buttons[\"More ...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["  Account Visits"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"  Account Visits\"]",".staticTexts[\"  Account Visits\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
        let typeTablesQuery = app/*@START_MENU_TOKEN@*/.tables.containing(.other, identifier:"Type")/*[[".tables.containing(.other, identifier:\"Past Visits\")",".tables.containing(.other, identifier:\"Date Range\")",".tables.containing(.other, identifier:\"Type\")"],[[[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        typeTablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Status"]/*[[".otherElements[\"Status\"].staticTexts[\"Status\"]",".staticTexts[\"Status\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let scheduledStaticText = typeTablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Scheduled"]/*[[".cells.staticTexts[\"Scheduled\"]",".staticTexts[\"Scheduled\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        scheduledStaticText.tap()
        scheduledStaticText.tap()
        scheduledStaticText.tap()
        
        app.buttons["submitButton"].tap()
        app.buttons["clearButton"].tap()
        
        typeTablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Status"]/*[[".otherElements[\"Status\"].staticTexts[\"Status\"]",".staticTexts[\"Status\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let plannedStaticText = typeTablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Planned"]/*[[".cells.staticTexts[\"Planned\"]",".staticTexts[\"Planned\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        plannedStaticText.tap()
        plannedStaticText.tap()
        plannedStaticText.tap()
        
        app.buttons["submitButton"].tap()
        app.buttons["clearButton"].tap()
        
        typeTablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Status"]/*[[".otherElements[\"Status\"].staticTexts[\"Status\"]",".staticTexts[\"Status\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let inProgressStaticText = typeTablesQuery/*@START_MENU_TOKEN@*/.staticTexts["In Progress"]/*[[".cells.staticTexts[\"In Progress\"]",".staticTexts[\"In Progress\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        inProgressStaticText.tap()
        inProgressStaticText.tap()
        inProgressStaticText.tap()
        
        app.buttons["submitButton"].tap()
        app.buttons["clearButton"].tap()
        
        typeTablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Status"]/*[[".otherElements[\"Status\"].staticTexts[\"Status\"]",".staticTexts[\"Status\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let completeStaticText = typeTablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Complete"]/*[[".cells.staticTexts[\"Complete\"]",".staticTexts[\"Complete\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        completeStaticText.tap()
        completeStaticText.tap()
        completeStaticText.tap()
        
        app.buttons["submitButton"].tap()
        app.buttons["clearButton"].tap()
        
    }
    
    func testFilterPastVisits() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["More ..."]/*[[".staticTexts.buttons[\"More ...\"]",".buttons[\"More ...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["  Account Visits"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"  Account Visits\"]",".staticTexts[\"  Account Visits\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
        let typeTablesQuery = app/*@START_MENU_TOKEN@*/.tables.containing(.other, identifier:"Type")/*[[".tables.containing(.other, identifier:\"Past Visits\")",".tables.containing(.other, identifier:\"Date Range\")",".tables.containing(.other, identifier:\"Type\")"],[[[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        typeTablesQuery.staticTexts["Past Visits"].tap()
        
        let pastVisitsStaticText = app.tables.cells.staticTexts["Past Visits"]
        pastVisitsStaticText.tap()
        pastVisitsStaticText.tap()
        pastVisitsStaticText.tap()
        
        app.buttons["submitButton"].tap()
        app.buttons["clearButton"].tap()
        
    }
    
    //If condition for applyFilter()
    func testApplyFilterWithDateRange() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["More ..."]/*[[".staticTexts.buttons[\"More ...\"]",".buttons[\"More ...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["  Account Visits"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"  Account Visits\"]",".staticTexts[\"  Account Visits\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
        let searchField = app.searchFields["Search"]
        searchField.tap()
        searchField.typeText("cave")
        app/*@START_MENU_TOKEN@*/.buttons["Hide keyboard"]/*[[".keyboards.buttons[\"Hide keyboard\"]",".buttons[\"Hide keyboard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["submitButton"].tap()
        
        let dateRangeStaticText = app.tables/*@START_MENU_TOKEN@*/.staticTexts["Date Range"]/*[[".otherElements[\"Date Range\"].staticTexts[\"Date Range\"]",".staticTexts[\"Date Range\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        dateRangeStaticText.tap()
        
        let tablesQuery = XCUIApplication().tables
        tablesQuery/*@START_MENU_TOKEN@*/.textFields["Start"]/*[[".cells.textFields[\"Start\"]",".textFields[\"Start\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let datePickersQuery = app.datePickers
        datePickersQuery.pickerWheels.element(boundBy: 0).adjust(toPickerWheelValue: "March")
        datePickersQuery.pickerWheels.element(boundBy: 1).adjust(toPickerWheelValue: "10")
        datePickersQuery.pickerWheels.element(boundBy: 2).adjust(toPickerWheelValue: "2018")
        app.toolbars["Toolbar"].buttons["Done"].tap()
        
        tablesQuery/*@START_MENU_TOKEN@*/.textFields["End"]/*[[".cells.textFields[\"End\"]",".textFields[\"End\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.toolbars["Toolbar"].buttons["Done"].tap()
        app.buttons["submitButton"].tap()
        
    }
    
    //Else condition for applyFilter()
    func testApplyFilterForPastVisits() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["More ..."]/*[[".staticTexts.buttons[\"More ...\"]",".buttons[\"More ...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["  Account Visits"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"  Account Visits\"]",".staticTexts[\"  Account Visits\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
        let searchField = app.searchFields["Search"]
        searchField.tap()
        searchField.typeText("cave")
        app/*@START_MENU_TOKEN@*/.buttons["Hide keyboard"]/*[[".keyboards.buttons[\"Hide keyboard\"]",".buttons[\"Hide keyboard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["submitButton"].tap()
        
        let typeTablesQuery = app/*@START_MENU_TOKEN@*/.tables.containing(.other, identifier:"Type")/*[[".tables.containing(.other, identifier:\"Past Visits\")",".tables.containing(.other, identifier:\"Date Range\")",".tables.containing(.other, identifier:\"Type\")"],[[[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        typeTablesQuery.staticTexts["Past Visits"].tap()
        
        let pastVisitsStaticText = app.tables.cells.staticTexts["Past Visits"]
        pastVisitsStaticText.tap()
        app.buttons["submitButton"].tap()
        
        pastVisitsStaticText.tap()
        app.buttons["submitButton"].tap()
        
    }
    
    //Type, date range and status filter applied
    func testTypeDateStatusFilterAdded() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["More ..."]/*[[".staticTexts.buttons[\"More ...\"]",".buttons[\"More ...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["  Account Visits"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"  Account Visits\"]",".staticTexts[\"  Account Visits\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Type"]/*[[".otherElements[\"Type\"].staticTexts[\"Type\"]",".staticTexts[\"Type\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Visit"]/*[[".cells.staticTexts[\"Visit\"]",".staticTexts[\"Visit\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Date Range"]/*[[".otherElements[\"Date Range\"].staticTexts[\"Date Range\"]",".staticTexts[\"Date Range\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["This Week"]/*[[".cells.staticTexts[\"This Week\"]",".staticTexts[\"This Week\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let typeTablesQuery = app/*@START_MENU_TOKEN@*/.tables.containing(.other, identifier:"Type")/*[[".tables.containing(.other, identifier:\"Past Visits\")",".tables.containing(.other, identifier:\"Date Range\")",".tables.containing(.other, identifier:\"Type\")"],[[[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        typeTablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Status"]/*[[".otherElements[\"Status\"].staticTexts[\"Status\"]",".staticTexts[\"Status\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        typeTablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Scheduled"]/*[[".cells.staticTexts[\"Scheduled\"]",".staticTexts[\"Scheduled\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app.buttons["submitButton"].tap()
        
    }
    
    // Record type and status filter added
    func testRecordTypeStatusFilterAdded() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["More ..."]/*[[".staticTexts.buttons[\"More ...\"]",".buttons[\"More ...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["  Account Visits"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"  Account Visits\"]",".staticTexts[\"  Account Visits\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Type"]/*[[".otherElements[\"Type\"].staticTexts[\"Type\"]",".staticTexts[\"Type\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Visit"]/*[[".cells.staticTexts[\"Visit\"]",".staticTexts[\"Visit\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let typeTablesQuery = app/*@START_MENU_TOKEN@*/.tables.containing(.other, identifier:"Type")/*[[".tables.containing(.other, identifier:\"Past Visits\")",".tables.containing(.other, identifier:\"Date Range\")",".tables.containing(.other, identifier:\"Type\")"],[[[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        typeTablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Status"]/*[[".otherElements[\"Status\"].staticTexts[\"Status\"]",".staticTexts[\"Status\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        typeTablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Scheduled"]/*[[".cells.staticTexts[\"Scheduled\"]",".staticTexts[\"Scheduled\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app.buttons["submitButton"].tap()
        
    }
    
    //Record type and date range filter added
    func testRecordTypeDateRangeAdded() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["More ..."]/*[[".staticTexts.buttons[\"More ...\"]",".buttons[\"More ...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["  Account Visits"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"  Account Visits\"]",".staticTexts[\"  Account Visits\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Type"]/*[[".otherElements[\"Type\"].staticTexts[\"Type\"]",".staticTexts[\"Type\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Visit"]/*[[".cells.staticTexts[\"Visit\"]",".staticTexts[\"Visit\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Date Range"]/*[[".otherElements[\"Date Range\"].staticTexts[\"Date Range\"]",".staticTexts[\"Date Range\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["This Week"]/*[[".cells.staticTexts[\"This Week\"]",".staticTexts[\"This Week\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app.buttons["submitButton"].tap()
        
    }
    
    //Date range and status filter added
    func testDateRangeStatusAdded() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["More ..."]/*[[".staticTexts.buttons[\"More ...\"]",".buttons[\"More ...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["  Account Visits"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"  Account Visits\"]",".staticTexts[\"  Account Visits\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Date Range"]/*[[".otherElements[\"Date Range\"].staticTexts[\"Date Range\"]",".staticTexts[\"Date Range\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["This Week"]/*[[".cells.staticTexts[\"This Week\"]",".staticTexts[\"This Week\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let typeTablesQuery = app/*@START_MENU_TOKEN@*/.tables.containing(.other, identifier:"Type")/*[[".tables.containing(.other, identifier:\"Past Visits\")",".tables.containing(.other, identifier:\"Date Range\")",".tables.containing(.other, identifier:\"Type\")"],[[[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        typeTablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Status"]/*[[".otherElements[\"Status\"].staticTexts[\"Status\"]",".staticTexts[\"Status\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        typeTablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Scheduled"]/*[[".cells.staticTexts[\"Scheduled\"]",".staticTexts[\"Scheduled\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app.buttons["submitButton"].tap()
        
    }
    
    func testSortTitle() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["More ..."]/*[[".staticTexts.buttons[\"More ...\"]",".buttons[\"More ...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["  Account Visits"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"  Account Visits\"]",".staticTexts[\"  Account Visits\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
    app.tables.otherElements["Title"].children(matching: .other).element.children(matching: .button).element(boundBy: 0).tap()
    app.tables.otherElements["Title"].children(matching: .other).element.children(matching: .button).element(boundBy: 0).tap()
        
    }
    
    func testSortStatus() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["More ..."]/*[[".staticTexts.buttons[\"More ...\"]",".buttons[\"More ...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["  Account Visits"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"  Account Visits\"]",".staticTexts[\"  Account Visits\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
    app.tables.otherElements["Title"].children(matching: .other).element.children(matching: .button).element(boundBy: 1).tap()
    app.tables.otherElements["Title"].children(matching: .other).element.children(matching: .button).element(boundBy: 1).tap()
        
    }
    
    func testSortDate() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["More ..."]/*[[".staticTexts.buttons[\"More ...\"]",".buttons[\"More ...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["  Account Visits"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"  Account Visits\"]",".staticTexts[\"  Account Visits\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
    app.tables.otherElements["Title"].children(matching: .other).element.children(matching: .button).element(boundBy: 2).tap()
    app.tables.otherElements["Title"].children(matching: .other).element.children(matching: .button).element(boundBy: 2).tap()
        
    }
    
    func testPageControl() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["More ..."]/*[[".staticTexts.buttons[\"More ...\"]",".buttons[\"More ...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["  Account Visits"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"  Account Visits\"]",".staticTexts[\"  Account Visits\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
        app.buttons["1"].tap()
        app.buttons["2"].tap()
        app.buttons["3"].tap()
        app.buttons["4"].tap()
        app.buttons["5"].tap()
        app.buttons[">"].tap()
        //app.buttons["6"].tap()
        //app.buttons["7"].tap()
        app.buttons["Last Page  >"].tap()
        app.buttons["<"].tap()
        app.buttons[">"].tap()
        app.buttons["<   First Page"].tap()
        
    }
    
    func testSearchVisitsSubmitClear() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["More ..."]/*[[".staticTexts.buttons[\"More ...\"]",".buttons[\"More ...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["  Account Visits"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"  Account Visits\"]",".staticTexts[\"  Account Visits\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
        let searchField = app.searchFields["Search"]
        searchField.tap()
        XCUIApplication()/*@START_MENU_TOKEN@*/.buttons["Done"]/*[[".keyboards.buttons[\"Done\"]",".buttons[\"Done\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        searchField.tap()
        searchField.typeText("cave")
        app/*@START_MENU_TOKEN@*/.buttons["Hide keyboard"]/*[[".keyboards.buttons[\"Hide keyboard\"]",".buttons[\"Hide keyboard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app.buttons["submitButton"].tap()
        app.buttons["clearButton"].tap()
        
    }
    
    func testAFiltersInPlanVisit() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["More ..."]/*[[".staticTexts.buttons[\"More ...\"]",".buttons[\"More ...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["  Account Visits"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"  Account Visits\"]",".staticTexts[\"  Account Visits\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Add New  +"].tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["Visit"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"Visit\"]",".staticTexts[\"Visit\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        app.tables/*@START_MENU_TOKEN@*/.textFields["Search by Account Name or ID"]/*[[".cells.textFields[\"Search by Account Name or ID\"]",".textFields[\"Search by Account Name or ID\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCUIApplication().otherElements["drop_down"].tables.staticTexts["Blenders Pride"].tap()
        
        app.tables/*@START_MENU_TOKEN@*/.textFields["MM/DD/YYYY"]/*[[".cells.textFields[\"MM\/DD\/YYYY\"]",".textFields[\"MM\/DD\/YYYY\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.toolbars["Toolbar"].buttons["Done"].tap()
        
        app.tables/*@START_MENU_TOKEN@*/.cells.containing(.textField, identifier:"HH:MM")/*[[".cells.containing(.staticText, identifier:\"Schedule Appointment*\")",".cells.containing(.staticText, identifier:\"End Time\")",".cells.containing(.staticText, identifier:\"Start Time\")",".cells.containing(.staticText, identifier:\"Date of Visit\")",".cells.containing(.textField, identifier:\"HH:MM\")"],[[[-1,4],[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .textField).matching(identifier: "HH:MM").element(boundBy: 0).tap()
        app.toolbars["Toolbar"].buttons["Done"].tap()
        
        XCUIApplication().tables/*@START_MENU_TOKEN@*/.textFields["HH:MM"]/*[[".cells.textFields[\"HH:MM\"]",".textFields[\"HH:MM\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let datePickersQuery = app.datePickers
        datePickersQuery.pickerWheels.element(boundBy: 0).adjust(toPickerWheelValue: "11")
        datePickersQuery.pickerWheels.element(boundBy: 1).adjust(toPickerWheelValue: "00")
        datePickersQuery.pickerWheels.element(boundBy: 2).adjust(toPickerWheelValue: "PM")
        app.toolbars["Toolbar"].buttons["Done"].tap()
        
        let planButton = app.buttons["Plan"]
        planButton.tap()
        
        app.buttons["Product Name"].tap()
        app.buttons["Product Name"].tap()
        app.buttons["Product Name"].tap()
        app.buttons["Source"].tap()
        app.buttons["Source"].tap()
        app.buttons["Source"].tap()
        app.buttons["PYCM Sold"].tap()
        app.buttons["PYCM Sold"].tap()
        app.buttons["Commit"].tap()
        app.buttons["Commit"].tap()
        app.buttons["Sold"].tap()
        app.buttons["Sold"].tap()
        app.buttons["Status"].tap()
        app.buttons["Status"].tap()
        
        app.buttons["Back"].tap()
        planButton.tap()
        XCUIApplication().buttons["Next"].tap()
        
        let collectionViewsQuery = app.collectionViews
        collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts["Point of Sale"]/*[[".cells.staticTexts[\"Point of Sale\"]",".staticTexts[\"Point of Sale\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts["In-Store Promotion"]/*[[".cells.staticTexts[\"In-Store Promotion\"]",".staticTexts[\"In-Store Promotion\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let paymentPickUpStaticText = collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts["Payment Pick-Up"]/*[[".cells.staticTexts[\"Payment Pick-Up\"]",".staticTexts[\"Payment Pick-Up\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        paymentPickUpStaticText.tap()
        paymentPickUpStaticText.tap()
        
        let closebuttonButton = app.buttons["closeButton"]
        closebuttonButton.tap()
        
        let alert = app.alerts["Alert"]
        alert.buttons["No"].tap()
        closebuttonButton.tap()
        alert.buttons["Yes"].tap()
        
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Accounts"]/*[[".staticTexts.buttons[\"Accounts\"]",".buttons[\"Accounts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Blenders Pride"]/*[[".cells.staticTexts[\"Blenders Pride\"]",".staticTexts[\"Blenders Pride\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        //tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Visit Blenders Pride"]/*[[".cells.staticTexts[\"Visit Blenders Pride\"]",".staticTexts[\"Visit Blenders Pride\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app.tables.containing(.other, identifier:"Past Activities").children(matching: .cell).element(boundBy: 2).staticTexts["Visit Blenders Pride"].tap()
        app.tables.containing(.other, identifier:"Location").element.tap()
        
    }
    
    func testBCreateActionItem() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["More ..."]/*[[".staticTexts.buttons[\"More ...\"]",".buttons[\"More ...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["  Account Visits"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"  Account Visits\"]",".staticTexts[\"  Account Visits\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        let searchField = app.searchFields["Search"]
        searchField.tap()
        searchField.typeText("Blender")
        
        app/*@START_MENU_TOKEN@*/.buttons["Hide keyboard"]/*[[".keyboards.buttons[\"Hide keyboard\"]",".buttons[\"Hide keyboard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.buttons["submitButton"]/*[[".buttons[\"Submit\"]",".buttons[\"submitButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app.tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Scheduled")/*[[".cells.containing(.staticText, identifier:\"06:39:PM\")",".cells.containing(.staticText, identifier:\"Scheduled\")"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .staticText).matching(identifier: "Blenders Pride").element(boundBy: 1).tap()
        
        app.buttons["Start Visit"].tap()
        app.buttons["Create Action Item"].tap()
        
    }
    
    func testCFilterVisitDelete() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["More ..."]/*[[".staticTexts.buttons[\"More ...\"]",".buttons[\"More ...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["  Account Visits"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"  Account Visits\"]",".staticTexts[\"  Account Visits\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        let searchField = app.searchFields["Search"]
        searchField.tap()
        searchField.typeText("Blender")
        
        app/*@START_MENU_TOKEN@*/.buttons["Hide keyboard"]/*[[".keyboards.buttons[\"Hide keyboard\"]",".buttons[\"Hide keyboard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.buttons["submitButton"]/*[[".buttons[\"Submit\"]",".buttons[\"submitButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app.tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Scheduled")/*[[".cells.containing(.staticText, identifier:\"06:39:PM\")",".cells.containing(.staticText, identifier:\"Scheduled\")"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .staticText).matching(identifier: "Blenders Pride").element(boundBy: 1).tap()
        app.buttons["    Delete Visit"].tap()
        app.buttons["Delete"].tap()
        sleep(5)
        let swsappParentviewNavigationBar = app.navigationBars["SWSApp.ParentView"]
        swsappParentviewNavigationBar.staticTexts["Online"].tap()
        app.staticTexts["Sync Now"].tap()
        
    }
}
