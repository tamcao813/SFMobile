//
//  AccountsActionItemViewModelTests.swift
//  SWSAppTests
//
//  Created by Krishna, Kamya on 7/30/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import XCTest
import SmartSync
@testable import SWSApp

class AccountsActionItemViewModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testActionItemFourMonthsSorted() {
        let viewModel = AccountsActionItemViewModel()
        _ = viewModel.actionItemFourMonthsSorted()
    }
    
    func testActionItemFourMonthsDescSorted() {
        let viewModel = AccountsActionItemViewModel()
        _ = viewModel.actionItemFourMonthsDescSorted()
        _ = viewModel.actionItemForUserTwoWeeksUpcoming()
        _ = viewModel.actionItemForUserOneWeeksPast()
    }
    
    func testEditActionItemsLocally() {
        let editActionItem = ActionItem(for: "editActionItem")
        //editActionItem = actionItemObject!
        editActionItem.status = "Complete"
        editActionItem.lastModifiedDate = DateTimeUtility.getCurrentTimeStampInUTCAsString()
        let attributeDict = ["type":"Task"]
        let actionItemDict: [String:Any] = [
            
            ActionItem.AccountActionItemFields[0]:"00T0t000008C4ouEAC",
            ActionItem.AccountActionItemFields[4]: editActionItem.status,
            ActionItem.AccountActionItemFields[7]: editActionItem.lastModifiedDate,
            
            kSyncTargetLocal:true,
            kSyncTargetLocallyCreated:false,
            kSyncTargetLocallyUpdated:true,
            kSyncTargetLocallyDeleted:false,
            "attributes":attributeDict]
        
        _ = StoreDispatcher.shared.editActionItemLocally(fieldsToUpload:actionItemDict)
        _ = StoreDispatcher.shared.editActionItemStatusLocally(fieldsToUpload: actionItemDict)
        
        
        let viewModel = AccountsActionItemViewModel()
        _ = viewModel.editActionItemLocally(fields: actionItemDict)
        _ = viewModel.editActionItemStatusLocally(fields: actionItemDict)
        _ = viewModel.editActionItemStatusLocallyAutomatically(fields: actionItemDict)
        _ = viewModel.deleteActionItemLocally(fields: actionItemDict)
        _ = viewModel.createNewActionItemLocally(fields: actionItemDict)
        
    }
}
