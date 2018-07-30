//
//  ReordTypeTests.swift
//  SWSAppTests
//
//  Created by Krishna, Kamya on 7/26/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import XCTest
@testable import SWSApp

class RecordTypeTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testRecordTypeInitJson(){
        
        let recordTypesFields: [String: Any] = ["Id": "","DeveloperName": "","CreatedDate": ""]
        let recordType = RecordType.init(json: recordTypesFields)
        
        XCTAssertEqual(recordType.Id, recordTypesFields["Id"] as! String)
        XCTAssertEqual(recordType.developerName, recordTypesFields["DeveloperName"] as! String)
        XCTAssertEqual(recordType.createdDate, recordTypesFields["CreatedDate"] as! String)
        
    }
    
    func testRecordTypeInit(){
        
        let recordType = RecordType.init(for: "")
        XCTAssertEqual(recordType.Id, "")
        XCTAssertEqual(recordType.developerName, "")
        XCTAssertEqual(recordType.createdDate, "")
        
    }
    
    func testRecordTypeCInit(){
        
        let recordTypesFields: [Any] = ["Id","DeveloperName","CreatedDate"]
        XCTAssertNotNil(RecordType.init(withAry: recordTypesFields))
        
    }
    
}
