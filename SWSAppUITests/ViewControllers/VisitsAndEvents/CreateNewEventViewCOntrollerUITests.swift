//
//  EventsUITests.swift
//  SWSAppUITests
//
//  Created by Krishna, Kamya on 7/26/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import XCTest

class EventsUITests: XCTestCase {
        
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
    
    func test1CreateCloseEvent() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["More ..."]/*[[".staticTexts.buttons[\"More ...\"]",".buttons[\"More ...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["  Account Visits"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"  Account Visits\"]",".staticTexts[\"  Account Visits\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Add New  +"].tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["Event"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"Event\"]",".staticTexts[\"Event\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
        let closeButton = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .button)["Close"]
        closeButton.tap()
        
    }
    
    //Create and save new event with all the mandatory fields validation
    func test2CreateSaveEventWithValidation() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["More ..."]/*[[".staticTexts.buttons[\"More ...\"]",".buttons[\"More ...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["  Account Visits"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"  Account Visits\"]",".staticTexts[\"  Account Visits\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Add New  +"].tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["Event"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"Event\"]",".staticTexts[\"Event\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
        app.swipeUp()
        
        let tablesQuery = XCUIApplication().tables
        tablesQuery.buttons["Save"].tap()
        let enterTitleField = tablesQuery/*@START_MENU_TOKEN@*/.textFields["Enter Title"]/*[[".cells.textFields[\"Enter Title\"]",".textFields[\"Enter Title\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        enterTitleField.tap()
        enterTitleField.typeText("event1")
        app/*@START_MENU_TOKEN@*/.buttons["Hide keyboard"]/*[[".keyboards.buttons[\"Hide keyboard\"]",".buttons[\"Hide keyboard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables.buttons["Save"].tap()
        
        app.tables/*@START_MENU_TOKEN@*/.cells.containing(.textField, identifier:"Select")/*[[".cells.containing(.staticText, identifier:\"End*\")",".cells.containing(.staticText, identifier:\"Start*\")",".cells.containing(.button, identifier:\"All Day Event\")",".cells.containing(.textField, identifier:\"Select\")"],[[[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .textField).matching(identifier: "Select").element(boundBy: 0).tap()
        app.toolbars["Toolbar"].buttons["Done"].tap()
        XCUIApplication().tables.buttons["Save"].tap()
        
        app.tables/*@START_MENU_TOKEN@*/.cells.containing(.textField, identifier:"Select")/*[[".cells.containing(.staticText, identifier:\"End*\")",".cells.containing(.staticText, identifier:\"Start*\")",".cells.containing(.button, identifier:\"All Day Event\")",".cells.containing(.textField, identifier:\"Select\")"],[[[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .textField).matching(identifier: "Select").element(boundBy: 0).tap()
        app.toolbars["Toolbar"].buttons["Done"].tap()
        XCUIApplication().tables.buttons["Save"].tap()
        
        XCUIApplication().tables/*@START_MENU_TOKEN@*/.cells.containing(.textField, identifier:"Select")/*[[".cells.containing(.staticText, identifier:\"End*\")",".cells.containing(.staticText, identifier:\"Start*\")",".cells.containing(.button, identifier:\"All Day Event\")",".cells.containing(.textField, identifier:\"Select\")"],[[[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .textField).matching(identifier: "Select").element(boundBy: 0).tap()
        XCUIApplication().toolbars["Toolbar"].buttons["Done"].tap()
        XCUIApplication().tables.buttons["Save"].tap()
        
        XCUIApplication().tables/*@START_MENU_TOKEN@*/.textFields["Select"]/*[[".cells.textFields[\"Select\"]",".textFields[\"Select\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let datePickersQuery = app.datePickers
        datePickersQuery.pickerWheels.element(boundBy: 0).adjust(toPickerWheelValue: "11")
        datePickersQuery.pickerWheels.element(boundBy: 1).adjust(toPickerWheelValue: "30")
        datePickersQuery.pickerWheels.element(boundBy: 2).adjust(toPickerWheelValue: "PM")
        XCUIApplication().toolbars["Toolbar"].buttons["Done"].tap()
        XCUIApplication().tables.buttons["Save"].tap()
        
        let searchAccountField =  app.tables/*@START_MENU_TOKEN@*/.textFields["Search by Account Name or ID"]/*[[".cells.textFields[\"Search by Account Name or ID\"]",".textFields[\"Search by Account Name or ID\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        searchAccountField.tap()
        searchAccountField.typeText("Aus")
        XCUIApplication().otherElements["drop_down"].tables/*@START_MENU_TOKEN@*/.staticTexts["Aus Lounge Bar"]/*[[".cells.staticTexts[\"Aus Lounge Bar\"]",".staticTexts[\"Aus Lounge Bar\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCUIApplication().tables.buttons["Save"].tap()
        
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Accounts"]/*[[".staticTexts.buttons[\"Accounts\"]",".buttons[\"Accounts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Clear"].tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Aus Lounge Bar"]/*[[".cells.staticTexts[\"Aus Lounge Bar\"]",".staticTexts[\"Aus Lounge Bar\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["event1"]/*[[".cells.staticTexts[\"event1\"]",".staticTexts[\"event1\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
    }
    
    func test3ViewEventInHomeCalendar() {
        
        let app = XCUIApplication()
        let collectionViewsQuery = app.scrollViews.otherElements.collectionViews
        collectionViewsQuery.cells.otherElements.containing(.staticText, identifier:"event1").element.swipeUp()
        collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts["event1"]/*[[".cells.staticTexts[\"event1\"]",".staticTexts[\"event1\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Close"].tap()
        
    }
    
    func test4CloseEventSelected() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["More ..."]/*[[".staticTexts.buttons[\"More ...\"]",".buttons[\"More ...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["  Account Visits"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"  Account Visits\"]",".staticTexts[\"  Account Visits\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
        let searchField = app.searchFields["Search"]
        searchField.tap()
        searchField.typeText("event1")
        XCUIApplication()/*@START_MENU_TOKEN@*/.buttons["Hide keyboard"]/*[[".keyboards.buttons[\"Hide keyboard\"]",".buttons[\"Hide keyboard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["submitButton"].tap()
        
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["event1"]/*[[".cells.staticTexts[\"event1\"]",".staticTexts[\"event1\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Close"].tap()
        
    }
    
    func testEditEventAndClose() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["More ..."]/*[[".staticTexts.buttons[\"More ...\"]",".buttons[\"More ...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["  Account Visits"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"  Account Visits\"]",".staticTexts[\"  Account Visits\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
        let searchField = app.searchFields["Search"]
        searchField.tap()
        searchField.typeText("event1")
        XCUIApplication()/*@START_MENU_TOKEN@*/.buttons["Hide keyboard"]/*[[".keyboards.buttons[\"Hide keyboard\"]",".buttons[\"Hide keyboard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["submitButton"].tap()
        
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["event1"]/*[[".cells.staticTexts[\"event1\"]",".staticTexts[\"event1\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app.buttons["Edit Event"].tap()
        //        app.tables.containing(.button, identifier:"Save")/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Aus Lounge Bar")/*[[".cells.containing(.staticText, identifier:\"Street #101 California, Indiana 111999\")",".cells.containing(.staticText, identifier:\"ACC111\")",".cells.containing(.staticText, identifier:\"Aus Lounge Bar\")"],[[[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.buttons["Close"].tap()
        //
        //        let searchAccountField =  app.tables/*@START_MENU_TOKEN@*/.textFields["Search by Account Name or ID"]/*[[".cells.textFields[\"Search by Account Name or ID\"]",".textFields[\"Search by Account Name or ID\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        //        searchAccountField.tap()
        //        searchAccountField.typeText("Fost")
        //        XCUIApplication().otherElements["drop_down"].tables/*@START_MENU_TOKEN@*/.staticTexts["Fosters Beer Parlour"]/*[[".cells.staticTexts[\"Fosters Beer Parlour\"]",".staticTexts[\"Fosters Beer Parlour\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCUIApplication().tables/*@START_MENU_TOKEN@*/.buttons["All Day Event"]/*[[".cells.buttons[\"All Day Event\"]",".buttons[\"All Day Event\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let searchContactField = app.tables/*@START_MENU_TOKEN@*/.textFields["Search for Contacts"]/*[[".cells.textFields[\"Search for Contacts\"]",".textFields[\"Search for Contacts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        searchContactField.tap()
        searchContactField.typeText("cook")
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["Thomas Cook"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"Thomas Cook\"]",".staticTexts[\"Thomas Cook\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
        XCUIApplication().children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 2).children(matching: .other).element.children(matching: .button)["Close"].tap()
        app.alerts["Any changes will not be saved"].buttons["No"].tap()
        XCUIApplication().children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 2).children(matching: .other).element.children(matching: .button)["Close"].tap()
        app.alerts["Any changes will not be saved"].buttons["Yes"].tap()
        
    }
    
    func testEditEventAndSave() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["More ..."]/*[[".staticTexts.buttons[\"More ...\"]",".buttons[\"More ...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["  Account Visits"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"  Account Visits\"]",".staticTexts[\"  Account Visits\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
        let searchField = app.searchFields["Search"]
        searchField.tap()
        searchField.typeText("event1")
        XCUIApplication()/*@START_MENU_TOKEN@*/.buttons["Hide keyboard"]/*[[".keyboards.buttons[\"Hide keyboard\"]",".buttons[\"Hide keyboard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["submitButton"].tap()
        
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["event1"]/*[[".cells.staticTexts[\"event1\"]",".staticTexts[\"event1\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app.buttons["Edit Event"].tap()
        //        app.tables.containing(.button, identifier:"Save")/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Aus Lounge Bar")/*[[".cells.containing(.staticText, identifier:\"Street #101 California, Indiana 111999\")",".cells.containing(.staticText, identifier:\"ACC111\")",".cells.containing(.staticText, identifier:\"Aus Lounge Bar\")"],[[[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.buttons["Close"].tap()
        //
        //        let searchAccountField =  app.tables/*@START_MENU_TOKEN@*/.textFields["Search by Account Name or ID"]/*[[".cells.textFields[\"Search by Account Name or ID\"]",".textFields[\"Search by Account Name or ID\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        //        searchAccountField.tap()
        //        searchAccountField.typeText("Fost")
        //        XCUIApplication().otherElements["drop_down"].tables/*@START_MENU_TOKEN@*/.staticTexts["Fosters Beer Parlour"]/*[[".cells.staticTexts[\"Fosters Beer Parlour\"]",".staticTexts[\"Fosters Beer Parlour\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCUIApplication().tables/*@START_MENU_TOKEN@*/.buttons["All Day Event"]/*[[".cells.buttons[\"All Day Event\"]",".buttons[\"All Day Event\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        //XCUIApplication().tables.containing(.button, identifier:"Save")/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"adam gilly")/*[[".cells.containing(.staticText, identifier:\"aa\")",".cells.containing(.staticText, identifier:\"adam.gilly@xyz.com\")",".cells.containing(.staticText, identifier:\"Email\")",".cells.containing(.staticText, identifier:\"Phone\")",".cells.containing(.staticText, identifier:\"adam gilly\")"],[[[-1,4],[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.buttons["Close"].tap()
        let searchContactField = app.tables/*@START_MENU_TOKEN@*/.textFields["Search for Contacts"]/*[[".cells.textFields[\"Search for Contacts\"]",".textFields[\"Search for Contacts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        searchContactField.tap()
        searchContactField.typeText("cook")
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["Thomas Cook"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"Thomas Cook\"]",".staticTexts[\"Thomas Cook\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
        let locationField = app.tables/*@START_MENU_TOKEN@*/.textFields["Enter Location"]/*[[".cells.textFields[\"Enter Location\"]",".textFields[\"Enter Location\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        locationField.tap()
        locationField.typeText("USA")
        XCUIApplication()/*@START_MENU_TOKEN@*/.buttons["Hide keyboard"]/*[[".keyboards.buttons[\"Hide keyboard\"]",".buttons[\"Hide keyboard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let eventDescField = XCUIApplication().tables.cells.containing(.staticText, identifier:"Event Description").children(matching: .textView).element
        eventDescField.tap()
        eventDescField.typeText("Event edited")
        XCUIApplication()/*@START_MENU_TOKEN@*/.buttons["Hide keyboard"]/*[[".keyboards.buttons[\"Hide keyboard\"]",".buttons[\"Hide keyboard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCUIApplication().tables.buttons["Save"].tap()
        XCUIApplication().children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .button).element.tap()
        
        app.navigationBars["SWSApp.ParentView"].staticTexts["Online"].tap()
        app.staticTexts["Sync Now"].tap()
        sleep(10)
        
    }
    
    //Test navigation from event screen to account details
    func testNavigateToAccountDetails() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["More ..."]/*[[".staticTexts.buttons[\"More ...\"]",".buttons[\"More ...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["  Account Visits"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"  Account Visits\"]",".staticTexts[\"  Account Visits\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
        let searchField = app.searchFields["Search"]
        searchField.tap()
        searchField.typeText("event1")
        XCUIApplication()/*@START_MENU_TOKEN@*/.buttons["Hide keyboard"]/*[[".keyboards.buttons[\"Hide keyboard\"]",".buttons[\"Hide keyboard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["submitButton"].tap()
        
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["event1"]/*[[".cells.staticTexts[\"event1\"]",".staticTexts[\"event1\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        //XCUIApplication()/*@START_MENU_TOKEN@*/.tables.containing(.other, identifier:"event1").cells.containing(.staticText, identifier:"Fosters Beer Parlour")/*[[".tables.containing(.other, identifier:\"Contact\")",".cells.containing(.staticText, identifier:\"Foster Street Florida, Florida AP 666555\")",".cells.containing(.staticText, identifier:\"FSTR9923\")",".cells.containing(.staticText, identifier:\"Fosters Beer Parlour\")",".tables.containing(.other, identifier:\"Location\")",".tables.containing(.other, identifier:\"Account\")",".tables.containing(.other, identifier:\"event1\")"],[[[-1,6,1],[-1,5,1],[-1,4,1],[-1,0,1]],[[-1,3],[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.children(matching: .button).element.tap()
        
        app/*@START_MENU_TOKEN@*/.tables.containing(.other, identifier:"event1").cells.containing(.staticText, identifier:"Aus Lounge Bar")/*[[".tables.containing(.other, identifier:\"Contact\")",".cells.containing(.staticText, identifier:\"Street #101 California, Indiana 111999\")",".cells.containing(.staticText, identifier:\"ACC111\")",".cells.containing(.staticText, identifier:\"Aus Lounge Bar\")",".tables.containing(.other, identifier:\"Location\")",".tables.containing(.other, identifier:\"Account\")",".tables.containing(.other, identifier:\"event1\")"],[[[-1,6,1],[-1,5,1],[-1,4,1],[-1,0,1]],[[-1,3],[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.children(matching: .button).element.tap()
        app.buttons["Details"].tap()
        
    }
    
    //Test navigation from event screen to contact details screen
    func testNavigateToContactDetails() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["More ..."]/*[[".staticTexts.buttons[\"More ...\"]",".buttons[\"More ...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["  Account Visits"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"  Account Visits\"]",".staticTexts[\"  Account Visits\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
        let searchField = app.searchFields["Search"]
        searchField.tap()
        searchField.typeText("event1")
        XCUIApplication()/*@START_MENU_TOKEN@*/.buttons["Hide keyboard"]/*[[".keyboards.buttons[\"Hide keyboard\"]",".buttons[\"Hide keyboard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["submitButton"].tap()
        
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["event1"]/*[[".cells.staticTexts[\"event1\"]",".staticTexts[\"event1\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["Thomas Cook"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"Thomas Cook\"]",".staticTexts[\"Thomas Cook\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
    }
    
    func testXDeleteEvent() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["More ..."]/*[[".staticTexts.buttons[\"More ...\"]",".buttons[\"More ...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["  Account Visits"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"  Account Visits\"]",".staticTexts[\"  Account Visits\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
        let searchField = app.searchFields["Search"]
        searchField.tap()
        searchField.typeText("event1")
        XCUIApplication()/*@START_MENU_TOKEN@*/.buttons["Hide keyboard"]/*[[".keyboards.buttons[\"Hide keyboard\"]",".buttons[\"Hide keyboard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["submitButton"].tap()
        
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["event1"]/*[[".cells.staticTexts[\"event1\"]",".staticTexts[\"event1\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let deleteButton = XCUIApplication().buttons["    Delete Event"]
        deleteButton.tap()
        app.alerts["Event Delete"].buttons["Cancel"].tap()
        deleteButton.tap()
        app.alerts["Event Delete"].buttons["Delete"].tap()
        sleep(10)
        
    }
    
    func testTimeAlert() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["More ..."]/*[[".staticTexts.buttons[\"More ...\"]",".buttons[\"More ...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["  Account Visits"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"  Account Visits\"]",".staticTexts[\"  Account Visits\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Add New  +"].tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["Event"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"Event\"]",".staticTexts[\"Event\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
        app.tables/*@START_MENU_TOKEN@*/.cells.containing(.textField, identifier:"Select")/*[[".cells.containing(.staticText, identifier:\"End*\")",".cells.containing(.staticText, identifier:\"Start*\")",".cells.containing(.button, identifier:\"All Day Event\")",".cells.containing(.textField, identifier:\"Select\")"],[[[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .textField).matching(identifier: "Select").element(boundBy: 0).tap()
        app.toolbars["Toolbar"].buttons["Done"].tap()
        
        app.tables/*@START_MENU_TOKEN@*/.cells.containing(.textField, identifier:"Select")/*[[".cells.containing(.staticText, identifier:\"End*\")",".cells.containing(.staticText, identifier:\"Start*\")",".cells.containing(.button, identifier:\"All Day Event\")",".cells.containing(.textField, identifier:\"Select\")"],[[[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .textField).matching(identifier: "Select").element(boundBy: 0).tap()
        app.toolbars["Toolbar"].buttons["Done"].tap()
        
        app.tables/*@START_MENU_TOKEN@*/.cells.containing(.textField, identifier:"Select")/*[[".cells.containing(.staticText, identifier:\"End*\")",".cells.containing(.staticText, identifier:\"Start*\")",".cells.containing(.button, identifier:\"All Day Event\")",".cells.containing(.textField, identifier:\"Select\")"],[[[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .textField).matching(identifier: "Select").element(boundBy: 0).tap()
        app.toolbars["Toolbar"].buttons["Done"].tap()
        
        app.tables/*@START_MENU_TOKEN@*/.textFields["Select"]/*[[".cells.textFields[\"Select\"]",".textFields[\"Select\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.toolbars["Toolbar"].buttons["Done"].tap()
        
        XCUIApplication().alerts["Alert"].buttons["OK"].tap()
        
        XCUIApplication().tables/*@START_MENU_TOKEN@*/.cells.containing(.textField, identifier:"Select")/*[[".cells.containing(.staticText, identifier:\"End*\")",".cells.containing(.staticText, identifier:\"Start*\")",".cells.containing(.button, identifier:\"All Day Event\")",".cells.containing(.textField, identifier:\"Select\")"],[[[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .textField).element(boundBy: 0).tap()
        let datePickersQuery = app.datePickers
        datePickersQuery.pickerWheels.element(boundBy: 0).adjust(toPickerWheelValue: "August")
        datePickersQuery.pickerWheels.element(boundBy: 1).adjust(toPickerWheelValue: "10")
        datePickersQuery.pickerWheels.element(boundBy: 2).adjust(toPickerWheelValue: "2018")
        app.toolbars["Toolbar"].buttons["Done"].tap()
        
        XCUIApplication().alerts["Alert"].buttons["OK"].tap()
        
    }
    
    //Start picker and allDayEvent button action
    func testStartDatePicker() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Accounts"]/*[[".staticTexts.buttons[\"Accounts\"]",".buttons[\"Accounts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["#KALAPAKI JOE'S BILL TO#"]/*[[".cells.staticTexts[\"#KALAPAKI JOE'S BILL TO#\"]",".staticTexts[\"#KALAPAKI JOE'S BILL TO#\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Add New  +"].tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["Event"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"Event\"]",".staticTexts[\"Event\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
        let tablesQuery = app.tables
        let allDayEventButton = tablesQuery/*@START_MENU_TOKEN@*/.buttons["All Day Event"]/*[[".cells.buttons[\"All Day Event\"]",".buttons[\"All Day Event\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        allDayEventButton.tap()
        
        app.tables/*@START_MENU_TOKEN@*/.cells.containing(.textField, identifier:"Select")/*[[".cells.containing(.staticText, identifier:\"End*\")",".cells.containing(.staticText, identifier:\"Start*\")",".cells.containing(.button, identifier:\"All Day Event\")",".cells.containing(.textField, identifier:\"Select\")"],[[[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .textField).matching(identifier: "Select").element(boundBy: 0).tap()
        app.toolbars["Toolbar"].buttons["Cancel"].tap()
        
        app.tables/*@START_MENU_TOKEN@*/.cells.containing(.textField, identifier:"Select")/*[[".cells.containing(.staticText, identifier:\"End*\")",".cells.containing(.staticText, identifier:\"Start*\")",".cells.containing(.button, identifier:\"All Day Event\")",".cells.containing(.textField, identifier:\"Select\")"],[[[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .textField).matching(identifier: "Select").element(boundBy: 0).tap()
        app.toolbars["Toolbar"].buttons["Done"].tap()
        
        allDayEventButton.tap()
        allDayEventButton.tap()
        
    }
    
    func testEndDatePicker() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Accounts"]/*[[".staticTexts.buttons[\"Accounts\"]",".buttons[\"Accounts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["#KALAPAKI JOE'S BILL TO#"]/*[[".cells.staticTexts[\"#KALAPAKI JOE'S BILL TO#\"]",".staticTexts[\"#KALAPAKI JOE'S BILL TO#\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Add New  +"].tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["Event"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"Event\"]",".staticTexts[\"Event\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
        app.tables/*@START_MENU_TOKEN@*/.cells.containing(.textField, identifier:"Select")/*[[".cells.containing(.staticText, identifier:\"End*\")",".cells.containing(.staticText, identifier:\"Start*\")",".cells.containing(.button, identifier:\"All Day Event\")",".cells.containing(.textField, identifier:\"Select\")"],[[[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .textField).matching(identifier: "Select").element(boundBy: 1).tap()
        app.toolbars["Toolbar"].buttons["Cancel"].tap()
        
        app.tables/*@START_MENU_TOKEN@*/.cells.containing(.textField, identifier:"Select")/*[[".cells.containing(.staticText, identifier:\"End*\")",".cells.containing(.staticText, identifier:\"Start*\")",".cells.containing(.button, identifier:\"All Day Event\")",".cells.containing(.textField, identifier:\"Select\")"],[[[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .textField).matching(identifier: "Select").element(boundBy: 1).tap()
        app.toolbars["Toolbar"].buttons["Done"].tap()
        
    }
    
    func testStartTimePicker() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Accounts"]/*[[".staticTexts.buttons[\"Accounts\"]",".buttons[\"Accounts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["#KALAPAKI JOE'S BILL TO#"]/*[[".cells.staticTexts[\"#KALAPAKI JOE'S BILL TO#\"]",".staticTexts[\"#KALAPAKI JOE'S BILL TO#\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Add New  +"].tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["Event"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"Event\"]",".staticTexts[\"Event\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
        app.tables/*@START_MENU_TOKEN@*/.cells.containing(.textField, identifier:"Select")/*[[".cells.containing(.staticText, identifier:\"End*\")",".cells.containing(.staticText, identifier:\"Start*\")",".cells.containing(.button, identifier:\"All Day Event\")",".cells.containing(.textField, identifier:\"Select\")"],[[[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .textField).matching(identifier: "Select").element(boundBy: 0).tap()
        app.toolbars["Toolbar"].buttons["Cancel"].tap()
        
        app.tables/*@START_MENU_TOKEN@*/.cells.containing(.textField, identifier:"Select")/*[[".cells.containing(.staticText, identifier:\"End*\")",".cells.containing(.staticText, identifier:\"Start*\")",".cells.containing(.button, identifier:\"All Day Event\")",".cells.containing(.textField, identifier:\"Select\")"],[[[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .textField).matching(identifier: "Select").element(boundBy: 0).tap()
        app.toolbars["Toolbar"].buttons["Done"].tap()
        
    }
    
    func testEndTimePicker() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Accounts"]/*[[".staticTexts.buttons[\"Accounts\"]",".buttons[\"Accounts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["#KALAPAKI JOE'S BILL TO#"]/*[[".cells.staticTexts[\"#KALAPAKI JOE'S BILL TO#\"]",".staticTexts[\"#KALAPAKI JOE'S BILL TO#\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Add New  +"].tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["Event"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"Event\"]",".staticTexts[\"Event\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
        app.tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Start*")/*[[".cells.containing(.button, identifier:\"All Day Event\")",".cells.containing(.staticText, identifier:\"End*\")",".cells.containing(.textField, identifier:\"Select\")",".cells.containing(.staticText, identifier:\"Start*\")"],[[[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .textField).matching(identifier: "Select").element(boundBy: 2).tap()
        app.toolbars["Toolbar"].buttons["Cancel"].tap()
        
        app.tables/*@START_MENU_TOKEN@*/.cells.containing(.textField, identifier:"Select")/*[[".cells.containing(.staticText, identifier:\"End*\")",".cells.containing(.staticText, identifier:\"Start*\")",".cells.containing(.button, identifier:\"All Day Event\")",".cells.containing(.textField, identifier:\"Select\")"],[[[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .textField).matching(identifier: "Select").element(boundBy: 2).tap()
        app.toolbars["Toolbar"].buttons["Done"].tap()
        
    }
    
}
