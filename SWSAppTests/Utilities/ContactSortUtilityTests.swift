//
//  ContactSortUtility.swift
//  SWSAppTests
//
//  Created by Krishna, Kamya on 7/30/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import XCTest
@testable import SWSApp

class MockContactDataProvider {
    
    static func mockTestContact1() -> Contact {
        let contact = Contact(for: "mockup")
        contact.contactId =  "111ASD"
        contact.name = "test1"
        contact.accountId = "001m000000cHLa7AAG"
        let n = Int(arc4random_uniform(1000) + 35)
        contact.firstName = "Greg" + "\(n)"
        contact.lastName = "Opa" + "\(n)"
        contact.phoneNumber = "(716) 666-8888"
        contact.preferredCommunicationMethod = "Phone"
        contact.contactClassification = "Influencer"
        
        return contact
    }
    
    static func mockTestContact2() -> Contact {
        let contact = Contact(for: "mockup")
        contact.contactId =  "212ASD"
        contact.name = "contactTest"
        contact.accountId = "001m000000cHLmDAAW"
        let n = Int(arc4random_uniform(1000) + 35)
        contact.firstName = "Greg" + "\(n)"
        contact.lastName = "Opa" + "\(n)"
        contact.phoneNumber = "(516) 666-9999"
        contact.preferredCommunicationMethod = "Phone"
        contact.contactClassification = "Influencer"
        
        return contact
    }
    
    static func mockTestContact3() -> Contact {
        let contact = Contact(for: "mockup")
        contact.contactId =  "xxxAAW"
        contact.name = "mockContactTest"
        contact.accountId = "001m000000cHLmDAAZ"
        let n = Int(arc4random_uniform(1000) + 35)
        contact.firstName = "Greg" + "\(n)"
        contact.lastName = "Opa" + "\(n)"
        contact.phoneNumber = "(314) 556-8458"
        contact.preferredCommunicationMethod = "Phone"
        contact.contactClassification = "Influencer"
        
        return contact
    }
    
    static func getListOfMockContactObjects() -> [Contact] {
        
        var arrayOfMockObjects = [Contact]()
        
        arrayOfMockObjects.append(mockTestContact1())
        arrayOfMockObjects.append(mockTestContact2())
        arrayOfMockObjects.append(mockTestContact3())
        
        return arrayOfMockObjects
    }
}

class ContactSortUtilityUITests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSortByContactNameAscending() {
        let listOfMockContactData = MockContactDataProvider.getListOfMockContactObjects()
        var contactsArraySorted = ContactSortUtility.sortByContactNameAlphabetically(contactsListToBeSorted: listOfMockContactData, ascending: true)
        XCTAssertEqual(contactsArraySorted[0].name, "contactTest")
        XCTAssertEqual(contactsArraySorted[1].name, "mockContactTest")
        XCTAssertEqual(contactsArraySorted[2].name, "test1")
    }
    
    func testSortByContactNameDescending() {
        let listOfMockContactData = MockContactDataProvider.getListOfMockContactObjects()
        var contactsArraySorted = ContactSortUtility.sortByContactNameAlphabetically(contactsListToBeSorted: listOfMockContactData, ascending: false)
        XCTAssertEqual(contactsArraySorted[0].name, "test1")
        XCTAssertEqual(contactsArraySorted[1].name, "mockContactTest")
        XCTAssertEqual(contactsArraySorted[2].name, "contactTest")
    }
    
    //Account ID search
    func testContactSearchBySearchBarQuery1() {
        var listOfMockContactData = MockContactDataProvider.getListOfMockContactObjects()
        let contactArrayAfterSearch = ContactSortUtility.searchContactBySearchBarQuery(contactsForLoggedUser: listOfMockContactData, searchText: "AAG")
        if(contactArrayAfterSearch.count != 1) {
            XCTFail()
        }
        
        let desiredContact: Contact = contactArrayAfterSearch[0]
        if(desiredContact.accountId != "001m000000cHLa7AAG") {
            XCTFail()
        }
        
        listOfMockContactData.removeAll()
    }
    
    //Contact Name search
    func testContactSearchBySearchBarQuery2() {
        var listOfMockContactData = MockContactDataProvider.getListOfMockContactObjects()
        let contactArrayAfterSearch = ContactSortUtility.searchContactBySearchBarQuery(contactsForLoggedUser: listOfMockContactData, searchText: "Test")
        if(contactArrayAfterSearch.count != 3){
            XCTFail()
        }
        listOfMockContactData.removeAll()
    }
    
}
