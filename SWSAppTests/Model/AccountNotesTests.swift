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
    
}
