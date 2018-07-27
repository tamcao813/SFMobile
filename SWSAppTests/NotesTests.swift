//
//  NotesTests.swift
//  SWSAppTests
//
//  Created by Krishna, Kamya on 7/26/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import XCTest
import SmartSync
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

class NotesTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInitNotes(){
        
        let notes = AccountNotes.init(for: "")
        XCTAssertEqual(notes.Id, "")
        XCTAssertEqual(notes.lastModifiedDate, "")
        XCTAssertEqual(notes.name, "")
        XCTAssertEqual(notes.ownerId, "")
        XCTAssertEqual(notes.accountId, "")
        XCTAssertEqual(notes.accountNotesDesc, "")
    }
    
    func testAccountNotesInitJson(){
        
        let accountNotesFields: [String: Any] = ["Id": "123","SGWS_AppModified_DateTime__c": "12/05/2018","Name": "Abc","OwnerId": "acb12","SGWS_Account__c": "Owner","SGWS_Description__c": "UserAccount"]
        let note = AccountNotes.init(json: accountNotesFields)
        
        XCTAssertEqual(note.Id, accountNotesFields["Id"] as! String)
        XCTAssertEqual(note.lastModifiedDate, accountNotesFields["SGWS_AppModified_DateTime__c"] as! String)
        XCTAssertEqual(note.name, accountNotesFields["Name"] as! String)
        XCTAssertEqual(note.ownerId, accountNotesFields["OwnerId"] as! String)
        XCTAssertEqual(note.accountId, accountNotesFields["SGWS_Account__c"] as! String)
        XCTAssertEqual(note.accountNotesDesc , accountNotesFields["SGWS_Description__c"] as! String)
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
    
    func testCreateNotesLocally() {
        
        let new_notes = AccountNotes(for: "newNotes")
        new_notes.Id = "10000DAAZ"
        new_notes.lastModifiedDate = "2018-05-02T14:00:00.000Z"
        new_notes.name = "New note"
        new_notes.ownerId = "100011ZAACA"
        new_notes.accountId = "101010ZAAQ"
        new_notes.accountNotesDesc = "Notes Description"
        
        let addNewDict: [String:Any] = [
            
            AccountNotes.AccountNotesFields[0]: new_notes.Id,
            AccountNotes.AccountNotesFields[1]: new_notes.lastModifiedDate,
            AccountNotes.AccountNotesFields[2]: new_notes.name,
            AccountNotes.AccountNotesFields[3]: new_notes.ownerId,
            AccountNotes.AccountNotesFields[4]: new_notes.accountId,
            AccountNotes.AccountNotesFields[5]: new_notes.accountNotesDesc
        ]
        let notesObj = AccountsNotesViewModel()
        let isNewNoteCreated = notesObj.createNewNotesLocally(fields: addNewDict)
        if(isNewNoteCreated != true) {
            XCTFail()
        }
    }
    
    func testNotesRandomNumberGen(){
        let cnote = CreateNoteViewController()
        let randomId = cnote.generateRandomIDForNotes()
        XCTAssertNotNil(randomId)
    }
    
    func testEditNoteFunc(){
        let enote = EditNoteViewController()
        XCTAssertNotNil(enote.displayAccountNotes())
        XCTAssertNotNil(enote.noteCreated())
        XCTAssertNotNil(enote.navigateToNotesSection())
        XCTAssertNotNil(enote.dismissEditNote())
    }
    
    func testNoteViewFunc(){
        let note = NotesViewController()
        XCTAssertNotNil(note.dismissEditNote())
        XCTAssertNotNil(note.noteCreated())
        XCTAssertNotNil(note.navigateToNotesSection())
    }
    
    //EditNoteViewController
    func testNotesDelegate(){
        let notesObj = EditNoteViewController()
        XCTAssertNotNil(notesObj.displayAccountNotes())
        XCTAssertNotNil(notesObj.noteCreated())
        XCTAssertNotNil(notesObj.navigateToNotesSection())
        XCTAssertNotNil(notesObj.dismissEditNote())
    }
    
    //NotesViewController
    func testNotesNavigateDelegate()  {
        let noteObj = NotesViewController()
        XCTAssertNotNil(noteObj.navigateToNotesSection())
        XCTAssertNotNil(noteObj.noteCreated())
        XCTAssertNotNil(noteObj.dismissEditNote())
    }
    
    func testAccountsNotesViewModel() {
        let accNotesModel = AccountsNotesViewModel()
        _ = accNotesModel.accountsNotesForUser()
        let attributeDict = ["type":"SGWS_Account_Notes__c"]
        
        let addNewDict: [String:Any] = [
            
            AccountNotes.AccountNotesFields[0]: generateRandomIDForNotes(),
            AccountNotes.AccountNotesFields[1]: "2018-07-17T12:13:33.000+0000",
            AccountNotes.AccountNotesFields[2]: "Test",
            AccountNotes.AccountNotesFields[3]: "2jsjs",
            AccountNotes.AccountNotesFields[4]: "101010ZAAQ",
            AccountNotes.AccountNotesFields[5]: "Test",
            kSyncTargetLocal:true,
            kSyncTargetLocallyCreated:true,
            kSyncTargetLocallyUpdated:false,
            kSyncTargetLocallyDeleted:false,
            "attributes":attributeDict]
        
        _ = accNotesModel.createNewNotesLocally(fields: addNewDict)
        _ = accNotesModel.editNotesLocally(fields:addNewDict)
        _ = accNotesModel.deleteNotesLocally(fields: addNewDict)
        
        let expectation = XCTestExpectation(description: "resyncStrategyAnswers")
        accNotesModel.syncNotesWithServer{ error in
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
        
    }
    
    func generateRandomIDForNotes()->String  {
        //  Make a variable equal to a random number....
        let randomNum:UInt32 = arc4random_uniform(99999999) // range is 0 to 99
        // convert the UInt32 to some other  types
        let someString:String = String(randomNum)
        return someString
    }
    
}
