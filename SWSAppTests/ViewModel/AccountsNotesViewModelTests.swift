//
//  AccountsNotesViewModelTests.swift
//  SWSAppTests
//
//  Created by Krishna, Kamya on 7/30/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import XCTest
import SmartSync
@testable import SWSApp

class AccountsNotesViewModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
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
    
    func generateRandomIDForNotes()->String  {
        //  Make a variable equal to a random number....
        let randomNum:UInt32 = arc4random_uniform(99999999) // range is 0 to 99
        // convert the UInt32 to some other  types
        let someString:String = String(randomNum)
        return someString
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
    
}
