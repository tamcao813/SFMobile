//
//  AccountFilterUITests.swift
//  SWSAppUITests
//
//  Created by Krishna, Kamya on 7/26/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import XCTest

class AccountFilterUITests: XCTestCase {
        
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
    
    func testFilterMenuSearchFieldSubmitClear(){
        
        let app = XCUIApplication()
        XCUIApplication().navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Accounts"]/*[[".staticTexts.buttons[\"Accounts\"]",".buttons[\"Accounts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let searchField = app.searchFields["Search Field Text"]
        searchField.tap()
        searchField.typeText("Kalapaki")
        XCUIApplication()/*@START_MENU_TOKEN@*/.buttons["Hide keyboard"]/*[[".keyboards.buttons[\"Hide keyboard\"]",".buttons[\"Hide keyboard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCUIApplication().buttons["Submit"].tap()
        XCUIApplication().buttons["Clear"].tap()
        
    }
    
    func testFilterMenuPastDue(){
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Accounts"]/*[[".staticTexts.buttons[\"Accounts\"]",".buttons[\"Accounts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let tablesQuery = app.tables
        tablesQuery.otherElements.staticTexts["Past Due"].tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Yes"]/*[[".cells.staticTexts[\"Yes\"]",".staticTexts[\"Yes\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Submit"].tap()
        app.buttons["Clear"].tap()
        
        tablesQuery.otherElements.staticTexts["Past Due"].tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["No"]/*[[".cells.staticTexts[\"No\"]",".staticTexts[\"No\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Submit"].tap()
        app.buttons["Clear"].tap()
        
    }
    
    func testFilterMenuStatus(){
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Accounts"]/*[[".staticTexts.buttons[\"Accounts\"]",".buttons[\"Accounts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let tablesQuery = app.tables
        tablesQuery.staticTexts["Status"].tap()
        tablesQuery.staticTexts["Status"].tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Active"]/*[[".cells.staticTexts[\"Active\"]",".staticTexts[\"Active\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Submit"].tap()
        app.buttons["Clear"].tap()
        
        tablesQuery.staticTexts["Status"].tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Inactive"]/*[[".cells.staticTexts[\"Inactive\"]",".staticTexts[\"Inactive\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Submit"].tap()
        app.buttons["Clear"].tap()
        
        tablesQuery.staticTexts["Status"].tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Suspended"]/*[[".cells.staticTexts[\"Suspended\"]",".staticTexts[\"Suspended\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Submit"].tap()
        app.buttons["Clear"].tap()
        
    }
    
    func testFilterMenuPremise(){
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Accounts"]/*[[".staticTexts.buttons[\"Accounts\"]",".buttons[\"Accounts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables.staticTexts["Premise"].tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["On"]/*[[".cells.staticTexts[\"On\"]",".staticTexts[\"On\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Submit"].tap()
        app.buttons["Clear"].tap()
        
        app.tables.staticTexts["Premise"].tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Off"]/*[[".cells.staticTexts[\"Off\"]",".staticTexts[\"Off\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Submit"].tap()
        app.buttons["Clear"].tap()
        
    }
    
    func testFilterMenuSingleMultiMenu(){
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Accounts"]/*[[".staticTexts.buttons[\"Accounts\"]",".buttons[\"Accounts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let tablesQuery = app.tables
        tablesQuery.staticTexts["Single / Multi locations"].tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Single"]/*[[".cells.staticTexts[\"Single\"]",".staticTexts[\"Single\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Submit"].tap()
        app.buttons["Clear"].tap()
        
        tablesQuery.staticTexts["Single / Multi locations"].tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Multi"]/*[[".cells.staticTexts[\"Multi\"]",".staticTexts[\"Multi\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Submit"].tap()
        app.buttons["Clear"].tap()
        
    }
    
    func testFilterMenuLicenseType(){
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Accounts"]/*[[".staticTexts.buttons[\"Accounts\"]",".buttons[\"Accounts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let tablesQuery = app.tables
        
        tablesQuery.staticTexts["License Type"].tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["L"]/*[[".cells.staticTexts[\"L\"]",".staticTexts[\"L\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Submit"].tap()
        app.buttons["Clear"].tap()
        
        tablesQuery.staticTexts["License Type"].tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["W"]/*[[".cells.staticTexts[\"W\"]",".staticTexts[\"W\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Submit"].tap()
        app.buttons["Clear"].tap()
        
        tablesQuery.staticTexts["License Type"].tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["B"]/*[[".cells.staticTexts[\"B\"]",".staticTexts[\"B\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Submit"].tap()
        app.buttons["Clear"].tap()
        
        tablesQuery.staticTexts["License Type"].tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["N"]/*[[".cells.staticTexts[\"N\"]",".staticTexts[\"N\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Submit"].tap()
        app.buttons["Clear"].tap()
        
    }
    
    //Search using searchbar query in filtered list
    func testSearchInFilteredList() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Accounts"]/*[[".staticTexts.buttons[\"Accounts\"]",".buttons[\"Accounts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let tablesQuery = app.tables
        app.buttons["Clear"].tap()
        tablesQuery.otherElements.staticTexts["Past Due"].tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Yes"]/*[[".cells.staticTexts[\"Yes\"]",".staticTexts[\"Yes\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Submit"].tap()
        let searchField = app.searchFields["Search Field Text"]
        searchField.tap()
        searchField.typeText("blender")
        
        app/*@START_MENU_TOKEN@*/.buttons["Hide keyboard"]/*[[".keyboards.buttons[\"Hide keyboard\"]",".buttons[\"Hide keyboard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Submit"].tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Blenders Pride"]/*[[".cells.staticTexts[\"Blenders Pride\"]",".staticTexts[\"Blenders Pride\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
    }
    
}
