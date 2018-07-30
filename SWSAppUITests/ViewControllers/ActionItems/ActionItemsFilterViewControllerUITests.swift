//
//  ActionItemsFilterUITests.swift
//  SWSAppUITests
//
//  Created by Krishna, Kamya on 7/26/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import XCTest

class ActionItemsFilterUITests: XCTestCase {
        
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
    
    func testFilterActionItemStatus() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["More ..."]/*[[".staticTexts.buttons[\"More ...\"]",".buttons[\"More ...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["  Action Items"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"  Action Items\"]",".staticTexts[\"  Action Items\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
        let actionItemStatusStaticText = app.tables/*@START_MENU_TOKEN@*/.staticTexts["Action Item Status"]/*[[".otherElements[\"Action Item Status\"].staticTexts[\"Action Item Status\"]",".staticTexts[\"Action Item Status\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        actionItemStatusStaticText.tap()
        actionItemStatusStaticText.tap()
        actionItemStatusStaticText.tap()
        
        app/*@START_MENU_TOKEN@*/.tables.containing(.other, identifier:"Action Item Status").staticTexts["Complete"]/*[[".tables.containing(.other, identifier:\"Due Date\")",".cells.staticTexts[\"Complete\"]",".staticTexts[\"Complete\"]",".tables.containing(.other, identifier:\"Action Item Type\")",".tables.containing(.other, identifier:\"Action Item Status\")"],[[[-1,4,1],[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.containing(.other, identifier:"Action Item Status").staticTexts["Complete"]/*[[".tables.containing(.other, identifier:\"Due Date\")",".cells.staticTexts[\"Complete\"]",".staticTexts[\"Complete\"]",".tables.containing(.other, identifier:\"Action Item Type\")",".tables.containing(.other, identifier:\"Action Item Status\")"],[[[-1,4,1],[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.containing(.other, identifier:"Action Item Status").staticTexts["Complete"]/*[[".tables.containing(.other, identifier:\"Due Date\")",".cells.staticTexts[\"Complete\"]",".staticTexts[\"Complete\"]",".tables.containing(.other, identifier:\"Action Item Type\")",".tables.containing(.other, identifier:\"Action Item Status\")"],[[[-1,4,1],[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
        app.buttons["submitButton"].tap()
        app.buttons["clearButton"].tap()
        
        actionItemStatusStaticText.tap()
        app/*@START_MENU_TOKEN@*/.tables.containing(.other, identifier:"Action Item Status").staticTexts["Open"]/*[[".tables.containing(.other, identifier:\"Due Date\")",".cells.staticTexts[\"Open\"]",".staticTexts[\"Open\"]",".tables.containing(.other, identifier:\"Action Item Type\")",".tables.containing(.other, identifier:\"Action Item Status\")"],[[[-1,4,1],[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.containing(.other, identifier:"Action Item Status").staticTexts["Open"]/*[[".tables.containing(.other, identifier:\"Due Date\")",".cells.staticTexts[\"Open\"]",".staticTexts[\"Open\"]",".tables.containing(.other, identifier:\"Action Item Type\")",".tables.containing(.other, identifier:\"Action Item Status\")"],[[[-1,4,1],[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.containing(.other, identifier:"Action Item Status").staticTexts["Open"]/*[[".tables.containing(.other, identifier:\"Due Date\")",".cells.staticTexts[\"Open\"]",".staticTexts[\"Open\"]",".tables.containing(.other, identifier:\"Action Item Type\")",".tables.containing(.other, identifier:\"Action Item Status\")"],[[[-1,4,1],[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
        app.buttons["submitButton"].tap()
        app.buttons["clearButton"].tap()
        
        actionItemStatusStaticText.tap()
        app/*@START_MENU_TOKEN@*/.tables.containing(.other, identifier:"Action Item Status").staticTexts["Overdue"]/*[[".tables.containing(.other, identifier:\"Due Date\")",".cells.staticTexts[\"Overdue\"]",".staticTexts[\"Overdue\"]",".tables.containing(.other, identifier:\"Action Item Type\")",".tables.containing(.other, identifier:\"Action Item Status\")"],[[[-1,4,1],[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.containing(.other, identifier:"Action Item Status").staticTexts["Overdue"]/*[[".tables.containing(.other, identifier:\"Due Date\")",".cells.staticTexts[\"Overdue\"]",".staticTexts[\"Overdue\"]",".tables.containing(.other, identifier:\"Action Item Type\")",".tables.containing(.other, identifier:\"Action Item Status\")"],[[[-1,4,1],[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.containing(.other, identifier:"Action Item Status").staticTexts["Overdue"]/*[[".tables.containing(.other, identifier:\"Due Date\")",".cells.staticTexts[\"Overdue\"]",".staticTexts[\"Overdue\"]",".tables.containing(.other, identifier:\"Action Item Type\")",".tables.containing(.other, identifier:\"Action Item Status\")"],[[[-1,4,1],[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
        app.buttons["submitButton"].tap()
        app.buttons["clearButton"].tap()
        
    }
    
    func testFilterActionItemType() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["More ..."]/*[[".staticTexts.buttons[\"More ...\"]",".buttons[\"More ...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["  Action Items"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"  Action Items\"]",".staticTexts[\"  Action Items\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Action Item Type"]/*[[".otherElements[\"Action Item Type\"].staticTexts[\"Action Item Type\"]",".staticTexts[\"Action Item Type\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let tablesQuery = XCUIApplication().tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Urgent"]/*[[".cells.staticTexts[\"Urgent\"]",".staticTexts[\"Urgent\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Urgent"]/*[[".cells.staticTexts[\"Urgent\"]",".staticTexts[\"Urgent\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Urgent"]/*[[".cells.staticTexts[\"Urgent\"]",".staticTexts[\"Urgent\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app.buttons["submitButton"].tap()
        app.buttons["clearButton"].tap()
        
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Action Item Type"]/*[[".otherElements[\"Action Item Type\"].staticTexts[\"Action Item Type\"]",".staticTexts[\"Action Item Type\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Not Urgent"]/*[[".cells.staticTexts[\"Not Urgent\"]",".staticTexts[\"Not Urgent\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Not Urgent"]/*[[".cells.staticTexts[\"Not Urgent\"]",".staticTexts[\"Not Urgent\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Not Urgent"]/*[[".cells.staticTexts[\"Not Urgent\"]",".staticTexts[\"Not Urgent\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app.buttons["submitButton"].tap()
        app.buttons["clearButton"].tap()
        
    }
    
    func testFilterActionItemDueDate() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["More ..."]/*[[".staticTexts.buttons[\"More ...\"]",".buttons[\"More ...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["  Action Items"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"  Action Items\"]",".staticTexts[\"  Action Items\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Due Date"]/*[[".otherElements[\"Due Date\"].staticTexts[\"Due Date\"]",".staticTexts[\"Due Date\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Yes"]/*[[".cells.staticTexts[\"Yes\"]",".staticTexts[\"Yes\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Yes"]/*[[".cells.staticTexts[\"Yes\"]",".staticTexts[\"Yes\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Yes"]/*[[".cells.staticTexts[\"Yes\"]",".staticTexts[\"Yes\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app.buttons["submitButton"].tap()
        app.buttons["clearButton"].tap()
        
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Due Date"]/*[[".otherElements[\"Due Date\"].staticTexts[\"Due Date\"]",".staticTexts[\"Due Date\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["No"]/*[[".cells.staticTexts[\"No\"]",".staticTexts[\"No\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["No"]/*[[".cells.staticTexts[\"No\"]",".staticTexts[\"No\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["No"]/*[[".cells.staticTexts[\"No\"]",".staticTexts[\"No\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app.buttons["submitButton"].tap()
        app.buttons["clearButton"].tap()
        
    }
    
    func testSearchActionItemSubmitClear() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["More ..."]/*[[".staticTexts.buttons[\"More ...\"]",".buttons[\"More ...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["  Action Items"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"  Action Items\"]",".staticTexts[\"  Action Items\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
        let searchActionItemField = app.searchFields["Search"]
        searchActionItemField.tap()
        searchActionItemField.typeText("test")
        app/*@START_MENU_TOKEN@*/.buttons["Done"]/*[[".keyboards.buttons[\"Done\"]",".buttons[\"Done\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app.buttons["submitButton"].tap()
        app.buttons["clearButton"].tap()
        
    }
    
    //ActionItemsListViewController - sort by title, due & status
    func testSortTitle() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["More ..."]/*[[".staticTexts.buttons[\"More ...\"]",".buttons[\"More ...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["  Action Items"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"  Action Items\"]",".staticTexts[\"  Action Items\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        app.tables.otherElements.containing(.button, identifier:"Title").children(matching: .button).element(boundBy: 0).tap()
        app.tables.otherElements.containing(.button, identifier:"Title").children(matching: .button).element(boundBy: 0).tap()
        
    }
    
    func testSortDue() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["More ..."]/*[[".staticTexts.buttons[\"More ...\"]",".buttons[\"More ...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["  Action Items"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"  Action Items\"]",".staticTexts[\"  Action Items\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        app.tables.otherElements.containing(.button, identifier:"Due").children(matching: .button).element(boundBy: 0).tap()
        app.tables.otherElements.containing(.button, identifier:"Due").children(matching: .button).element(boundBy: 0).tap()
        
    }
    
    func testSortStatus() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["More ..."]/*[[".staticTexts.buttons[\"More ...\"]",".buttons[\"More ...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["  Action Items"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"  Action Items\"]",".staticTexts[\"  Action Items\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        app.tables.otherElements.containing(.button, identifier:"Status").children(matching: .button).element(boundBy: 0).tap()
        app.tables.otherElements.containing(.button, identifier:"Status").children(matching: .button).element(boundBy: 0).tap()
        
    }
    
    //Test filter combinations
    func testAllFiltersAdded() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["More ..."]/*[[".staticTexts.buttons[\"More ...\"]",".buttons[\"More ...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["  Action Items"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"  Action Items\"]",".staticTexts[\"  Action Items\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
        let actionItemStatusStaticText = app.tables/*@START_MENU_TOKEN@*/.staticTexts["Action Item Status"]/*[[".otherElements[\"Action Item Status\"].staticTexts[\"Action Item Status\"]",".staticTexts[\"Action Item Status\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        actionItemStatusStaticText.tap()
        app/*@START_MENU_TOKEN@*/.tables.containing(.other, identifier:"Action Item Status").staticTexts["Open"]/*[[".tables.containing(.other, identifier:\"Due Date\")",".cells.staticTexts[\"Open\"]",".staticTexts[\"Open\"]",".tables.containing(.other, identifier:\"Action Item Type\")",".tables.containing(.other, identifier:\"Action Item Status\")"],[[[-1,4,1],[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Action Item Type"]/*[[".otherElements[\"Action Item Type\"].staticTexts[\"Action Item Type\"]",".staticTexts[\"Action Item Type\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let tablesQuery = XCUIApplication().tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Urgent"]/*[[".cells.staticTexts[\"Urgent\"]",".staticTexts[\"Urgent\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Due Date"]/*[[".otherElements[\"Due Date\"].staticTexts[\"Due Date\"]",".staticTexts[\"Due Date\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["No"]/*[[".cells.staticTexts[\"No\"]",".staticTexts[\"No\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app.buttons["submitButton"].tap()
        
    }
    
    func testStatusDueFilterAdded() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["More ..."]/*[[".staticTexts.buttons[\"More ...\"]",".buttons[\"More ...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["  Action Items"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"  Action Items\"]",".staticTexts[\"  Action Items\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
        let actionItemStatusStaticText = app.tables/*@START_MENU_TOKEN@*/.staticTexts["Action Item Status"]/*[[".otherElements[\"Action Item Status\"].staticTexts[\"Action Item Status\"]",".staticTexts[\"Action Item Status\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        actionItemStatusStaticText.tap()
        app/*@START_MENU_TOKEN@*/.tables.containing(.other, identifier:"Action Item Status").staticTexts["Open"]/*[[".tables.containing(.other, identifier:\"Due Date\")",".cells.staticTexts[\"Open\"]",".staticTexts[\"Open\"]",".tables.containing(.other, identifier:\"Action Item Type\")",".tables.containing(.other, identifier:\"Action Item Status\")"],[[[-1,4,1],[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
        let tablesQuery = XCUIApplication().tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Due Date"]/*[[".otherElements[\"Due Date\"].staticTexts[\"Due Date\"]",".staticTexts[\"Due Date\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["No"]/*[[".cells.staticTexts[\"No\"]",".staticTexts[\"No\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app.buttons["submitButton"].tap()
        
    }
    
    func testStatusUrgentFilterAdded() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["More ..."]/*[[".staticTexts.buttons[\"More ...\"]",".buttons[\"More ...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["  Action Items"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"  Action Items\"]",".staticTexts[\"  Action Items\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
        let actionItemStatusStaticText = app.tables/*@START_MENU_TOKEN@*/.staticTexts["Action Item Status"]/*[[".otherElements[\"Action Item Status\"].staticTexts[\"Action Item Status\"]",".staticTexts[\"Action Item Status\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        actionItemStatusStaticText.tap()
        app/*@START_MENU_TOKEN@*/.tables.containing(.other, identifier:"Action Item Status").staticTexts["Open"]/*[[".tables.containing(.other, identifier:\"Due Date\")",".cells.staticTexts[\"Open\"]",".staticTexts[\"Open\"]",".tables.containing(.other, identifier:\"Action Item Type\")",".tables.containing(.other, identifier:\"Action Item Status\")"],[[[-1,4,1],[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Action Item Type"]/*[[".otherElements[\"Action Item Type\"].staticTexts[\"Action Item Type\"]",".staticTexts[\"Action Item Type\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let tablesQuery = XCUIApplication().tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Urgent"]/*[[".cells.staticTexts[\"Urgent\"]",".staticTexts[\"Urgent\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app.buttons["submitButton"].tap()
        
    }
    
    func testUrgentDueFilterAdded() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["More ..."]/*[[".staticTexts.buttons[\"More ...\"]",".buttons[\"More ...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["  Action Items"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"  Action Items\"]",".staticTexts[\"  Action Items\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Action Item Type"]/*[[".otherElements[\"Action Item Type\"].staticTexts[\"Action Item Type\"]",".staticTexts[\"Action Item Type\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let tablesQuery = XCUIApplication().tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Urgent"]/*[[".cells.staticTexts[\"Urgent\"]",".staticTexts[\"Urgent\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Due Date"]/*[[".otherElements[\"Due Date\"].staticTexts[\"Due Date\"]",".staticTexts[\"Due Date\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["No"]/*[[".cells.staticTexts[\"No\"]",".staticTexts[\"No\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app.buttons["submitButton"].tap()
        
    }
    
    func testApplyFilterAndSort(){
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["More ..."]/*[[".staticTexts.buttons[\"More ...\"]",".buttons[\"More ...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["  Action Items"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"  Action Items\"]",".staticTexts[\"  Action Items\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
        let actionItemStatusStaticText = app.tables/*@START_MENU_TOKEN@*/.staticTexts["Action Item Status"]/*[[".otherElements[\"Action Item Status\"].staticTexts[\"Action Item Status\"]",".staticTexts[\"Action Item Status\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        actionItemStatusStaticText.tap()
        app/*@START_MENU_TOKEN@*/.tables.containing(.other, identifier:"Action Item Status").staticTexts["Open"]/*[[".tables.containing(.other, identifier:\"Due Date\")",".cells.staticTexts[\"Open\"]",".staticTexts[\"Open\"]",".tables.containing(.other, identifier:\"Action Item Type\")",".tables.containing(.other, identifier:\"Action Item Status\")"],[[[-1,4,1],[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["submitButton"].tap()
        
        app.tables.otherElements.containing(.button, identifier:"Title").children(matching: .button).element(boundBy: 0).tap()
        app.tables.otherElements.containing(.button, identifier:"Title").children(matching: .button).element(boundBy: 0).tap()
        app.tables.otherElements.containing(.button, identifier:"Due").children(matching: .button).element(boundBy: 0).tap()
        app.tables.otherElements.containing(.button, identifier:"Due").children(matching: .button).element(boundBy: 0).tap()
        app.tables.otherElements.containing(.button, identifier:"Status").children(matching: .button).element(boundBy: 0).tap()
        app.tables.otherElements.containing(.button, identifier:"Status").children(matching: .button).element(boundBy: 0).tap()
        
    }
    
}
