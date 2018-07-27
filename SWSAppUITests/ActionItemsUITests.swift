//
//  ActionItemsUITests.swift
//  SWSAppUITests
//
//  Created by Krishna, Kamya on 7/26/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import XCTest

class ActionItemsUITests: XCTestCase {
        
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
    
    func testAddAndCloseActionItem() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["More ..."]/*[[".staticTexts.buttons[\"More ...\"]",".buttons[\"More ...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["  Action Items"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"  Action Items\"]",".staticTexts[\"  Action Items\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        XCUIApplication().buttons["Add New +"].tap()
        
        app.buttons["Save & Close"].tap()
        
        let titleField = app.tables/*@START_MENU_TOKEN@*/.textFields["Enter Title"]/*[[".cells.textFields[\"Enter Title\"]",".textFields[\"Enter Title\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        titleField.tap()
        titleField.typeText("Action Item 1")
        XCUIApplication()/*@START_MENU_TOKEN@*/.buttons["Hide keyboard"]/*[[".keyboards.buttons[\"Hide keyboard\"]",".buttons[\"Hide keyboard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app.buttons["Save & Close"].tap()
        
        let closeButton = app.buttons["Close"]
        closeButton.tap()
        app.alerts["Any changes will not be saved"].buttons["No"].tap()
        closeButton.tap()
        app.alerts["Any changes will not be saved"].buttons["Yes"].tap()
        
    }
    
    //Create a new action item
    func testAddNewActionItem() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["More ..."]/*[[".staticTexts.buttons[\"More ...\"]",".buttons[\"More ...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["  Action Items"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"  Action Items\"]",".staticTexts[\"  Action Items\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        XCUIApplication().buttons["Add New +"].tap()
        
        let titleField = app.tables/*@START_MENU_TOKEN@*/.textFields["Enter Title"]/*[[".cells.textFields[\"Enter Title\"]",".textFields[\"Enter Title\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        titleField.tap()
        titleField.typeText("action item 1")
        XCUIApplication()/*@START_MENU_TOKEN@*/.buttons["Hide keyboard"]/*[[".keyboards.buttons[\"Hide keyboard\"]",".buttons[\"Hide keyboard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        XCUIApplication().tables/*@START_MENU_TOKEN@*/.textFields["Search by Account Name or ID"]/*[[".cells.textFields[\"Search by Account Name or ID\"]",".textFields[\"Search by Account Name or ID\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCUIApplication().otherElements["drop_down"].tables/*@START_MENU_TOKEN@*/.staticTexts["Aus Lounge Bar"]/*[[".cells.staticTexts[\"Aus Lounge Bar\"]",".staticTexts[\"Aus Lounge Bar\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let actionItemDescField = app.tables.cells.containing(.staticText, identifier:"Action Item Description*").children(matching: .textView).element
        actionItemDescField.tap()
        actionItemDescField.typeText("Action Item 1 Description")
        XCUIApplication()/*@START_MENU_TOKEN@*/.buttons["Hide keyboard"]/*[[".keyboards.buttons[\"Hide keyboard\"]",".buttons[\"Hide keyboard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app.tables/*@START_MENU_TOKEN@*/.textFields["Select"]/*[[".cells.textFields[\"Select\"]",".textFields[\"Select\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.toolbars["Toolbar"].buttons["Cancel"].tap()
        app.tables/*@START_MENU_TOKEN@*/.textFields["Select"]/*[[".cells.textFields[\"Select\"]",".textFields[\"Select\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.toolbars["Toolbar"].buttons["Done"].tap()
        app.buttons["Save & Close"].tap()
        
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Accounts"]/*[[".staticTexts.buttons[\"Accounts\"]",".buttons[\"Accounts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Aus Lounge Bar"]/*[[".cells.staticTexts[\"Aus Lounge Bar\"]",".staticTexts[\"Aus Lounge Bar\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery.cells.containing(.staticText, identifier:"Today").staticTexts["action item 1"].tap()
        
    }
    
    //Create action item for swipe
    func testAddNewActionItemForSwipe() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["More ..."]/*[[".staticTexts.buttons[\"More ...\"]",".buttons[\"More ...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["  Action Items"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"  Action Items\"]",".staticTexts[\"  Action Items\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        XCUIApplication().buttons["Add New +"].tap()
        
        let titleField = app.tables/*@START_MENU_TOKEN@*/.textFields["Enter Title"]/*[[".cells.textFields[\"Enter Title\"]",".textFields[\"Enter Title\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        titleField.tap()
        titleField.typeText("Swipe me")
        XCUIApplication()/*@START_MENU_TOKEN@*/.buttons["Hide keyboard"]/*[[".keyboards.buttons[\"Hide keyboard\"]",".buttons[\"Hide keyboard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        XCUIApplication().tables/*@START_MENU_TOKEN@*/.textFields["Search by Account Name or ID"]/*[[".cells.textFields[\"Search by Account Name or ID\"]",".textFields[\"Search by Account Name or ID\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCUIApplication().otherElements["drop_down"].tables/*@START_MENU_TOKEN@*/.staticTexts["Aus Lounge Bar"]/*[[".cells.staticTexts[\"Aus Lounge Bar\"]",".staticTexts[\"Aus Lounge Bar\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 1).tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Aus Lounge Bar")/*[[".cells.containing(.staticText, identifier:\"Street #101 California, Indiana 111999\")",".cells.containing(.staticText, identifier:\"ACC111\")",".cells.containing(.staticText, identifier:\"Aus Lounge Bar\")"],[[[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .button).element.tap()
        
        XCUIApplication().tables/*@START_MENU_TOKEN@*/.textFields["Search by Account Name or ID"]/*[[".cells.textFields[\"Search by Account Name or ID\"]",".textFields[\"Search by Account Name or ID\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCUIApplication().otherElements["drop_down"].tables/*@START_MENU_TOKEN@*/.staticTexts["Aus Lounge Bar"]/*[[".cells.staticTexts[\"Aus Lounge Bar\"]",".staticTexts[\"Aus Lounge Bar\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let actionItemDescField = app.tables.cells.containing(.staticText, identifier:"Action Item Description*").children(matching: .textView).element
        actionItemDescField.tap()
        actionItemDescField.typeText("Swipe me Description")
        XCUIApplication()/*@START_MENU_TOKEN@*/.buttons["Hide keyboard"]/*[[".keyboards.buttons[\"Hide keyboard\"]",".buttons[\"Hide keyboard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Save & Close"].tap()
        
    }
    
    func testEditActionItem() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["More ..."]/*[[".staticTexts.buttons[\"More ...\"]",".buttons[\"More ...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["  Action Items"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"  Action Items\"]",".staticTexts[\"  Action Items\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
        let searchActionItemField = app.searchFields["Search"]
        searchActionItemField.tap()
        searchActionItemField.typeText("action")
        XCUIApplication()/*@START_MENU_TOKEN@*/.buttons["Hide keyboard"]/*[[".keyboards.buttons[\"Hide keyboard\"]",".buttons[\"Hide keyboard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["submitButton"].tap()
        XCUIApplication().tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Open")/*[[".cells.containing(.staticText, identifier:\"Aus Lounge Bar\")",".cells.containing(.staticText, identifier:\"Street #101 California, Indiana 111999\")",".cells.containing(.staticText, identifier:\"ACC111\")",".cells.containing(.staticText, identifier:\"Open\")"],[[[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.staticTexts["action item 1"].tap()
        
        app.buttons["Edit"].tap()
        let editedField = app.tables.cells.containing(.staticText, identifier:"Action Item Title*").children(matching: .textField).element
        editedField.tap()
        app/*@START_MENU_TOKEN@*/.keys["delete"]/*[[".keyboards.keys[\"delete\"]",".keys[\"delete\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        editedField.typeText("new")
        XCUIApplication()/*@START_MENU_TOKEN@*/.buttons["Hide keyboard"]/*[[".keyboards.buttons[\"Hide keyboard\"]",".buttons[\"Hide keyboard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Save & Close"].tap()
        
    }
    
    func testEditCloseActionItem() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["More ..."]/*[[".staticTexts.buttons[\"More ...\"]",".buttons[\"More ...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["  Action Items"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"  Action Items\"]",".staticTexts[\"  Action Items\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
        let searchActionItemField = app.searchFields["Search"]
        searchActionItemField.tap()
        searchActionItemField.typeText("action")
        XCUIApplication()/*@START_MENU_TOKEN@*/.buttons["Hide keyboard"]/*[[".keyboards.buttons[\"Hide keyboard\"]",".buttons[\"Hide keyboard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["submitButton"].tap()
        XCUIApplication().tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Open")/*[[".cells.containing(.staticText, identifier:\"Aus Lounge Bar\")",".cells.containing(.staticText, identifier:\"Street #101 California, Indiana 111999\")",".cells.containing(.staticText, identifier:\"ACC111\")",".cells.containing(.staticText, identifier:\"Open\")"],[[[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.staticTexts["action item new"].tap()
        XCUIApplication().buttons["Close"].tap()
        
    }
    
    func testEditCompleteActionItem() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["More ..."]/*[[".staticTexts.buttons[\"More ...\"]",".buttons[\"More ...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["  Action Items"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"  Action Items\"]",".staticTexts[\"  Action Items\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
        let searchActionItemField = app.searchFields["Search"]
        searchActionItemField.tap()
        searchActionItemField.typeText("action")
        XCUIApplication()/*@START_MENU_TOKEN@*/.buttons["Hide keyboard"]/*[[".keyboards.buttons[\"Hide keyboard\"]",".buttons[\"Hide keyboard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["submitButton"].tap()
        XCUIApplication().tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Open")/*[[".cells.containing(.staticText, identifier:\"Aus Lounge Bar\")",".cells.containing(.staticText, identifier:\"Street #101 California, Indiana 111999\")",".cells.containing(.staticText, identifier:\"ACC111\")",".cells.containing(.staticText, identifier:\"Open\")"],[[[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.staticTexts["action item new"].tap()
        app.buttons["Complete"].tap()
        
    }
    
    func testEditOpenActionItem() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["More ..."]/*[[".staticTexts.buttons[\"More ...\"]",".buttons[\"More ...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["  Action Items"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"  Action Items\"]",".staticTexts[\"  Action Items\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
        let searchActionItemField = app.searchFields["Search"]
        searchActionItemField.tap()
        searchActionItemField.typeText("action")
        XCUIApplication()/*@START_MENU_TOKEN@*/.buttons["Hide keyboard"]/*[[".keyboards.buttons[\"Hide keyboard\"]",".buttons[\"Hide keyboard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["submitButton"].tap()
        XCUIApplication().tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Complete")/*[[".cells.containing(.staticText, identifier:\"Aus Lounge Bar\")",".cells.containing(.staticText, identifier:\"Street #101 California, Indiana 111999\")",".cells.containing(.staticText, identifier:\"ACC111\")",".cells.containing(.staticText, identifier:\"Complete\")"],[[[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.staticTexts["action item new"].tap()
        app.buttons["Open"].tap()
        
    }
    
    func testViewInAccountActionItems() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Accounts"]/*[[".staticTexts.buttons[\"Accounts\"]",".buttons[\"Accounts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Aus Lounge Bar"]/*[[".cells.staticTexts[\"Aus Lounge Bar\"]",".staticTexts[\"Aus Lounge Bar\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Action Items"].tap()
        
        let searchActionItemField = app.searchFields["Search"]
        searchActionItemField.tap()
        searchActionItemField.typeText("action")
        app/*@START_MENU_TOKEN@*/.buttons["Hide keyboard"]/*[[".keyboards.buttons[\"Hide keyboard\"]",".buttons[\"Hide keyboard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCUIApplication().scrollViews.otherElements/*@START_MENU_TOKEN@*/.tables.containing(.other, identifier:"Action Item Status").element/*[[".tables.containing(.other, identifier:\"Due Date\").element",".tables.containing(.other, identifier:\"Action Item Type\").element",".tables.containing(.other, identifier:\"Action Item Status\").element"],[[[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeUp()
        
        app.buttons["submitButton"].tap()
        app.tables.cells.containing(.staticText, identifier:"Open").staticTexts["action item new"].tap()
        app.buttons["Close"].tap()
        
    }
    
    func testViewInActivities() {
        
        let app = XCUIApplication()
        app.scrollViews.otherElements.tables/*@START_MENU_TOKEN@*/.staticTexts["action item new"]/*[[".cells.staticTexts[\"action item new\"]",".staticTexts[\"action item new\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Close"].tap()
        
    }
    
    func testXDeleteActionItem() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["More ..."]/*[[".staticTexts.buttons[\"More ...\"]",".buttons[\"More ...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["  Action Items"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"  Action Items\"]",".staticTexts[\"  Action Items\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
        let searchActionItemField = app.searchFields["Search"]
        searchActionItemField.tap()
        searchActionItemField.typeText("action")
        XCUIApplication()/*@START_MENU_TOKEN@*/.buttons["Hide keyboard"]/*[[".keyboards.buttons[\"Hide keyboard\"]",".buttons[\"Hide keyboard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["submitButton"].tap()
        XCUIApplication().tables.cells.containing(.staticText, identifier:"Open").staticTexts["action item new"].tap()
        
        let deleteVisitButton = app.buttons["    Delete"]
        deleteVisitButton.tap()
        app.alerts["Action Item Delete"].buttons["No"].tap()
        deleteVisitButton.tap()
        app.alerts["Action Item Delete"].buttons["Yes"].tap()
        
    }
    
    func testSwipeEdit() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["More ..."]/*[[".staticTexts.buttons[\"More ...\"]",".buttons[\"More ...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["  Action Items"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"  Action Items\"]",".staticTexts[\"  Action Items\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
        let searchActionItemField = app.searchFields["Search"]
        searchActionItemField.tap()
        searchActionItemField.typeText("swipe")
        XCUIApplication()/*@START_MENU_TOKEN@*/.buttons["Hide keyboard"]/*[[".keyboards.buttons[\"Hide keyboard\"]",".buttons[\"Hide keyboard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["submitButton"].tap()
        
        XCUIApplication().tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Open")/*[[".cells.containing(.staticText, identifier:\"Aus Lounge Bar\")",".cells.containing(.staticText, identifier:\"Street #101 California, Indiana 111999\")",".cells.containing(.staticText, identifier:\"ACC111\")",".cells.containing(.staticText, identifier:\"Open\")"],[[[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.staticTexts["Swipe me"].swipeLeft()
        app.tables/*@START_MENU_TOKEN@*/.buttons["Edit"]/*[[".cells.buttons[\"Edit\"]",".buttons[\"Edit\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        XCUIApplication().tables.cells.containing(.staticText, identifier:"Due Date").children(matching: .textField).element.tap()
        let datePickersQuery = app.datePickers
        datePickersQuery.pickerWheels.element(boundBy: 0).adjust(toPickerWheelValue: "April")
        datePickersQuery.pickerWheels.element(boundBy: 1).adjust(toPickerWheelValue: "10")
        datePickersQuery.pickerWheels.element(boundBy: 2).adjust(toPickerWheelValue: "2019")
        app.toolbars["Toolbar"].buttons["Done"].tap()
        
    }
    
    //Change action item status to complete and then open.
    func testSwipeComplete() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["More ..."]/*[[".staticTexts.buttons[\"More ...\"]",".buttons[\"More ...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["  Action Items"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"  Action Items\"]",".staticTexts[\"  Action Items\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
        let searchActionItemField = app.searchFields["Search"]
        searchActionItemField.tap()
        searchActionItemField.typeText("swipe")
        XCUIApplication()/*@START_MENU_TOKEN@*/.buttons["Hide keyboard"]/*[[".keyboards.buttons[\"Hide keyboard\"]",".buttons[\"Hide keyboard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["submitButton"].tap()
        
        XCUIApplication().tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Open")/*[[".cells.containing(.staticText, identifier:\"Aus Lounge Bar\")",".cells.containing(.staticText, identifier:\"Street #101 California, Indiana 111999\")",".cells.containing(.staticText, identifier:\"ACC111\")",".cells.containing(.staticText, identifier:\"Open\")"],[[[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.staticTexts["Swipe me"].swipeLeft()
        app.tables.buttons["Complete"].tap()
        
        XCUIApplication().tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Complete")/*[[".cells.containing(.staticText, identifier:\"Aus Lounge Bar\")",".cells.containing(.staticText, identifier:\"Street #101 California, Indiana 111999\")",".cells.containing(.staticText, identifier:\"ACC111\")",".cells.containing(.staticText, identifier:\"Complete\")"],[[[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.staticTexts["Swipe me"].swipeLeft()
        app.tables.buttons["Open"].tap()
        
    }
    
    func testSwipeXDeleteNoYes() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["More ..."]/*[[".staticTexts.buttons[\"More ...\"]",".buttons[\"More ...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["  Action Items"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"  Action Items\"]",".staticTexts[\"  Action Items\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
        let searchActionItemField = app.searchFields["Search"]
        searchActionItemField.tap()
        searchActionItemField.typeText("swipe")
        XCUIApplication()/*@START_MENU_TOKEN@*/.buttons["Hide keyboard"]/*[[".keyboards.buttons[\"Hide keyboard\"]",".buttons[\"Hide keyboard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["submitButton"].tap()
        
        XCUIApplication().tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Open")/*[[".cells.containing(.staticText, identifier:\"Aus Lounge Bar\")",".cells.containing(.staticText, identifier:\"Street #101 California, Indiana 111999\")",".cells.containing(.staticText, identifier:\"ACC111\")",".cells.containing(.staticText, identifier:\"Open\")"],[[[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.staticTexts["Swipe me"].swipeLeft()
        app.tables/*@START_MENU_TOKEN@*/.buttons["Delete"]/*[[".cells.buttons[\"Delete\"]",".buttons[\"Delete\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.alerts["Action Item Delete"].buttons["No"].tap()
        
        XCUIApplication().tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Open")/*[[".cells.containing(.staticText, identifier:\"Aus Lounge Bar\")",".cells.containing(.staticText, identifier:\"Street #101 California, Indiana 111999\")",".cells.containing(.staticText, identifier:\"ACC111\")",".cells.containing(.staticText, identifier:\"Open\")"],[[[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.staticTexts["Swipe me"].swipeLeft()
        app.tables/*@START_MENU_TOKEN@*/.buttons["Delete"]/*[[".cells.buttons[\"Delete\"]",".buttons[\"Delete\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.alerts["Action Item Delete"].buttons["Yes"].tap()
        
    }
    
    func testYSyncUpActionItems() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["More ..."]/*[[".staticTexts.buttons[\"More ...\"]",".buttons[\"More ...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["  Action Items"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"  Action Items\"]",".staticTexts[\"  Action Items\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
        app.navigationBars["SWSApp.ParentView"].staticTexts["Online"].tap()
        app.staticTexts["Sync Now"].tap()
        
    }
}
