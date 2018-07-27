//
//  AccountTests.swift
//  SWSAppTests
//
//  Created by Krishna, Kamya on 7/26/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import XCTest
@testable import SWSApp

class AccountTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInitAccountDetails() {
        let account = Account.init(for: "")
        // XCTAssertEqual(account.accountId, "")
        XCTAssertEqual(account.accountName, "")
        //XCTAssertEqual(account.siteId, "")
        XCTAssertEqual(account.phone, "")
        XCTAssertEqual(account.licenseStatus, "")
        // XCTAssertEqual(account.netSales, 0.0)
        // XCTAssertEqual(account.pastDueAmount, 0.0)
        XCTAssertEqual(account.accountNumber, "")
        XCTAssertEqual(account.premiseCode, "")
        XCTAssertEqual(account.licenseType, "")
        XCTAssertEqual(account.licenseNumber, "")
        XCTAssertEqual(account.operatingHours, "")
        XCTAssertEqual(account.totalCYR12NetSales, 0.0)
        XCTAssertEqual(account.totalARBalance, 0.0)
        XCTAssertEqual(account.creditLimit, 0.0)
        XCTAssertEqual(account.creditLimit, 0.0)
        XCTAssertEqual(account.channelTD, "")
        XCTAssertEqual(account.subChannelTD, "")
        XCTAssertEqual(account.licenseStatusDescription, "")
        XCTAssertEqual(account.shippingCity, "")
        XCTAssertEqual(account.shippingCountry, "")
        //  XCTAssertEqual(account.shippingLatitude, 0.0)
        // XCTAssertEqual(account.shippingLongitude, 0.0)
        XCTAssertEqual(account.shippingPostalCode, "")
        XCTAssertEqual(account.shippingState, "")
        XCTAssertEqual(account.shippingStreet, "")
        XCTAssertEqual(account.nextDeliveryDate, "")
        XCTAssertEqual(account.deliveryFrequency, "")
        XCTAssertEqual(account.licenseStatusDescription, "")
        XCTAssertEqual(account.pastDueAlert, "")
        XCTAssertEqual(account.percentageLastYearMTDNetSales, "")
        XCTAssertEqual(account.actionItem, 0)
        
    }
    
    func testAccountInitJson(){
        
        let accountFields: [String: Any] = ["Account.SGWS_Account_Health_Grade__c": "","Account.Name": "","Account.AccountNumber": "","Account.SWS_Total_CY_MTD_Net_Sales__c": "","Account.SWS_Total_AR_Balance__c": "","Account.IS_Next_Delivery_Date__c": "","Account.SWS_Premise_Code__c": "","Account.SWS_License_Type__c": "","Account.SWS_License__c": "","Account.Google_Place_Operating_Hours__c": "","Account.SWS_License_Expiration_Date__c": "","Account.SWS_Total_CY_R12_Net_Sales__c": "","Account.SWS_Credit_Limit__c": "","Account.SWS_TD_Channel__c": "","Account.SWS_TD_Sub_Channel__c": "","Account.SWS_License_Status_Description__c": "","Account.ShippingCity": "","Account.ShippingCountry": "","Account.ShippingPostalCode": "","Account.ShippingState": "","Account.ShippingStreet": "","Account.SWS_PCT_to_Last_Year_MTD_Net_Sales__c": "","Account.SWS_AR_Past_Due_Amount__c": "112","Account.SWS_Delivery_Frequency__c": "","Account.SGWS_Single_Multi_Locations_Filter__c": "","Account.Google_Place_Formatted_Phone__c": "","Account.SWS_Status_Description__c": "","AccountId": "","Account.SWS_PCT_to_Last_Year_R12_Net_Sales__c": ""]
        
        let account = Account.init(json: accountFields)
        
        XCTAssertEqual(account.acctHealthGrade, accountFields["Account.SGWS_Account_Health_Grade__c"] as! String)
        XCTAssertEqual(account.accountName, accountFields["Account.Name"] as! String)
        //XCTAssertNil(account.accountNumber, accountFields["Account.Number"] as! String)
        //XCTAssertEqual(account.mtdNetSales, accountFields["Account.SWS_Total_CY_MTD_Net_Sales__c"] as! Double)
        //        XCTAssertEqual(account.totalARBalance, accountFields["Account.SWS_Total_AR_Balance__c"] as! Double)
        XCTAssertEqual(account.nextDeliveryDate, accountFields["Account.IS_Next_Delivery_Date__c"] as! String)
        XCTAssertEqual(account.premiseCode, accountFields["Account.SWS_Premise_Code__c"] as! String)
        XCTAssertEqual(account.licenseType, accountFields["Account.SWS_License_Type__c"] as! String)
        XCTAssertEqual(account.licenseNumber, accountFields["Account.SWS_License__c"] as! String)
        XCTAssertEqual(account.operatingHours, accountFields["Account.Google_Place_Operating_Hours__c"] as! String)
        XCTAssertEqual(account.licenseExpirationDate, accountFields["Account.SWS_License_Expiration_Date__c"] as! String)
        //        XCTAssertEqual(account.totalCYR12NetSales, accountFields["Account.SWS_Total_CY_R12_Net_Sales__c"] as! Double)
        //        XCTAssertEqual(account.creditLimit, accountFields["Account.SWS_Credit_Limit__c"] as! Double)
        XCTAssertEqual(account.channelTD, accountFields["Account.SWS_TD_Channel__c"] as! String)
        XCTAssertEqual(account.subChannelTD, accountFields["Account.SWS_TD_Sub_Channel__c"] as! String)
        XCTAssertEqual(account.licenseStatus, accountFields["Account.SWS_License_Status_Description__c"] as! String)
        XCTAssertEqual(account.shippingCity, accountFields["Account.ShippingCity"] as! String)
        XCTAssertEqual(account.shippingCountry, accountFields["Account.ShippingCountry"] as! String)
        XCTAssertEqual(account.shippingPostalCode, accountFields["Account.ShippingPostalCode"] as! String)
        XCTAssertEqual(account.shippingState, accountFields["Account.ShippingState"] as! String)
        XCTAssertEqual(account.shippingStreet, accountFields["Account.ShippingStreet"] as! String)
        XCTAssertEqual(account.percentageLastYearMTDNetSales, accountFields["Account.SWS_PCT_to_Last_Year_MTD_Net_Sales__c"] as! String)
        XCTAssertEqual(account.pastDueAmount, accountFields["Account.SWS_AR_Past_Due_Amount__c"] as! String)
        XCTAssertEqual(account.deliveryFrequency, accountFields["Account.SWS_Delivery_Frequency__c"] as! String)
        XCTAssertEqual(account.singleMultiLocationFilter, accountFields["Account.SGWS_Single_Multi_Locations_Filter__c"] as! String)
        XCTAssertEqual(account.phone, accountFields["Account.Google_Place_Formatted_Phone__c"] as! String)
        XCTAssertEqual(account.licenseStatusDescription, accountFields["Account.SWS_Status_Description__c"] as! String)
        XCTAssertEqual(account.account_Id, accountFields["AccountId"] as! String)
        XCTAssertEqual(account.percentageLastYearR12NetSales, accountFields["Account.SWS_PCT_to_Last_Year_R12_Net_Sales__c"] as! String)
        
    }
    
    
    
    func testAcrInit() {
        let accnt = AccountContactRelation.init(for: "")
        //XCTAssertEqual(accnt.acrId, "")
        //XCTAssertEqual(accnt.accountName, "")
        XCTAssertEqual(accnt.roles, "")
        XCTAssertEqual(accnt.accountId, "")
        XCTAssertEqual(accnt.contactId, "")
        XCTAssertEqual(accnt.contactName, "")
        //XCTAssertEqual(accnt.sgwsSiteNumber, "")
    }
    
    func testSearchBarSearchButtonClicked(){
        let account = AccountsMenuViewController()
        let search = UISearchBar()
        XCTAssertNotNil(account.searchBarSearchButtonClicked(search))
    }
    
    func testTableViewDidDeselectRowAt(){
        let account = AccountsMenuViewController()
        let index = IndexPath()
        let tableView = UITableView()
        XCTAssertNotNil(account.tableView(tableView, didDeselectRowAt: index))
    }
    
    func testTextFieldDidEndEditing(){
        let account = AccountsMenuTableTableViewCell()
        let textField = UITextField()
        XCTAssertNotNil(account.textFieldDidEndEditing(textField))
    }
    
    func testViewModel(){
        let account = AccountsViewController()
        XCTAssertNotNil(account.viewWillDisappear(true))
    }
    
    //CustomerHeaderTableViewCell
    func testSetSelected(){
        let custom = CustomerHeaderTableViewCell()
        XCTAssertNotNil(custom.setSelected(true, animated: true))
    }
    
    //ParentViewController
    func testDidReceiveMemoryWarning(){
        let parent = ParentViewController()
        XCTAssertNotNil(parent.didReceiveMemoryWarning())
    }
    
    //    func testSyncUpData(){
    //        let parent = ParentViewController()
    //        XCTAssertNotNil(parent.SyncUpData())
    //    }
    
    //EditAccountStrategyViewController
    func testMemoryWarning(){
        let strategy =  EditAccountStrategyViewController()
        XCTAssertNotNil(strategy.didReceiveMemoryWarning())
    }
    
    func testCloseAcion(){
        let account = AccountView()
        XCTAssertNotNil(account.closeAction((Any).self))
    }
    
    //AssociateTableViewCell
    func testAssociateSetSelected(){
        let associate = AssociateTableViewCell()
        XCTAssertNotNil(associate.setSelected(false, animated: false))
    }
    
    //AccountDetailsViewController
    func testDismissEditNote() {
        let accountDetailsObj = AccountDetailsViewController()
        XCTAssertNotNil(accountDetailsObj.dismissEditNote())
        XCTAssertNotNil(accountDetailsObj.displayAccountNotes())
        XCTAssertNotNil(accountDetailsObj.noteCreated())
    }
    
    func testAccountsDidReceiveMemoryWarning(){
        let account = AccountsMenuViewController()
        XCTAssertNotNil(account.didReceiveMemoryWarning())
    }
    
}
