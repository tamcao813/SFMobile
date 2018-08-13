//
//  OpportunitiesMenuViewControllerUITests.swift
//  SWSAppUITests
//
//  Created by Krishna, Kamya on 7/30/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import XCTest

class OpportunitiesMenuViewControllerUITests: XCTestCase {
        
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
    
    func testFilterViewBy9LCase() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Accounts"]/*[[".staticTexts.buttons[\"Accounts\"]",".buttons[\"Accounts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["#KALAPAKI JOE'S BILL TO#"]/*[[".cells.staticTexts[\"#KALAPAKI JOE'S BILL TO#\"]",".staticTexts[\"#KALAPAKI JOE'S BILL TO#\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Opportunities"].tap()
        
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["View By"]/*[[".otherElements[\"View By\"].staticTexts[\"View By\"]",".staticTexts[\"View By\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["View By"]/*[[".otherElements[\"View By\"].staticTexts[\"View By\"]",".staticTexts[\"View By\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["9L Case"]/*[[".cells.staticTexts[\"9L Case\"]",".staticTexts[\"9L Case\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["9L Case"]/*[[".cells.staticTexts[\"9L Case\"]",".staticTexts[\"9L Case\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["9L Case"]/*[[".cells.staticTexts[\"9L Case\"]",".staticTexts[\"9L Case\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["View By"]/*[[".otherElements[\"View By\"].staticTexts[\"View By\"]",".staticTexts[\"View By\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCUIApplication().scrollViews.otherElements/*@START_MENU_TOKEN@*/.tables.containing(.other, identifier:"View By").element/*[[".tables.containing(.other, identifier:\"Objective\").element",".tables.containing(.other, identifier:\"Source\").element",".tables.containing(.other, identifier:\"Status\").element",".tables.containing(.other, identifier:\"View By\").element"],[[[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeUp()
        
        app.buttons["submitButton"].tap()
        app.buttons["clearButton"].tap()
        
    }
    
    func testFilterViewByCaseDecimal() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Accounts"]/*[[".staticTexts.buttons[\"Accounts\"]",".buttons[\"Accounts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let tablesQuery = app.tables
        app.buttons["Clear"].tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Blenders Pride"]/*[[".cells.staticTexts[\"Blenders Pride\"]",".staticTexts[\"Blenders Pride\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Opportunities"].tap()
        
        let caseDecimalStaticText = XCUIApplication().tables/*@START_MENU_TOKEN@*/.staticTexts["Case Decimal"]/*[[".cells.staticTexts[\"Case Decimal\"]",".staticTexts[\"Case Decimal\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        caseDecimalStaticText.tap()
        caseDecimalStaticText.tap()
        
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["View By"]/*[[".otherElements[\"View By\"].staticTexts[\"View By\"]",".staticTexts[\"View By\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCUIApplication().scrollViews.otherElements/*@START_MENU_TOKEN@*/.tables.containing(.other, identifier:"View By").element/*[[".tables.containing(.other, identifier:\"Objective\").element",".tables.containing(.other, identifier:\"Source\").element",".tables.containing(.other, identifier:\"Status\").element",".tables.containing(.other, identifier:\"View By\").element"],[[[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeUp()
        
        app.buttons["submitButton"].tap()
        app.buttons["clearButton"].tap()
        
    }
    
    func testFilterStatus() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Accounts"]/*[[".staticTexts.buttons[\"Accounts\"]",".buttons[\"Accounts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let tablesQuery = app.tables
        app.buttons["Clear"].tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Blenders Pride"]/*[[".cells.staticTexts[\"Blenders Pride\"]",".staticTexts[\"Blenders Pride\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Opportunities"].tap()
        
        app/*@START_MENU_TOKEN@*/.tables.containing(.other, identifier:"View By").staticTexts["Status"]/*[[".tables.containing(.other, identifier:\"Objective\")",".otherElements[\"Status\"].staticTexts[\"Status\"]",".staticTexts[\"Status\"]",".tables.containing(.other, identifier:\"Source\")",".tables.containing(.other, identifier:\"View By\")"],[[[-1,4,1],[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Closed"]/*[[".cells.staticTexts[\"Closed\"]",".staticTexts[\"Closed\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Closed"]/*[[".cells.staticTexts[\"Closed\"]",".staticTexts[\"Closed\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Closed"]/*[[".cells.staticTexts[\"Closed\"]",".staticTexts[\"Closed\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app/*@START_MENU_TOKEN@*/.tables.containing(.other, identifier:"View By").staticTexts["Status"]/*[[".tables.containing(.other, identifier:\"Objective\")",".otherElements[\"Status\"].staticTexts[\"Status\"]",".staticTexts[\"Status\"]",".tables.containing(.other, identifier:\"Source\")",".tables.containing(.other, identifier:\"View By\")"],[[[-1,4,1],[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        XCUIApplication().scrollViews.otherElements/*@START_MENU_TOKEN@*/.tables.containing(.other, identifier:"View By").element/*[[".tables.containing(.other, identifier:\"Objective\").element",".tables.containing(.other, identifier:\"Source\").element",".tables.containing(.other, identifier:\"Status\").element",".tables.containing(.other, identifier:\"View By\").element"],[[[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeUp()
        
        app.buttons["submitButton"].tap()
        app.buttons["clearButton"].tap()
        
        app/*@START_MENU_TOKEN@*/.tables.containing(.other, identifier:"View By").staticTexts["Status"]/*[[".tables.containing(.other, identifier:\"Objective\")",".otherElements[\"Status\"].staticTexts[\"Status\"]",".staticTexts[\"Status\"]",".tables.containing(.other, identifier:\"Source\")",".tables.containing(.other, identifier:\"View By\")"],[[[-1,4,1],[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Closed Won"]/*[[".cells.staticTexts[\"Closed Won\"]",".staticTexts[\"Closed Won\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Closed Won"]/*[[".cells.staticTexts[\"Closed Won\"]",".staticTexts[\"Closed Won\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Closed Won"]/*[[".cells.staticTexts[\"Closed Won\"]",".staticTexts[\"Closed Won\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app.buttons["submitButton"].tap()
        app.buttons["clearButton"].tap()
        
        app/*@START_MENU_TOKEN@*/.tables.containing(.other, identifier:"View By").staticTexts["Status"]/*[[".tables.containing(.other, identifier:\"Objective\")",".otherElements[\"Status\"].staticTexts[\"Status\"]",".staticTexts[\"Status\"]",".tables.containing(.other, identifier:\"Source\")",".tables.containing(.other, identifier:\"View By\")"],[[[-1,4,1],[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Open"]/*[[".cells.staticTexts[\"Open\"]",".staticTexts[\"Open\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Open"]/*[[".cells.staticTexts[\"Open\"]",".staticTexts[\"Open\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Open"]/*[[".cells.staticTexts[\"Open\"]",".staticTexts[\"Open\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["submitButton"].tap()
        app.buttons["clearButton"].tap()
        
        app/*@START_MENU_TOKEN@*/.tables.containing(.other, identifier:"View By").staticTexts["Status"]/*[[".tables.containing(.other, identifier:\"Objective\")",".otherElements[\"Status\"].staticTexts[\"Status\"]",".staticTexts[\"Status\"]",".tables.containing(.other, identifier:\"Source\")",".tables.containing(.other, identifier:\"View By\")"],[[[-1,4,1],[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Planned"]/*[[".cells.staticTexts[\"Planned\"]",".staticTexts[\"Planned\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Planned"]/*[[".cells.staticTexts[\"Planned\"]",".staticTexts[\"Planned\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Planned"]/*[[".cells.staticTexts[\"Planned\"]",".staticTexts[\"Planned\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["submitButton"].tap()
        app.buttons["clearButton"].tap()
        
    }
    
    func testFilterSource() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Accounts"]/*[[".staticTexts.buttons[\"Accounts\"]",".buttons[\"Accounts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let tablesQuery = app.tables
        app.buttons["Clear"].tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Blenders Pride"]/*[[".cells.staticTexts[\"Blenders Pride\"]",".staticTexts[\"Blenders Pride\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Opportunities"].tap()
        
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["View By"]/*[[".otherElements[\"View By\"].staticTexts[\"View By\"]",".staticTexts[\"View By\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery.staticTexts["Source"].tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Book Of Business"]/*[[".cells.staticTexts[\"Book Of Business\"]",".staticTexts[\"Book Of Business\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Book Of Business"]/*[[".cells.staticTexts[\"Book Of Business\"]",".staticTexts[\"Book Of Business\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Book Of Business"]/*[[".cells.staticTexts[\"Book Of Business\"]",".staticTexts[\"Book Of Business\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        tablesQuery.staticTexts["Source"].tap()
        XCUIApplication().scrollViews.otherElements/*@START_MENU_TOKEN@*/.tables.containing(.other, identifier:"View By").element/*[[".tables.containing(.other, identifier:\"Objective\").element",".tables.containing(.other, identifier:\"Source\").element",".tables.containing(.other, identifier:\"Status\").element",".tables.containing(.other, identifier:\"View By\").element"],[[[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeUp()
        
        app.buttons["submitButton"].tap()
        app.buttons["clearButton"].tap()
        
        tablesQuery.staticTexts["Source"].tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Top Sellers"]/*[[".cells.staticTexts[\"Top Sellers\"]",".staticTexts[\"Top Sellers\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Top Sellers"]/*[[".cells.staticTexts[\"Top Sellers\"]",".staticTexts[\"Top Sellers\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Top Sellers"]/*[[".cells.staticTexts[\"Top Sellers\"]",".staticTexts[\"Top Sellers\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app.buttons["submitButton"].tap()
        app.buttons["clearButton"].tap()
        
        tablesQuery.staticTexts["Source"].tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Undersold"]/*[[".cells.staticTexts[\"Undersold\"]",".staticTexts[\"Undersold\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Undersold"]/*[[".cells.staticTexts[\"Undersold\"]",".staticTexts[\"Undersold\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Undersold"]/*[[".cells.staticTexts[\"Undersold\"]",".staticTexts[\"Undersold\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app.buttons["submitButton"].tap()
        app.buttons["clearButton"].tap()
        
        tablesQuery.staticTexts["Source"].tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["What’s Hot"]/*[[".cells.staticTexts[\"What’s Hot\"]",".staticTexts[\"What’s Hot\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["What’s Hot"]/*[[".cells.staticTexts[\"What’s Hot\"]",".staticTexts[\"What’s Hot\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["What’s Hot"]/*[[".cells.staticTexts[\"What’s Hot\"]",".staticTexts[\"What’s Hot\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app.buttons["submitButton"].tap()
        app.buttons["clearButton"].tap()
        
        tablesQuery.staticTexts["Source"].tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Unsold"]/*[[".cells.staticTexts[\"Unsold\"]",".staticTexts[\"Unsold\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Unsold"]/*[[".cells.staticTexts[\"Unsold\"]",".staticTexts[\"Unsold\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Unsold"]/*[[".cells.staticTexts[\"Unsold\"]",".staticTexts[\"Unsold\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app.buttons["submitButton"].tap()
        app.buttons["clearButton"].tap()
        
    }
    
    func testFilterObjective() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Accounts"]/*[[".staticTexts.buttons[\"Accounts\"]",".buttons[\"Accounts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let tablesQuery = app.tables
        app.buttons["Clear"].tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Blenders Pride"]/*[[".cells.staticTexts[\"Blenders Pride\"]",".staticTexts[\"Blenders Pride\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Opportunities"].tap()
        
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["View By"]/*[[".otherElements[\"View By\"].staticTexts[\"View By\"]",".staticTexts[\"View By\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery.staticTexts["Objective"].tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["9L​ Case"]/*[[".cells.staticTexts[\"9L​ Case\"]",".staticTexts[\"9L​ Case\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["9L​ Case"]/*[[".cells.staticTexts[\"9L​ Case\"]",".staticTexts[\"9L​ Case\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["9L​ Case"]/*[[".cells.staticTexts[\"9L​ Case\"]",".staticTexts[\"9L​ Case\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        tablesQuery.staticTexts["Objective"].tap()
        XCUIApplication().scrollViews.otherElements/*@START_MENU_TOKEN@*/.tables.containing(.other, identifier:"View By").element/*[[".tables.containing(.other, identifier:\"Objective\").element",".tables.containing(.other, identifier:\"Source\").element",".tables.containing(.other, identifier:\"Status\").element",".tables.containing(.other, identifier:\"View By\").element"],[[[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeUp()
        
        app.buttons["submitButton"].tap()
        app.buttons["clearButton"].tap()
        
        tablesQuery.staticTexts["Objective"].tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["ACS"]/*[[".cells.staticTexts[\"ACS\"]",".staticTexts[\"ACS\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["ACS"]/*[[".cells.staticTexts[\"ACS\"]",".staticTexts[\"ACS\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["ACS"]/*[[".cells.staticTexts[\"ACS\"]",".staticTexts[\"ACS\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app.buttons["submitButton"].tap()
        app.buttons["clearButton"].tap()
        
        tablesQuery.staticTexts["Objective"].tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Case Decimal"]/*[[".cells.staticTexts[\"Case Decimal\"]",".staticTexts[\"Case Decimal\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Case Decimal"]/*[[".cells.staticTexts[\"Case Decimal\"]",".staticTexts[\"Case Decimal\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Case Decimal"]/*[[".cells.staticTexts[\"Case Decimal\"]",".staticTexts[\"Case Decimal\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app.buttons["submitButton"].tap()
        app.buttons["clearButton"].tap()
        
        tablesQuery.staticTexts["Objective"].tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["POD"]/*[[".cells.staticTexts[\"POD\"]",".staticTexts[\"POD\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["POD"]/*[[".cells.staticTexts[\"POD\"]",".staticTexts[\"POD\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["POD"]/*[[".cells.staticTexts[\"POD\"]",".staticTexts[\"POD\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app.buttons["submitButton"].tap()
        app.buttons["clearButton"].tap()
        
        tablesQuery.staticTexts["Objective"].tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Revenue"]/*[[".cells.staticTexts[\"Revenue\"]",".staticTexts[\"Revenue\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Revenue"]/*[[".cells.staticTexts[\"Revenue\"]",".staticTexts[\"Revenue\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Revenue"]/*[[".cells.staticTexts[\"Revenue\"]",".staticTexts[\"Revenue\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app.buttons["submitButton"].tap()
        app.buttons["clearButton"].tap()
        
    }
    
    func testSearchOppurtunitySubmit() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Accounts"]/*[[".staticTexts.buttons[\"Accounts\"]",".buttons[\"Accounts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Clear"].tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Blenders Pride"]/*[[".cells.staticTexts[\"Blenders Pride\"]",".staticTexts[\"Blenders Pride\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Opportunities"].tap()
        
        let searchOppurtunityField = app.searchFields["Product Name, ID"]
        searchOppurtunityField.tap()
        searchOppurtunityField.typeText("abc")
        app/*@START_MENU_TOKEN@*/.buttons["Hide keyboard"]/*[[".keyboards.buttons[\"Hide keyboard\"]",".buttons[\"Hide keyboard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["View By"]/*[[".otherElements[\"View By\"].staticTexts[\"View By\"]",".staticTexts[\"View By\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCUIApplication().scrollViews.otherElements/*@START_MENU_TOKEN@*/.tables.containing(.other, identifier:"View By").element/*[[".tables.containing(.other, identifier:\"Objective\").element",".tables.containing(.other, identifier:\"Source\").element",".tables.containing(.other, identifier:\"Status\").element",".tables.containing(.other, identifier:\"View By\").element"],[[[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeUp()
        
        app.buttons["submitButton"].tap()
        app.buttons["clearButton"].tap()
        
    }
}
