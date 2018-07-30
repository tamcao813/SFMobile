//
//  UserTests.swift
//  SWSAppTests
//
//  Created by Krishna, Kamya on 7/26/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import XCTest
@testable import SWSApp

class UserTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInitUser(){
        
        let user = User.init(for: "")
        XCTAssertEqual(user.id, "")
        XCTAssertEqual(user.username, "")
        XCTAssertEqual(user.accountId, "")
        XCTAssertEqual(user.userId, "")
        XCTAssertEqual(user.userSite, "")
        XCTAssertEqual(user.userEmail, "")
        XCTAssertEqual(user.userPhone, "")
        XCTAssertEqual(user.userManagerId, "")
        
    }
    
    func testUserInitJson(){
        
        let userFields: [String: Any] = ["Id": "", "User.Username": "", "User.Name": "", "AccountId": "", "UserId": "", "User.Email": "","User.Phone": "","TeamMemberRole": "","User.SGWS_Site__c": "","User.ManagerId": "", "Account.RecordTypeId": "", "User.SGWS_Employee_Contact_Id__c": ""]
        
        let user = User.init(json: userFields)
        
        XCTAssertEqual(user.id, userFields["Id"] as! String)
        XCTAssertEqual(user.username, userFields["User.Username"] as! String)
        XCTAssertEqual(user.accountId, userFields["AccountId"] as! String)
        XCTAssertEqual(user.userId, userFields["UserId"] as! String)
        XCTAssertEqual(user.userEmail, userFields["User.Email"] as! String)
        XCTAssertEqual(user.userPhone, userFields["User.Phone"] as! String)
        XCTAssertEqual(user.userTeamMemberRole, userFields["TeamMemberRole"] as! String)
        XCTAssertEqual(user.userSite, userFields["User.SGWS_Site__c"] as! String)
        XCTAssertEqual(user.userManagerId, userFields["User.ManagerId"] as! String)
        XCTAssertEqual(user.recordTypeId, userFields["Account.RecordTypeId"] as! String)
        XCTAssertEqual(user.sgws_Employee_Contact, userFields["User.SGWS_Employee_Contact_Id__c"] as! String)
        
    }
    
    func testUserCInits(){
        
        let userFields: [Any] = ["Id", "User.Username", "User.Name", "AccountId", "UserId", "User.Email","User.Phone","TeamMemberRole","User.SGWS_Site__c","User.ManagerId", "Account.RecordTypeId","User.SGWS_Employee_Contact_Id__c"] // Stage 1
        
        let userSimpleFields: [Any] =
            ["Id", "Username", "Name", "AccountId", "Email","Phone","SGWS_Site__c","ManagerId", "Account.RecordTypeId"]
        
        XCTAssertNotNil(User.init(withAry: userFields))
        XCTAssertNotNil(User.init(withAryForUserSimple: userSimpleFields))
    }
    
    func testUserSimpleJson(){
        let userFields: [String: Any] = ["Id": "", "Username": "", "Name": "", "AccountId": "",  "Email": "","Phone": "","SGWS_Site__c": "","ManagerId": "", "Account.RecordTypeId": "", "SGWS_Employee_Contact_Id__c": ""]
        
        let user = User.init(jsonSimple: userFields)
        
        XCTAssertEqual(user.id, userFields["Id"] as! String)
        XCTAssertEqual(user.userId, user.id)
        XCTAssertEqual(user.fullName, userFields["Name"] as! String)
        XCTAssertEqual(user.username, userFields["Username"] as! String)
        XCTAssertEqual(user.accountId, userFields["AccountId"] as! String)
        XCTAssertEqual(user.userEmail, userFields["Email"] as! String)
        XCTAssertEqual(user.userPhone, userFields["Phone"] as! String)
        XCTAssertEqual(user.userSite, userFields["SGWS_Site__c"] as! String)
        XCTAssertEqual(user.userManagerId, userFields["ManagerId"] as! String)
        XCTAssertEqual(user.recordTypeId, userFields["Account.RecordTypeId"] as! String)
        XCTAssertEqual(user.userTeamMemberRole, "")
        XCTAssertEqual(user.sgws_Employee_Contact, userFields["SGWS_Employee_Contact_Id__c"] as! String)
        
        _ = User.init(jsonSimple: ["":""])
      
    }
    
}
