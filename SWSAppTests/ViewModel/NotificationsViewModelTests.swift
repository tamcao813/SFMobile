//
//  NotificationsViewModelTests.swift
//  SWSAppTests
//
//  Created by Krishna, Kamya on 7/30/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import XCTest
@testable import SWSApp

class NotificationsViewModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSyncNotificationWithServer(){
        let notif = NotificationsViewModel()
        let expectation = XCTestExpectation(description: "Notification reSync")
        notif.syncNotificationWithServer{ error in
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
        
    }
    
    func testNotificationsForUser(){
        let note = NotificationsViewModel()
        XCTAssertNotNil(note.notificationsForUser())
    }
    
}
