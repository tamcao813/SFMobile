//
//  NotesUITests.swift
//  SWSAppUITests
//
//  Created by Krishna, Kamya on 7/26/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import XCTest

class AaaNotesUITests: XCTestCase {
        
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
    
    func testSortNoteTitle(){
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Accounts"]/*[[".staticTexts.buttons[\"Accounts\"]",".buttons[\"Accounts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["#KALAPAKI JOE'S BILL TO#"]/*[[".cells.staticTexts[\"#KALAPAKI JOE'S BILL TO#\"]",".staticTexts[\"#KALAPAKI JOE'S BILL TO#\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Notes"].tap()
        
        let notesTitleStaticText = tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Notes Title"]/*[[".otherElements[\"Notes Title\"]",".cells.staticTexts[\"Notes Title\"]",".staticTexts[\"Notes Title\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        notesTitleStaticText.tap()
        notesTitleStaticText.tap()
        notesTitleStaticText.tap()
        
    }
    
    func testSortDateModified(){
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Accounts"]/*[[".staticTexts.buttons[\"Accounts\"]",".buttons[\"Accounts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["#KALAPAKI JOE'S BILL TO#"]/*[[".cells.staticTexts[\"#KALAPAKI JOE'S BILL TO#\"]",".staticTexts[\"#KALAPAKI JOE'S BILL TO#\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Notes"].tap()
        let dateModifiedStaticText = tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Date Modified"]/*[[".otherElements[\"Notes Title\"]",".cells.staticTexts[\"Date Modified\"]",".staticTexts[\"Date Modified\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        dateModifiedStaticText.tap()
        dateModifiedStaticText.tap()
        dateModifiedStaticText.tap()
        
    }
    
    //Create new note from Add New+ button
    func testCreateNewNote(){
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Accounts"]/*[[".staticTexts.buttons[\"Accounts\"]",".buttons[\"Accounts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables.containing(.other, identifier:"Account Name").children(matching: .cell).element(boundBy: 1).staticTexts["  Details"].tap()
        app.buttons["Add New  +"].tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["Note"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"Note\"]",".staticTexts[\"Note\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Save & Close"].tap()
        
        let closeButton = app.buttons["close"]
        closeButton.tap()
        
    }
    
    func testCreateNewNoteUsingTypeText(){
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Accounts"]/*[[".staticTexts.buttons[\"Accounts\"]",".buttons[\"Accounts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"11112222")/*[[".cells.containing(.staticText, identifier:\"03\/16\/2018\")",".cells.containing(.staticText, identifier:\"#KALAPAKI JOE'S BILL TO#\")",".cells.containing(.staticText, identifier:\"$0.99\")",".cells.containing(.staticText, identifier:\"$3,700.00\")",".cells.containing(.staticText, identifier:\"P.O. BOX 1231345 White River Junction, New Hampshire 96766\")",".cells.containing(.staticText, identifier:\"11112222\")"],[[[-1,5],[-1,4],[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.staticTexts["  Details"].tap()
        app.buttons["Notes"].tap()
        app.buttons["Add New  +"].tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["Note"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"Note\"]",".staticTexts[\"Note\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        app.staticTexts["Note Title*"].tap()
        let title = app.textFields["notesTitleTextFieldID"]
        title.tap()
        title.typeText("Hello1")
        let desc = app.textViews["notesTextViewID"]
        desc.tap()
        desc.typeText("123")
        app/*@START_MENU_TOKEN@*/.buttons["Hide keyboard"]/*[[".keyboards.buttons[\"Hide keyboard\"]",".buttons[\"Hide keyboard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Save & Close"].tap()
        
    }
    
    func testCreateNewNoteForSwipe(){
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Accounts"]/*[[".staticTexts.buttons[\"Accounts\"]",".buttons[\"Accounts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"11112222")/*[[".cells.containing(.staticText, identifier:\"03\/16\/2018\")",".cells.containing(.staticText, identifier:\"#KALAPAKI JOE'S BILL TO#\")",".cells.containing(.staticText, identifier:\"$0.99\")",".cells.containing(.staticText, identifier:\"$3,700.00\")",".cells.containing(.staticText, identifier:\"P.O. BOX 1231345 White River Junction, New Hampshire 96766\")",".cells.containing(.staticText, identifier:\"11112222\")"],[[[-1,5],[-1,4],[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.staticTexts["  Details"].tap()
        app.buttons["Notes"].tap()
        app.buttons["Add New  +"].tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["Note"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"Note\"]",".staticTexts[\"Note\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        app.staticTexts["Note Title*"].tap()
        let title = app.textFields["notesTitleTextFieldID"]
        title.tap()
        title.typeText("Hello")
        let desc = app.textViews["notesTextViewID"]
        desc.tap()
        desc.typeText("123")
        app/*@START_MENU_TOKEN@*/.buttons["Hide keyboard"]/*[[".keyboards.buttons[\"Hide keyboard\"]",".buttons[\"Hide keyboard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Save & Close"].tap()
        
    }
    
    func testCreateNoteForEditSwipe(){
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Accounts"]/*[[".staticTexts.buttons[\"Accounts\"]",".buttons[\"Accounts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"11112222")/*[[".cells.containing(.staticText, identifier:\"03\/16\/2018\")",".cells.containing(.staticText, identifier:\"#KALAPAKI JOE'S BILL TO#\")",".cells.containing(.staticText, identifier:\"$0.99\")",".cells.containing(.staticText, identifier:\"$3,700.00\")",".cells.containing(.staticText, identifier:\"P.O. BOX 1231345 White River Junction, New Hampshire 96766\")",".cells.containing(.staticText, identifier:\"11112222\")"],[[[-1,5],[-1,4],[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.staticTexts["  Details"].tap()
        app.buttons["Notes"].tap()
        app.buttons["Add New  +"].tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["Note"]/*[[".otherElements[\"drop_down\"].tables",".cells.staticTexts[\"Note\"]",".staticTexts[\"Note\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        app.staticTexts["Note Title*"].tap()
        let title = app.textFields["notesTitleTextFieldID"]
        title.tap()
        title.typeText("Hello there")
        let desc = app.textViews["notesTextViewID"]
        desc.tap()
        desc.typeText("123")
        app/*@START_MENU_TOKEN@*/.buttons["Hide keyboard"]/*[[".keyboards.buttons[\"Hide keyboard\"]",".buttons[\"Hide keyboard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Save & Close"].tap()
        
    }
    
    func testEditNote(){
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Accounts"]/*[[".staticTexts.buttons[\"Accounts\"]",".buttons[\"Accounts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"11112222")/*[[".cells.containing(.staticText, identifier:\"03\/16\/2018\")",".cells.containing(.staticText, identifier:\"#KALAPAKI JOE'S BILL TO#\")",".cells.containing(.staticText, identifier:\"$0.99\")",".cells.containing(.staticText, identifier:\"$3,700.00\")",".cells.containing(.staticText, identifier:\"P.O. BOX 1231345 White River Junction, New Hampshire 96766\")",".cells.containing(.staticText, identifier:\"11112222\")"],[[[-1,5],[-1,4],[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.staticTexts["  Details"].tap()
        app.buttons["Notes"].tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["test from app"]/*[[".cells.staticTexts[\"test from app\"]",".staticTexts[\"test from app\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Delete Note"].tap()
        app.alerts["Delete Note?"].buttons["Cancel"].tap()
        app.buttons["Edit Note"].tap()
        app.buttons["Save & Close"].tap()
        
    }
    
    func testEditonclose(){
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Accounts"]/*[[".staticTexts.buttons[\"Accounts\"]",".buttons[\"Accounts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"11112222")/*[[".cells.containing(.staticText, identifier:\"03\/16\/2018\")",".cells.containing(.staticText, identifier:\"#KALAPAKI JOE'S BILL TO#\")",".cells.containing(.staticText, identifier:\"$0.99\")",".cells.containing(.staticText, identifier:\"$3,700.00\")",".cells.containing(.staticText, identifier:\"P.O. BOX 1231345 White River Junction, New Hampshire 96766\")",".cells.containing(.staticText, identifier:\"11112222\")"],[[[-1,5],[-1,4],[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.staticTexts["  Details"].tap()
        app.buttons["Notes"].tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["test from app"]/*[[".cells.staticTexts[\"test from app\"]",".staticTexts[\"test from app\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 1)
        element.staticTexts["test from app"].tap()
        app.otherElements["App test"].tap()
        app.buttons["Close"].tap()
        
    }
    
    func testEditNoteTypeText(){
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Accounts"]/*[[".staticTexts.buttons[\"Accounts\"]",".buttons[\"Accounts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"11112222")/*[[".cells.containing(.staticText, identifier:\"03\/16\/2018\")",".cells.containing(.staticText, identifier:\"#KALAPAKI JOE'S BILL TO#\")",".cells.containing(.staticText, identifier:\"$0.99\")",".cells.containing(.staticText, identifier:\"$3,700.00\")",".cells.containing(.staticText, identifier:\"P.O. BOX 1231345 White River Junction, New Hampshire 96766\")",".cells.containing(.staticText, identifier:\"11112222\")"],[[[-1,5],[-1,4],[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.staticTexts["  Details"].tap()
        app.buttons["Notes"].tap()
        XCUIApplication().tables/*@START_MENU_TOKEN@*/.staticTexts["Hello there"]/*[[".cells.staticTexts[\"Hello there\"]",".staticTexts[\"Hello there\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app.buttons["Edit Note"].tap()
        
        let title = app.textFields["notesTitleTextFieldID"]
        title.tap()
        title.typeText("123")
        let desc = app.textViews["notesTextViewID"]
        desc.tap()
        desc.typeText("123")
        app/*@START_MENU_TOKEN@*/.buttons["Hide keyboard"]/*[[".keyboards.buttons[\"Hide keyboard\"]",".buttons[\"Hide keyboard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Save & Close"].tap()
        
    }
    
    func testEditOnSwipe() {
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Accounts"]/*[[".staticTexts.buttons[\"Accounts\"]",".buttons[\"Accounts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["#KALAPAKI JOE'S BILL TO#"]/*[[".cells.staticTexts[\"#KALAPAKI JOE'S BILL TO#\"]",".staticTexts[\"#KALAPAKI JOE'S BILL TO#\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Notes"].tap()
        XCUIApplication().tables/*@START_MENU_TOKEN@*/.staticTexts["Hello there123"]/*[[".cells.staticTexts[\"Hello there123\"]",".staticTexts[\"Hello there123\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeLeft()
        app.tables/*@START_MENU_TOKEN@*/.buttons["Edit"]/*[[".cells.buttons[\"Edit\"]",".buttons[\"Edit\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let closeButton = app.buttons["close"]
        closeButton.tap()
        
        XCUIApplication().tables/*@START_MENU_TOKEN@*/.staticTexts["Hello there123"]/*[[".cells.staticTexts[\"Hello there123\"]",".staticTexts[\"Hello there123\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Delete Note"].tap()
        app.alerts["Delete Note?"].buttons["Delete"].tap()
        
    }
    
    func testDeleteNote(){
        
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Accounts"]/*[[".staticTexts.buttons[\"Accounts\"]",".buttons[\"Accounts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"11112222")/*[[".cells.containing(.staticText, identifier:\"#KALAPAKI JOE'S BILL TO#\")",".cells.containing(.staticText, identifier:\"$0.99\")",".cells.containing(.staticText, identifier:\"$3,700.00\")",".cells.containing(.staticText, identifier:\"P.O. BOX 1231345 White River Junction, New Hampshire 96766\")",".cells.containing(.staticText, identifier:\"11112222\")"],[[[-1,4],[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.staticTexts["  Details"].tap()
        app.buttons["Notes"].tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Hello1"]/*[[".cells.staticTexts[\"Hello1\"]",".staticTexts[\"Hello1\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Delete Note"].tap()
        app.alerts["Delete Note?"].buttons["Delete"].tap()
        
    }
    
    func testDeleteOnSwipeCancel(){
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Accounts"]/*[[".staticTexts.buttons[\"Accounts\"]",".buttons[\"Accounts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["#KALAPAKI JOE'S BILL TO#"]/*[[".cells.staticTexts[\"#KALAPAKI JOE'S BILL TO#\"]",".staticTexts[\"#KALAPAKI JOE'S BILL TO#\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Notes"].tap()
        XCUIApplication().tables/*@START_MENU_TOKEN@*/.staticTexts["Hello"]/*[[".cells.staticTexts[\"Hello\"]",".staticTexts[\"Hello\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeLeft()
        
        app.tables/*@START_MENU_TOKEN@*/.buttons["Delete"]/*[[".cells.buttons[\"Delete\"]",".buttons[\"Delete\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.alerts["Delete Note?"].buttons["Cancel"].tap()
        
    }
    
    func testDeleteOnSwipeDelete(){
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Accounts"]/*[[".staticTexts.buttons[\"Accounts\"]",".buttons[\"Accounts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["#KALAPAKI JOE'S BILL TO#"]/*[[".cells.staticTexts[\"#KALAPAKI JOE'S BILL TO#\"]",".staticTexts[\"#KALAPAKI JOE'S BILL TO#\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Notes"].tap()
        XCUIApplication().tables/*@START_MENU_TOKEN@*/.staticTexts["Hello"]/*[[".cells.staticTexts[\"Hello\"]",".staticTexts[\"Hello\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeLeft()
        app.tables/*@START_MENU_TOKEN@*/.buttons["Delete"]/*[[".cells.buttons[\"Delete\"]",".buttons[\"Delete\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.alerts["Delete Note?"].buttons["Delete"].tap()
    }
    
    //Save note with no title
    func testEditNoteAlert(){
        let app = XCUIApplication()
        app.navigationBars["SWSApp.ParentView"]/*@START_MENU_TOKEN@*/.buttons["Accounts"]/*[[".staticTexts.buttons[\"Accounts\"]",".buttons[\"Accounts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"11112222")/*[[".cells.containing(.staticText, identifier:\"03\/16\/2018\")",".cells.containing(.staticText, identifier:\"#KALAPAKI JOE'S BILL TO#\")",".cells.containing(.staticText, identifier:\"$0.99\")",".cells.containing(.staticText, identifier:\"$3,700.00\")",".cells.containing(.staticText, identifier:\"P.O. BOX 1231345 White River Junction, New Hampshire 96766\")",".cells.containing(.staticText, identifier:\"11112222\")"],[[[-1,5],[-1,4],[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.staticTexts["  Details"].tap()
        
        app.buttons["Notes"].tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["test from app"]/*[[".cells.staticTexts[\"test from app\"]",".staticTexts[\"test from app\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Close"].tap()
        
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["test from app"]/*[[".cells.staticTexts[\"test from app\"]",".staticTexts[\"test from app\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Edit Note"].tap()
        app/*@START_MENU_TOKEN@*/.textFields["notesTitleTextFieldID"]/*[[".textFields[\"Enter Title\"]",".textFields[\"notesTitleTextFieldID\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let deleteKey = app/*@START_MENU_TOKEN@*/.keys["delete"]/*[[".keyboards.keys[\"delete\"]",".keys[\"delete\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        deleteKey/*@START_MENU_TOKEN@*/.press(forDuration: 4.7);/*[[".tap()",".press(forDuration: 4.7);"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        
        app/*@START_MENU_TOKEN@*/.buttons["Hide keyboard"]/*[[".keyboards.buttons[\"Hide keyboard\"]",".buttons[\"Hide keyboard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let closeButton = app.buttons["close"]
        closeButton.tap()
        
        let anyChangesWillNotBeSavedAlert = app.alerts["Any changes will not be saved"]
        anyChangesWillNotBeSavedAlert.buttons["No"].tap()
        app.buttons["Save & Close"].tap()
        closeButton.tap()
        anyChangesWillNotBeSavedAlert.buttons["Yes"].tap()
        
    }
    
    func testSyncUpNotes() {
        
        let app = XCUIApplication()
        let swsappParentviewNavigationBar = app.navigationBars["SWSApp.ParentView"]
        swsappParentviewNavigationBar/*@START_MENU_TOKEN@*/.buttons["Accounts"]/*[[".staticTexts.buttons[\"Accounts\"]",".buttons[\"Accounts\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["#KALAPAKI JOE'S BILL TO#"]/*[[".cells.staticTexts[\"#KALAPAKI JOE'S BILL TO#\"]",".staticTexts[\"#KALAPAKI JOE'S BILL TO#\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Notes"].tap()
        swsappParentviewNavigationBar.staticTexts["Online"].tap()
        app.staticTexts["Sync Now"].tap()
        
    }
    
}
