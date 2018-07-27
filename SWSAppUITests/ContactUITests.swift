//
//  ContactUITests.swift
//  SWSAppUITests
//
//  Created by Krishna, Kamya on 7/26/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import XCTest

class ContactUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()
        sleep(20)

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCreateNewContact() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Contacts"]/*[[".staticTexts.buttons[\"Contacts\"]",".buttons[\"Contacts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["New Contact  +"]/*[[".cells.buttons[\"New Contact  +\"]",".buttons[\"New Contact  +\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let departmentStaticText = tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Department"]/*[[".cells.staticTexts[\"Department\"]",".staticTexts[\"Department\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        departmentStaticText.tap()
        departmentStaticText.swipeLeft()
        tablesQuery.buttons["Save"].tap()
        
    }
    
    //create and close new contact
    func testCreateNewContactAndClose(){
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Contacts"]/*[[".staticTexts.buttons[\"Contacts\"]",".buttons[\"Contacts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables/*@START_MENU_TOKEN@*/.buttons["New Contact  +"]/*[[".cells.buttons[\"New Contact  +\"]",".buttons[\"New Contact  +\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let searchAccountField =  app.tables/*@START_MENU_TOKEN@*/.textFields["Search by Account Name or ID"]/*[[".cells.textFields[\"Search by Account Name or ID\"]",".textFields[\"Search by Account Name or ID\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        searchAccountField.tap()
        searchAccountField.typeText("Kala")
        XCUIApplication().otherElements["drop_down"].tables/*@START_MENU_TOKEN@*/.staticTexts["#KALAPAKI JOE'S BILL TO#"]/*[[".cells.staticTexts[\"#KALAPAKI JOE'S BILL TO#\"]",".staticTexts[\"#KALAPAKI JOE'S BILL TO#\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["No"]/*[[".cells.buttons[\"No\"]",".buttons[\"No\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Yes"]/*[[".cells.buttons[\"Yes\"]",".buttons[\"Yes\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let fname = app.tables/*@START_MENU_TOKEN@*/.textFields["First Name"]/*[[".cells.textFields[\"First Name\"]",".textFields[\"First Name\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        fname.tap()
        fname.typeText("xyz")
        let lname = app.tables/*@START_MENU_TOKEN@*/.textFields["Last Name"]/*[[".cells.textFields[\"Last Name\"]",".textFields[\"Last Name\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        lname.tap()
        lname.typeText("gmail")
        let pname = app.tables/*@START_MENU_TOKEN@*/.textFields["Preferred Name"]/*[[".cells.textFields[\"Preferred Name\"]",".textFields[\"Preferred Name\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        pname.tap()
        pname.typeText("xyzgmail")
        
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .button).element.tap()
        app.alerts["Any changes will not be saved"].buttons["No"].tap()
        
        app.tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Primary Function / Role*")/*[[".cells.containing(.staticText, identifier:\"Department\")",".cells.containing(.textField, identifier:\"Helper Text\")",".cells.containing(.staticText, identifier:\"Title\")",".cells.containing(.staticText, identifier:\"Primary Function \/ Role*\")"],[[[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.textFields["Select"].tap()
        app.toolbars["Toolbar"].buttons["Done"].tap()
        
        app.swipeUp()
        let fax = app.tables/*@START_MENU_TOKEN@*/.textFields["(555) 555-5555"]/*[[".cells.textFields[\"(555) 555-5555\"]",".textFields[\"(555) 555-5555\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        fax.tap()
        fax.typeText("(555) 555-5555")
        
        app.swipeUp()
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .button).element.tap()
        app.alerts["Any changes will not be saved"].buttons["Yes"].tap()
        
    }
    
    func testCreateNewContactUsingIDUsingAll(){
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Contacts"]/*[[".staticTexts.buttons[\"Contacts\"]",".buttons[\"Contacts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables/*@START_MENU_TOKEN@*/.buttons["New Contact  +"]/*[[".cells.buttons[\"New Contact  +\"]",".buttons[\"New Contact  +\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let searchField = app.tables/*@START_MENU_TOKEN@*/.textFields["Search by Account Name or ID"]/*[[".cells.textFields[\"Search by Account Name or ID\"]",".textFields[\"Search by Account Name or ID\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        searchField.tap()
        searchField.typeText("Kalapaki")
        XCUIApplication().otherElements["drop_down"].tables/*@START_MENU_TOKEN@*/.staticTexts["#KALAPAKI JOE'S BILL TO#"]/*[[".cells.staticTexts[\"#KALAPAKI JOE'S BILL TO#\"]",".staticTexts[\"#KALAPAKI JOE'S BILL TO#\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        //app.tables/*@START_MENU_TOKEN@*/.staticTexts["#KALAPAKI JOE'S BILL TO#"]/*[[".cells.staticTexts[\"#KALAPAKI JOE'S BILL TO#\"]",".staticTexts[\"#KALAPAKI JOE'S BILL TO#\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["No"]/*[[".cells.buttons[\"No\"]",".buttons[\"No\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Yes"]/*[[".cells.buttons[\"Yes\"]",".buttons[\"Yes\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let fname = app.tables/*@START_MENU_TOKEN@*/.textFields["First Name"]/*[[".cells.textFields[\"First Name\"]",".textFields[\"First Name\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        fname.tap()
        fname.typeText("xabc")
        let lname = app.tables/*@START_MENU_TOKEN@*/.textFields["Last Name"]/*[[".cells.textFields[\"Last Name\"]",".textFields[\"Last Name\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        lname.tap()
        lname.typeText("xabc")
        let pname = app.tables/*@START_MENU_TOKEN@*/.textFields["Preferred Name"]/*[[".cells.textFields[\"Preferred Name\"]",".textFields[\"Preferred Name\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        pname.tap()
        pname.typeText("xabcxabc")
        app.tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Primary Function / Role*")/*[[".cells.containing(.staticText, identifier:\"Department\")",".cells.containing(.textField, identifier:\"Helper Text\")",".cells.containing(.staticText, identifier:\"Title\")",".cells.containing(.staticText, identifier:\"Primary Function \/ Role*\")"],[[[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.textFields["Select"].tap()
        app.toolbars["Toolbar"].buttons["Cancel"].tap()
        app.tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Primary Function / Role*")/*[[".cells.containing(.staticText, identifier:\"Department\")",".cells.containing(.textField, identifier:\"Helper Text\")",".cells.containing(.staticText, identifier:\"Title\")",".cells.containing(.staticText, identifier:\"Primary Function \/ Role*\")"],[[[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.textFields["Select"].tap()
        app.toolbars["Toolbar"].buttons["Done"].tap()
        let phone = app.tables/*@START_MENU_TOKEN@*/.textFields["(334) 424-0366"]/*[[".cells.textFields[\"(334) 424-0366\"]",".textFields[\"(334) 424-0366\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        phone.tap()
        phone.typeText("(334) 424-0367")
        let fax = app.tables/*@START_MENU_TOKEN@*/.textFields["(555) 555-5555"]/*[[".cells.textFields[\"(555) 555-5555\"]",".textFields[\"(555) 555-5555\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        fax.tap()
        fax.typeText("qwertyqwerty")
        app.swipeUp()
        
        tablesQuery.buttons["Save"].tap()
        tablesQuery/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Phone*")/*[[".cells.containing(.staticText, identifier:\"Fax (Optional)\")",".cells.containing(.staticText, identifier:\"Phone*\")"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .textField).element(boundBy: 1).tap()
        
        let deleteKey = app/*@START_MENU_TOKEN@*/.keys["delete"]/*[[".keyboards.keys[\"delete\"]",".keys[\"delete\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        deleteKey/*@START_MENU_TOKEN@*/.press(forDuration: 4.7);/*[[".tap()",".press(forDuration: 4.7);"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        app/*@START_MENU_TOKEN@*/.buttons["Hide keyboard"]/*[[".keyboards.buttons[\"Hide keyboard\"]",".buttons[\"Hide keyboard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let email = app.tables/*@START_MENU_TOKEN@*/.textFields["name@email.com"]/*[[".cells.textFields[\"name@email.com\"]",".textFields[\"name@email.com\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        email.tap()
        email.typeText("qwertyqwerty")
        app.swipeUp()
        
        app.tables.buttons["Save"].tap()
        app/*@START_MENU_TOKEN@*/.tables.containing(.button, identifier:"Save")/*[[".tables.containing(.staticText, identifier:\"Please correct error above\")",".tables.containing(.button, identifier:\"Save\")"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Email").children(matching: .textField).element.tap()
        
        deleteKey/*@START_MENU_TOKEN@*/.press(forDuration: 4.7);/*[[".tap()",".press(forDuration: 4.7);"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        app/*@START_MENU_TOKEN@*/.buttons["Hide keyboard"]/*[[".keyboards.buttons[\"Hide keyboard\"]",".buttons[\"Hide keyboard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let chours = app.tables/*@START_MENU_TOKEN@*/.textFields["Ex 8-5 PM, M-F"]/*[[".cells.textFields[\"Ex 8-5 PM, M-F\"]",".textFields[\"Ex 8-5 PM, M-F\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        chours.tap()
        chours.typeText("8-5 PM, M-F")
        
        let preferCommunicatn = app.tables/*@START_MENU_TOKEN@*/.textFields["Select One"]/*[[".cells.textFields[\"Select One\"]",".textFields[\"Select One\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        preferCommunicatn.tap()
        app.toolbars["Toolbar"].buttons["Done"].tap()
        app.tables.cells.containing(.staticText, identifier:"Birthday").textFields["Select"].tap()
        app.toolbars["Toolbar"].buttons["Done"].tap()
        app.tables.cells.containing(.staticText, identifier:"Anniversary").textFields["Select"].tap()
        app.toolbars["Toolbar"].buttons["Done"].tap()
        app.swipeUp()
        
        let likes = app.tables.cells.containing(.staticText, identifier:"Likes").children(matching: .textView).element
        likes.tap()
        likes.typeText("Like Like")
        
        let disLike = app.tables.cells.containing(.staticText, identifier:"Dislikes").children(matching: .textView).element
        disLike.tap()
        disLike.typeText("DisLike DisLike")
        app.swipeUp()
        
        let favActivities = app.tables.cells.containing(.staticText, identifier:"Favorite Activities").children(matching: .textView).element
        favActivities.tap()
        favActivities.typeText("Favourite Activities")
        
        let notes = app.tables.cells.containing(.staticText, identifier:"Notes").children(matching: .textView).element
        notes.tap()
        notes.typeText("Notes Here")
        app.tables.buttons["Save"].tap()
        
    }
    
    //Creates contact dynamically
    func testCreateContactDynamically() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Contacts"]/*[[".staticTexts.buttons[\"Contacts\"]",".buttons[\"Contacts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables/*@START_MENU_TOKEN@*/.buttons["New Contact  +"]/*[[".cells.buttons[\"New Contact  +\"]",".buttons[\"New Contact  +\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let searchAccountField = app.tables/*@START_MENU_TOKEN@*/.textFields["Search by Account Name or ID"]/*[[".cells.textFields[\"Search by Account Name or ID\"]",".textFields[\"Search by Account Name or ID\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        searchAccountField.tap()
        searchAccountField.typeText("kala")
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["#KALAPAKI JOE'S BILL TO#"]/*[[".cells.staticTexts[\"#KALAPAKI JOE'S BILL TO#\"]",".staticTexts[\"#KALAPAKI JOE'S BILL TO#\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["No"]/*[[".cells.buttons[\"No\"]",".buttons[\"No\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Yes"]/*[[".cells.buttons[\"Yes\"]",".buttons[\"Yes\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let fname = app.tables/*@START_MENU_TOKEN@*/.textFields["First Name"]/*[[".cells.textFields[\"First Name\"]",".textFields[\"First Name\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        fname.tap()
        fname.typeText("john")
        
        let lname = app.tables/*@START_MENU_TOKEN@*/.textFields["Last Name"]/*[[".cells.textFields[\"Last Name\"]",".textFields[\"Last Name\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        lname.tap()
        lname.typeText("peter")
        
        let pname = app.tables/*@START_MENU_TOKEN@*/.textFields["Preferred Name"]/*[[".cells.textFields[\"Preferred Name\"]",".textFields[\"Preferred Name\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        pname.tap()
        pname.typeText("johnpeter")
        
        let titleField = app.tables/*@START_MENU_TOKEN@*/.textFields["Title"]/*[[".cells.textFields[\"Title\"]",".textFields[\"Title\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        titleField.tap()
        titleField.typeText("title")
        app/*@START_MENU_TOKEN@*/.buttons["Hide keyboard"]/*[[".keyboards.buttons[\"Hide keyboard\"]",".buttons[\"Hide keyboard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let deptField = app.tables/*@START_MENU_TOKEN@*/.textFields["Department"]/*[[".cells.textFields[\"Department\"]",".textFields[\"Department\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        deptField.tap()
        deptField.typeText("Department")
        app/*@START_MENU_TOKEN@*/.buttons["Hide keyboard"]/*[[".keyboards.buttons[\"Hide keyboard\"]",".buttons[\"Hide keyboard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app.tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Primary Function / Role*")/*[[".cells.containing(.staticText, identifier:\"Department\")",".cells.containing(.textField, identifier:\"Helper Text\")",".cells.containing(.staticText, identifier:\"Title\")",".cells.containing(.staticText, identifier:\"Primary Function \/ Role*\")"],[[[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.textFields["Select"].tap()
        app.toolbars["Toolbar"].buttons["Done"].tap()
        
        let phone = app.tables/*@START_MENU_TOKEN@*/.textFields["(334) 424-0366"]/*[[".cells.textFields[\"(334) 424-0366\"]",".textFields[\"(334) 424-0366\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        phone.tap()
        phone.typeText("(427) 828-4327")
        
        //        let fax = app.tables/*@START_MENU_TOKEN@*/.textFields["(555) 555-5555"]/*[[".cells.textFields[\"(555) 555-5555\"]",".textFields[\"(555) 555-5555\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        //        fax.tap()
        //        fax.typeText("(666) 666-6666")
        
        app.swipeUp()
        app.tables.buttons["Save"].tap()
        
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Accounts"]/*[[".staticTexts.buttons[\"Accounts\"]",".buttons[\"Accounts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"03/16/2018")/*[[".cells.containing(.button, identifier:\"92.50%\")",".cells.containing(.staticText, identifier:\"$0.99\")",".cells.containing(.staticText, identifier:\"$3,700.00\")",".cells.containing(.staticText, identifier:\"0\")",".cells.containing(.staticText, identifier:\"P.O. BOX 1231345 White River Junction, New Hampshire 96766\")",".cells.containing(.staticText, identifier:\"11112222\")",".cells.containing(.staticText, identifier:\"03\/16\/2018\")"],[[[-1,6],[-1,5],[-1,4],[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.staticTexts["#KALAPAKI JOE'S BILL TO#"].tap()
        app.buttons["Details"].tap()
        app.swipeUp()
        
        tablesQuery.cells.containing(.staticText, identifier:"Owner").staticTexts["john peter"].tap()
        
        let swsappParentviewNavigationBar = app.navigationBars["SWSApp.ParentView"]
        swsappParentviewNavigationBar.staticTexts["Online"].tap()
        app.staticTexts["Sync Now"].tap()
        
    }
    
    func testCreateDuplicateContactEntry() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Contacts"]/*[[".staticTexts.buttons[\"Contacts\"]",".buttons[\"Contacts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables/*@START_MENU_TOKEN@*/.buttons["New Contact  +"]/*[[".cells.buttons[\"New Contact  +\"]",".buttons[\"New Contact  +\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let searchField = app.tables/*@START_MENU_TOKEN@*/.textFields["Search by Account Name or ID"]/*[[".cells.textFields[\"Search by Account Name or ID\"]",".textFields[\"Search by Account Name or ID\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        searchField.tap()
        searchField.typeText("Kalapaki")
        XCUIApplication().otherElements["drop_down"].tables/*@START_MENU_TOKEN@*/.staticTexts["#KALAPAKI JOE'S BILL TO#"]/*[[".cells.staticTexts[\"#KALAPAKI JOE'S BILL TO#\"]",".staticTexts[\"#KALAPAKI JOE'S BILL TO#\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["No"]/*[[".cells.buttons[\"No\"]",".buttons[\"No\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Yes"]/*[[".cells.buttons[\"Yes\"]",".buttons[\"Yes\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let fname = app.tables/*@START_MENU_TOKEN@*/.textFields["First Name"]/*[[".cells.textFields[\"First Name\"]",".textFields[\"First Name\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        fname.tap()
        fname.typeText("Jane")
        let lname = app.tables/*@START_MENU_TOKEN@*/.textFields["Last Name"]/*[[".cells.textFields[\"Last Name\"]",".textFields[\"Last Name\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        lname.tap()
        lname.typeText("Doe")
        
        app.tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Primary Function / Role*")/*[[".cells.containing(.staticText, identifier:\"Department\")",".cells.containing(.textField, identifier:\"Helper Text\")",".cells.containing(.staticText, identifier:\"Title\")",".cells.containing(.staticText, identifier:\"Primary Function \/ Role*\")"],[[[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.textFields["Select"].tap()
        app.toolbars["Toolbar"].buttons["Done"].tap()
        let phone = app.tables/*@START_MENU_TOKEN@*/.textFields["(334) 424-0366"]/*[[".cells.textFields[\"(334) 424-0366\"]",".textFields[\"(334) 424-0366\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        phone.tap()
        phone.typeText("(215) 867-5309")
        app.swipeUp()
        XCUIApplication().tables.buttons["Save"].tap()
        app.alerts["Alert"].buttons["Ok"].tap()
        
    }
    
    func testAllContacts() {
        
        let app = XCUIApplication()
        XCUIApplication().navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Accounts"]/*[[".staticTexts.buttons[\"Accounts\"]",".buttons[\"Accounts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Clear"].tap()
        
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Blenders Pride"]/*[[".cells.staticTexts[\"Blenders Pride\"]",".staticTexts[\"Blenders Pride\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Details"].tap()
        //XCUIApplication().tables/*@START_MENU_TOKEN@*/.staticTexts["Blenders Pride Contacts"]/*[[".otherElements[\"Blenders Pride Contacts\"].staticTexts[\"Blenders Pride Contacts\"]",".staticTexts[\"Blenders Pride Contacts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCUIApplication().scrollViews.otherElements.tables/*@START_MENU_TOKEN@*/.staticTexts["Blenders Pride Contacts"]/*[[".otherElements[\"Blenders Pride Contacts\"].staticTexts[\"Blenders Pride Contacts\"]",".staticTexts[\"Blenders Pride Contacts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeUp()
        app.swipeUp()
        
    }
    
    func testEditAndCloseContactDetails() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Contacts"]/*[[".staticTexts.buttons[\"Contacts\"]",".buttons[\"Contacts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app.swipeUp()
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"AS")/*[[".cells.containing(.staticText, identifier:\"arytonsennasennaaryton.sennaaryton@xcode.com\")",".cells.containing(.staticText, identifier:\"90909090090\")",".cells.containing(.staticText, identifier:\"Aryton Senna\")",".cells.containing(.staticText, identifier:\"AS\")"],[[[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.staticTexts["Details"].tap()
        tablesQuery/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Preferred Name")/*[[".cells.containing(.staticText, identifier:\"Visit planning\")",".cells.containing(.staticText, identifier:\"Notes\")",".cells.containing(.staticText, identifier:\"Preferred Contact Method\")",".cells.containing(.staticText, identifier:\"Favorites Anuroop\")",".cells.containing(.staticText, identifier:\"Favorite Activities\")",".cells.containing(.staticText, identifier:\"Cricket\")",".cells.containing(.staticText, identifier:\"Dislikes\")",".cells.containing(.staticText, identifier:\"I’ll\")",".cells.containing(.staticText, identifier:\"Likes\")",".cells.containing(.staticText, identifier:\"Children\")",".cells.containing(.staticText, identifier:\"11\/02\/2002\")",".cells.containing(.staticText, identifier:\"Anniversary\")",".cells.containing(.staticText, identifier:\"09\/06\/1987\")",".cells.containing(.staticText, identifier:\"Birthday\")",".cells.containing(.staticText, identifier:\"7 to 9 M-S\")",".cells.containing(.staticText, identifier:\"Contact Hours\")",".cells.containing(.staticText, identifier:\"(666) 555-5559\")",".cells.containing(.staticText, identifier:\"Fax\")",".cells.containing(.staticText, identifier:\"Takeaway\")",".cells.containing(.staticText, identifier:\"Department\")",".cells.containing(.staticText, identifier:\"Unit head\")",".cells.containing(.staticText, identifier:\"Title\")",".cells.containing(.staticText, identifier:\"finch\")",".cells.containing(.staticText, identifier:\"Preferred Name\")"],[[[-1,23],[-1,22],[-1,21],[-1,20],[-1,19],[-1,18],[-1,17],[-1,16],[-1,15],[-1,14],[-1,13],[-1,12],[-1,11],[-1,10],[-1,9],[-1,8],[-1,7],[-1,6],[-1,5],[-1,4],[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.buttons["Edit"].tap()
        
        let titleField = app.tables/*@START_MENU_TOKEN@*/.textFields["titleTextFieldID"]/*[[".cells",".textFields[\"Title\"]",".textFields[\"titleTextFieldID\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        titleField.tap()
        titleField.typeText("Title")
        app/*@START_MENU_TOKEN@*/.buttons["Hide keyboard"]/*[[".keyboards.buttons[\"Hide keyboard\"]",".buttons[\"Hide keyboard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let closeButton = app.buttons["Close"]
        closeButton.tap()
        XCUIApplication().alerts["Any changes will not be saved"].buttons["No"].tap()
        closeButton.tap()
        XCUIApplication().alerts["Any changes will not be saved"].buttons["Yes"].tap()
        
    }
    
    func testEditAndSaveContactDetails() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Contacts"]/*[[".staticTexts.buttons[\"Contacts\"]",".buttons[\"Contacts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let searchField = app.searchFields["Name, Account, ID"]
        searchField.tap()
        searchField.typeText("Aryton")
        XCUIApplication().tables/*@START_MENU_TOKEN@*/.staticTexts["Aryton Senna"]/*[[".cells.staticTexts[\"Aryton Senna\"]",".staticTexts[\"Aryton Senna\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Preferred Name")/*[[".cells.containing(.staticText, identifier:\"Visit planning\")",".cells.containing(.staticText, identifier:\"Notes\")",".cells.containing(.staticText, identifier:\"Preferred Contact Method\")",".cells.containing(.staticText, identifier:\"Favorites Anuroop\")",".cells.containing(.staticText, identifier:\"Favorite Activities\")",".cells.containing(.staticText, identifier:\"Cricket\")",".cells.containing(.staticText, identifier:\"Dislikes\")",".cells.containing(.staticText, identifier:\"I’ll\")",".cells.containing(.staticText, identifier:\"Likes\")",".cells.containing(.staticText, identifier:\"Children\")",".cells.containing(.staticText, identifier:\"11\/02\/2002\")",".cells.containing(.staticText, identifier:\"Anniversary\")",".cells.containing(.staticText, identifier:\"09\/06\/1987\")",".cells.containing(.staticText, identifier:\"Birthday\")",".cells.containing(.staticText, identifier:\"7 to 9 M-S\")",".cells.containing(.staticText, identifier:\"Contact Hours\")",".cells.containing(.staticText, identifier:\"(666) 555-5559\")",".cells.containing(.staticText, identifier:\"Fax\")",".cells.containing(.staticText, identifier:\"Takeaway\")",".cells.containing(.staticText, identifier:\"Department\")",".cells.containing(.staticText, identifier:\"Unit head\")",".cells.containing(.staticText, identifier:\"Title\")",".cells.containing(.staticText, identifier:\"finch\")",".cells.containing(.staticText, identifier:\"Preferred Name\")"],[[[-1,23],[-1,22],[-1,21],[-1,20],[-1,19],[-1,18],[-1,17],[-1,16],[-1,15],[-1,14],[-1,13],[-1,12],[-1,11],[-1,10],[-1,9],[-1,8],[-1,7],[-1,6],[-1,5],[-1,4],[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.buttons["Edit"].tap()
        XCUIApplication().tables.buttons["Save"].tap()
        
    }
    
    func testEditContactDynamically() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Contacts"]/*[[".staticTexts.buttons[\"Contacts\"]",".buttons[\"Contacts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let search = app.searchFields["Name, Account, ID"]
        search.tap()
        search.typeText("John")
        app/*@START_MENU_TOKEN@*/.buttons["Hide keyboard"]/*[[".keyboards.buttons[\"Hide keyboard\"]",".buttons[\"Hide keyboard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Submit"].tap()
        
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["john peter"]/*[[".cells.staticTexts[\"john peter\"]",".staticTexts[\"john peter\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Preferred Name")/*[[".cells.containing(.staticText, identifier:\"Notes\")",".cells.containing(.staticText, identifier:\"Preferred Contact Method\")",".cells.containing(.staticText, identifier:\"Favorite Activities\")",".cells.containing(.staticText, identifier:\"Dislikes\")",".cells.containing(.staticText, identifier:\"Likes\")",".cells.containing(.staticText, identifier:\"Family\")",".cells.containing(.staticText, identifier:\"Anniversary\")",".cells.containing(.staticText, identifier:\"Birthday\")",".cells.containing(.staticText, identifier:\"Contact Hours\")",".cells.containing(.staticText, identifier:\"Fax\")",".cells.containing(.staticText, identifier:\"Department\")",".cells.containing(.staticText, identifier:\"title\")",".cells.containing(.staticText, identifier:\"Title\")",".cells.containing(.staticText, identifier:\"johnpeter\")",".cells.containing(.staticText, identifier:\"Preferred Name\")"],[[[-1,14],[-1,13],[-1,12],[-1,11],[-1,10],[-1,9],[-1,8],[-1,7],[-1,6],[-1,5],[-1,4],[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.buttons["Edit"].tap()
        
        let faxField = app.tables/*@START_MENU_TOKEN@*/.textFields["(555) 555-5555"]/*[[".cells.textFields[\"(555) 555-5555\"]",".textFields[\"(555) 555-5555\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        faxField.tap()
        faxField.typeText("5555555555")
        
        XCUIApplication().tables.cells.containing(.staticText, identifier:"Preferred Communication Method").children(matching: .textField).element.tap()
        app.pickerWheels.element.adjust(toPickerWheelValue: "Fax")
        app.toolbars["Toolbar"].buttons["Done"].tap()
        
        app.tables.buttons["Save"].tap()
        
    }
    
    func testLinkAccount() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Contacts"]/*[[".staticTexts.buttons[\"Contacts\"]",".buttons[\"Contacts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let searchField = app.searchFields["Name, Account, ID"]
        searchField.tap()
        searchField.typeText("Aryton")
        XCUIApplication().tables/*@START_MENU_TOKEN@*/.staticTexts["Aryton Senna"]/*[[".cells.staticTexts[\"Aryton Senna\"]",".staticTexts[\"Aryton Senna\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let tablesQuery = XCUIApplication().tables
        app.swipeUp()
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Link New Account"]/*[[".cells.buttons[\"Link New Account\"]",".buttons[\"Link New Account\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables/*@START_MENU_TOKEN@*/.textFields["Search by Account Name or ID"]/*[[".cells.textFields[\"Search by Account Name or ID\"]",".textFields[\"Search by Account Name or ID\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCUIApplication().tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"FSTR9923")/*[[".cells.containing(.button, identifier:\"Close\")",".cells.containing(.staticText, identifier:\"Foster Street Florida, Florida AP 666555\")",".cells.containing(.staticText, identifier:\"FSTR9923\")"],[[[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.staticTexts["Fosters Beer Parlour"].tap()
        XCUIApplication().tables/*@START_MENU_TOKEN@*/.buttons["Close"]/*[[".cells.buttons[\"Close\"]",".buttons[\"Close\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app.tables.buttons["Save"].tap()
        
        app.tables/*@START_MENU_TOKEN@*/.textFields["Search by Account Name or ID"]/*[[".cells.textFields[\"Search by Account Name or ID\"]",".textFields[\"Search by Account Name or ID\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCUIApplication().tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"FSTR9923")/*[[".cells.containing(.button, identifier:\"Close\")",".cells.containing(.staticText, identifier:\"Foster Street Florida, Florida AP 666555\")",".cells.containing(.staticText, identifier:\"FSTR9923\")"],[[[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.staticTexts["Fosters Beer Parlour"].tap()
        app.tables.buttons["Save"].tap()
        
        app.tables.cells.containing(.staticText, identifier:"Primary Function / Role*").textFields["Select"].tap()
        app.toolbars["Toolbar"].buttons["Done"].tap()
        
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["No"]/*[[".cells.buttons[\"No\"]",".buttons[\"No\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables.buttons["Save"].tap()
        
        app.tables.cells.containing(.staticText, identifier:"Contact Classification*").textFields["Select"].tap()
        app.pickerWheels.element.adjust(toPickerWheelValue: "Other")
        app.toolbars["Toolbar"].buttons["Done"].tap()
        app.tables.buttons["Save"].tap()
        
        let specifyField = app.tables/*@START_MENU_TOKEN@*/.textFields["Please Specify*"]/*[[".cells.textFields[\"Please Specify*\"]",".textFields[\"Please Specify*\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        specifyField.tap()
        specifyField.typeText("Others")
        XCUIApplication()/*@START_MENU_TOKEN@*/.buttons["Hide keyboard"]/*[[".keyboards.buttons[\"Hide keyboard\"]",".buttons[\"Hide keyboard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let button = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .button).element
        button.tap()
        
        let anyChangesWillNotBeSavedAlert = app.alerts["Any changes will not be saved"]
        anyChangesWillNotBeSavedAlert.buttons["No"].tap()
        
        XCUIApplication().tables/*@START_MENU_TOKEN@*/.buttons["Yes"]/*[[".cells.buttons[\"Yes\"]",".buttons[\"Yes\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables.buttons["Save"].tap()
        
        app.navigationBars["SWSApp.ParentView"].staticTexts["Online"].tap()
        app.staticTexts["Sync Now"].tap()
        
    }
    
    //Edit the account linked
    func testLinkAccountsEdit() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Contacts"]/*[[".staticTexts.buttons[\"Contacts\"]",".buttons[\"Contacts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        //app.tables/*@START_MENU_TOKEN@*/.staticTexts["john peter"]/*[[".cells.staticTexts[\"john peter\"]",".staticTexts[\"john peter\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["AH"]/*[[".cells.staticTexts[\"AH\"]",".staticTexts[\"AH\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.swipeUp()
        //XCUIApplication().tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Chain Buyer")/*[[".cells.containing(.button, identifier:\"  Unlink\")",".cells.containing(.staticText, identifier:\"Florida, Florida AP 666555\")",".cells.containing(.staticText, identifier:\"Foster Street\")",".cells.containing(.staticText, identifier:\"FSTR9923\")",".cells.containing(.staticText, identifier:\"Buyer\")",".cells.containing(.staticText, identifier:\"Chain Buyer\")"],[[[-1,5],[-1,4],[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.buttons["Edit"].tap()
        
        XCUIApplication().tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Owner")/*[[".cells.containing(.button, identifier:\"  Unlink\")",".cells.containing(.staticText, identifier:\"Florida, Florida AP 666555\")",".cells.containing(.staticText, identifier:\"Foster Street\")",".cells.containing(.staticText, identifier:\"FSTR9923\")",".cells.containing(.staticText, identifier:\"Buyer\")",".cells.containing(.staticText, identifier:\"Owner\")"],[[[-1,5],[-1,4],[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.buttons["Edit"].tap()
        
        XCUIApplication().tables.cells.containing(.staticText, identifier:"Primary Function / Role*").children(matching: .textField).element.tap()
        app.pickerWheels.element.adjust(toPickerWheelValue: "Outlet Manager")
        app.toolbars["Toolbar"].buttons["Done"].tap()
        
        app.buttons["  Unlink Account"].tap()
        app.alerts["Cannot unlink, this is the only linked account."].buttons["OK"].tap()
        
        let closeButton = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .button)["Close"]
        closeButton.tap()
        
        let anyChangesWillNotBeSavedAlert = app.alerts["Any changes will not be saved"]
        anyChangesWillNotBeSavedAlert.buttons["No"].tap()
        closeButton.tap()
        anyChangesWillNotBeSavedAlert.buttons["Yes"].tap()
        
    }
    
    func testLinkAlreadyLinkedAccount() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Contacts"]/*[[".staticTexts.buttons[\"Contacts\"]",".buttons[\"Contacts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let searchField = app.searchFields["Name, Account, ID"]
        searchField.tap()
        searchField.typeText("Aryton")
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Aryton Senna"]/*[[".cells.staticTexts[\"Aryton Senna\"]",".staticTexts[\"Aryton Senna\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let tablesQuery = XCUIApplication().tables
        app.swipeUp()
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Link New Account"]/*[[".cells.buttons[\"Link New Account\"]",".buttons[\"Link New Account\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app.tables/*@START_MENU_TOKEN@*/.textFields["Search by Account Name or ID"]/*[[".cells.textFields[\"Search by Account Name or ID\"]",".textFields[\"Search by Account Name or ID\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCUIApplication()/*@START_MENU_TOKEN@*/.tables.cells.containing(.staticText, identifier:"Street #101 California, Indiana 111999").staticTexts["Aus Lounge Bar"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"Aus Lounge Bar\"]",".staticTexts[\"Aus Lounge Bar\"]",".tables.cells.containing(.staticText, identifier:\"Street #101 California, Indiana 111999\").staticTexts[\"Aus Lounge Bar\"]"],[[[-1,3],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.alerts["This account is already linked."].buttons["Ok"].tap()
        
    }
    
    func testLinkAccountsEditAndSave() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Contacts"]/*[[".staticTexts.buttons[\"Contacts\"]",".buttons[\"Contacts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let searchField = app.searchFields["Name, Account, ID"]
        searchField.tap()
        searchField.typeText("Aryton")
        XCUIApplication().tables/*@START_MENU_TOKEN@*/.staticTexts["Aryton Senna"]/*[[".cells.staticTexts[\"Aryton Senna\"]",".staticTexts[\"Aryton Senna\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.swipeUp()
        
        XCUIApplication().tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"FSTR9923")/*[[".cells.containing(.staticText, identifier:\"Florida, Florida AP 666555\")",".cells.containing(.staticText, identifier:\"Foster Street\")",".cells.containing(.staticText, identifier:\"FSTR9923\")"],[[[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.buttons["Edit"].tap()
        
        XCUIApplication().tables.cells.containing(.staticText, identifier:"Primary Function / Role*").children(matching: .textField).element.tap()
        app.pickerWheels.element.adjust(toPickerWheelValue: "Regional Manager")
        XCUIApplication().toolbars["Toolbar"].buttons["Done"].tap()
        XCUIApplication().tables.buttons["Save"].tap()
        
        app.swipeUp()
        
    }
    
    func testUnLinkAccount() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Contacts"]/*[[".staticTexts.buttons[\"Contacts\"]",".buttons[\"Contacts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["AH"]/*[[".cells.staticTexts[\"AH\"]",".staticTexts[\"AH\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.swipeUp()
        app.tables/*@START_MENU_TOKEN@*/.buttons["  Unlink"]/*[[".cells.buttons[\"  Unlink\"]",".buttons[\"  Unlink\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.alerts.buttons["OK"].tap()
        
    }
    
    // Test pickers in Create new contact
    func testPrimaryFunctionPicker() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Contacts"]/*[[".staticTexts.buttons[\"Contacts\"]",".buttons[\"Contacts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables/*@START_MENU_TOKEN@*/.buttons["New Contact  +"]/*[[".cells.buttons[\"New Contact  +\"]",".buttons[\"New Contact  +\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app.tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Primary Function / Role*")/*[[".cells.containing(.staticText, identifier:\"Department\")",".cells.containing(.textField, identifier:\"Helper Text\")",".cells.containing(.staticText, identifier:\"Title\")",".cells.containing(.staticText, identifier:\"Primary Function \/ Role*\")"],[[[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.textFields["Select"].tap()
        app.toolbars["Toolbar"].buttons["Cancel"].tap()
        app.tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Primary Function / Role*")/*[[".cells.containing(.staticText, identifier:\"Department\")",".cells.containing(.textField, identifier:\"Helper Text\")",".cells.containing(.staticText, identifier:\"Title\")",".cells.containing(.staticText, identifier:\"Primary Function \/ Role*\")"],[[[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.textFields["Select"].tap()
        
        app.pickerWheels.element.adjust(toPickerWheelValue: "Owner")
        app.toolbars["Toolbar"].buttons["Done"].tap()
        
    }
    
    func testContactClassificationPicker() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Contacts"]/*[[".staticTexts.buttons[\"Contacts\"]",".buttons[\"Contacts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["New Contact  +"]/*[[".cells.buttons[\"New Contact  +\"]",".buttons[\"New Contact  +\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["No"]/*[[".cells.buttons[\"No\"]",".buttons[\"No\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app.tables.cells.containing(.staticText, identifier:"Contact Classification*").textFields["Select"].tap()
        app.toolbars["Toolbar"].buttons["Cancel"].tap()
        app.tables.cells.containing(.staticText, identifier:"Contact Classification*").textFields["Select"].tap()
        app.toolbars["Toolbar"].buttons["Done"].tap()
        
    }
    
    func testOtherInContactClassification() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Contacts"]/*[[".staticTexts.buttons[\"Contacts\"]",".buttons[\"Contacts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["New Contact  +"]/*[[".cells.buttons[\"New Contact  +\"]",".buttons[\"New Contact  +\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCUIApplication().tables/*@START_MENU_TOKEN@*/.textFields["Search by Account Name or ID"]/*[[".cells.textFields[\"Search by Account Name or ID\"]",".textFields[\"Search by Account Name or ID\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.cells.containing(.staticText, identifier:"ACC111").staticTexts["Aus Lounge Bar"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"Aus Lounge Bar\"]",".staticTexts[\"Aus Lounge Bar\"]",".tables",".cells.containing(.staticText, identifier:\"Street #101 California, Indiana 111999\").staticTexts[\"Aus Lounge Bar\"]",".cells.containing(.staticText, identifier:\"ACC111\").staticTexts[\"Aus Lounge Bar\"]"],[[[-1,3,2],[-1,0,1]],[[-1,2],[-1,1]],[[-1,5],[-1,4]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["No"]/*[[".cells.buttons[\"No\"]",".buttons[\"No\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app.tables.cells.containing(.staticText, identifier:"Contact Classification*").textFields["Select"].tap()
        app.pickerWheels.element.adjust(toPickerWheelValue: "Other")
        app.toolbars["Toolbar"].buttons["Done"].tap()
        
        app.swipeUp()
        XCUIApplication().tables.buttons["Save"].tap()
        
    }
    
    func testTypeTextInOther() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Contacts"]/*[[".staticTexts.buttons[\"Contacts\"]",".buttons[\"Contacts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["New Contact  +"]/*[[".cells.buttons[\"New Contact  +\"]",".buttons[\"New Contact  +\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["No"]/*[[".cells.buttons[\"No\"]",".buttons[\"No\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app.tables.cells.containing(.staticText, identifier:"Contact Classification*").textFields["Select"].tap()
        app.pickerWheels.element.adjust(toPickerWheelValue: "Other")
        app.toolbars["Toolbar"].buttons["Done"].tap()
        
        let specifyId = app.tables/*@START_MENU_TOKEN@*/.textFields["Please Specify*"]/*[[".cells.textFields[\"Please Specify*\"]",".textFields[\"Please Specify*\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        specifyId.tap()
        specifyId.typeText("abc")
    }
    
    func testPreferredCommunicationPicker() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Contacts"]/*[[".staticTexts.buttons[\"Contacts\"]",".buttons[\"Contacts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables/*@START_MENU_TOKEN@*/.buttons["New Contact  +"]/*[[".cells.buttons[\"New Contact  +\"]",".buttons[\"New Contact  +\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let tablesQuery = XCUIApplication().tables
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["dropDownLight"]/*[[".cells",".textFields[\"Select One\"].buttons[\"dropDownLight\"]",".buttons[\"dropDownLight\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.textFields["Select One"]/*[[".cells.textFields[\"Select One\"]",".textFields[\"Select One\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app/*@START_MENU_TOKEN@*/.pickerWheels["Phone"].press(forDuration: 0.8);/*[[".pickers.pickerWheels[\"Phone\"]",".tap()",".press(forDuration: 0.8);",".pickerWheels[\"Phone\"]"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/
        app.toolbars["Toolbar"].buttons["Cancel"].tap()
        
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["dropDownLight"]/*[[".cells",".textFields[\"Select One\"].buttons[\"dropDownLight\"]",".buttons[\"dropDownLight\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.textFields["Select One"]/*[[".cells.textFields[\"Select One\"]",".textFields[\"Select One\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app/*@START_MENU_TOKEN@*/.pickerWheels["Phone"].press(forDuration: 0.8);/*[[".pickers.pickerWheels[\"Phone\"]",".tap()",".press(forDuration: 0.8);",".pickerWheels[\"Phone\"]"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/
        app.pickerWheels.element.adjust(toPickerWheelValue: "Email")
        app.toolbars["Toolbar"].buttons["Done"].tap()
        
    }
    
    func testBirthdayPicker() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Contacts"]/*[[".staticTexts.buttons[\"Contacts\"]",".buttons[\"Contacts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables/*@START_MENU_TOKEN@*/.buttons["New Contact  +"]/*[[".cells.buttons[\"New Contact  +\"]",".buttons[\"New Contact  +\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.swipeUp()
        
        app.tables.cells.containing(.staticText, identifier:"Birthday").textFields["Select"].tap()
        let datePickersQuery = app.datePickers
        datePickersQuery.pickerWheels["2018"].swipeLeft()
        app.toolbars["Toolbar"].buttons["Cancel"].tap()
        
        app.tables.cells.containing(.staticText, identifier:"Birthday").textFields["Select"].tap()
        datePickersQuery.pickerWheels.element(boundBy: 0).adjust(toPickerWheelValue: "March")
        datePickersQuery.pickerWheels.element(boundBy: 1).adjust(toPickerWheelValue: "10")
        datePickersQuery.pickerWheels.element(boundBy: 2).adjust(toPickerWheelValue: "2000")
        app.toolbars["Toolbar"].buttons["Done"].tap()
        
    }
    
    func testAnniversaryPicker() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Contacts"]/*[[".staticTexts.buttons[\"Contacts\"]",".buttons[\"Contacts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables/*@START_MENU_TOKEN@*/.buttons["New Contact  +"]/*[[".cells.buttons[\"New Contact  +\"]",".buttons[\"New Contact  +\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.swipeUp()
        
        app.tables.cells.containing(.staticText, identifier:"Anniversary").textFields["Select"].tap()
        
        let datePickersQuery = app.datePickers
        datePickersQuery.pickerWheels["2018"].swipeLeft()
        app.toolbars["Toolbar"].buttons["Cancel"].tap()
        
        app.tables.cells.containing(.staticText, identifier:"Anniversary").textFields["Select"].tap()
        datePickersQuery.pickerWheels.element(boundBy: 0).adjust(toPickerWheelValue: "April")
        datePickersQuery.pickerWheels.element(boundBy: 1).adjust(toPickerWheelValue: "16")
        datePickersQuery.pickerWheels.element(boundBy: 2).adjust(toPickerWheelValue: "1997")
        app.toolbars["Toolbar"].buttons["Done"].tap()
        
    }
    
    func testFamilyPicker() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Contacts"]/*[[".staticTexts.buttons[\"Contacts\"]",".buttons[\"Contacts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables/*@START_MENU_TOKEN@*/.buttons["New Contact  +"]/*[[".cells.buttons[\"New Contact  +\"]",".buttons[\"New Contact  +\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.swipeUp()
        
        let contactHours = app/*@START_MENU_TOKEN@*/.textFields["Ex 8-5 PM, M-F"]/*[[".cells.textFields[\"Ex 8-5 PM, M-F\"]",".textFields[\"Ex 8-5 PM, M-F\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        contactHours.tap()
        contactHours.typeText("Name")
        app/*@START_MENU_TOKEN@*/.buttons["Hide keyboard"]/*[[".keyboards.buttons[\"Hide keyboard\"]",".buttons[\"Hide keyboard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.swipeUp()
        
        app.tables.containing(.button, identifier:"Save").children(matching: .cell).element(boundBy: 10).textFields["Select"].tap()
        let datePickersQuery = app.datePickers
        datePickersQuery.pickerWheels.element(boundBy: 0).adjust(toPickerWheelValue: "June")
        datePickersQuery.pickerWheels.element(boundBy: 1).adjust(toPickerWheelValue: "1")
        datePickersQuery.pickerWheels.element(boundBy: 2).adjust(toPickerWheelValue: "2000")
        app.toolbars["Toolbar"].buttons["Done"].tap()
        
        let familyField1 = app.tables.containing(.button, identifier:"Save").children(matching: .cell).element(boundBy: 11).textFields["Name"]
        familyField1.tap()
        familyField1.typeText("Name1")
        app.tables.containing(.button, identifier:"Save").children(matching: .cell).element(boundBy: 11).textFields["Select"].tap()
        datePickersQuery.pickerWheels.element(boundBy: 0).adjust(toPickerWheelValue: "July")
        datePickersQuery.pickerWheels.element(boundBy: 1).adjust(toPickerWheelValue: "19")
        datePickersQuery.pickerWheels.element(boundBy: 2).adjust(toPickerWheelValue: "2002")
        app.toolbars["Toolbar"].buttons["Done"].tap()
        
        let familyField2 = app.tables.containing(.button, identifier:"Save").children(matching: .cell).element(boundBy: 12).textFields["Name"]
        familyField2.tap()
        familyField2.typeText("Name2")
        app.tables.containing(.button, identifier:"Save").children(matching: .cell).element(boundBy: 12).textFields["Select"].tap()
        datePickersQuery.pickerWheels.element(boundBy: 0).adjust(toPickerWheelValue: "March")
        datePickersQuery.pickerWheels.element(boundBy: 1).adjust(toPickerWheelValue: "5")
        datePickersQuery.pickerWheels.element(boundBy: 2).adjust(toPickerWheelValue: "2005")
        app.toolbars["Toolbar"].buttons["Done"].tap()
        
        let familyField3 = app.tables.containing(.button, identifier:"Save").children(matching: .cell).element(boundBy: 13).textFields["Name"]
        familyField3.tap()
        familyField3.typeText("Name3")
        app.tables.containing(.button, identifier:"Save").children(matching: .cell).element(boundBy: 13).textFields["Select"].tap()
        datePickersQuery.pickerWheels.element(boundBy: 0).adjust(toPickerWheelValue: "April")
        datePickersQuery.pickerWheels.element(boundBy: 1).adjust(toPickerWheelValue: "23")
        datePickersQuery.pickerWheels.element(boundBy: 2).adjust(toPickerWheelValue: "2009")
        app.toolbars["Toolbar"].buttons["Done"].tap()
        
        let familyField4 = app.tables.containing(.button, identifier:"Save").children(matching: .cell).element(boundBy: 14).textFields["Name"]
        familyField4.tap()
        familyField4.typeText("Name4")
        app.tables.containing(.button, identifier:"Save").children(matching: .cell).element(boundBy: 14).textFields["Select"].tap()
        datePickersQuery.pickerWheels.element(boundBy: 0).adjust(toPickerWheelValue: "October")
        datePickersQuery.pickerWheels.element(boundBy: 1).adjust(toPickerWheelValue: "9")
        datePickersQuery.pickerWheels.element(boundBy: 2).adjust(toPickerWheelValue: "2012")
        app.toolbars["Toolbar"].buttons["Done"].tap()
        
        let familyField5 = app.tables.containing(.button, identifier:"Save").children(matching: .cell).element(boundBy: 15).textFields["Name"]
        familyField5.tap()
        familyField5.typeText("Name5")
        app.tables.containing(.button, identifier:"Save").children(matching: .cell).element(boundBy: 15).textFields["Select"].tap()
        datePickersQuery.pickerWheels.element(boundBy: 0).adjust(toPickerWheelValue: "March")
        datePickersQuery.pickerWheels.element(boundBy: 1).adjust(toPickerWheelValue: "24")
        datePickersQuery.pickerWheels.element(boundBy: 2).adjust(toPickerWheelValue: "2012")
        app.toolbars["Toolbar"].buttons["Done"].tap()
        
    }
    
    func testPageControl() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Contacts"]/*[[".staticTexts.buttons[\"Contacts\"]",".buttons[\"Contacts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let firstPageButton = app.buttons["<   First Page"]
        firstPageButton.tap()
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
        app.buttons["<   First Page"].tap()
        firstPageButton.tap()
        
    }
    
    // Validation for all fields in Create New Contact
    func testValidation() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Contacts"]/*[[".staticTexts.buttons[\"Contacts\"]",".buttons[\"Contacts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["New Contact  +"]/*[[".cells.buttons[\"New Contact  +\"]",".buttons[\"New Contact  +\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.swipeUp()
        XCUIApplication().tables.buttons["Save"].tap()
        
        app.tables/*@START_MENU_TOKEN@*/.textFields["Search by Account Name or ID"]/*[[".cells.textFields[\"Search by Account Name or ID\"]",".textFields[\"Search by Account Name or ID\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["#KALAPAKI JOE'S BILL TO#"]/*[[".cells.staticTexts[\"#KALAPAKI JOE'S BILL TO#\"]",".staticTexts[\"#KALAPAKI JOE'S BILL TO#\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCUIApplication().tables.buttons["Save"].tap()
        
        app.tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Primary Function / Role*")/*[[".cells.containing(.staticText, identifier:\"Department\")",".cells.containing(.textField, identifier:\"Helper Text\")",".cells.containing(.staticText, identifier:\"Title\")",".cells.containing(.staticText, identifier:\"Primary Function \/ Role*\")"],[[[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.textFields["Select"].tap()
        app.toolbars["Toolbar"].buttons["Done"].tap()
        app.swipeUp()
        XCUIApplication().tables.buttons["Save"].tap()
        
        let fname = app.tables/*@START_MENU_TOKEN@*/.textFields["First Name"]/*[[".cells.textFields[\"First Name\"]",".textFields[\"First Name\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        fname.tap()
        fname.typeText("firstName")
        app.swipeUp()
        XCUIApplication().tables.buttons["Save"].tap()
        
        let lname = app.tables/*@START_MENU_TOKEN@*/.textFields["Last Name"]/*[[".cells.textFields[\"Last Name\"]",".textFields[\"Last Name\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        lname.tap()
        lname.typeText("lastName")
        app.swipeUp()
        XCUIApplication().tables.buttons["Save"].tap()
        
        let phoneField = app.tables/*@START_MENU_TOKEN@*/.textFields["(334) 424-0366"]/*[[".cells.textFields[\"(334) 424-0366\"]",".textFields[\"(334) 424-0366\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        phoneField.tap()
        phoneField.typeText("3452718377")
        app.swipeUp()
        XCUIApplication().tables.buttons["Save"].tap()
        
    }
    
    func testSearchAccountDropDownReturn() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Contacts"]/*[[".staticTexts.buttons[\"Contacts\"]",".buttons[\"Contacts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables/*@START_MENU_TOKEN@*/.buttons["New Contact  +"]/*[[".cells.buttons[\"New Contact  +\"]",".buttons[\"New Contact  +\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables/*@START_MENU_TOKEN@*/.textFields["Search by Account Name or ID"]/*[[".cells.textFields[\"Search by Account Name or ID\"]",".textFields[\"Search by Account Name or ID\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCUIApplication()/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"return\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        
    }
    
    //Invalid phone number entry validation
    func testPhoneCellValidation() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Contacts"]/*[[".staticTexts.buttons[\"Contacts\"]",".buttons[\"Contacts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables/*@START_MENU_TOKEN@*/.buttons["New Contact  +"]/*[[".cells.buttons[\"New Contact  +\"]",".buttons[\"New Contact  +\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables/*@START_MENU_TOKEN@*/.textFields["Search by Account Name or ID"]/*[[".cells.textFields[\"Search by Account Name or ID\"]",".textFields[\"Search by Account Name or ID\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["#KALAPAKI JOE'S BILL TO#"]/*[[".cells.staticTexts[\"#KALAPAKI JOE'S BILL TO#\"]",".staticTexts[\"#KALAPAKI JOE'S BILL TO#\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["No"]/*[[".cells.buttons[\"No\"]",".buttons[\"No\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Yes"]/*[[".cells.buttons[\"Yes\"]",".buttons[\"Yes\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let fname = app.tables/*@START_MENU_TOKEN@*/.textFields["First Name"]/*[[".cells.textFields[\"First Name\"]",".textFields[\"First Name\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        fname.tap()
        fname.typeText("john")
        let lname = app.tables/*@START_MENU_TOKEN@*/.textFields["Last Name"]/*[[".cells.textFields[\"Last Name\"]",".textFields[\"Last Name\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        lname.tap()
        lname.typeText("peter")
        
        app.tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Primary Function / Role*")/*[[".cells.containing(.staticText, identifier:\"Department\")",".cells.containing(.textField, identifier:\"Helper Text\")",".cells.containing(.staticText, identifier:\"Title\")",".cells.containing(.staticText, identifier:\"Primary Function \/ Role*\")"],[[[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.textFields["Select"].tap()
        app.toolbars["Toolbar"].buttons["Done"].tap()
        let phone = app.tables/*@START_MENU_TOKEN@*/.textFields["(334) 424-0366"]/*[[".cells.textFields[\"(334) 424-0366\"]",".textFields[\"(334) 424-0366\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        phone.tap()
        phone.typeText("(676) 554-abcd")
        app.swipeUp()
        XCUIApplication().tables.buttons["Save"].tap()
        
    }
    
}
