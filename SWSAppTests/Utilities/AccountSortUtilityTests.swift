//
//  AccountListTests.swift
//  SWSAppTests
//
//  Created by shilpa.a.kulkarni on 11/04/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import XCTest
import Foundation
@testable import SWSApp

class MockAccountDataProvider
{
    static func mockTestAccount1() -> Account {
        let acc = Account(for: "mockup")
        acc.account_Id =  "001m000000cHLmDAAW"
        acc.accountNumber = "148"
        acc.accountName = "Crown Liquor Store"
        //acc.shippingAddress =  "B1- 202 Argentina"
        acc.shippingStreet = "W. Broadway Blvd"
        acc.shippingCity = "New York4"
        acc.shippingState = "NY"
        acc.shippingPostalCode = "12105"
        acc.shippingCountry = "USA"
        acc.totalARBalance = 90.98
        acc.totalCYR12NetSales = 2000.00
        acc.nextDeliveryDate = "2018-04-27"// yyyy-mm-dd
        acc.actionItem = 2
        return acc
    }
    static func mockTestAccount2() -> Account {
        let acc = Account(for: "mockup")
        acc.account_Id =  "001m000000cHLmDAAZ"
        acc.accountNumber = "188"
        acc.accountName = "Big Liquor Store"
        //acc.shippingAddress = "B1- 202 California"
        acc.shippingStreet = "W. Broadway Blvd"
        acc.shippingCity = "New York3"
        acc.shippingState = "NY"
        acc.shippingPostalCode = "12102"
        acc.shippingCountry = "USA"
        acc.totalARBalance = 80.98
        acc.totalCYR12NetSales = 4000.00
        acc.nextDeliveryDate = "2018-07-10"//"07/10/2018" // yyyy-mm-dd
        acc.actionItem = 5
        
        return acc
    }
    
    static func mockTestAccount3() -> Account {
        let acc = Account(for: "mockup")
        acc.account_Id =  "001m000000cHLmDAAZ"
        acc.accountNumber = "198"
        acc.accountName = "Bigger Liquor Store"
        //acc.shippingAddress = "7890"
        acc.shippingStreet = "W. Broadway Blvd"
        acc.shippingCity = "New York2"
        acc.shippingState = "NY"
        acc.shippingPostalCode = "12101"
        acc.shippingCountry = "USA"
        acc.totalARBalance = 90.98
        acc.totalCYR12NetSales = 4500.00
        let dateFormatter = DateFormatter()
        //dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"// MM-DD-YYYY
        dateFormatter.dateFormat = "yyyy-MM-dd"// MM-DD-YYYY
        dateFormatter.timeZone = TimeZone(identifier:"UTC")
        //acc.nextDeliveryDate = dateFormatter.date(from:"2018-05-10")!
        acc.nextDeliveryDate = "2018-06-17" // yyyy-mm-dd
        acc.actionItem = 7
        
        return acc
    }
    
    static func mockTestAccount4() -> Account {
        let acc = Account(for: "mockup")
        acc.account_Id =  "001m000000cHLmDAAZ"
        acc.accountNumber = "208"
        acc.accountName = "Biggest Liquor Store"
        //acc.shippingAddress = "4567"
        acc.shippingStreet = "W. Broadway Blvd"
        acc.shippingCity = "New York1"
        acc.shippingState = "NY"
        acc.shippingPostalCode = "12100"
        acc.shippingCountry = "USA"
        acc.totalARBalance = 99.98
        acc.totalCYR12NetSales = 4300.00
        let dateFormatter = DateFormatter()
        //dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"// MM-DD-YYYY
        dateFormatter.dateFormat = "yyyy-MM-dd"// MM-DD-YYYY
        dateFormatter.timeZone = TimeZone(identifier:"UTC")
        acc.nextDeliveryDate = "2018-05-07" // yyyy-mm-dd
        acc.actionItem = 15
        
        return acc
    }
    
    static func getListOfMockAccountObjects()->[Account]
    {
        var arrayOfMockAccounts = [Account]()
        
        arrayOfMockAccounts.append(mockTestAccount1())
        arrayOfMockAccounts.append(mockTestAccount2())
        arrayOfMockAccounts.append(mockTestAccount3())
        arrayOfMockAccounts.append(mockTestAccount4())
        
        return arrayOfMockAccounts
    }
}

class AccountListTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    /*func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }*/
    
    // account name search
    func testAccountSearchBySearchBarQuery1()
    {
        var listOfMockAccountData = MockAccountDataProvider.getListOfMockAccountObjects()
        let accountsArrayAfterSearch = AccountSortUtility.searchAccountBySearchBarQuery(accountsForLoggedUser: listOfMockAccountData, searchText: "XYZ")
        if(accountsArrayAfterSearch.count != 0)
        {
            XCTFail()
        }
        
        listOfMockAccountData.removeAll()
    }
    
    // account name search
    func testAccountSearchBySearchBarQuery2()
    {
        var listOfMockAccountData = MockAccountDataProvider.getListOfMockAccountObjects()
        let accountsArrayAfterSearch = AccountSortUtility.searchAccountBySearchBarQuery(accountsForLoggedUser: listOfMockAccountData, searchText: "BIG")
        if(accountsArrayAfterSearch.count != 3)
        {
            XCTFail()
        }
        
        listOfMockAccountData.removeAll()
    }
    
    // account name search
    func testAccountSearchBySearchBarQuery3()
    {
        var listOfMockAccountData = MockAccountDataProvider.getListOfMockAccountObjects()
        let accountsArrayAfterSearch = AccountSortUtility.searchAccountBySearchBarQuery(accountsForLoggedUser: listOfMockAccountData, searchText: " Biggest ")
        if(accountsArrayAfterSearch.count != 1)
        {
            XCTFail()
        }
        
        listOfMockAccountData.removeAll()
    }
    
    // account name search
    func testAccountSearchBySearchBarQuery4()
    {
        var listOfMockAccountData = MockAccountDataProvider.getListOfMockAccountObjects()
        let accountsArrayAfterSearch = AccountSortUtility.searchAccountBySearchBarQuery(accountsForLoggedUser: listOfMockAccountData, searchText: "CROWN")
        if(accountsArrayAfterSearch.count != 1)
        {
            XCTFail()
        }
        
        listOfMockAccountData.removeAll()
    }
    
    //account number search
    func testAccountSearchBySearchBarQuery5()
    {
        var listOfMockAccountData = MockAccountDataProvider.getListOfMockAccountObjects()
        let accountsArrayAfterSearch = AccountSortUtility.searchAccountBySearchBarQuery(accountsForLoggedUser: listOfMockAccountData, searchText: "148")
        if(accountsArrayAfterSearch.count != 1)
        {
            XCTFail()
        }
        
        let desiredAccount:Account = accountsArrayAfterSearch[0]
        if(desiredAccount.accountName != "Crown Liquor Store")
        {
            XCTFail()
        }
        
        listOfMockAccountData.removeAll()
    }
    
    // shipping city search
    func testAccountSearchBySearchBarQuery6()
    {
        var listOfMockAccountData = MockAccountDataProvider.getListOfMockAccountObjects()
        let accountsArrayAfterSearch = AccountSortUtility.searchAccountBySearchBarQuery(accountsForLoggedUser: listOfMockAccountData, searchText: "148")
        if(accountsArrayAfterSearch.count != 1)
        {
            XCTFail()
        }
        
        let desiredAccount:Account = accountsArrayAfterSearch[0]
        if(desiredAccount.accountName != "Crown Liquor Store")
        {
            XCTFail()
        }
        
        listOfMockAccountData.removeAll()
    }
    
    // postal code search
    func testAccountSearchBySearchBarQuery7()
    {
        var listOfMockAccountData = MockAccountDataProvider.getListOfMockAccountObjects()
        let accountsArrayAfterSearch = AccountSortUtility.searchAccountBySearchBarQuery(accountsForLoggedUser: listOfMockAccountData, searchText: "12100")
        if(accountsArrayAfterSearch.count != 1)
        {
            XCTFail()
        }
        
        let desiredAccount:Account = accountsArrayAfterSearch[0]
        if(desiredAccount.accountName != "Biggest Liquor Store")
        {
            XCTFail()
        }
        
        listOfMockAccountData.removeAll()
    }
    
    
    // account ID search
    func testSearchAccountByAccountId() {
        let listOfMockAccountData = MockAccountDataProvider.getListOfMockAccountObjects()
        let accountAfterSearch = AccountSortUtility.searchAccountByAccountId(accountsForLoggedUser: listOfMockAccountData, accountId: "001m000000cHLmDAAW")
        if(accountAfterSearch.count > 1){
            XCTFail()
        }
        
        let desiredAccount: Account = accountAfterSearch[0]
        if(desiredAccount.accountName != "Crown Liquor Store" ){
            XCTFail()
        }
    }
    
    // sort by account name ascending descending
    func testSortAccountListAlphabeticallyAscending() {
        let listOfMockAccountData = MockAccountDataProvider.getListOfMockAccountObjects()
        let accountsArrayAlphabeticallyAscending = AccountSortUtility.sortByAccountNameAlphabetically(accountsListToBeSorted: listOfMockAccountData, ascending: true)
        XCTAssertEqual(accountsArrayAlphabeticallyAscending[0].accountName, "Big Liquor Store")
        XCTAssertEqual(accountsArrayAlphabeticallyAscending[1].accountName, "Bigger Liquor Store")
        XCTAssertEqual(accountsArrayAlphabeticallyAscending[2].accountName, "Biggest Liquor Store")
        XCTAssertEqual(accountsArrayAlphabeticallyAscending[3].accountName, "Crown Liquor Store")
    }
    
    func testSortAccountListAlphabeticallyDescending() {
        let listOfMockAccountData = MockAccountDataProvider.getListOfMockAccountObjects()
        let accountsArrayAlphabeticallyDescending = AccountSortUtility.sortByAccountNameAlphabetically(accountsListToBeSorted: listOfMockAccountData, ascending: false)
        XCTAssertEqual(accountsArrayAlphabeticallyDescending[0].accountName, "Crown Liquor Store")
        XCTAssertEqual(accountsArrayAlphabeticallyDescending[1].accountName, "Biggest Liquor Store")
        XCTAssertEqual(accountsArrayAlphabeticallyDescending[2].accountName, "Bigger Liquor Store")
        XCTAssertEqual(accountsArrayAlphabeticallyDescending[3].accountName, "Big Liquor Store")
    }
    // sort by action items ascending descending
    
    func testSortActionItemsAscending() {
        let listOfMockAccountData = MockAccountDataProvider.getListOfMockAccountObjects()
        let accountsArrayAscending = AccountSortUtility.sortAccountsByActionItems(accountsListToBeSorted: listOfMockAccountData, ascending: true)
        XCTAssertEqual(accountsArrayAscending[0].actionItem, 2)
        XCTAssertEqual(accountsArrayAscending[1].actionItem, 5)
        XCTAssertEqual(accountsArrayAscending[2].actionItem, 7)
        XCTAssertEqual(accountsArrayAscending[3].actionItem, 15)
    }
    
    func testSortActionItemsDescending() {
        let listOfMockAccountData = MockAccountDataProvider.getListOfMockAccountObjects()
        let accountsArrayDescending = AccountSortUtility.sortAccountsByActionItems(accountsListToBeSorted: listOfMockAccountData, ascending: false)
        XCTAssertEqual(accountsArrayDescending[0].actionItem, 15)
        XCTAssertEqual(accountsArrayDescending[1].actionItem, 7)
        XCTAssertEqual(accountsArrayDescending[2].actionItem, 5)
        XCTAssertEqual(accountsArrayDescending[3].actionItem, 2)
    }
    
    // sort by netsales ascending descending
    
    func testSortNetSalesAscending() {
        let listOfMockAccountData = MockAccountDataProvider.getListOfMockAccountObjects()
        let accountsArrayAscending = AccountSortUtility.sortAccountsByTotalNetSales(accountsListToBeSorted: listOfMockAccountData, ascending: true)
        XCTAssertEqual(accountsArrayAscending[0].totalCYR12NetSales, 2000.00)
        XCTAssertEqual(accountsArrayAscending[1].totalCYR12NetSales, 4000.00)
        XCTAssertEqual(accountsArrayAscending[2].totalCYR12NetSales, 4300.00)
        XCTAssertEqual(accountsArrayAscending[3].totalCYR12NetSales, 4500.00)
    }
    
    func testSortNetSalesDescending() {
        let listOfMockAccountData = MockAccountDataProvider.getListOfMockAccountObjects()
        let accountsArrayDescending = AccountSortUtility.sortAccountsByTotalNetSales(accountsListToBeSorted: listOfMockAccountData, ascending: false)
        XCTAssertEqual(accountsArrayDescending[0].totalCYR12NetSales, 4500.00)
        XCTAssertEqual(accountsArrayDescending[1].totalCYR12NetSales, 4300.00)
        XCTAssertEqual(accountsArrayDescending[2].totalCYR12NetSales, 4000.00)
        XCTAssertEqual(accountsArrayDescending[3].totalCYR12NetSales, 2000.00)
    }
    
    // sort by balance ascending descending
    
    func testSortBalanceAscending() {
        let listOfMockAccountData = MockAccountDataProvider.getListOfMockAccountObjects()
        let accountsArrayAlphabeticallyAscending = AccountSortUtility.sortAccountsByBalance(accountsListToBeSorted: listOfMockAccountData, ascending: true)
        XCTAssertEqual(accountsArrayAlphabeticallyAscending[0].totalARBalance, 90.98)
        XCTAssertEqual(accountsArrayAlphabeticallyAscending[1].totalARBalance, 80.98)
        XCTAssertEqual(accountsArrayAlphabeticallyAscending[2].totalARBalance, 90.98)
        XCTAssertEqual(accountsArrayAlphabeticallyAscending[3].totalARBalance, 99.98)
    }
    
    func testSortBalanceDescending() {
        let listOfMockAccountData = MockAccountDataProvider.getListOfMockAccountObjects()
        let accountsArrayAlphabeticallyAscending = AccountSortUtility.sortAccountsByBalance(accountsListToBeSorted: listOfMockAccountData, ascending: false)
        XCTAssertEqual(accountsArrayAlphabeticallyAscending[0].totalARBalance, 90.98)
        XCTAssertEqual(accountsArrayAlphabeticallyAscending[1].totalARBalance, 80.98)
        XCTAssertEqual(accountsArrayAlphabeticallyAscending[2].totalARBalance, 90.98)
        XCTAssertEqual(accountsArrayAlphabeticallyAscending[3].totalARBalance, 99.98)
    }
    
    // sort by next delivery date ascending descending
    
    func testSortNextDeliveryDateAscending() {
        let listOfMockAccountData = MockAccountDataProvider.getListOfMockAccountObjects()
        let accountsArrayDateAscending = AccountSortUtility.sortAccountsByNextDeliveryDate(accountsListToBeSorted: listOfMockAccountData, ascending: true)
        XCTAssertEqual(accountsArrayDateAscending[0].nextDeliveryDate, "2018-05-07")
        XCTAssertEqual(accountsArrayDateAscending[1].nextDeliveryDate, "2018-07-10")
        XCTAssertEqual(accountsArrayDateAscending[2].nextDeliveryDate, "2018-06-17")
        XCTAssertEqual(accountsArrayDateAscending[3].nextDeliveryDate, "2018-04-27")
    }
    
    func testSortNextDeliveryDateDescending() {
        let listOfMockAccountData = MockAccountDataProvider.getListOfMockAccountObjects()
        let accountsArrayDateDescending = AccountSortUtility.sortAccountsByNextDeliveryDate(accountsListToBeSorted: listOfMockAccountData, ascending: false)
        XCTAssertEqual(accountsArrayDateDescending[0].nextDeliveryDate, "2018-04-27")
        XCTAssertEqual(accountsArrayDateDescending[1].nextDeliveryDate, "2018-06-17")
        XCTAssertEqual(accountsArrayDateDescending[2].nextDeliveryDate, "2018-07-10")
        XCTAssertEqual(accountsArrayDateDescending[3].nextDeliveryDate, "2018-05-07")
    }
    
}
