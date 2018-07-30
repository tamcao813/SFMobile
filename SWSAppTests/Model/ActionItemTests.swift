//
//  ActionItemsTests.swift
//  SWSAppTests
//
//  Created by Krishna, Kamya on 7/26/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import XCTest
@testable import SWSApp

class ActionItemsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testActionItemInitJson(){
        
        let accountActionItemFields: [String: Any] =  ["Id": "","SGWS_Account__c": "","Subject": "","Description": "","Status": "","ActivityDate": "","SGWS_Urgent__c": true,"SGWS_AppModified_DateTime__c": "","RecordTypeId": "","Account.Name": "","Account.AccountNumber": "","Account.ShippingCity": "","Account.ShippingCountry": "","Account.ShippingPostalCode": "","Account.ShippingState": "","Account.ShippingStreet": "","OwnerId": ""]
        
        let accountActionItem = ActionItem.init(json: accountActionItemFields)
        XCTAssertEqual(accountActionItem.Id, accountActionItemFields["Id"] as! String)
        XCTAssertEqual(accountActionItem.accountId, accountActionItemFields["SGWS_Account__c"] as! String)
        XCTAssertEqual(accountActionItem.subject, accountActionItemFields["Subject"] as! String)
        XCTAssertEqual(accountActionItem.description, accountActionItemFields["Description"] as! String)
        XCTAssertEqual(accountActionItem.status, accountActionItemFields["Status"] as! String)
        XCTAssertEqual(accountActionItem.activityDate, accountActionItemFields["ActivityDate"] as! String)
        XCTAssertEqual(accountActionItem.isUrgent, (accountActionItemFields["SGWS_Urgent__c"] != nil))
        XCTAssertEqual(accountActionItem.lastModifiedDate, accountActionItemFields["SGWS_AppModified_DateTime__c"] as! String)
        XCTAssertEqual(accountActionItem.recordTypeId, accountActionItemFields["RecordTypeId"] as! String)
        XCTAssertEqual(accountActionItem.accountName, accountActionItemFields["Account.Name"] as! String)
        XCTAssertEqual(accountActionItem.accountNumber, accountActionItemFields["Account.AccountNumber"] as! String)
        XCTAssertEqual(accountActionItem.shippingCity, accountActionItemFields["Account.ShippingCity"] as! String)
        XCTAssertEqual(accountActionItem.shippingCountry, accountActionItemFields["Account.ShippingCountry"] as! String)
        XCTAssertEqual(accountActionItem.shippingPostalCode, accountActionItemFields["Account.ShippingPostalCode"] as! String)
        XCTAssertEqual(accountActionItem.shippingState, accountActionItemFields["Account.ShippingState"] as! String)
        XCTAssertEqual(accountActionItem.shippingStreet, accountActionItemFields["Account.ShippingStreet"] as! String)
        XCTAssertEqual(accountActionItem.ownerId, accountActionItemFields["OwnerId"] as! String)
        XCTAssertEqual(accountActionItem.activityDate, "")
        XCTAssertNotEqual(accountActionItem.isUrgent, false)
        
    }
    
    func testActionItemInit(){
        
        let actionItem = ActionItem.init(for: "")
        XCTAssertEqual(actionItem.Id, "")
        XCTAssertEqual(actionItem.accountId, "")
        XCTAssertEqual(actionItem.subject, "")
        XCTAssertEqual(actionItem.description, "")
        XCTAssertEqual(actionItem.status, "")
        XCTAssertEqual(actionItem.activityDate, "")
        XCTAssertEqual(actionItem.isUrgent, false)
        XCTAssertEqual(actionItem.lastModifiedDate, "")
        XCTAssertEqual(actionItem.recordTypeId, "")
        XCTAssertEqual(actionItem.accountName, "")
        XCTAssertEqual(actionItem.accountNumber, "")
        XCTAssertEqual(actionItem.shippingCity, "")
        XCTAssertEqual(actionItem.shippingCountry, "")
        XCTAssertEqual(actionItem.shippingState, "")
        XCTAssertEqual(actionItem.shippingStreet, "")
        XCTAssertEqual(actionItem.ownerId, "")
        XCTAssertEqual(actionItem.shippingPostalCode, "")
        XCTAssertEqual(actionItem._soupEntryId, 0)
        XCTAssertEqual(actionItem.dateStart, nil)
        
    }
    
    func testActionItemCInit(){
        
        let accountActionItemFields: [Any] =  ["Id","SGWS_Account__c","Subject","Description","Status","ActivityDate","SGWS_Urgent__c","SGWS_AppModified_DateTime__c","RecordTypeId","Account.Name","Account.AccountNumber","Account.ShippingCity","Account.ShippingCountry","Account.ShippingPostalCode","Account.ShippingState","Account.ShippingStreet","OwnerId"]
        
        let accountActionItemFieldsWithoutAccount: [Any] =  ["Id","SGWS_Account__c","Subject","Description","Status","ActivityDate","SGWS_Urgent__c","SGWS_AppModified_DateTime__c","RecordTypeId","OwnerId"]
        
        XCTAssertNotNil(ActionItem.init(withAryAccount: accountActionItemFields))
        XCTAssertNotNil(ActionItem.init(withAryNoAccount: accountActionItemFieldsWithoutAccount))
        
    }
    
}
