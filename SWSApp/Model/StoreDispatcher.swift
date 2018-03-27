//
//  StoreDispatcher.swift
//  SWSApp
//
//  Created by maria.min-hui.yu on 3/23/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation
import SalesforceSDKCore
import SalesforceSwiftSDK
import PromiseKit
import SmartStore
import SmartSync

class StoreDispatcher {
    static let shared = StoreDispatcher()
    static let SFADB = "SFADB"
    
    final var sfaStore: SFSmartStore {
        let store = SFSmartStore.sharedGlobalStore(withName: StoreDispatcher.SFADB) as! SFSmartStore
        
        print("Store Path is \(String(describing: store.storePath))")
        return store
    }
    
    lazy final var sfaSyncMgr: SFSmartSyncSyncManager = SFSmartSyncSyncManager.sharedInstance(for: sfaStore)!
    
    
    //register all soups - to do: register other needed soups
    func registerSoups() {
        registerUserSoup()
        registerAccountSoup()
        registerContactSoup()
    }
    
    //sync down all soups
    func syncDownSoups() -> Bool {
        
        //To Do: research how to use Promises
        
        var completed: Bool = false
        let queue = DispatchQueue(label: "serial") //or concurrent
        let group = DispatchGroup()
        
        group.enter()
        syncDownUser()
        group.leave()
        
        group.enter()
        syncDownAccount()
        group.leave()
    
        group.enter()
        syncDownContact()
        group.leave()
        
        //to do: syncDown other soups
        
        group.notify(queue: queue) {
            completed = true
        }
        
        return completed
    }
    
    //#pragma mark - create indexes for the soup and register the soup; only create indexes for the fields we want to query by
    
    func registerUserSoup() {
        let indexSpec:[SFSoupIndex] = [
            SFSoupIndex(path: "Id", indexType: kSoupIndexTypeString, columnName: "Id")!,
            SFSoupIndex(path: "Name", indexType:kSoupIndexTypeString, columnName: "Name")!,
            SFSoupIndex(path: "EmployeeNumber", indexType:kSoupIndexTypeString, columnName: "EmployeeNumber")!,
            SFSoupIndex(path: "Job_Role__c", indexType: kSoupIndexTypeString, columnName: "Job_Role__c")!,
            SFSoupIndex(path: "AccountId", indexType: kSoupIndexTypeString, columnName: "AccountNumber")!
            ]
    
        do {
            try sfaStore.registerSoup("User", withIndexSpecs: indexSpec, error: ())
            
        } catch let error as NSError {
            SalesforceSwiftLogger.log(type(of:self), level:.error, message: "failed to register User soup: \(error.localizedDescription)")
        }
    }
    
    func registerAccountSoup() {
        let indexSpec:[SFSoupIndex] = [
            SFSoupIndex(path: "Id", indexType: kSoupIndexTypeString, columnName: "Id")!,
            SFSoupIndex(path: "Name", indexType:kSoupIndexTypeString, columnName: "Name")!,
            SFSoupIndex(path: "AccountNumber", indexType: kSoupIndexTypeString, columnName: "AccountNumber")!
        ]
        
        do {
            try sfaStore.registerSoup("Account", withIndexSpecs: indexSpec, error: ())
            
        } catch let error as NSError {
            SalesforceSwiftLogger.log(type(of:self), level:.error, message: "failed to register Account soup: \(error.localizedDescription)")
        }
    }
    
    func registerContactSoup() {
        let indexSpec:[SFSoupIndex] = [
            SFSoupIndex(path: "Id", indexType: kSoupIndexTypeString, columnName: "Id")!,
            SFSoupIndex(path: "FirstName", indexType: kSoupIndexTypeString, columnName: "FirstName")!,
            SFSoupIndex(path: "LastName", indexType: kSoupIndexTypeString, columnName: "LastName")!,
            SFSoupIndex(path: "AccountId", indexType: kSoupIndexTypeString, columnName: "AccountId")!,
            SFSoupIndex(path: "Birthdate", indexType: kSoupIndexTypeString, columnName: "Birthdate")!
        ]
        
        do {
            try sfaStore.registerSoup("Contact", withIndexSpecs: indexSpec, error: ())
            
        } catch let error as NSError {
            SalesforceSwiftLogger.log(type(of:self), level:.error, message: "failed to register Contact soup: \(error.localizedDescription)")
        }
    }
    
    
    //#pragma mark - syncdown so we have data in the soups
    
    func syncDownUser() {
        let fields : [String] = ["Id", "FirstName", "LastName", "Email", "AccountId", "EmployeeNumber"]
        
        let soqlQuery = "Select \(fields.joined(separator: ",")) from User"
        
        let syncDownTarget = SFSoqlSyncDownTarget.newSyncTarget(soqlQuery)
        let syncOptions    = SFSyncOptions.newSyncOptions(forSyncDown:
            SFSyncStateMergeMode.overwrite)
    
        sfaSyncMgr.Promises.syncDown(target: syncDownTarget, options: syncOptions, soupName: "User")
        .done { syncStateStatus in
            if syncStateStatus.isDone() {
                print("syncDownUser() done")
            }
        }
        .catch { error in
        }
    }
    
    func syncDownAccount() {
        let fields : [String] = ["Id", "AccountNumber", "Name"] //add more
        
        let soqlQuery = "Select \(fields.joined(separator: ",")) from Account limit 10"
        
        let syncDownTarget = SFSoqlSyncDownTarget.newSyncTarget(soqlQuery)
        let syncOptions    = SFSyncOptions.newSyncOptions(forSyncDown:
            SFSyncStateMergeMode.overwrite)
        
        sfaSyncMgr.Promises.syncDown(target: syncDownTarget, options: syncOptions, soupName: "User")
            .done { syncStateStatus in
                if syncStateStatus.isDone() {
                    print("syncDownAccount() done")
                }
                
            }
            .catch { error in
        }
    }
    
    func syncDownContact() {
        let fields : [String] = ["Id", "FirstName", "LastName", "AccountId", "Birthdate"] //add more
        
        let soqlQuery = "Select \(fields.joined(separator: ",")) from Contact limit 10"
        
        let syncDownTarget = SFSoqlSyncDownTarget.newSyncTarget(soqlQuery)
        let syncOptions    = SFSyncOptions.newSyncOptions(forSyncDown:
            SFSyncStateMergeMode.overwrite)
        
        sfaSyncMgr.Promises.syncDown(target: syncDownTarget, options: syncOptions, soupName: "User")
            .done { syncStateStatus in
                if syncStateStatus.isDone() {
                    print("syncDownContact() done")
                }
            }
            .catch { error in
        }
    }
    
    
    func fetchLoggedInUser() -> User? {
        let userId : String = SFUserAccountManager.sharedInstance().currentUser!.accountIdentity.userId
        var currentUser:Promise<User>?
        
        //SELECT fields FROM User WHERE Id = '\(userId)'
        let querySpec =  SFQuerySpec.Builder(soupName: "User")
                    .queryType(value: "match")
                    .path(value: "Id")
                    .matchKey(value: userId)
                    .build()
        
        firstly {
            self.sfaStore.Promises.query(querySpec: querySpec, pageIndex: 0)
        }
        .then {
            result -> Promise<User> in
            let dict = result[0] as! [String:AnyObject]
            currentUser = Promise<User>(value: User(json: dict))
            return currentUser!
        }
        .done { syncStateStatus in
            if currentUser != nil {
                print("fetchLoggedInUser() done")
            }        }
        .catch { error in
        }
        
        return nil
    }
    
    func fetchAccounts(forConsultant cid: String) -> [Account]  {
        var accountAry: [Account] = []
        let querySpec = SFQuerySpec.newSmartQuerySpec("SELECT {Account:Id}, {Account:AccountNumber}, {Account:Name} FROM {Account} WHERE {Account:AccountNumber} like '3200%' ", withPageSize: 10000) //{Account:ConsultantId} = 'cid'",  withPageSize: 100000)
        
        var error : NSError?
        let result = sfaStore.query(with: querySpec!, pageIndex: 0, error: &error)
        
        
        let cnt = result.count
        for i in 0...cnt-1 {
            let acc = Account(withAry:result[i] as! [Any])
            accountAry.append(acc)
        }
        
        return accountAry
    }
    
    //not quite right - to do: research how to return an array by using Promise
    /*
    func fetchAccount(forConsultant cid: String) -> [Account]  {
        var accountAry: [Promise<Account>] = []
        
        //SELECT fields FROM Account WHERE ConsultantId = '\(cid)'
        let querySpec =  SFQuerySpec.Builder(soupName: "Account")
            .queryType(value: "match")
            .path(value: "ConsultantId")
            .matchKey(value: cid)
            .build()
        
        firstly {
            self.sfaStore.Promises.query(querySpec: querySpec, pageIndex: 0)
            }
            .then {
                result -> Promise<[Account]> in
                let cnt = result.count
                
                for i in 0...cnt-1 {
                let dict = result[i] as! [String:AnyObject]
                    let acc = Promise<Account>(value: Account(json: dict))
                    accountAry.append(acc)
                }
                return accountAry
            }
            .done { syncStateStatus in
                
            }
            .catch { error in
        }
        return nil
    }
    */
    
    func fetchContacts(forAccount aid: String) -> [Contact]  {
        //to do
        var contactAry: [Contact] = []
        
        return contactAry
    }
    
    func fetchNotifications(forUser uid: String) -> [Notification]  {
        //to do
        var ary: [Notification] = []
        
        return ary
    }
}
