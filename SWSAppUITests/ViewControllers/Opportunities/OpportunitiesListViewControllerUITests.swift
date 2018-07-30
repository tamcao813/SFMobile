//
//  OpportunitiesListViewControllerUITests.swift
//  SWSAppUITests
//
//  Created by Krishna, Kamya on 7/30/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import XCTest

class OpportunitiesListViewControllerUITests: XCTestCase {
        
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
    
    func testSortProductName() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Accounts"]/*[[".staticTexts.buttons[\"Accounts\"]",".buttons[\"Accounts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Clear"].tap()
        
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Aus Lounge Bar"]/*[[".cells.staticTexts[\"Aus Lounge Bar\"]",".staticTexts[\"Aus Lounge Bar\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Opportunities"].tap()
        app.buttons["Product Name"].tap()
        app.buttons["Product Name"].tap()
        
    }
    
    func testSortSource() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Accounts"]/*[[".staticTexts.buttons[\"Accounts\"]",".buttons[\"Accounts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Clear"].tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Aus Lounge Bar"]/*[[".cells.staticTexts[\"Aus Lounge Bar\"]",".staticTexts[\"Aus Lounge Bar\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Opportunities"].tap()
        app.buttons["Source"].tap()
        app.buttons["Source"].tap()
        
    }
    
    func testSortPYCMSold() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Accounts"]/*[[".staticTexts.buttons[\"Accounts\"]",".buttons[\"Accounts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Clear"].tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Aus Lounge Bar"]/*[[".cells.staticTexts[\"Aus Lounge Bar\"]",".staticTexts[\"Aus Lounge Bar\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Opportunities"].tap()
        app.buttons["PYCM Sold"].tap()
        app.buttons["PYCM Sold"].tap()
        
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["9L Case"]/*[[".cells.staticTexts[\"9L Case\"]",".staticTexts[\"9L Case\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["PYCM Sold"].tap()
        app.buttons["PYCM Sold"].tap()
        
    }
    
    func testSortCommit() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Accounts"]/*[[".staticTexts.buttons[\"Accounts\"]",".buttons[\"Accounts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Clear"].tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Aus Lounge Bar"]/*[[".cells.staticTexts[\"Aus Lounge Bar\"]",".staticTexts[\"Aus Lounge Bar\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Opportunities"].tap()
        app.buttons["Commit"].tap()
        app.buttons["Commit"].tap()
        
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["9L Case"]/*[[".cells.staticTexts[\"9L Case\"]",".staticTexts[\"9L Case\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Commit"].tap()
        app.buttons["Commit"].tap()
        
    }
    
    func testSortSold() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Accounts"]/*[[".staticTexts.buttons[\"Accounts\"]",".buttons[\"Accounts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Clear"].tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Aus Lounge Bar"]/*[[".cells.staticTexts[\"Aus Lounge Bar\"]",".staticTexts[\"Aus Lounge Bar\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Opportunities"].tap()
        app.buttons["Sold"].tap()
        app.buttons["Sold"].tap()
        
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["9L Case"]/*[[".cells.staticTexts[\"9L Case\"]",".staticTexts[\"9L Case\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Sold"].tap()
        app.buttons["Sold"].tap()
        
    }
    
    func testSortMonth() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Accounts"]/*[[".staticTexts.buttons[\"Accounts\"]",".buttons[\"Accounts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Clear"].tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Aus Lounge Bar"]/*[[".cells.staticTexts[\"Aus Lounge Bar\"]",".staticTexts[\"Aus Lounge Bar\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Opportunities"].tap()
        app.buttons["Month"].tap()
        app.buttons["Month"].tap()
        
    }
    
    func testSortStatus() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Accounts"]/*[[".staticTexts.buttons[\"Accounts\"]",".buttons[\"Accounts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Clear"].tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Aus Lounge Bar"]/*[[".cells.staticTexts[\"Aus Lounge Bar\"]",".staticTexts[\"Aus Lounge Bar\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Opportunities"].tap()
        app.buttons["Status"].tap()
        app.buttons["Status"].tap()
        
    }
    
}
