//
//  NotificationsUITests.swift
//  SWSAppUITests
//
//  Created by Krishna, Kamya on 7/26/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import XCTest

class NotificationsUITests: XCTestCase {
        
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
    
    // Filters in Notification screen
    func testFilterType() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["More ..."]/*[[".staticTexts.buttons[\"More ...\"]",".buttons[\"More ...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["  Notifications"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"  Notifications\"]",".staticTexts[\"  Notifications\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Type"]/*[[".otherElements[\"Type\"].staticTexts[\"Type\"]",".staticTexts[\"Type\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let licenseExpirationStaticText = tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["License Expiration"]/*[[".cells.staticTexts[\"License Expiration\"]",".staticTexts[\"License Expiration\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        licenseExpirationStaticText.tap()
        licenseExpirationStaticText.tap()
        licenseExpirationStaticText.tap()
        
        app.buttons["submitButton"].tap()
        app.buttons["clearButton"].tap()
        
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Type"]/*[[".otherElements[\"Type\"].staticTexts[\"Type\"]",".staticTexts[\"Type\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let contactBirthdayStaticText = tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Contact Birthday"]/*[[".cells.staticTexts[\"Contact Birthday\"]",".staticTexts[\"Contact Birthday\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        contactBirthdayStaticText.tap()
        contactBirthdayStaticText.tap()
        contactBirthdayStaticText.tap()
        
        app.buttons["submitButton"].tap()
        app.buttons["clearButton"].tap()
        
    }
    
    func testFilterStatus() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["More ..."]/*[[".staticTexts.buttons[\"More ...\"]",".buttons[\"More ...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["  Notifications"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"  Notifications\"]",".staticTexts[\"  Notifications\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Status"]/*[[".otherElements[\"Status\"].staticTexts[\"Status\"]",".staticTexts[\"Status\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let readStaticText = tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Read"]/*[[".cells.staticTexts[\"Read\"]",".staticTexts[\"Read\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        readStaticText.tap()
        readStaticText.tap()
        readStaticText.tap()
        
        app.buttons["submitButton"].tap()
        app.buttons["clearButton"].tap()
        
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Status"]/*[[".otherElements[\"Status\"].staticTexts[\"Status\"]",".staticTexts[\"Status\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let unReadStaticText = tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Unread"]/*[[".cells.staticTexts[\"Unread\"]",".staticTexts[\"Unread\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        unReadStaticText.tap()
        unReadStaticText.tap()
        unReadStaticText.tap()
        
        app.buttons["submitButton"].tap()
        app.buttons["clearButton"].tap()
        
    }
    
    func testMultipleFiltersSubmit() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["More ..."]/*[[".staticTexts.buttons[\"More ...\"]",".buttons[\"More ...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["  Notifications"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"  Notifications\"]",".staticTexts[\"  Notifications\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Type"]/*[[".otherElements[\"Type\"].staticTexts[\"Type\"]",".staticTexts[\"Type\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["License Expiration"]/*[[".cells.staticTexts[\"License Expiration\"]",".staticTexts[\"License Expiration\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Contact Birthday"]/*[[".cells.staticTexts[\"Contact Birthday\"]",".staticTexts[\"Contact Birthday\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Status"]/*[[".otherElements[\"Status\"].staticTexts[\"Status\"]",".staticTexts[\"Status\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Unread"]/*[[".cells.staticTexts[\"Unread\"]",".staticTexts[\"Unread\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app.buttons["submitButton"].tap()
        app.buttons["clearButton"].tap()
        
    }
    
    func testSearchNotificationSubmitClear() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["More ..."]/*[[".staticTexts.buttons[\"More ...\"]",".buttons[\"More ...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["  Notifications"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"  Notifications\"]",".staticTexts[\"  Notifications\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
        let searchActionItemField = app.searchFields["Search"]
        searchActionItemField.tap()
        searchActionItemField.typeText("birthday")
        app/*@START_MENU_TOKEN@*/.buttons["Done"]/*[[".keyboards.buttons[\"Done\"]",".buttons[\"Done\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app.buttons["submitButton"].tap()
        app.buttons["clearButton"].tap()
        
    }
    
}
