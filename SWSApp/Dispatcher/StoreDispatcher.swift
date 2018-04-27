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
    
    let SoupUser = "User"
    let SoupAccount = "AccountTeamMember"
    let SoupContact = "Contact"
    let SoupAccountContactRelation = "AccountContactRelation"

    lazy final var sfaStore: SFSmartStore = SFSmartStore.sharedStore(withName: StoreDispatcher.SFADB) as! SFSmartStore
    
    lazy final var sfaSyncMgr: SFSmartSyncSyncManager = SFSmartSyncSyncManager.sharedInstance(for: sfaStore)!
    
    var userVieModel: UserViewModel {
        return UserViewModel()
        
    }
    
    //register all soups - to do: register other needed soups
    func registerSoups() {
        print("Store Path is \(String(describing: sfaStore.storePath))")
        
        registerUserSoup()
        registerAccountSoup()
        registerContactSoup()
        registerACRSoup()
    }
    
    func downloadAllSoups(_ completion: @escaping ((_ error: NSError?) -> ()) ) {
        syncDownSoups(completion)
    }
    
    
    //sync down all soups other than User
    fileprivate func syncDownSoups(_ completion: @escaping ((_ error: NSError?) -> ()) ) {
        
        let queue = DispatchQueue(label: "concurrent")
        let group = DispatchGroup()
        
        group.enter()
        downloadContactRolesPList() { _ in
            group.leave()
        }
        
        group.enter()
        syncDownAccount() { _ in
            self.syncDownACR() { _ in
                group.leave()
            }
        }
        
        group.enter()
        syncDownUserDataForAccounts() { _ in
            group.leave()
        }
        
        group.enter()
        syncDownContact() { _ in
            group.leave()
        }
        
        group.enter()
        syncDownACR() { _ in
            group.leave()
        }
        
        //to do: syncDown other soups
        
        group.notify(queue: queue) {
            completion(nil)
        }
        
        
    }
    
    func downloadContactRolesPList(_ completion:@escaping (_ error: NSError?)->()) {
        let recordTypeId = "012i0000000PebvAAC" //"012i0000000Pf4AAAS" //(userVieModel.loggedInUser?.recordTypeId)!
        let path = "ui-api/object-info/Contact/picklist-values/" + recordTypeId + "/SGWS_Roles__c"
        let request = SFRestRequest(method: .GET, path: path, queryParams: nil)
        request.endpoint = "/services/data/v41.0/"
        
        SFRestAPI.sharedInstance().Promises.send(request: request)
            .done { sfRestResponse in
                let response = sfRestResponse.asJsonDictionary()
                    
                var rolesPicklist = [String:[PlistOption]]()
                
                if response.count > 0 {
                    var rolesAry = [PlistOption]()
                
                    if let options = response["values"] as? [[String : AnyObject]] {
                        for option in options {
                            let label = option["label"] as? String ?? ""
                            let value = option["value"] as? String ?? ""
                            let role = PlistOption(label: label, value: value)
                        
                            rolesAry.append(role)
                        }
                    
                        rolesPicklist["Roles"] = rolesAry
                    }
                }
                
                PlistMap.sharedInstance.addToMap(self.SoupContact, map: rolesPicklist)
                completion(nil)
            }
            .catch { error in
                print(error)
                completion(error as NSError?)
        }
    }

    
    //#pragma mark - create indexes for the soup and register the soup; only create indexes for the fields we want to query by
    
    func registerUserSoup() {
        let userQueryFields = User.UserFields
        
        var indexSpec:[SFSoupIndex] = []
        for i in 0...userQueryFields.count - 1 {
            let sfIndex = SFSoupIndex(path: userQueryFields[i], indexType: kSoupIndexTypeString, columnName: userQueryFields[i])!
            indexSpec.append(sfIndex)
        }
        
        do {
            try sfaStore.registerSoup(SoupUser, withIndexSpecs: indexSpec, error: ())
            
        } catch let error as NSError {
            SalesforceSwiftLogger.log(type(of:self), level:.error, message: "failed to register User soup: \(error.localizedDescription)")
        }
    }
    
    func registerAccountSoup() {
        
        let indexes:[AnyObject]! = [
            SFSoupIndex(path: "Id", indexType: kSoupIndexTypeString, columnName: "Id")!,
            SFSoupIndex(path: "Account.SGWS_Account_Health_Grade__c", indexType: kSoupIndexTypeString, columnName: "Account.SGWS_Account_Health_Grade__c")!,
            SFSoupIndex(path: "Account.Name", indexType: kSoupIndexTypeFullText, columnName: "Account.Name")!,
            SFSoupIndex(path: "Account.AccountNumber", indexType: kSoupIndexTypeString, columnName: "Account.AccountNumber")!,
            SFSoupIndex(path: "Account.SWS_Total_CY_MTD_Net_Sales__c", indexType: kSoupIndexTypeFloating, columnName: "Account.SWS_Total_CY_MTD_Net_Sales__c")!,
            SFSoupIndex(path: "Account.SWS_Total_AR_Balance__c", indexType: kSoupIndexTypeFloating, columnName: "Account.SWS_Total_AR_Balance__c")!,
            SFSoupIndex(path: "Account.IS_Next_Delivery_Date__c", indexType: kSoupIndexTypeFullText, columnName: "Account.IS_Next_Delivery_Date__c")!,
            SFSoupIndex(path: "Account.SWS_Premise_Code__c", indexType: kSoupIndexTypeFullText, columnName: "Account.SWS_Premise_Code__c")!,
            SFSoupIndex(path: "Account.SWS_License_Type__c", indexType: kSoupIndexTypeString, columnName: "Account.SWS_License_Type__c")!,
           SFSoupIndex(path: "Account.SWS_License__c", indexType: kSoupIndexTypeString, columnName: "Account.SWS_License__c")!,
            SFSoupIndex(path: "Account.Google_Place_Operating_Hours__c", indexType: kSoupIndexTypeString, columnName:"Account.Google_Place_Operating_Hours__c")!,
            SFSoupIndex(path: "Account.SWS_License_Expiration_Date__c", indexType: kSoupIndexTypeString, columnName:"Account.SWS_License_Expiration_Date__c")!,
            SFSoupIndex(path: "Account.SWS_Total_CY_R12_Net_Sales__c", indexType: kSoupIndexTypeFloating, columnName:"Account.SWS_Total_CY_R12_Net_Sales__c")!,
            SFSoupIndex(path: "Account.SWS_Credit_Limit__c", indexType: kSoupIndexTypeFloating, columnName:"Account.SWS_Credit_Limit__c")!,
            SFSoupIndex(path: "Account.SWS_TD_Channel__c", indexType: kSoupIndexTypeString, columnName: "Account.SWS_TD_Channel__c")!,
            SFSoupIndex(path: "Account.SWS_TD_Sub_Channel__c", indexType: kSoupIndexTypeString, columnName: "Account.SWS_TD_Sub_Channel__c")!,
            SFSoupIndex(path: "Account.SWS_License_Status_Description__c", indexType: kSoupIndexTypeString, columnName: "Account.SWS_License_Status_Description__c")!,
            SFSoupIndex(path: "Account.ShippingCity", indexType: kSoupIndexTypeString, columnName: "Account.ShippingCity")!,
            SFSoupIndex(path: "Account.ShippingCountry", indexType: kSoupIndexTypeString, columnName: "Account.ShippingCountry")!,
            SFSoupIndex(path: "Account.ShippingPostalCode", indexType: kSoupIndexTypeString, columnName: "Account.ShippingPostalCode")!,
            SFSoupIndex(path: "Account.ShippingState", indexType: kSoupIndexTypeString, columnName: "Account.ShippingState")!,
            SFSoupIndex(path: "Account.ShippingStreet", indexType: kSoupIndexTypeString, columnName: "Account.ShippingStreet")!,
            SFSoupIndex(path: "Account.SWS_PCT_to_Last_Year_MTD_Net_Sales__c", indexType: kSoupIndexTypeString, columnName: "Account.SWS_PCT_to_Last_Year_MTD_Net_Sales__c")!,
            SFSoupIndex(path: "Account.SWS_AR_Past_Due_Amount__c", indexType: kSoupIndexTypeString, columnName: "Account.SWS_AR_Past_Due_Amount__c")!,
            SFSoupIndex(path: "Account.SWS_Delivery_Frequency__c", indexType: kSoupIndexTypeString, columnName: "Account.SWS_Delivery_Frequency__c")!,
            SFSoupIndex(path: "Account.SGWS_Single_Multi_Locations_Filter__c", indexType: kSoupIndexTypeString, columnName: "Account.SGWS_Single_Multi_Locations_Filter__c")!,
            SFSoupIndex(path: "Account.Google_Place_Formatted_Phone__c", indexType: kSoupIndexTypeString, columnName: "Account.Google_Place_Formatted_Phone__c")!,
             SFSoupIndex(path: "Account.SWS_Status_Description__c", indexType: kSoupIndexTypeString, columnName: "Account.SWS_Status_Description__c")!,
             SFSoupIndex(path: "AccountId", indexType: kSoupIndexTypeString, columnName: "AccountId")!,
            SFSoupIndex(path: "Account.SWS_PCT_to_Last_Year_R12_Net_Sales__c", indexType: kSoupIndexTypeString, columnName: "Account.SWS_PCT_to_Last_Year_R12_Net_Sales__c")!
             
            
            // SFSoupIndex(path: "Account.ShippingLatitude", indexType: kSoupIndexTypeFloating, columnName: "Account.ShippingLatitude")!,
           // SFSoupIndex(path: "Account.ShippingLongitude", indexType: kSoupIndexTypeFloating, columnName: "Account.ShippingLongitude")!
        ]
        let indexSpecs: [AnyObject] = SFSoupIndex.asArraySoupIndexes(indexes) as [AnyObject]
        
        
        do {
            try sfaStore.registerSoup(SoupAccount, withIndexSpecs: indexSpecs, error: ())
            
        } catch let error as NSError {
            SalesforceSwiftLogger.log(type(of:self), level:.error, message: "failed to register Account soup: \(error.localizedDescription)")
        }
    }
    
    func registerContactSoup() {
        let contactQueryFields = Contact.ContactFields
        
        var indexSpec:[SFSoupIndex] = []
        for i in 0...contactQueryFields.count - 1 {
            let sfIndex = SFSoupIndex(path: contactQueryFields[i], indexType: kSoupIndexTypeString, columnName: contactQueryFields[i])!
            indexSpec.append(sfIndex)
        }
        
        do {
            try sfaStore.registerSoup(SoupContact, withIndexSpecs: indexSpec, error: ())
            
        } catch let error as NSError {
            SalesforceSwiftLogger.log(type(of:self), level:.error, message: "failed to register Contact soup: \(error.localizedDescription)")
        }
    }
    
    //#pragma mark - syncdown so we have data in the soups
    
    func syncDownUser(_ completion:@escaping (_ error: NSError?)->()) {
        
        let fields : [String] = User.UserFields
        let userId =   SFUserAccountManager.sharedInstance().currentUser?.credentials.userId
        
        let soqlQuery = "Select \(fields.joined(separator: ",")) from AccountTeamMember Where UserId = '\(userId!)' OR User.ManagerId = '\(userId!)' limit 100"
        
        let syncDownTarget = SFSoqlSyncDownTarget.newSyncTarget(soqlQuery)
        let syncOptions    = SFSyncOptions.newSyncOptions(forSyncDown:
            SFSyncStateMergeMode.overwrite)
        
        sfaSyncMgr.Promises.syncDown(target: syncDownTarget, options: syncOptions, soupName: SoupUser)
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
    
    func fetchAllAccountIdFromUser()->[String]{
        
        var accountIdsArray:[String] = []
        
        let soqlQuery = "Select {User:AccountId} FROM {User}"
        
        let fetchQuerySpec = SFQuerySpec.newSmartQuerySpec(soqlQuery, withPageSize: 100000)
        
        var error : NSError?
        let result = sfaStore.query(with: fetchQuerySpec!, pageIndex: 0, error: &error)
        
        
        if result.count > 0 {
            for i in 0...result.count - 1 {
                let ary:[Any] = result[i] as! [Any]
                accountIdsArray.append(ary[0] as! String)
                
            }
        }
        print(accountIdsArray)
        
        return accountIdsArray
    }
    
    func syncDownUserDataForAccounts(_ completion:@escaping (_ error: NSError?)->()) {
        
        let fields : [String] = User.UserFields
        
        let accIdsString = fetchAllAccountIdFromUser().joined(separator: "','")
        
        print("UserTable Account ids \(accIdsString)")
        
        let accIdsFormattedString = "'" + accIdsString + "'"
        
        let soqlQuery = "Select \(fields.joined(separator: ",")) from AccountTeamMember  WHERE AccountId IN (\(accIdsFormattedString))"
        
        
        let syncDownTarget = SFSoqlSyncDownTarget.newSyncTarget(soqlQuery)
        let syncOptions    = SFSyncOptions.newSyncOptions(forSyncDown:
            SFSyncStateMergeMode.overwrite)
        
        sfaSyncMgr.Promises.syncDown(target: syncDownTarget, options: syncOptions, soupName: SoupUser)
            .done { syncStateStatus in
                if syncStateStatus.isDone() {
                    print("syncDownUserDataForAccounts() done")
                    completion(nil)
                }
                else if syncStateStatus.hasFailed() {
                    let meg = "ErrorDownloading: syncDownUserDataForAccounts() "
                    let userInfo: [String: Any] =
                        [
                            NSLocalizedDescriptionKey : meg,
                            NSLocalizedFailureReasonErrorKey : meg
                    ]
                    let err = NSError(domain: "syncDownUserDataForAccounts()", code: 601, userInfo: userInfo)
                    completion(err as NSError?)
                }
            }
            .catch { error in
                completion(error as NSError?)
        }
    }
    
    
    
    func syncDownAccount(_ completion:@escaping (_ error: NSError?)->()) {
        /*
         let userid = (userVieModel.loggedInUser?.userid)!
         
         let fields: [String] = Account.AccountFields
         
         //let soqlQuery = "Select \(fields.joined(separator: ",")) from AccountTeamMember where Account.RecordType.DeveloperName = 'Customer' "
         */
        
     //   let soqlQuery = "SELECT Id,CreatedDate,,,,,,,,,,,,,,,,,,,,,,Account.SGWS_Account_Health_Grade__c  FROM AccountTeamMember Where Account.RecordType.DeveloperName='Customer' limit 10000"
        
        //,,Account.SWS_Premise_Code__c
        
        let soqlQuery = "SELECT Id,Account.SGWS_Account_Health_Grade__c,Account.Name,Account.AccountNumber,Account.SWS_Total_CY_MTD_Net_Sales__c,Account.SWS_Total_AR_Balance__c, Account.IS_Next_Delivery_Date__c,Account.SWS_Premise_Code__c,Account.SWS_License_Type__c,Account.SWS_License__c,Account.Google_Place_Operating_Hours__c,Account.SWS_License_Expiration_Date__c,Account.SWS_Total_CY_R12_Net_Sales__c,Account.SWS_Credit_Limit__c,Account.SWS_TD_Channel__c,Account.SWS_TD_Sub_Channel__c,Account.SWS_License_Status_Description__c,Account.ShippingCity,Account.ShippingCountry,Account.ShippingPostalCode,Account.ShippingState,Account.ShippingStreet,Account.SWS_PCT_to_Last_Year_MTD_Net_Sales__c,Account.SWS_AR_Past_Due_Amount__c,Account.SWS_Delivery_Frequency__c,Account.SGWS_Single_Multi_Locations_Filter__c,Account.Google_Place_Formatted_Phone__c,Account.SWS_Status_Description__c,AccountId,Account.SWS_PCT_to_Last_Year_R12_Net_Sales__c FROM AccountTeamMember Where Account.RecordType.DeveloperName='Customer' limit 10000"
       
        //,,,
        
        // Account.ShippingLatitude,Account.ShippingLongitude
        
        let syncDownTarget = SFSoqlSyncDownTarget.newSyncTarget(soqlQuery)
        let syncOptions    = SFSyncOptions.newSyncOptions(forSyncDown:
            SFSyncStateMergeMode.overwrite)
        
        sfaSyncMgr.Promises.syncDown(target: syncDownTarget, options: syncOptions, soupName: SoupAccount)
            .done { syncStateStatus in
                if syncStateStatus.isDone() {
                    print("syncDownAccount() done")
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
        let userid:String = (userVieModel.loggedInUser?.userId)!
        let siteid:String = (userVieModel.loggedInUser?.userSite)!
        
        let fields : [String] = Contact.ContactFields
        
        let soqlQuery = "Select \(fields.joined(separator: ",")) from Contact where SGWS_Account_Site_Number__c = '\(siteid)' and RecordType.DeveloperName = 'Customer' " //and AccountId IN(Select AccountId from AccountTeamMember where UserId = '\(userid)' "
        
        //let soqlQuery = "Select Id from Contact where SGWS_Account_Site_Number__c = '\(siteid)' "
        
        let syncDownTarget = SFSoqlSyncDownTarget.newSyncTarget(soqlQuery)
        let syncOptions    = SFSyncOptions.newSyncOptions(forSyncDown:
            SFSyncStateMergeMode.overwrite)
        
        sfaSyncMgr.Promises.syncDown(target: syncDownTarget, options: syncOptions, soupName: SoupContact)
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
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        if appDelegate.isMockUser  {
//            completion(User.mockUser(), nil)
//            return
//        }
        var error : NSError?
        guard let user = SFUserAccountManager.sharedInstance().currentUser else {
            completion(nil, error)
            return
        }
                
        let username = user.userName
        
        let fields = User.UserFields.map{"{User:\($0)}"}
        
        let soqlQuery = "Select \(fields.joined(separator: ",")) from {User} Where {User:User.Username} = '\(username)'"
        
        let fetchQuerySpec = SFQuerySpec.newSmartQuerySpec(soqlQuery, withPageSize: 100000)
        
        let result = sfaStore.query(with: fetchQuerySpec!, pageIndex: 0, error: &error)
        
        if (error == nil && result.count > 0) {
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
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if appDelegate.isMockUser {
            let account1 = Account.mockAccount1()
            let account2 = Account.mockAccount2()
            let account3 = Account.mockAccount3()
            let account4 = Account.mockAccount4()
            //add more if needed
            
            var ary = [Account]()
            ary.append(account1)
            ary.append(account2)
            ary.append(account3)
            ary.append(account4)
            
            return ary
        }
        else {
            let userViewModel = UserViewModel()
            
            let userid: String = (userViewModel.loggedInUser?.userId)!
            
            return fetchAccounts(forUser: userid)
        }
    }
    
    
    func fetchAllAccountIds()->[String]{
        
        var accountIdsArray:[String] = []
        
        let soqlQuery = "Select {AccountTeamMember:AccountId} FROM {AccountTeamMember}"
        
        let fetchQuerySpec = SFQuerySpec.newSmartQuerySpec(soqlQuery, withPageSize: 100000)
        
        var error : NSError?
        let result = sfaStore.query(with: fetchQuerySpec!, pageIndex: 0, error: &error)
        
        
        if result.count > 0 {
            for i in 0...result.count - 1 {
                let ary:[Any] = result[i] as! [Any]
                accountIdsArray.append(ary[0] as! String)
                
            }
        }
        print(accountIdsArray)

        return accountIdsArray
    }
    
    func fetchAccounts(forUser userid: String) -> [Account] {
        var accountAry: [Account] = []
        
        // Get All Account Id's and Format as string with comma separator
        let accIdArray = fetchAllAccountIds().joined(separator: "','")
        
        // Formatted accIdArray String with adding "'" at start and end
        let formattedAccIdArray = "'" + accIdArray + "'"
        
       // let fields = Account.AccountFields.map{"{AccountTeamMember:\($0)}"}
        
        //let soqlQuery = "Select \(fields.joined(separator: ",")) from {AccountTeamMember} " //where {AccountTeamMember:Account.RecordType.DeveloperName} = 'Customer'"
        
        let soqlQuery = "Select DISTINCT {AccountTeamMember:Account.SGWS_Account_Health_Grade__c},{AccountTeamMember:Account.Name},{AccountTeamMember:Account.AccountNumber},{AccountTeamMember:Account.SWS_Total_CY_MTD_Net_Sales__c},{AccountTeamMember:Account.SWS_Total_AR_Balance__c},{AccountTeamMember:Account.IS_Next_Delivery_Date__c},{AccountTeamMember:Account.SWS_Premise_Code__c},{AccountTeamMember:Account.SWS_License_Type__c},{AccountTeamMember:Account.SWS_License__c},{AccountTeamMember:Account.Google_Place_Operating_Hours__c},{AccountTeamMember:Account.SWS_License_Expiration_Date__c},{AccountTeamMember:Account.SWS_Total_CY_R12_Net_Sales__c},{AccountTeamMember:Account.SWS_Credit_Limit__c},{AccountTeamMember:Account.SWS_TD_Channel__c},{AccountTeamMember:Account.SWS_TD_Sub_Channel__c},{AccountTeamMember:Account.SWS_License_Status_Description__c},{AccountTeamMember:Account.ShippingCity},{AccountTeamMember:Account.ShippingCountry},{AccountTeamMember:Account.ShippingPostalCode},{AccountTeamMember:Account.ShippingState},{AccountTeamMember:Account.ShippingStreet},{AccountTeamMember:Account.SWS_PCT_to_Last_Year_MTD_Net_Sales__c},{AccountTeamMember:Account.SWS_AR_Past_Due_Amount__c},{AccountTeamMember:Account.SWS_Delivery_Frequency__c},{AccountTeamMember:Account.SGWS_Single_Multi_Locations_Filter__c},{AccountTeamMember:Account.Google_Place_Formatted_Phone__c},{AccountTeamMember:Account.SWS_Status_Description__c},{AccountTeamMember:AccountId},{AccountTeamMember:Account.SWS_PCT_to_Last_Year_R12_Net_Sales__c} from {AccountTeamMember} WHERE {AccountTeamMember:AccountId} IN (\(formattedAccIdArray))"
        
        
        let querySpec = SFQuerySpec.newSmartQuerySpec(soqlQuery, withPageSize: 100000)
        
        var error : NSError?
        // json array of dict
        let result = sfaStore.query(with: querySpec!, pageIndex: 0, error: &error)
        print("The json of account is \(result)")
        if (error == nil && result.count > 0) {
            for i in 0...result.count - 1 {
                let ary:[Any] = result[i] as! [Any]
                let account = Account(withAry: ary)
                accountAry.append(account)
            }
        }
        else if error != nil {
            print("fectchAccounts for userid " + userid + " error:" + (error?.localizedDescription)!)
        }
        
        return accountAry
    }
    
    
    //Contacts
    func fetchContactsWithBuyingPower(forAccount accountId: String) -> [Contact] {
        
        print("fetchContactsWithBuyingPower \(accountId)")
        var contactAry: [Contact] = []
        
        let fields = Contact.ContactFields.map{"{Contact:\($0)}"}
        let soqlQuery = "Select \(fields.joined(separator: ",")) from {Contact} Where {Contact:SGWS_Buyer_Flag__c} = 1 AND {Contact:AccountId} = '\(accountId)' "
        
        let querySpec = SFQuerySpec.newSmartQuerySpec(soqlQuery, withPageSize: 100000)
        
        var error : NSError?
        let result = sfaStore.query(with: querySpec!, pageIndex: 0, error: &error)
        
        if (error == nil && result.count > 0) {
            for i in 0...result.count - 1 {
                let ary:[Any] = result[i] as! [Any]
                let contact = Contact(withAry: ary)
                contactAry.append(contact)
            }
        }
        else if error != nil {
            print("fectchGlobalContacts " + " error:" + (error?.localizedDescription)!)
        }
        return contactAry
    }
    
    func fetchContactsForSG(forAccount accountId:String) -> [Contact] {
        
       var contactAry: [Contact] = []
        
        let fields = User.UserFields.map{"{User:\($0)}"}
        
        let soqlQuery = "Select \(fields.joined(separator: ",")) from {User} Where {User:AccountId} = '\(accountId)' "
        
        let querySpec = SFQuerySpec.newSmartQuerySpec(soqlQuery, withPageSize: 100000)
        
        var error : NSError?
        let result = sfaStore.query(with: querySpec!, pageIndex: 0, error: &error)
        
        if (error == nil && result.count > 0) {
            for i in 0...result.count - 1 {
                let ary:[Any] = result[i] as! [Any]
                let user = User(withAry: ary)
                
                let json:[String:Any] = [ "Id":user.id, "Name":user.userName, "FirstName":user.username, "LastName":user.username, "Phone":user.userPhone, "Email":user.userEmail, "Birthdate":"", "AccountId":user.accountId, "Account.SWS_Account_Site__c":user.userSite, "SGWS_Account_Site_Number__c":user.userSite,"SGWS_Buyer_Flag__c":"","SGWS_Roles__c":user.userTeamMemberRole]
                
                let contact =  Contact.init(json: json)
                
                contactAry.append(contact)
            }
        }
        else if error != nil {
            print("fectchGlobalContacts " + " error:" + (error?.localizedDescription)!)
            
        }
        print("SG Contacts are \(contactAry)")
        return contactAry
        
    }
    
    func fetchGlobalContacts() -> [Contact]  {
        let userid:String = (userVieModel.loggedInUser?.userId)!
        let siteid:String = (userVieModel.loggedInUser?.userSite)!
        
        var contactAry: [Contact] = []
        
        let fields = Contact.ContactFields.map{"{Contact:\($0)}"}
        
        let soqlQuery = "Select \(fields.joined(separator: ",")) from {Contact} " //where {Contact:SGWS_Account_Site_Number__c} = '\(siteid)' and {Contact:RecordType.DeveloperName} = 'Customer' and {Contact:AccountId} IN(Select {Contact:AccountId} from {Contact:AccountTeamMember where UserId = '\(userid)' "
        
        let querySpec = SFQuerySpec.newSmartQuerySpec(soqlQuery, withPageSize: 100000)
        
        var error : NSError?
        let result = sfaStore.query(with: querySpec!, pageIndex: 0, error: &error)
       
        
        if (error == nil && result.count > 0) {
            for i in 0...result.count - 1 {
                let ary:[Any] = result[i] as! [Any]
                let contact = Contact(withAry: ary)
                contactAry.append(contact)
            }
        }
        else if error != nil {
            print("fectchGlobalContacts " + " error:" + (error?.localizedDescription)!)
        }
         print("contact array is \(contactAry)")
        return contactAry
       
    }
    
    func fetchNotifications(forUser uid: String) -> [Notification]  {
        //to do
        var ary: [Notification] = []
        
        return ary
    }
    
    func deleteSmartStore(){
        
        do {
            try FileManager.default.removeItem(atPath: sfaStore.storePath!)
        }
        catch{
            
            print("Not able to delete smart store")
        }
        
        
        
    }
    
    func fetchContacts(forAccount accountId: String) -> [Contact] {
        
        print("fetchContactsWithAccountID \(accountId)")
        var contactAry: [Contact] = []
        
        let fields = Contact.ContactFields.map{"{Contact:\($0)}"}
        let soqlQuery = "Select \(fields.joined(separator: ",")) from {Contact} Where {Contact:AccountId} = '\(accountId)' "
        
        let querySpec = SFQuerySpec.newSmartQuerySpec(soqlQuery, withPageSize: 100000)
        
        var error : NSError?
        let result = sfaStore.query(with: querySpec!, pageIndex: 0, error: &error)
        
        if (error == nil && result.count > 0) {
            for i in 0...result.count - 1 {
                let ary:[Any] = result[i] as! [Any]
                let contact = Contact(withAry: ary)
                contactAry.append(contact)
            }
        }
        else if error != nil {
            print("fectchGlobalContacts " + " error:" + (error?.localizedDescription)!)
        }
        return contactAry
    }
    
    
    func fetchAllContactIds()->[String]{
        
        var contactIdsArray:[String] = []
        
        let soqlQuery = "Select {Contact:Id} FROM {Contact}"
        
        let fetchQuerySpec = SFQuerySpec.newSmartQuerySpec(soqlQuery, withPageSize: 100000)
        
        var error : NSError?
        let result = sfaStore.query(with: fetchQuerySpec!, pageIndex: 0, error: &error)
        
        
        if result.count > 0 {
            for i in 0...result.count - 1 {
                let ary:[Any] = result[i] as! [Any]
                contactIdsArray.append(ary[0] as! String)
            }
        }
        print(contactIdsArray)
        
        return contactIdsArray
    }
    
    func fetchContactsAccounts() -> [AccountContactRelation] {
        
        print("fetchContactsAccounts")
        var acrAry: [AccountContactRelation] = []
        
        // print("\(formattedContactIdsArray) formattedContactIdsArray")
        
        let fields = AccountContactRelation.AccountContactRelationFields.map{"{AccountContactRelation:\($0)}"}
        let soapQuery = "Select \(fields.joined(separator: ",")) FROM {AccountContactRelation}"
        
        //let soqlQuery = "Select {AccountContactRelation:Account.Name}, {AccountContactRelation:AccountId}, {AccountContactRelation:ContactId},{AccountContactRelation:Contact.name} FROM {AccountContactRelation} WHERE {AccountContactRelation:AccountId} = '\(accountId)' "
        
        let querySpec = SFQuerySpec.newSmartQuerySpec(soapQuery, withPageSize: 100000)
        
        var error : NSError?
        let result = sfaStore.query(with: querySpec!, pageIndex: 0, error: &error)
        
        if (error == nil && result.count > 0) {
            for i in 0...result.count - 1 {
                let ary:[Any] = result[i] as! [Any]
                let acr = AccountContactRelation(withAry: ary)
                acrAry.append(acr)
            }
        }
        else if error != nil {
            print("fetchContactsAccounts " + " error:" + (error?.localizedDescription)!)
        }
        return acrAry
    }
    
    func registerACRSoup(){
        
        let acrQueryFields = AccountContactRelation.AccountContactRelationFields
        
        var indexSpec:[SFSoupIndex] = []
        for i in 0...acrQueryFields.count - 1 {
            let sfIndex = SFSoupIndex(path: acrQueryFields[i], indexType: kSoupIndexTypeString, columnName: acrQueryFields[i])!
            indexSpec.append(sfIndex)
        }
        
        do {
            try sfaStore.registerSoup(SoupAccountContactRelation, withIndexSpecs: indexSpec, error: ())
            
        } catch let error as NSError {
            SalesforceSwiftLogger.log(type(of:self), level:.error, message: "failed to register SoupAccountContactRelation soup: \(error.localizedDescription)")
        }
        
    }
    
    func syncDownACR(_ completion:@escaping (_ error: NSError?)->()) {
        
        let accIdsString = fetchAllAccountIds().joined(separator: "','")
        
        print("account  ids \(accIdsString)")
        
        let accIdsFormattedString = "'" + accIdsString + "'"
        
        let soqlQuery = "Select Id,Account.Name, Roles, AccountId, ContactId, Contact.name, SGWS_Account_Site_Number__c From AccountContactRelation WHERE AccountId IN (\(accIdsFormattedString))"
        
        print(soqlQuery)
        
        let syncDownTarget = SFSoqlSyncDownTarget.newSyncTarget(soqlQuery)
        let syncOptions    = SFSyncOptions.newSyncOptions(forSyncDown:
            SFSyncStateMergeMode.overwrite)
        
        sfaSyncMgr.Promises.syncDown(target: syncDownTarget, options: syncOptions, soupName: SoupAccountContactRelation)
            .done { syncStateStatus in
                if syncStateStatus.isDone() {
                    print("syncDownACR() done")
                    completion(nil)
                }
                else if syncStateStatus.hasFailed() {
                    let meg = "ErrorDownloading: syncDownACR()"
                    let userInfo: [String: Any] =
                        [
                            NSLocalizedDescriptionKey : meg,
                            NSLocalizedFailureReasonErrorKey : meg
                    ]
                    let err = NSError(domain: "syncDownACR()", code: 601, userInfo: userInfo)
                    completion(err as NSError?)
                }
            }
            .catch { error in
                completion(error as NSError?)
        }
    }
}

