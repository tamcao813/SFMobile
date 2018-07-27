//
//  AccountStrategyUITests.swift
//  SWSAppUITests
//
//  Created by Krishna, Kamya on 7/26/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import XCTest

class AccountStrategyUITests: XCTestCase {
        
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
    
    func testEditAndSaveAccountStrategy() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Accounts"]/*[[".staticTexts.buttons[\"Accounts\"]",".buttons[\"Accounts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["#KALAPAKI JOE'S BILL TO#"]/*[[".cells.staticTexts[\"#KALAPAKI JOE'S BILL TO#\"]",".staticTexts[\"#KALAPAKI JOE'S BILL TO#\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Strategy"].tap()
        app.buttons["Edit"].tap()
        
        let cellsQuery = XCUIApplication().collectionViews.cells
        cellsQuery.otherElements.containing(.staticText, identifier:"Meet the needs of its regulars").element.tap()
        cellsQuery.otherElements.containing(.staticText, identifier:"Inventory Is Hard To Manage").element.tap()
        app.swipeUp()
        cellsQuery/*@START_MENU_TOKEN@*/.buttons["Save"]/*[[".cells.buttons[\"Save\"]",".buttons[\"Save\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
    }
    
    func testEditAndCloseAccountStrategy() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Accounts"]/*[[".staticTexts.buttons[\"Accounts\"]",".buttons[\"Accounts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["#KALAPAKI JOE'S BILL TO#"]/*[[".cells.staticTexts[\"#KALAPAKI JOE'S BILL TO#\"]",".staticTexts[\"#KALAPAKI JOE'S BILL TO#\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Strategy"].tap()
        
        let editButton = app.buttons["Edit"]
        editButton.tap()
        XCUIApplication().collectionViews.cells.otherElements.containing(.staticText, identifier:"Blaze its own path").element.tap()
        
        let closeButton = app.buttons["Close"]
        closeButton.tap()
        
        let anyChangesWillNotBeSavedAlert = app.alerts["Any changes will not be saved"]
        anyChangesWillNotBeSavedAlert.buttons["No"].tap()
        closeButton.tap()
        anyChangesWillNotBeSavedAlert.buttons["Yes"].tap()
        
    }
    
    func testEditAndCancelAccountStrategy(){
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Accounts"]/*[[".staticTexts.buttons[\"Accounts\"]",".buttons[\"Accounts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCUIApplication().buttons["3"].tap()
        app.swipeUp()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["#KALAPAKI JOE'S BILL TO#"]/*[[".cells.staticTexts[\"#KALAPAKI JOE'S BILL TO#\"]",".staticTexts[\"#KALAPAKI JOE'S BILL TO#\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        //app.tables/*@START_MENU_TOKEN@*/.staticTexts["ROUGH RIVER DAM STATE RES"]/*[[".cells.staticTexts[\"ROUGH RIVER DAM STATE RES\"]",".staticTexts[\"ROUGH RIVER DAM STATE RES\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Strategy"].tap()
        app.buttons["Edit"].tap()
        app.swipeUp()
        
        let cancelButton = XCUIApplication().collectionViews/*@START_MENU_TOKEN@*/.buttons["Cancel"]/*[[".cells.buttons[\"Cancel\"]",".buttons[\"Cancel\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        cancelButton.tap()
        app.alerts["Any changes will not be saved"].buttons["No"].tap()
        cancelButton.tap()
        app.alerts["Any changes will not be saved"].buttons["No"].tap()
        
    }
    
    func testEditAndSaveStrategyNotes(){
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Accounts"]/*[[".staticTexts.buttons[\"Accounts\"]",".buttons[\"Accounts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["#KALAPAKI JOE'S BILL TO#"]/*[[".cells.staticTexts[\"#KALAPAKI JOE'S BILL TO#\"]",".staticTexts[\"#KALAPAKI JOE'S BILL TO#\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Strategy"].tap()
        app.buttons["Edit"].tap()
        
        let cellsQuery = app.collectionViews.cells
        
        cellsQuery.otherElements.containing(.staticText, identifier:"Blaze its own path").element.tap()
        cellsQuery.otherElements.containing(.staticText, identifier:"Limited Cash Flow").element.tap()
        app.swipeUp()
        
        XCUIApplication().collectionViews.cells.otherElements.containing(.staticText, identifier:"Respect(For Expertise)").element.tap()
        
        let collectionViewsQuery2 = app.collectionViews
        let stratNotes = app.textViews["strategyNotes"]
        stratNotes.tap()
        stratNotes.typeText("hello")
        collectionViewsQuery2/*@START_MENU_TOKEN@*/.buttons["Save"]/*[[".cells.buttons[\"Save\"]",".buttons[\"Save\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
    }
    
    func testStrategyFooter(){
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Accounts"]/*[[".staticTexts.buttons[\"Accounts\"]",".buttons[\"Accounts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"11112222")/*[[".cells.containing(.staticText, identifier:\"03\/16\/2018\")",".cells.containing(.staticText, identifier:\"#KALAPAKI JOE'S BILL TO#\")",".cells.containing(.staticText, identifier:\"$0.99\")",".cells.containing(.staticText, identifier:\"$3,700.00\")",".cells.containing(.staticText, identifier:\"P.O. BOX 1231345 White River Junction, New Hampshire 96766\")",".cells.containing(.staticText, identifier:\"11112222\")"],[[[-1,5],[-1,4],[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.staticTexts["  Details"].tap()
        app.buttons["Strategy"].tap()
        
        let collectionViewsQuery = app.collectionViews
        collectionViewsQuery.staticTexts["Account Situation"].tap()
        app.swipeUp()
        //collectionViewsQuery.staticTexts["Goals"].tap()
        //collectionViewsQuery.staticTexts["Account Strategy Notes"].tap()
        
    }
    
    func testNoStrategyForAccount() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Accounts"]/*[[".staticTexts.buttons[\"Accounts\"]",".buttons[\"Accounts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Blenders Pride"]/*[[".cells.staticTexts[\"Blenders Pride\"]",".staticTexts[\"Blenders Pride\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Strategy"].tap()
        
    }
}
