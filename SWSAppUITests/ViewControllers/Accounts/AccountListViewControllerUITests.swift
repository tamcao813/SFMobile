//
//  AccountListViewControllerUITests.swift
//  SWSAppUITests
//
//  Created by Krishna, Kamya on 7/30/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import XCTest

class AccountListViewControllerUITests: XCTestCase {
        
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
    
    func testPageControl(){
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Accounts"]/*[[".staticTexts.buttons[\"Accounts\"]",".buttons[\"Accounts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["1"].tap()
        app.buttons["<"].tap()
        app.buttons["2"].tap()
        app.buttons["3"].tap()
        app.buttons["4"].tap()
        app.buttons["5"].tap()
        app.buttons[">"].tap()
        app.buttons["Last Page  >"].tap()
        app.buttons["<   First Page"].tap()
    }
    
    func testAccountNameSort(){
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Accounts"]/*[[".staticTexts.buttons[\"Accounts\"]",".buttons[\"Accounts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let accountName = app.tables/*@START_MENU_TOKEN@*/.staticTexts["Account Name"]/*[[".otherElements[\"Account Name\"].staticTexts[\"Account Name\"]",".staticTexts[\"Account Name\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        accountName.tap()
        accountName.tap()
    }
    
    func testActionItemsSort(){
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Accounts"]/*[[".staticTexts.buttons[\"Accounts\"]",".buttons[\"Accounts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let actionItemsStaticText = app.tables.otherElements["Account Name"].staticTexts["Action Items"]
        actionItemsStaticText.tap()
        actionItemsStaticText.tap()
        
    }
    
    func testTotalNetSalesSort(){
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Accounts"]/*[[".staticTexts.buttons[\"Accounts\"]",".buttons[\"Accounts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let totalR12NetSalesStaticText = app.tables/*@START_MENU_TOKEN@*/.staticTexts["Total R12 Net Sales"]/*[[".otherElements[\"Account Name\"].staticTexts[\"Total R12 Net Sales\"]",".staticTexts[\"Total R12 Net Sales\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        totalR12NetSalesStaticText.tap()
        totalR12NetSalesStaticText.tap()
    }
    
    func testBalanceSort(){
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Accounts"]/*[[".staticTexts.buttons[\"Accounts\"]",".buttons[\"Accounts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let balanceStaticText = app.tables/*@START_MENU_TOKEN@*/.staticTexts["Balance"]/*[[".otherElements[\"Account Name\"].staticTexts[\"Balance\"]",".staticTexts[\"Balance\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        balanceStaticText.tap()
        balanceStaticText.tap()
        
    }
    
    func testNextDeliverySort(){
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Accounts"]/*[[".staticTexts.buttons[\"Accounts\"]",".buttons[\"Accounts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let nextDeliveryStaticText = app.tables/*@START_MENU_TOKEN@*/.staticTexts["Next Delivery"]/*[[".otherElements[\"Account Name\"].staticTexts[\"Next Delivery\"]",".staticTexts[\"Next Delivery\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        nextDeliveryStaticText.tap()
        nextDeliveryStaticText.tap()
    }
    
    func testFilterSortAll() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Accounts"]/*[[".staticTexts.buttons[\"Accounts\"]",".buttons[\"Accounts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let tablesQuery2 = app.tables
        tablesQuery2.otherElements.staticTexts["Past Due"].tap()
        
        let tablesQuery = tablesQuery2
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["No"]/*[[".cells.staticTexts[\"No\"]",".staticTexts[\"No\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Submit"].tap()
        
        let accountNameStaticText = tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Account Name"]/*[[".otherElements[\"Account Name\"].staticTexts[\"Account Name\"]",".staticTexts[\"Account Name\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        accountNameStaticText.tap()
        accountNameStaticText.tap()
        
        //let tablesQuery = XCUIApplication().tables
        tablesQuery.otherElements["Account Name"].staticTexts["Action Items"].tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Total R12 Net Sales"]/*[[".otherElements[\"Account Name\"].staticTexts[\"Total R12 Net Sales\"]",".staticTexts[\"Total R12 Net Sales\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Balance"]/*[[".otherElements[\"Account Name\"].staticTexts[\"Balance\"]",".staticTexts[\"Balance\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let nextDeliveryStaticText = tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Next Delivery"]/*[[".otherElements[\"Account Name\"].staticTexts[\"Next Delivery\"]",".staticTexts[\"Next Delivery\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        nextDeliveryStaticText.tap()
        nextDeliveryStaticText.tap()
    }
    
    //Sort the accounts after filtering
    func testSortAccountNameAfterFiltering() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Accounts"]/*[[".staticTexts.buttons[\"Accounts\"]",".buttons[\"Accounts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let tablesQuery = app.tables
        tablesQuery.otherElements["Past Due"].staticTexts["Past Due"].tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Yes"]/*[[".cells.staticTexts[\"Yes\"]",".staticTexts[\"Yes\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Submit"].tap()
        XCUIApplication().tables/*@START_MENU_TOKEN@*/.staticTexts["Account Name"]/*[[".otherElements[\"Account Name\"].staticTexts[\"Account Name\"]",".staticTexts[\"Account Name\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCUIApplication().tables/*@START_MENU_TOKEN@*/.staticTexts["Account Name"]/*[[".otherElements[\"Account Name\"].staticTexts[\"Account Name\"]",".staticTexts[\"Account Name\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
    }
    
    func testSortNetSalesAfterFiltering() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Accounts"]/*[[".staticTexts.buttons[\"Accounts\"]",".buttons[\"Accounts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let tablesQuery2 = app.tables
        tablesQuery2.otherElements["Past Due"].staticTexts["Past Due"].tap()
        
        let tablesQuery = tablesQuery2
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Yes"]/*[[".cells.staticTexts[\"Yes\"]",".staticTexts[\"Yes\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Submit"].tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Total R12 Net Sales"]/*[[".otherElements[\"Account Name\"].staticTexts[\"Total R12 Net Sales\"]",".staticTexts[\"Total R12 Net Sales\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Total R12 Net Sales"]/*[[".otherElements[\"Account Name\"].staticTexts[\"Total R12 Net Sales\"]",".staticTexts[\"Total R12 Net Sales\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
    }
    
    func testSortBalanceAfterFiltering() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Accounts"]/*[[".staticTexts.buttons[\"Accounts\"]",".buttons[\"Accounts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables.otherElements["Past Due"].staticTexts["Past Due"].tap()
        
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Yes"]/*[[".cells.staticTexts[\"Yes\"]",".staticTexts[\"Yes\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Submit"].tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Balance"]/*[[".otherElements[\"Account Name\"].staticTexts[\"Balance\"]",".staticTexts[\"Balance\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Balance"]/*[[".otherElements[\"Account Name\"].staticTexts[\"Balance\"]",".staticTexts[\"Balance\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
    }
    
    func testSortNextDeliveryAfterFiltering() {
        
        let app = XCUIApplication()
        XCUIApplication().navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Accounts"]/*[[".staticTexts.buttons[\"Accounts\"]",".buttons[\"Accounts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables.otherElements["Past Due"].staticTexts["Past Due"].tap()
        
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Yes"]/*[[".cells.staticTexts[\"Yes\"]",".staticTexts[\"Yes\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Submit"].tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Next Delivery"]/*[[".otherElements[\"Account Name\"].staticTexts[\"Next Delivery\"]",".staticTexts[\"Next Delivery\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Next Delivery"]/*[[".otherElements[\"Account Name\"].staticTexts[\"Next Delivery\"]",".staticTexts[\"Next Delivery\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
    }
    
    func testSortActionItemsAfterFiltering() {
        
        let app = XCUIApplication()
        XCUIApplication().navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Accounts"]/*[[".staticTexts.buttons[\"Accounts\"]",".buttons[\"Accounts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables.otherElements["Past Due"].staticTexts["Past Due"].tap()
        
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Yes"]/*[[".cells.staticTexts[\"Yes\"]",".staticTexts[\"Yes\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Submit"].tap()
        XCUIApplication().tables.otherElements["Account Name"].staticTexts["Action Items"].tap()
        XCUIApplication().tables.otherElements["Account Name"].staticTexts["Action Items"].tap()
        
    }
}
