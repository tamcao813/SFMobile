//
//  ContactsViewModelTests.swift
//  SWSAppTests
//
//  Created by Krishna, Kamya on 7/30/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import XCTest
@testable import SWSApp

class ContactsViewModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testContactViewModel() {
        let contactViewModel = ContactsViewModel()
        _ = contactViewModel.userVieModel
        _ = contactViewModel.contactsWithBuyingPower(forAccount: "001m000000cHLa7AAG")
        _ = contactViewModel.contactsForSG(forAccount: "001m000000cHLa7AAG")
        _ = contactViewModel.globalContacts()
        _ = contactViewModel.sgwsEmployeeContacts()
        _ = contactViewModel.contacts(forAccount: "001m000000cHLa7AAG")
        _ = contactViewModel.accountsForContacts()
        _ = contactViewModel.activeAccountsForContacts()
        _ = contactViewModel.linkedAccountsForContact(with: "xxxAAW")
        _ = contactViewModel.contactIdForACR(with: "xxxAAW")
        _ = contactViewModel.createNewContactToSoup(object: MockContactDataProvider.mockTestContact1())
        _ = contactViewModel.editNewContactToSoup(object: MockContactDataProvider.mockTestContact3())
    }
    
    func testSyncContactWithServer() {
        let contactViewModel = ContactsViewModel()
        let expectation = XCTestExpectation(description: "contacts sync")
        contactViewModel.syncContactWithServer{ error in
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
        
        let expectation1 = XCTestExpectation(description: "ACR sync")
        contactViewModel.syncACRwithServer{ error in
            expectation1.fulfill()
        }
        wait(for: [expectation1], timeout: 10.0)
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
    
}
