//
//  ContactFilterUITests.swift
//  SWSAppUITests
//
//  Created by Krishna, Kamya on 7/26/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import XCTest

class ContactFilterUITests: XCTestCase {
        
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
    
    func testPageControl() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Contacts"]/*[[".staticTexts.buttons[\"Contacts\"]",".buttons[\"Contacts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
//        app.tables/*@START_MENU_TOKEN@*/.staticTexts["All Contacts"]/*[[".cells.staticTexts[\"All Contacts\"]",".staticTexts[\"All Contacts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
//        app.buttons["Submit"].tap()
        
        app.buttons["1"].tap()
        app.buttons["2"].tap()
        app.buttons["3"].tap()
        app.buttons["4"].tap()
        app.buttons["5"].tap()
        app.buttons[">"].tap()
        app.buttons["Last Page  >"].tap()
        app.buttons["<"].tap()
        app.buttons["<   First Page"].tap()
        
    }
//
//    func testFilterContactAssociation() {
//
//        let app = XCUIApplication()
//        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Contacts"]/*[[".staticTexts.buttons[\"Contacts\"]",".buttons[\"Contacts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
//        app.tables/*@START_MENU_TOKEN@*/.staticTexts["All Contacts"]/*[[".cells.staticTexts[\"All Contacts\"]",".staticTexts[\"All Contacts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
//        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Contacts On My Route"]/*[[".cells.staticTexts[\"Contacts On My Route\"]",".staticTexts[\"Contacts On My Route\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
//        app.buttons["Submit"].tap()
//
//        app.tables/*@START_MENU_TOKEN@*/.staticTexts["All Contacts"]/*[[".cells.staticTexts[\"All Contacts\"]",".staticTexts[\"All Contacts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
//        app.buttons["Submit"].tap()
//        app.buttons["Clear"].tap()
//
//    }
//
    func testFilterFunctionRole() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Contacts"]/*[[".staticTexts.buttons[\"Contacts\"]",".buttons[\"Contacts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Function/Role"]/*[[".otherElements[\"Function\/Role\"].staticTexts[\"Function\/Role\"]",".staticTexts[\"Function\/Role\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["All"]/*[[".cells.staticTexts[\"All\"]",".staticTexts[\"All\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["All"]/*[[".cells.staticTexts[\"All\"]",".staticTexts[\"All\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["All"]/*[[".cells.staticTexts[\"All\"]",".staticTexts[\"All\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Submit"].tap()
        app.buttons["Clear"].tap()
        
    }
    
    func testFilterBuyingPower() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Contacts"]/*[[".staticTexts.buttons[\"Contacts\"]",".buttons[\"Contacts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Buying Power"]/*[[".otherElements[\"Buying Power\"].staticTexts[\"Buying Power\"]",".staticTexts[\"Buying Power\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["All"]/*[[".cells.staticTexts[\"All\"]",".staticTexts[\"All\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["All"]/*[[".cells.staticTexts[\"All\"]",".staticTexts[\"All\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["All"]/*[[".cells.staticTexts[\"All\"]",".staticTexts[\"All\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Submit"].tap()
        app.buttons["Clear"].tap()
        
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Buying Power"]/*[[".otherElements[\"Buying Power\"].staticTexts[\"Buying Power\"]",".staticTexts[\"Buying Power\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery.cells.staticTexts["Buying Power"].tap()
        tablesQuery.cells.staticTexts["Buying Power"].tap()
        tablesQuery.cells.staticTexts["Buying Power"].tap()
        app.buttons["Submit"].tap()
        app.buttons["Clear"].tap()
        
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Buying Power"]/*[[".otherElements[\"Buying Power\"].staticTexts[\"Buying Power\"]",".staticTexts[\"Buying Power\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["No Buying Power"]/*[[".cells.staticTexts[\"No Buying Power\"]",".staticTexts[\"No Buying Power\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["No Buying Power"]/*[[".cells.staticTexts[\"No Buying Power\"]",".staticTexts[\"No Buying Power\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["No Buying Power"]/*[[".cells.staticTexts[\"No Buying Power\"]",".staticTexts[\"No Buying Power\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Submit"].tap()
        app.buttons["Clear"].tap()
        
    }
    
    func testMultipleFunctionalRoleFilters() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Contacts"]/*[[".staticTexts.buttons[\"Contacts\"]",".buttons[\"Contacts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Function/Role"]/*[[".otherElements[\"Function\/Role\"].staticTexts[\"Function\/Role\"]",".staticTexts[\"Function\/Role\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Owner"]/*[[".cells.staticTexts[\"Owner\"]",".staticTexts[\"Owner\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        //tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Owner's Relative"]/*[[".cells.staticTexts[\"Owner's Relative\"]",".staticTexts[\"Owner's Relative\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Regional Manager"]/*[[".cells.staticTexts[\"Regional Manager\"]",".staticTexts[\"Regional Manager\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Submit"].tap()
        
    }
    
    // Buying power filters with another filter applied
    
    func testAllBuyingFilter() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Contacts"]/*[[".staticTexts.buttons[\"Contacts\"]",".buttons[\"Contacts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Buying Power"]/*[[".otherElements[\"Buying Power\"].staticTexts[\"Buying Power\"]",".staticTexts[\"Buying Power\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["All"]/*[[".cells.staticTexts[\"All\"]",".staticTexts[\"All\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Function/Role"]/*[[".otherElements[\"Function\/Role\"].staticTexts[\"Function\/Role\"]",".staticTexts[\"Function\/Role\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Owner"]/*[[".cells.staticTexts[\"Owner\"]",".staticTexts[\"Owner\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Submit"].tap()
        
    }
    
    func testBuyingPowerFilter() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Contacts"]/*[[".staticTexts.buttons[\"Contacts\"]",".buttons[\"Contacts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Buying Power"]/*[[".otherElements[\"Buying Power\"].staticTexts[\"Buying Power\"]",".staticTexts[\"Buying Power\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery.cells.staticTexts["Buying Power"].tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Function/Role"]/*[[".otherElements[\"Function\/Role\"].staticTexts[\"Function\/Role\"]",".staticTexts[\"Function\/Role\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Owner"]/*[[".cells.staticTexts[\"Owner\"]",".staticTexts[\"Owner\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Submit"].tap()
        
    }
    
    func testNoBuyingPowerFilter() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Contacts"]/*[[".staticTexts.buttons[\"Contacts\"]",".buttons[\"Contacts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Buying Power"]/*[[".otherElements[\"Buying Power\"].staticTexts[\"Buying Power\"]",".staticTexts[\"Buying Power\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["No Buying Power"]/*[[".cells.staticTexts[\"No Buying Power\"]",".staticTexts[\"No Buying Power\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Function/Role"]/*[[".otherElements[\"Function\/Role\"].staticTexts[\"Function\/Role\"]",".staticTexts[\"Function\/Role\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Owner"]/*[[".cells.staticTexts[\"Owner\"]",".staticTexts[\"Owner\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Submit"].tap()
        
    }
    
    //Search field - submit, clear
    func testFilterSearchFail() {
        
        let app = XCUIApplication()
        XCUIApplication().navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Contacts"]/*[[".staticTexts.buttons[\"Contacts\"]",".buttons[\"Contacts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let searchField = app.searchFields["Name, Account, ID"]
        searchField.tap()
        searchField.typeText("Qwerty")
        XCUIApplication()/*@START_MENU_TOKEN@*/.buttons["Hide keyboard"]/*[[".keyboards.buttons[\"Hide keyboard\"]",".buttons[\"Hide keyboard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCUIApplication().buttons["Submit"].tap()
        
    }
    
    func testFilterSearchSubmit() {
        
        let app = XCUIApplication()
        XCUIApplication().navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Contacts"]/*[[".staticTexts.buttons[\"Contacts\"]",".buttons[\"Contacts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
//        app.tables/*@START_MENU_TOKEN@*/.staticTexts["All Contacts"]/*[[".cells.staticTexts[\"All Contacts\"]",".staticTexts[\"All Contacts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
//        app.buttons["Submit"].tap()
        
        let searchField = app.searchFields["Name, Account, ID"]
        searchField.tap()
        searchField.typeText("Aryton")
        XCUIApplication()/*@START_MENU_TOKEN@*/.buttons["Hide keyboard"]/*[[".keyboards.buttons[\"Hide keyboard\"]",".buttons[\"Hide keyboard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCUIApplication().buttons["Submit"].tap()
        XCUIApplication().buttons["Clear"].tap()
        
    }
}
