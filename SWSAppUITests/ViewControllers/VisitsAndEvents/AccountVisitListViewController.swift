//
//  AccountVisitListViewController.swift
//  SWSAppUITests
//
//  Created by Krishna, Kamya on 7/30/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import XCTest

class AccountVisitListViewController: XCTestCase {
        
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
    
}
