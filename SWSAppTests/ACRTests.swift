//
//  ACRTests.swift
//  SWSAppTests
//
//  Created by Krishna, Kamya on 7/26/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import XCTest
@testable import SWSApp

class MockACRData {
    
    static func mockData1() -> AccountContactRelation {
        let acrObj = AccountContactRelation(for: "mockUp")
        acrObj.accountId = ""
        acrObj.contactId = ""
        acrObj.contactName = ""
        //acrObj.sgwsSiteNumber = ""
        acrObj.roles = ""
        
        return acrObj
    }
    
    static func mockData2() -> AccountContactRelation {
        let acrObj = AccountContactRelation(for: "mockUp")
        acrObj.accountId = ""
        acrObj.contactId = ""
        acrObj.contactName = ""
        //acrObj.sgwsSiteNumber = ""
        acrObj.roles = ""
        
        return acrObj
    }
    
    static func getListOfMockDataObjects() -> [AccountContactRelation] {
        var arrayOfMockACRData = [AccountContactRelation]()
        
        arrayOfMockACRData.append(mockData1())
        arrayOfMockACRData.append(mockData2())
        
        return arrayOfMockACRData
    }
}

class ACRTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAcrInitJson(){
        
        let accountContactRelationFields: [String: Any] = ["Id": "","Account.Name": "", "Roles": "", "AccountId": "", "ContactId": "", "Contact.name": "", "SGWS_Account_Site_Number__c": ""]
        
        let acrInit = AccountContactRelation.init(json: accountContactRelationFields)
        
        XCTAssertEqual(acrInit.acrId, accountContactRelationFields["Id"] as! String)
        //XCTAssertEqual(acrInit.accountName, accountContactRelationFields["Account.Name"] as! String)
        XCTAssertEqual(acrInit.roles, accountContactRelationFields["Roles"] as! String)
        XCTAssertEqual(acrInit.accountId, accountContactRelationFields["AccountId"] as! String)
        XCTAssertEqual(acrInit.contactId, accountContactRelationFields["ContactId"] as! String)
        XCTAssertEqual(acrInit.contactName, accountContactRelationFields["Contact.name"] as! String)
        //XCTAssertEqual(acrInit.sgwsSiteNumber, accountContactRelationFields["SGWS_Account_Site_Number__c"] as! String)
    }
    
    func testUpdateACRtoSoup() {
        
        let obj = ContactsViewModel()
        let mockData = MockACRData.getListOfMockDataObjects()
        let result = obj.updateACRToSoup(objects: mockData)
        if(!result){
            XCTFail()
        }
    }
    
    func testCreateNewACRToSoup() {
        let obj = ContactsViewModel()
        let mockData = MockACRData.getListOfMockDataObjects()
        let result = obj.createNewACRToSoup(object: mockData[0])
        if(!result) {
            XCTFail()
        }
    }
    
    func testForegroundBackground() {
        
        let appInstace = UIApplication.shared.delegate!
        appInstace.applicationWillEnterForeground!(UIApplication.shared)
        appInstace.applicationDidEnterBackground!(UIApplication.shared)
        appInstace.applicationWillResignActive!(UIApplication.shared)
        appInstace.applicationWillTerminate!(UIApplication.shared)
        
    }
    
}
