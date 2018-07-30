//
//  NotesSortUtilityTests.swift
//  SWSAppTests
//
//  Created by Krishna, Kamya on 7/30/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import XCTest
@testable import SWSApp

class MockNotesDataProvider
{
    static func mockTestNotes1() -> AccountNotes {
        let notes = AccountNotes(for: "mockUp")
        notes.Id = "1234"
        notes.lastModifiedDate =  "10/7/18"
        notes.name = "first note"
        notes.ownerId = "5678"
        notes.accountId = "9012"
        notes.accountNotesDesc = "This is my first Note"
        return notes
    }
    static func mockTestNotes2() -> AccountNotes {
        let notes = AccountNotes(for: "mockUp")
        notes.Id = "1234"
        notes.lastModifiedDate =  "8/2/18"
        notes.name = "hello world"
        notes.ownerId = "5678"
        notes.accountId = "9012"
        notes.accountNotesDesc = "This is my second Note"
        return notes
    }
    static func mockTestNotes3() -> AccountNotes {
        let notes = AccountNotes(for: "mockUp")
        notes.Id = "1234"
        notes.lastModifiedDate =  "9/11/18"
        notes.name = "my note"
        notes.ownerId = "5678"
        notes.accountId = "9012"
        notes.accountNotesDesc = "This is my third Note"
        return notes
    }
    static func mockTestNotes4() -> AccountNotes {
        let notes = AccountNotes(for: "mockUp")
        notes.Id = "1234"
        notes.lastModifiedDate =  "23/2/18"
        notes.name = "Hello note"
        notes.ownerId = "5678"
        notes.accountId = "9012"
        notes.accountNotesDesc = "This is my fourth Note"
        return notes
    }
    
    static func getListOfMockNotesObject() -> [AccountNotes]{
        var arrayOfMockNotes = [AccountNotes]()
        arrayOfMockNotes.append(mockTestNotes1())
        arrayOfMockNotes.append(mockTestNotes2())
        arrayOfMockNotes.append(mockTestNotes3())
        arrayOfMockNotes.append(mockTestNotes4())
        
        return arrayOfMockNotes
    }
}

class NotesSortUtilityTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSortNotesTitleAlphabeticallyAscending(){
        let listOfMockNotesData = MockNotesDataProvider.getListOfMockNotesObject()
        let notesArrayAscending = NoteSortUtility.sortByNoteTitleAlphabetically(notesListToBeSorted: listOfMockNotesData, ascending: true)
        XCTAssertEqual(notesArrayAscending[0].name, "first note")
        XCTAssertEqual(notesArrayAscending[1].name, "Hello note")
        XCTAssertEqual(notesArrayAscending[2].name, "hello world")
        XCTAssertEqual(notesArrayAscending[3].name, "my note")
    }
    
    func testSortNotesTitleAlphabeticallyDescending(){
        let listOfMockNotesData = MockNotesDataProvider.getListOfMockNotesObject()
        let notesArrayDescending = NoteSortUtility.sortByNoteTitleAlphabetically(notesListToBeSorted: listOfMockNotesData, ascending: false)
        XCTAssertEqual(notesArrayDescending[0].name, "my note")
        XCTAssertEqual(notesArrayDescending[1].name, "hello world")
        XCTAssertEqual(notesArrayDescending[2].name, "Hello note")
        XCTAssertEqual(notesArrayDescending[3].name, "first note")
    }
    
    func testSortNotesDateModifiedAscending() {
        let listOfMockNotesData = MockNotesDataProvider.getListOfMockNotesObject()
        let notesDatesArrayAscending = NoteSortUtility.sortAccountsByNotesDateModified(accountNotesToBeSorted: listOfMockNotesData, ascending: true)
        XCTAssertEqual(notesDatesArrayAscending[0].lastModifiedDate, "10/7/18")
        XCTAssertEqual(notesDatesArrayAscending[1].lastModifiedDate, "23/2/18")
        XCTAssertEqual(notesDatesArrayAscending[2].lastModifiedDate, "8/2/18")
        XCTAssertEqual(notesDatesArrayAscending[3].lastModifiedDate, "9/11/18")
    }
    
    func testSortNotesDateModifiedDescending() {
        let listOfMockNotesData = MockNotesDataProvider.getListOfMockNotesObject()
        let notesDatesArrayDescending = NoteSortUtility.sortAccountsByNotesDateModified(accountNotesToBeSorted: listOfMockNotesData, ascending: false)
        XCTAssertEqual(notesDatesArrayDescending[0].lastModifiedDate, "9/11/18")
        XCTAssertEqual(notesDatesArrayDescending[1].lastModifiedDate, "8/2/18")
        XCTAssertEqual(notesDatesArrayDescending[2].lastModifiedDate, "23/2/18")
        XCTAssertEqual(notesDatesArrayDescending[3].lastModifiedDate, "10/7/18")
    }
    
}
