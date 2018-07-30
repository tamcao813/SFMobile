//
//  DropDownUITests.swift
//  SWSAppUITests
//
//  Created by Krishna, Kamya on 7/26/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import XCTest

class DropDownUITests: XCTestCase {
        
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
    
    func testDropDownMenuActionItems(){
        
        let app = XCUIApplication()
        let swsappParentviewNavigationBar = app.navigationBars["SWSApp.ParentView"]
        swsappParentviewNavigationBar/*@START_MENU_TOKEN@*/.buttons["More ..."]/*[[".staticTexts.buttons[\"More ...\"]",".buttons[\"More ...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["  Action Items"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"  Action Items\"]",".staticTexts[\"  Action Items\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        swsappParentviewNavigationBar/*@START_MENU_TOKEN@*/.buttons["Objectives"]/*[[".staticTexts.buttons[\"Objectives\"]",".buttons[\"Objectives\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
    }
    
    func testDropDownMenuAccountVisits(){
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["More ..."]/*[[".staticTexts.buttons[\"More ...\"]",".buttons[\"More ...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["  Account Visits"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"  Account Visits\"]",".staticTexts[\"  Account Visits\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
    }
    
    func testDropDownMenuInsights(){
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["More ..."]/*[[".staticTexts.buttons[\"More ...\"]",".buttons[\"More ...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["  Insights"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"  Insights\"]",".staticTexts[\"  Insights\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
        
    }
    
    func testDropDownMenuReports(){
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["More ..."]/*[[".staticTexts.buttons[\"More ...\"]",".buttons[\"More ...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["  Reports"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"  Reports\"]",".staticTexts[\"  Reports\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
    }
    
    func testDropDownMenuNotifications(){
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["More ..."]/*[[".staticTexts.buttons[\"More ...\"]",".buttons[\"More ...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["  Notifications"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"  Notifications\"]",".staticTexts[\"  Notifications\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
    }
    
    func testDropDownMenuChatter(){
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["More ..."]/*[[".staticTexts.buttons[\"More ...\"]",".buttons[\"More ...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["  Chatter"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"  Chatter\"]",".staticTexts[\"  Chatter\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
    }
    
    func testDropDownMenuTransaction(){
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["More ..."]/*[[".staticTexts.buttons[\"More ...\"]",".buttons[\"More ...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["  Transactions (Topaz)"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"  Transactions (Topaz)\"]",".staticTexts[\"  Transactions (Topaz)\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
    }
    
    func testDropDownMenuLoadDeposit(){
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["More ..."]/*[[".staticTexts.buttons[\"More ...\"]",".buttons[\"More ...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["  Load Deposit (IDD)"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"  Load Deposit (IDD)\"]",".staticTexts[\"  Load Deposit (IDD)\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
    }
    
    func testDropDownMenuGoSpotCheck(){
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["More ..."]/*[[".staticTexts.buttons[\"More ...\"]",".buttons[\"More ...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["  GoSpotCheck"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"  GoSpotCheck\"]",".staticTexts[\"  GoSpotCheck\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
    }
    
}
