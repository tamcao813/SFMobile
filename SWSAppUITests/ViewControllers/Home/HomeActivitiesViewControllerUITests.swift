//
//  HomeUITests.swift
//  SWSAppUITests
//
//  Created by Krishna, Kamya on 7/26/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import XCTest

class HomeUITests: XCTestCase {
        
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
    
    func testViewAllNotifications() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Home"]/*[[".staticTexts.buttons[\"Home\"]",".buttons[\"Home\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.scrollViews.otherElements.buttons["View All Notifications"].tap()
        
    }
    
    func testViewAllActionItems() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Home"]/*[[".staticTexts.buttons[\"Home\"]",".buttons[\"Home\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.scrollViews.otherElements.buttons["View All Action Items"].tap()
        
    }
    
    func testViewCalendar() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Home"]/*[[".staticTexts.buttons[\"Home\"]",".buttons[\"Home\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.scrollViews.otherElements.buttons["View Calendar"].tap()
        
    }
    
    func testCreateNewCalenderVisit() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Home"]/*[[".staticTexts.buttons[\"Home\"]",".buttons[\"Home\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.scrollViews.otherElements.buttons["Add New"].tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["Visit"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"Visit\"]",".staticTexts[\"Visit\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Close"].tap()
        
    }
    
    func testCreateNewCalendarEvent() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Home"]/*[[".staticTexts.buttons[\"Home\"]",".buttons[\"Home\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.scrollViews.otherElements.buttons["Add New"].tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["Event"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"Event\"]",".staticTexts[\"Event\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
    }
    
    func testCalendarNavigation() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Home"]/*[[".staticTexts.buttons[\"Home\"]",".buttons[\"Home\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let scrollViewsQuery = app.scrollViews
        scrollViewsQuery.otherElements.buttons["  "].tap()
        scrollViewsQuery.children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element.children(matching: .button).element(boundBy: 0).tap()
        
    }
    
    func testLogoBackAndRun() {
        
        let app = XCUIApplication()
        let applogoButton = app.navigationBars["SWSApp.ParentView"].buttons["AppLogo"]
        applogoButton.tap()
        
        let inspectSmartstoreNavigationBar = app.navigationBars["Inspect SmartStore"]
        let backButton = inspectSmartstoreNavigationBar.buttons["Back"]
        backButton.tap()
        applogoButton.tap()
        inspectSmartstoreNavigationBar.buttons["Run"].tap()
        app.alerts["Query failed"].buttons["OK"].tap()
        backButton.tap()
        
    }
    
    func testLogoSoupsAndClear() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"].buttons["AppLogo"].tap()
        app.buttons["Soups"].tap()
        app.alerts["Query failed"].buttons["OK"].tap()
        app.buttons["Clear"].tap()
        
    }
    
    func testLogoIndicesAndClear() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"].buttons["AppLogo"].tap()
        app.buttons["Indices"].tap()
        app.buttons["Clear"].tap()
        app/*@START_MENU_TOKEN@*/.pickerWheels["SFADB (user store)"]/*[[".pickers.pickerWheels[\"SFADB (user store)\"]",".pickerWheels[\"SFADB (user store)\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
    }
    
}
