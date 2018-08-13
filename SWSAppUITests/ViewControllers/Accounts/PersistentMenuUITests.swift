//
//  PersistentMenuUITests.swift
//  SWSAppUITests
//
//  Created by Krishna, Kamya on 7/26/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import XCTest

class PersistentMenuUITests: XCTestCase {
        
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
    
    func testPersistentMenuHome(){
        XCUIApplication().navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Home"]/*[[".staticTexts.buttons[\"Home\"]",".buttons[\"Home\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
    }
    
    func testPersistentMenuAccounts(){
        XCUIApplication().navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Accounts"]/*[[".staticTexts.buttons[\"Accounts\"]",".buttons[\"Accounts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
    }
    
    func testPersistentMenuContacts(){
        XCUIApplication().navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Contacts"]/*[[".staticTexts.buttons[\"Contacts\"]",".buttons[\"Contacts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
    }
    func testPersistentMenuCalendar(){
        XCUIApplication().navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Calendar"]/*[[".staticTexts.buttons[\"Calendar\"]",".buttons[\"Calendar\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
    }
    func testPersistentMenuObjective(){
        XCUIApplication().navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Objectives"]/*[[".staticTexts.buttons[\"Objectives\"]",".buttons[\"Objectives\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
    }
    
    func testPersistentMenuMore(){
        XCUIApplication().navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["More ..."]/*[[".staticTexts.buttons[\"More ...\"]",".buttons[\"More ...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
    }
    
    func testPersistentMenuNameInitial(){
        XCUIApplication().navigationBars["SWSApp.ParentView"].staticTexts["ag"].tap()
        
    }
    
    func testOnlineSyncupButton() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"].staticTexts["Online"].tap()
        app.staticTexts["Last Sync Successful"].tap()
        XCUIApplication().staticTexts["Sync Now"].tap()
        
    }
    
}
