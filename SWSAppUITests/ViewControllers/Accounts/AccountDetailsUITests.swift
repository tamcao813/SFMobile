//
//  AccountDetailsUITests.swift
//  SWSAppUITests
//
//  Created by Krishna, Kamya on 7/26/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import XCTest

class AccountDetailsUITests: XCTestCase {
        
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
    
    func testAccountDisplayDataOverview(){
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Accounts"]/*[[".staticTexts.buttons[\"Accounts\"]",".buttons[\"Accounts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables.containing(.other, identifier:"Account Name").children(matching: .cell).element(boundBy: 0).staticTexts["  Details"].tap()
        app.buttons["Overview"].tap()
        
    }
    
    func testAccountDisplayDataDetails(){
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Accounts"]/*[[".staticTexts.buttons[\"Accounts\"]",".buttons[\"Accounts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables.containing(.other, identifier:"Account Name").children(matching: .cell).element(boundBy: 1).staticTexts["  Details"].tap()
        app.buttons["Details"].tap()
        app.swipeUp()
    }
    
    func testAccountDisplayDataInsight(){
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Accounts"]/*[[".staticTexts.buttons[\"Accounts\"]",".buttons[\"Accounts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables.containing(.other, identifier:"Account Name").children(matching: .cell).element(boundBy: 1).staticTexts["  Details"].tap()
        app.buttons["Insights"].tap()
        
    }
    
    func testAccountDisplayDataOppurtunities(){
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Accounts"]/*[[".staticTexts.buttons[\"Accounts\"]",".buttons[\"Accounts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables.containing(.other, identifier:"Account Name").children(matching: .cell).element(boundBy: 0).staticTexts[">"].tap()
        app.buttons["Opportunities"].tap()
        
    }
    
    func testAccountDisplayDataStrategy(){
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Accounts"]/*[[".staticTexts.buttons[\"Accounts\"]",".buttons[\"Accounts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables.containing(.other, identifier:"Account Name").children(matching: .cell).element(boundBy: 0).staticTexts["  Details"].tap()
        app.buttons["Strategy"].tap()
        
    }
    func testAccountDisplayDataActionItems(){
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Accounts"]/*[[".staticTexts.buttons[\"Accounts\"]",".buttons[\"Accounts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables.containing(.other, identifier:"Account Name").children(matching: .cell).element(boundBy: 0).staticTexts["  Details"].tap()
        app.buttons["Action Items"].tap()
        
    }
    
    func testAccountDisplayDataNotes(){
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Accounts"]/*[[".staticTexts.buttons[\"Accounts\"]",".buttons[\"Accounts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables.containing(.other, identifier:"Account Name").children(matching: .cell).element(boundBy: 1).staticTexts["  Details"].tap()
        app.buttons["Notes"].tap()
        
    }
    
    func testAccountDetailsChatter(){
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Accounts"]/*[[".staticTexts.buttons[\"Accounts\"]",".buttons[\"Accounts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"11112222")/*[[".cells.containing(.staticText, identifier:\"03\/16\/2018\")",".cells.containing(.staticText, identifier:\"#KALAPAKI JOE'S BILL TO#\")",".cells.containing(.staticText, identifier:\"$0.99\")",".cells.containing(.staticText, identifier:\"$3,700.00\")",".cells.containing(.staticText, identifier:\"P.O. BOX 1231345 White River Junction, New Hampshire 96766\")",".cells.containing(.staticText, identifier:\"11112222\")"],[[[-1,5],[-1,4],[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.staticTexts["  Details"].tap()
        app.buttons["Chatter"].tap()
        app.buttons["Close"].tap()
    }
    
    func testAccountDetailsInsights(){
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Accounts"]/*[[".staticTexts.buttons[\"Accounts\"]",".buttons[\"Accounts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["#KALAPAKI JOE'S BILL TO#"]/*[[".cells.staticTexts[\"#KALAPAKI JOE'S BILL TO#\"]",".staticTexts[\"#KALAPAKI JOE'S BILL TO#\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Insights"].tap()
        app.buttons["closeButtonID"].tap()
        
    }
    
    func testAccountDetailsBack(){
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Accounts"]/*[[".staticTexts.buttons[\"Accounts\"]",".buttons[\"Accounts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"11112222")/*[[".cells.containing(.staticText, identifier:\"03\/16\/2018\")",".cells.containing(.staticText, identifier:\"#KALAPAKI JOE'S BILL TO#\")",".cells.containing(.staticText, identifier:\"$0.99\")",".cells.containing(.staticText, identifier:\"$3,700.00\")",".cells.containing(.staticText, identifier:\"P.O. BOX 1231345 White River Junction, New Hampshire 96766\")",".cells.containing(.staticText, identifier:\"11112222\")"],[[[-1,5],[-1,4],[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.staticTexts["  Details"].tap()
        app.buttons["Back"].tap()
    }
    
    func testAccountDetailsAddNewVisit(){
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Accounts"]/*[[".staticTexts.buttons[\"Accounts\"]",".buttons[\"Accounts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"11112222")/*[[".cells.containing(.staticText, identifier:\"03\/16\/2018\")",".cells.containing(.staticText, identifier:\"#KALAPAKI JOE'S BILL TO#\")",".cells.containing(.staticText, identifier:\"$0.99\")",".cells.containing(.staticText, identifier:\"$3,700.00\")",".cells.containing(.staticText, identifier:\"P.O. BOX 1231345 White River Junction, New Hampshire 96766\")",".cells.containing(.staticText, identifier:\"11112222\")"],[[[-1,5],[-1,4],[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.staticTexts["  Details"].tap()
        app.buttons["Add New  +"].tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["Visit"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"Visit\"]",".staticTexts[\"Visit\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
    }
    
    func testAccountDetailsAddNewEvent(){
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Accounts"]/*[[".staticTexts.buttons[\"Accounts\"]",".buttons[\"Accounts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"11112222")/*[[".cells.containing(.staticText, identifier:\"03\/16\/2018\")",".cells.containing(.staticText, identifier:\"#KALAPAKI JOE'S BILL TO#\")",".cells.containing(.staticText, identifier:\"$0.99\")",".cells.containing(.staticText, identifier:\"$3,700.00\")",".cells.containing(.staticText, identifier:\"P.O. BOX 1231345 White River Junction, New Hampshire 96766\")",".cells.containing(.staticText, identifier:\"11112222\")"],[[[-1,5],[-1,4],[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.staticTexts["  Details"].tap()
        app.buttons["Add New  +"].tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["Event"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"Event\"]",".staticTexts[\"Event\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
    }
    
    func testAccountDetailsAddNewActionItem(){
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Accounts"]/*[[".staticTexts.buttons[\"Accounts\"]",".buttons[\"Accounts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"11112222")/*[[".cells.containing(.staticText, identifier:\"03\/16\/2018\")",".cells.containing(.staticText, identifier:\"#KALAPAKI JOE'S BILL TO#\")",".cells.containing(.staticText, identifier:\"$0.99\")",".cells.containing(.staticText, identifier:\"$3,700.00\")",".cells.containing(.staticText, identifier:\"P.O. BOX 1231345 White River Junction, New Hampshire 96766\")",".cells.containing(.staticText, identifier:\"11112222\")"],[[[-1,5],[-1,4],[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.staticTexts["  Details"].tap()
        app.buttons["Add New  +"].tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["Action Item"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"Action Item\"]",".staticTexts[\"Action Item\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
    }
    
    func testAccountDetailsAddNewNotes() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Accounts"]/*[[".staticTexts.buttons[\"Accounts\"]",".buttons[\"Accounts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"11112222")/*[[".cells.containing(.staticText, identifier:\"03\/16\/2018\")",".cells.containing(.staticText, identifier:\"#KALAPAKI JOE'S BILL TO#\")",".cells.containing(.staticText, identifier:\"$0.99\")",".cells.containing(.staticText, identifier:\"$3,700.00\")",".cells.containing(.staticText, identifier:\"P.O. BOX 1231345 White River Junction, New Hampshire 96766\")",".cells.containing(.staticText, identifier:\"11112222\")"],[[[-1,5],[-1,4],[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.staticTexts["  Details"].tap()
        app.buttons["Add New  +"].tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["Note"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"Note\"]",".staticTexts[\"Note\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
    }
    
}
