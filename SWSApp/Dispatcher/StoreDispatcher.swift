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
        
        //print("Store Path is \(String(describing: store.storePath))")
        return store
    }
    
    lazy final var sfaSyncMgr: SFSmartSyncSyncManager = SFSmartSyncSyncManager.sharedInstance(for: sfaStore)!
    
    
    //register all soups - to do: register other needed soups
    func registerSoups() {
        registerUserSoup()
        registerAccountSoup()
        registerContactSoup()
    }
    
    func downloadAllSoups(_ completion: @escaping ((_ error: NSError?) -> ()) ) {
        syncDownSoups(completion)
    }
    
    
    //sync down all soups
    fileprivate func syncDownSoups(_ completion: @escaping ((_ error: NSError?) -> ()) ) {
        
        let queue = DispatchQueue(label: "serial") // or concurrent
        let group = DispatchGroup()
        
        group.enter()
        syncDownUser() { _ in
            group.leave()
        }
        
        
        group.enter()
        syncDownAccount() { _ in
            group.leave()
        }
        
        group.enter()
        syncDownContact() { _ in
            group.leave()
        }
        
        //to do: syncDown other soups
        
        group.notify(queue: queue) {
            completion(nil)
        }
        
        
    }
    
    //#pragma mark - create indexes for the soup and register the soup; only create indexes for the fields we want to query by
    
    func registerUserSoup() {
        let indexSpec:[SFSoupIndex] = [
            SFSoupIndex(path: "Id", indexType: kSoupIndexTypeString, columnName: "Id")!,
            //SFSoupIndex(path: "Name", indexType:kSoupIndexTypeString, columnName: "Name")!,
            SFSoupIndex(path: "FirstName", indexType:kSoupIndexTypeString, columnName: "FirstName")!,
            //SFSoupIndex(path: "EmployeeNumber", indexType:kSoupIndexTypeString, columnName: "EmployeeNumber")!,
            //SFSoupIndex(path: "Job_Role__c", indexType: kSoupIndexTypeString, columnName: "Job_Role__c")!,
            //SFSoupIndex(path: "AccountId", indexType: kSoupIndexTypeString, columnName: "AccountId")!
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
            SFSoupIndex(path: "AccountNumber", indexType: kSoupIndexTypeString, columnName: "AccountNumber")!,
            SFSoupIndex(path: "Name", indexType:kSoupIndexTypeString, columnName: "Name")!
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
    
    func syncDownUser(_ completion:@escaping (_ error: NSError?)->()) {
        //let userId : String = SFUserAccountManager.sharedInstance().currentUser!.accountIdentity.userId //logged in userId
        let userId : String = "005i0000002XxdhAAC" //use this for now for testing
        
        //let fields : [String] = ["Id", "Name", "Username", "Manager.Name", "Manager.Username", "Manager.Manager.Name", "Manager.Manager.Username"]
        
        let fields : [String] = ["Id", "FirstName", "LastName", "AccountId"] //, "EmployeeNumber"]
        
        let soqlQuery = "Select \(fields.joined(separator: ",")) from User Where Id = '\(userId)'"
        
        let syncDownTarget = SFSoqlSyncDownTarget.newSyncTarget(soqlQuery)
        let syncOptions    = SFSyncOptions.newSyncOptions(forSyncDown:
            SFSyncStateMergeMode.overwrite)
        
        sfaSyncMgr.Promises.syncDown(target: syncDownTarget, options: syncOptions, soupName: "User")
            .done { syncStateStatus in
                if syncStateStatus.isDone() {
                    print("syncDownUser() done")
                    completion(nil)
                }
                else if syncStateStatus.hasFailed() {
                    let meg = "ErrorDownloading: syncDownUser()"
                    let userInfo: [String: Any] =
                        [
                            NSLocalizedDescriptionKey : meg,
                            NSLocalizedFailureReasonErrorKey : meg
                    ]
                    let err = NSError(domain: "syncDownUser()", code: 601, userInfo: userInfo)
                    completion(err as NSError?)
                }
            }
            .catch { error in
                completion(error as NSError?)
        }
    }
    
    func syncDownAccount(_ completion:@escaping (_ error: NSError?)->()) {
        let fields : [String] = ["Id", "AccountNumber", "Name"] //add more
        
        let soqlQuery = "Select \(fields.joined(separator: ",")) from Account where AccountNumber like '3200%' limit 10"
        
        let syncDownTarget = SFSoqlSyncDownTarget.newSyncTarget(soqlQuery)
        let syncOptions    = SFSyncOptions.newSyncOptions(forSyncDown:
            SFSyncStateMergeMode.overwrite)
        
        sfaSyncMgr.Promises.syncDown(target: syncDownTarget, options: syncOptions, soupName: "User")
            .done { syncStateStatus in
                if syncStateStatus.isDone() {
                    print("syncDownAccount() done")
                    //let _ = self.fetchAccounts(forConsultant: "111")
                    completion(nil)
                }
                else if syncStateStatus.hasFailed() {
                    let meg = "ErrorDownloading: syncDownAccount() "
                    let userInfo: [String: Any] =
                        [
                            NSLocalizedDescriptionKey : meg,
                            NSLocalizedFailureReasonErrorKey : meg
                    ]
                    let err = NSError(domain: "syncDownAccount()", code: 601, userInfo: userInfo)
                    completion(err as NSError?)
                }
            }
            .catch { error in
                completion(error as NSError?)
        }
    }
    
    func syncDownContact(_ completion:@escaping (_ error: NSError?)->()) {
        let fields : [String] = ["Id", "FirstName", "LastName", "AccountId", "Birthdate"] //add more
        
        let soqlQuery = "Select \(fields.joined(separator: ",")) from Contact limit 10"
        
        let syncDownTarget = SFSoqlSyncDownTarget.newSyncTarget(soqlQuery)
        let syncOptions    = SFSyncOptions.newSyncOptions(forSyncDown:
            SFSyncStateMergeMode.overwrite)
        
        sfaSyncMgr.Promises.syncDown(target: syncDownTarget, options: syncOptions, soupName: "User")
            .done { syncStateStatus in
                if syncStateStatus.isDone() {
                    print("syncDownContact() done")
                    completion(nil)
                }
                else if syncStateStatus.hasFailed() {
                    let meg = "ErrorDownloading: syncDownContact()"
                    let userInfo: [String: Any] =
                        [
                            NSLocalizedDescriptionKey : meg,
                            NSLocalizedFailureReasonErrorKey : meg
                    ]
                    let err = NSError(domain: "syncDownContact()", code: 601, userInfo: userInfo)
                    completion(err as NSError?)
                }
            }
            .catch { error in
                completion(error as NSError?)
        }
    }
    
    
    //User
    func fetchLoggedInUser(_ completion:@escaping ((_ user:User?, _ error: NSError?)->())) {
        completion(User.mockUser(), nil)
        return
        
        //user mockUser for now
        let userId : String = "005i0000002XxdhAAC" //use this for now for testing SFUserAccountManager.sharedInstance().currentUser!.accountIdentity.userId
        
        let fetchQuerySpec = SFQuerySpec.newSmartQuerySpec("SELECT {User:Id}, {User:FirstName} FROM {User} Where {User:Id} = '\(userId)'", withPageSize: 10)
        var error : NSError?
        let result = self.sfaStore.query(with: fetchQuerySpec!, pageIndex: 0, error: &error)
        
        if (error == nil ) {
            let ary:[Any] = result[0] as! [Any]
            let user = User(withAry: ary)
            completion(user, nil)
        }
        else {
            completion(nil, error)
        }
    }
    
    
    //Accounts
    func fetchAccountsForLoggedUser() -> [Account] {
        let account1 = Account.mockAccount1()
        //add more if needed
        
        var ary = [Account]()
        ary.append(account1)
        
        return ary
    }
    
    
    
    func fetchAccounts(forConsultant cid: String) -> [Account]  {
        var accountAry: [Account] = []
        let querySpec = SFQuerySpec.newSmartQuerySpec("SELECT {Account:Id}, {Account:AccountNumber}, {Account:Name} FROM {Account}", withPageSize: 10) //{Account:ConsultantId} = 'cid'",  withPageSize: 100000)
        
        var error : NSError?
        let result = sfaStore.query(with: querySpec!, pageIndex: 0, error: &error)
        
        
        let cnt = result.count
        
        if cnt < 1 {
            return accountAry
        }
        
        for i in 0...cnt-1 {
            let acc = Account(withAry:result[i] as! [Any])
            accountAry.append(acc)
        }
        
        return accountAry
    }
    
    //Contacts
    func fetchContactsWithBuyingPower(forUser uid: String) -> [Contact] {
        let contact1 = Contact.mockBuyingPowerContact1()
        let contact2 = Contact.mockBuyingPowerContact2()
        let contact3 = Contact.mockBuyingPowerContact3()
        
        //add more if needed
        
        var ary = [Contact]()
        ary.append(contact1)
        ary.append(contact2)
        ary.append(contact3)
        return ary
    }
    
    func fetchContactsForSG(forUser uid: String) -> [Contact] {
        let contact1 = Contact.mockContactSG1()
        let contact2 = Contact.mockContactSG2()
        let contact3 = Contact.mockContactSG3()
        let contact4 = Contact.mockContactSG4()
        //add more if needed
        
        var ary = [Contact]()
        ary.append(contact1)
        ary.append(contact2)
        ary.append(contact3)
        ary.append(contact4)
        return ary
    }
    
    
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

