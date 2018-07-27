//
//  NotificationTests.swift
//  SWSAppTests
//
//  Created by Krishna, Kamya on 7/26/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import XCTest
@testable import SWSApp

class NotificationTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testinitNotification() {
        
        let notify = Notifications.init(for: "")
        XCTAssertEqual(notify.Id, "")
        XCTAssertEqual(notify.account, "")
        XCTAssertEqual(notify.createdDate, "")
        XCTAssertNil(notify.createdDataInDateType)
        //XCTAssertEqual(notify.createdDataInDateType, nil )
        XCTAssertEqual(notify.name, "")
        XCTAssertEqual(notify.sgwsAccLicenseNotification, "")
        XCTAssertEqual(notify.sgwsSite, "")
        XCTAssertEqual(notify.sgwsContactBirthdayNotification, "")
        XCTAssertEqual(notify.sgwsContact, "")
        XCTAssertFalse(notify.isRead)
        //XCTAssertEqual(notify.isRead, false)
        XCTAssertEqual(notify.soupEntryId, "")
        XCTAssertEqual(notify.sgwsType, "")
        
    }
    
    func testInitJsonNotifications(){
        
        let notificationsFields: [String: Any] = ["Id": "", "Account__c": "", "CreatedDate": "", "Name": "", "SGWS_Account_License_Notification__c": "", "SGWS_Site__c": "", "SGWS_Contact_Birthday_Notification__c": "", "SGWS_Contact__c": "", "isRead": "", "_soupEntryId": "", "SGWS_Type__c": ""]
        
        let notify = Notifications.init(json: notificationsFields)
        XCTAssertEqual(notify.Id, notificationsFields["Id"] as! String)
        XCTAssertEqual(notify.account, notificationsFields["Account__c"] as! String)
        XCTAssertNotNil(notify.createdDate, notificationsFields["CreatedDate"] as! String)
        XCTAssertEqual(notify.sgwsContactBirthdayNotification, notificationsFields["SGWS_Account_License_Notification__c"] as! String)
        XCTAssertEqual(notify.sgwsSite, notificationsFields["SGWS_Site__c"] as! String)
        XCTAssertEqual(notify.sgwsContactBirthdayNotification, notificationsFields["SGWS_Contact_Birthday_Notification__c"] as! String)
        XCTAssertEqual(notify.sgwsContact, notificationsFields["SGWS_Contact__c"] as! String)
        
        XCTAssertFalse(notify.isRead, notificationsFields["isRead"] as! String)
        XCTAssertEqual(notify.soupEntryId, notificationsFields["_soupEntryId"] as! String)
        XCTAssertEqual(notify.sgwsType, notificationsFields["SGWS_Type__c"] as! String)
        
    }
    
    func testNotificationsCInit(){
        
        let notificationsFields: [Any] = ["Id","Account__c","CreatedDate","Name","SGWS_Account_License_Notification__c","SGWS_Site__c","SGWS_Contact_Birthday_Notification__c","SGWS_Contact__c","isRead","_soupEntryId","SGWS_Type__c"]
        XCTAssertNotNil(Notifications.init(withAry: notificationsFields))
        
    }
    
    //NotificationsViewController
    
    func testNotificationsViewControllerViewWillAppear(){
        let appear = NotificationsViewController()
        XCTAssertNotNil(appear.viewWillAppear(true))
    }
    
    func testNotificationsViewControllerViewWillDisappear(){
        let disAppear = NotificationsViewController()
        XCTAssertNotNil(disAppear.viewWillDisappear(true))
    }
    
    //NotificationModalTableViewCell
    
    func testNotificationModalTableViewCellAwakeFromNib(){
        let awake = NotificationModalTableViewCell()
        XCTAssertNotNil(awake.awakeFromNib())
    }
    
    func testSyncNotificationWithServer(){
        let notif = NotificationsViewModel()
        let expectation = XCTestExpectation(description: "Notification reSync")
        notif.syncNotificationWithServer{ error in
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
        
    }
    
}
