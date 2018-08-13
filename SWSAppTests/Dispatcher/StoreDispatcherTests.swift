//
//  StoreDispatcherTests.swift
//  SWSAppTests
//
//  Created by Krishna, Kamya on 7/26/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import XCTest
@testable import SWSApp
import Reachability
import SmartSync

class StoreDispatcherTests: XCTestCase {
    
    func mockTestNotification1() -> Notifications {
        let notification = Notifications(for: "mockup")
        notification.Id = "1233"
        notification.account = "Test Notification"
        notification.createdDate = ""
        notification.createdDataInDateType = Date()
        notification.name = "Test"
        notification.sgwsAccLicenseNotification = "licence"
        notification.sgwsSite = "site"
        notification.sgwsContactBirthdayNotification = "birthday"
        notification.sgwsContact = "contact"
        notification.isRead = true
        notification.soupEntryId = "48"
        notification.sgwsType = "type"
        return notification
    }
    func mockTestNotification2() -> Notifications {
        let notification = Notifications(for: "mockup")
        return notification
    }
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCreateSyncLogOnSyncStop() {
        StoreDispatcher.shared.createSyncLogOnSyncStop(networkType: network())
        
    }
    
    func network()->String{
        let reachability = Reachability()!
        var status :String = ""
        if reachability.connection == .wifi {
            status = "WIFI"
        } else {
            status = "Cellular"
        }
        return status
    }
    
    func testcreateSyncLogOnSyncError() {
        StoreDispatcher.shared.createSyncLogOnSyncError(networkType: network())
        
    }
    
    func testSyncUpLogHandeler() {
        StoreDispatcher.shared.syncUpLogHandeler()
        
    }
    
    func testFetchAllAccountsSurveyIds() {
        _ = StoreDispatcher.shared.fetchAllAccountsSurveyIds()
    }
    
    func testFetchStrategy() {
        _ = StoreDispatcher.shared.fetchStrategy(forAccount: "001i000001IWj78AAD")
    }
    
    func testFetchContacts() {
        _ = StoreDispatcher.shared.fetchContacts(forAccount: "0010t00000SwzC2AAJ")
        _ = StoreDispatcher.shared.fetchContacts(forAccount: "001i000001IUjJCAA1")
    }
    
    func testFetchContactsAccounts() {
        _ = StoreDispatcher.shared.fetchContactsAccounts()
    }
    
    func testFetchContactId() {
        _ = StoreDispatcher.shared.fetchContactId(for: "0030t00000LTiM7AAL")
    }
    
    func testFetchSchedulerVisits() {
        _ = StoreDispatcher.shared.fetchSchedulerVisits()
    }
    
    func testEditVisitEx() {
        let attributeDict = ["type":"WorkOrder"]
        
        let addNewDict: [String:Any] = [
            
            PlanVisit.planVisitFields[13]:"49",
            kSyncTargetLocal:true,
            kSyncTargetLocallyCreated:true,
            kSyncTargetLocallyUpdated:false,
            kSyncTargetLocallyDeleted:false,
            "attributes":attributeDict]
        _ = StoreDispatcher.shared.editVisitEx(fields: addNewDict)
       
    }
    
    func testEditNotificationsLocally () {
        
        let editNotification = Notifications(for: "notification")
        editNotification.isRead = true
        let attributeDict = ["type":"FS_Notification__c"]
        let notificationDict: [String:Any] = [
            Notifications.notificationsFields[0]: "a0u0t0000022lzLAAQ",
            Notifications.notificationsFields[8]: editNotification.isRead,
            kSyncTargetLocal:true,
            kSyncTargetLocallyCreated:false,
            kSyncTargetLocallyUpdated:true,
            kSyncTargetLocallyDeleted:false,
            "attributes":attributeDict]
        _ = StoreDispatcher.shared.editNotificationsLocally(fieldsToUpload: notificationDict)
        
    }
    
    func testFetchUnreadNotificationsCount() {
        _ = StoreDispatcher.shared.fetchUnreadNotificationsCount()
    }
    
}
