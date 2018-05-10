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
    let SoupAccountNotes = "SGWS_Account_Notes__c"
    let SoupVisit = "WorkOrder"
    let SoupStrategyQA = "SGWS_Response__c"
    let SoupStrategyQuestion = "SGWS_Question__c"
    let SoupStrategyAnswers = "SGWS_Answer__c"
    
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
        registerNotesSoup()
        registerVisitSoup()
        registerStrategyQASoup()
        registerStrategyQuestions()
        registerStrategyAnswers()
    }
    
    func downloadAllSoups(_ completion: @escaping ((_ error: NSError?) -> ()) ) {
        syncDownSoups(completion)
    }
    
    
    //sync down all soups other than User
    fileprivate func syncDownSoups(_ completion: @escaping ((_ error: NSError?) -> ()) ) {
        
        let queue = DispatchQueue(label: "concurrent")
        let group = DispatchGroup()
        
        group.enter()
        downloadContactPLists() { _ in
            group.leave()
        }
        
        group.enter()
        downloadVisitPLists() { _ in
            group.leave()
        }
        
        
        group.enter()
        syncDownAccount() { _ in
            
            self.syncDownACR() { _ in
            }
            
            // stage 2 Downlaod response after Sync down Account
            self.syncDownStrategyQA() { _ in
            }
            
            // Stage 2 StrategyQuestions downlaod need survey Id's which are downlaoded in Account
            self.syncDownStrategyQuestions() { _ in
                
                //Stage 3 do only when we have all questions
                self.syncDownStrategyAnswers() { _ in
                    group.leave()
                }
                
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
        
        group.enter()
        syncDownNotes() { _ in
            group.leave()
        }
        
        group.enter()
        syncDownVisits() { _ in
            group.leave()
        }
        
        //to do: syncDown other soups
        
        group.notify(queue: queue) {
            completion(nil)
        }
    }
    
    func downloadContactPLists(_ completion:@escaping (_ error: NSError?)->()) {
        let query = "SELECT id FROM RecordType where DeveloperName = 'customer' and isActive = true and SobjectType = 'Contact'"
        
        SFRestAPI.sharedInstance().performSOQLQuery(query, fail: {
            (error, response) in
            print(error?.localizedDescription as Any)
            completion(error! as NSError)
            
        }) { (data, response) in  //success
            if let data = data, data.count > 0 {
                let response:[Any]  = data[AnyHashable("records")] as! [Any]
                let dict:[String: Any] = response[0] as! [String: Any]
                let recordTypeId: String = dict["Id"] as! String
                print(recordTypeId)
                
                let queue = DispatchQueue(label: "concurrent")
                let group = DispatchGroup()
                
                group.enter()
                self.downloadContactRolesPList(recordTypeId: recordTypeId) { _ in
                    group.leave()
                }
                
                group.enter()
                self.downloadContactPreferredCommmunicationPList(recordTypeId: recordTypeId) { _ in
                    group.leave()
                }
                
                group.enter()
                self.downloadContactClassificationPList(recordTypeId: recordTypeId) { _ in
                    group.leave()
                }
                
                
                group.notify(queue: queue) {
                    completion(nil)
                }
            }
        }
    }
    
    // Create PList For Service Purposes
    
    func createPList(plist:String, plistObject:[[String : AnyObject]]) {
        
        let fileManager = FileManager.default
        
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let path = documentDirectory.appending(plist)
        if(!fileManager.fileExists(atPath: path)){
            
            var tempArr = [Dictionary<String, String>]()
            var targetDict = [String: String]()
            for object in plistObject {
                for (key, value) in object {
                    if let value = value as? String {
                        targetDict[key] = value
                    }
                }
                tempArr.append(targetDict)
            }
            
            let isWritten = (tempArr as NSArray).write(toFile: path, atomically: true)
            print("is the file created: \(isWritten)")
            
        } else {
            print("file exists")
        }
    }
    
    func downloadContactRolesPList(recordTypeId: String, completion:@escaping (_ error: NSError?)->()) {
        let recordTypeId = recordTypeId //"012i0000000PebvAAC" //"012i0000000Pf4AAAS" //(userVieModel.loggedInUser?.recordTypeId)!
        let path = "ui-api/object-info/Contact/picklist-values/" + recordTypeId + "/SGWS_Roles__c"
        let request = SFRestRequest(method: .GET, path: path, queryParams: nil)
        request.endpoint = "/services/data/v41.0/"
        
        SFRestAPI.sharedInstance().Promises.send(request: request)
            .done { sfRestResponse in
                let response = sfRestResponse.asJsonDictionary()
                
                var rolesPicklist = [String:[PlistOption]]()
                
                if response.count > 0 {
                    var rolesAry = [PlistOption]()
                    self.createPList(plist: "/ContactRoles.plist", plistObject: (response["values"] as? [[String : AnyObject]])! )
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
                
                PlistMap.sharedInstance.addToMap(field: "ContactRoles", map: rolesPicklist["Roles"]! )
                completion(nil)
            }
            .catch { error in
                print("roles plist error: " + error.localizedDescription)
                completion(error as NSError?)
        }
    }
    
    func downloadContactPreferredCommmunicationPList(recordTypeId: String, completion:@escaping (_ error: NSError?)->()) {
        let recordTypeId = recordTypeId
        let path = "ui-api/object-info/Contact/picklist-values/" + recordTypeId + "/SGWS_Preferred_Communication_Method__c"
        let request = SFRestRequest(method: .GET, path: path, queryParams: nil)
        request.endpoint = "/services/data/v41.0/"
        
        SFRestAPI.sharedInstance().Promises.send(request: request)
            .done { sfRestResponse in
                let response = sfRestResponse.asJsonDictionary()
                
                var communicationPicklist = [String:[PlistOption]]()
                
                if response.count > 0 {
                    var ary = [PlistOption]()
                    
                    self.createPList(plist: "/ContactPreferred.plist", plistObject: (response["values"] as? [[String : AnyObject]])! )
                    if let options = response["values"] as? [[String : AnyObject]] {
                        for option in options {
                            let label = option["label"] as? String ?? ""
                            let value = option["value"] as? String ?? ""
                            let preferred = PlistOption(label: label, value: value)
                            
                            ary.append(preferred)
                        }
                        
                        communicationPicklist["PreferredCommunication"] = ary
                    }
                }
                
                PlistMap.sharedInstance.addToMap(field: "ContactPreferredCommunication", map: communicationPicklist["PreferredCommunication"]!)
                completion(nil)
            }
            .catch { error in
                print("preferredCommunication plist error: " + error.localizedDescription)
                completion(error as NSError?)
        }
    }
    
    func downloadContactClassificationPList(recordTypeId: String, completion:@escaping (_ error: NSError?)->()) {
        let recordTypeId = recordTypeId
        let path = "ui-api/object-info/Contact/picklist-values/" + recordTypeId + "/SGWS_Contact_Classification__c"
        let request = SFRestRequest(method: .GET, path: path, queryParams: nil)
        request.endpoint = "/services/data/v41.0/"
        
        SFRestAPI.sharedInstance().Promises.send(request: request)
            .done { sfRestResponse in
                let response = sfRestResponse.asJsonDictionary()
                
                var classificationPicklist = [String:[PlistOption]]()
                
                if response.count > 0 {
                    var ary = [PlistOption]()
                    self.createPList(plist: "/ContactClassification.plist", plistObject: (response["values"] as? [[String : AnyObject]])! )
                    if let options = response["values"] as? [[String : AnyObject]] {
                        for option in options {
                            let label = option["label"] as? String ?? ""
                            let value = option["value"] as? String ?? ""
                            let preferred = PlistOption(label: label, value: value)
                            
                            ary.append(preferred)
                        }
                        classificationPicklist["Classification"] = ary
                    }
                }
                
                PlistMap.sharedInstance.addToMap(field: "ContactClassification", map: classificationPicklist["Classification"]!)
                completion(nil)
            }
            .catch { error in
                print("Classification plist error: " + error.localizedDescription)
                completion(error as NSError?)
        }
    }
    
    
    func downloadVisitPLists(_ completion:@escaping (_ error: NSError?)->()) {
        let query = "SELECT id FROM RecordType where SobjectType = 'WorkOrder'"
        
        SFRestAPI.sharedInstance().performSOQLQuery(query, fail: {
            (error, response) in
            print(error?.localizedDescription as Any)
            completion(error! as NSError)
            
        }) { (data, response) in  //success
            if let data = data, data.count > 0 {
                let response:[Any]  = data[AnyHashable("records")] as! [Any]
                let dict:[String: Any] = response[0] as! [String: Any]
                let recordTypeId: String = dict["Id"] as! String
                print(recordTypeId)
                
                let queue = DispatchQueue(label: "concurrent")
                let group = DispatchGroup()
        
                
                group.enter()
                self.downloadVisitPurposetPList(recordTypeId: recordTypeId) { _ in
                    group.leave()
                }
                
                group.notify(queue: queue) {
                    completion(nil)
                }
            }
        }
    }
    
    
    
    
    func downloadVisitPurposetPList(recordTypeId: String, completion:@escaping (_ error: NSError?)->()) {
        let recordTypeId = recordTypeId
        let path = "ui-api/object-info/WorkOrder/picklist-values/" + recordTypeId + "/SGWS_Visit_Purpose__c"
        let request = SFRestRequest(method: .GET, path: path, queryParams: nil)
        request.endpoint = "/services/data/v41.0/"
        
        SFRestAPI.sharedInstance().Promises.send(request: request)
            .done { sfRestResponse in
                let response = sfRestResponse.asJsonDictionary()
                
                var visitPicklist = [String:[PlistOption]]()
                if response.count > 0 {
                    var ary = [PlistOption]()
                    
                    if let options = response["values"] as? [[String : AnyObject]] {
                        for option in options {
                            let label = option["label"] as? String ?? ""
                            let value = option["value"] as? String ?? ""
                            let preferred = PlistOption(label: label, value: value)
                            
                            ary.append(preferred)
                        }
                        visitPicklist["VisitPurpose"] = ary
                    }
                }
                
                PlistMap.sharedInstance.addToMap(field: "AccountVisitPurpose", map: visitPicklist["VisitPurpose"]!)
                print("VisitPurpose PickList Downloaded \(visitPicklist["VisitPurpose"]!)")
                completion(nil)
            }
            .catch { error in
                print("Visit_Purpose plist error: " + error.localizedDescription)
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
            SFSoupIndex(path: "Account.SWS_PCT_to_Last_Year_R12_Net_Sales__c", indexType: kSoupIndexTypeString, columnName: "Account.SWS_PCT_to_Last_Year_R12_Net_Sales__c")!,
            SFSoupIndex(path: "Account.SGWS_SurveyId__c", indexType: kSoupIndexTypeString, columnName: "Account.SGWS_SurveyId__c")!
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
        for i in 0...contactQueryFields.count - 4 {
            let sfIndex = SFSoupIndex(path: contactQueryFields[i], indexType: kSoupIndexTypeString, columnName: contactQueryFields[i])!
            indexSpec.append(sfIndex)
        }
        
        var sfIndex1 = SFSoupIndex(path: contactQueryFields[contactQueryFields.count - 3], indexType: kSoupIndexTypeFullText, columnName: contactQueryFields[contactQueryFields.count - 3])!
        indexSpec.append(sfIndex1)
        sfIndex1 = SFSoupIndex(path: contactQueryFields[contactQueryFields.count - 2], indexType: kSoupIndexTypeFullText, columnName: contactQueryFields[contactQueryFields.count - 2])!
        indexSpec.append(sfIndex1)
        sfIndex1 = SFSoupIndex(path: contactQueryFields[contactQueryFields.count - 1], indexType: kSoupIndexTypeFullText, columnName: contactQueryFields[contactQueryFields.count - 1])!
        indexSpec.append(sfIndex1)
        
        sfIndex1 = SFSoupIndex(path: kSyncTargetLocal, indexType: kSoupIndexTypeString, columnName: "kSyncTargetLocal")!
        indexSpec.append(sfIndex1)
        
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
        
        let soqlQuery = "SELECT Id,Account.SGWS_Account_Health_Grade__c,Account.Name,Account.AccountNumber,Account.SWS_Total_CY_MTD_Net_Sales__c,Account.SWS_Total_AR_Balance__c, Account.IS_Next_Delivery_Date__c,Account.SWS_Premise_Code__c,Account.SWS_License_Type__c,Account.SWS_License__c,Account.Google_Place_Operating_Hours__c,Account.SWS_License_Expiration_Date__c,Account.SWS_Total_CY_R12_Net_Sales__c,Account.SWS_Credit_Limit__c,Account.SWS_TD_Channel__c,Account.SWS_TD_Sub_Channel__c,Account.SWS_License_Status_Description__c,Account.ShippingCity,Account.ShippingCountry,Account.ShippingPostalCode,Account.ShippingState,Account.ShippingStreet,Account.SWS_PCT_to_Last_Year_MTD_Net_Sales__c,Account.SWS_AR_Past_Due_Amount__c,Account.SWS_Delivery_Frequency__c,Account.SGWS_Single_Multi_Locations_Filter__c,Account.Google_Place_Formatted_Phone__c,Account.SWS_Status_Description__c,AccountId,Account.SWS_PCT_to_Last_Year_R12_Net_Sales__c,Account.SGWS_SurveyId__c FROM AccountTeamMember Where Account.RecordType.DeveloperName='Customer' limit 10000"
       
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
        
        let fields = "Select Id,Name,FirstName,LastName,Phone,Email,Birthdate,SGWS_Buying_Power__c,AccountId,Account.SWS_Account_Site__c,SGWS_Account_Site_Number__c,Title,Department,SGWS_Preferred_Name__c,SGWS_Contact_Hours__c,SGWS_Notes__c,LastModifiedBy.Name,LastModifiedDate,SGWS_Child_1_Name__c,SGWS_Child_1_Birthday__c,SGWS_Child_2_Name__c,SGWS_Child_2_Birthday__c,SGWS_Child_3_Name__c,SGWS_Child_3_Birthday__c,SGWS_Child_4_Name__c,SGWS_Child_4_Birthday__c,SGWS_Child_5_Name__c,SGWS_Child_5_Birthday__c,SGWS_Anniversary__c,SGWS_Likes__c,SGWS_Dislikes__c,SGWS_Favorite_Activities__c,SGWS_Life_Events__c,SGWS_Life_Events_Date__c,Fax,SGWS_Other_Specification__c,SGWS_Roles__c,SGWS_Preferred_Communication_Method__c,SGWS_Contact_Classification__c"
        
        let soqlQuery = "\(fields) from Contact where SGWS_Account_Site_Number__c = '\(siteid)' and RecordType.DeveloperName = 'Customer' " //and AccountId IN(Select AccountId from AccountTeamMember where UserId = '\(userid)' "
        
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
    
    func fetchAllAccountsSurveyIds()->[String]{
        
        var surveyIdsArray:[String] = []
        
        let soqlQuery = "Select {AccountTeamMember:Account.SGWS_SurveyId__c} FROM {AccountTeamMember}"
        
        let fetchQuerySpec = SFQuerySpec.newSmartQuerySpec(soqlQuery, withPageSize: 100000)
        
        var error : NSError?
        let result = sfaStore.query(with: fetchQuerySpec!, pageIndex: 0, error: &error)
        
        
        if result.count > 0 {
            for i in 0...result.count - 1 {
                let ary:[Any] = result[i] as! [Any]
                if(ary[0] is NSNull){
                } else {
                    surveyIdsArray.append(ary[0] as! String)
                }
                
            }
        }
        print(surveyIdsArray)
        
        return surveyIdsArray
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
    func fetchStrategy(forAccount accountId: String) -> [StrategyQA] {
        
        print("fetchStrategy \(accountId)")
        var strategyAry: [StrategyQA] = []
        
        //let fields = StrategyQA.StrategyQAFields.map{"{\(SoupStrategyQA):\($0)}"}
        let soqlQuery = "SELECT {SGWS_Response__c:Id},{SGWS_Response__c:SGWS_Answer_Description_List__c},{SGWS_Question__c:Id},{SGWS_Question__c:SGWS_Question_Type__c},{SGWS_Question__c:SGWS_Question_Sub_Type__c},{SGWS_Response__c:SGWS_Notes__c} from {SGWS_Response__c} INNER JOIN {SGWS_Question__c} where {SGWS_Question__c:Id} = {SGWS_Response__c:SGWS_Question__c} AND {SGWS_Response__c:SGWS_Account__c} = '\(accountId)' "
        
        let querySpec = SFQuerySpec.newSmartQuerySpec(soqlQuery, withPageSize: 100000)
        
        var error : NSError?
        let result = sfaStore.query(with: querySpec!, pageIndex: 0, error: &error)
        
        if (error == nil && result.count > 0) {
            for i in 0...result.count - 1 {
                let ary:[Any] = result[i] as! [Any]
                
//                  let accountId =
//                let answers =  result[2]
//
//                let ownerId =  result[3]
//
//                let header =  result[4]
//
//                let subHeader =  result[5]
//
               // ["Id","SGWS_Account__c","SGWS_Question_Sub_Type__c","SGWS_Question__c","SGWS_Notes__c","LastModifiedById","LastModifiedDate","OwnerId","SGWS_Answer_Description_List__c"]
                
                let json:[String:Any] = [ "SGWS_Account__c":ary[0], "SGWS_Question_Sub_Type__c":ary[4], "SGWS_Question__c":ary[3], "SGWS_Answer_Description_List__c":ary[1],"SGWS_Notes__c":ary[5]]

               let strategy = StrategyQA.init(json: json)
                strategyAry.append(strategy)
          
            }
        }
        else if error != nil {
            print("fetchStrategyQA " + " error:" + (error?.localizedDescription)!)
        }
        return strategyAry
        
    }
    
    //Contacts
    func fetchContactsWithBuyingPower(forAccount accountId: String) -> [Contact] {
        
        print("fetchContactsWithBuyingPower \(accountId)")
        var contactAry: [Contact] = []
        
        let fields = Contact.ContactFields.map{"{Contact:\($0)}"}
        let soqlQuery = "Select \(fields.joined(separator: ",")) from {Contact} Where {Contact:AccountId} = '\(accountId)' "

        let querySpec = SFQuerySpec.newSmartQuerySpec(soqlQuery, withPageSize: 100000)
        
        var error : NSError?
        let result = sfaStore.query(with: querySpec!, pageIndex: 0, error: &error)
        
        if (error == nil && result.count > 0) {
            for i in 0...result.count - 1 {
                let ary:[Any] = result[i] as! [Any]
                let resultDict = Dictionary(uniqueKeysWithValues: zip(Contact.ContactFields, ary))
                let contact = Contact(withAry: resultDict)
                if contact.buyerFlag {
                    contactAry.append(contact)
                }
                else if contact.contactClassification == "Influencer" {
                    contactAry.append(contact)
                }
            }
        }
        else if error != nil {
            print("fetchContactsWithBuyingPower " + " error:" + (error?.localizedDescription)!)
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
                
                let json:[String:Any] = [ "Id":user.id, "Name":user.userName, "FirstName":user.username, "LastName":user.username, "Phone":user.userPhone, "Email":user.userEmail, "Birthdate":"", "AccountId":user.accountId, "Account.SWS_Account_Site__c":user.userSite, "SGWS_Account_Site_Number__c":user.userSite,"SGWS_Buying_Power__c":"","SGWS_Roles__c":user.userTeamMemberRole]
                
                let contact =  Contact.init(json: json)
                
                contactAry.append(contact)
            }
        }
        else if error != nil {
            print("fetchContactsForSG" + " error:" + (error?.localizedDescription)!)
            
        }
        print("SG Contacts are \(contactAry)")
        return contactAry
        
    }
    
    func fetchGlobalContacts() -> [Contact]  {
        let userid:String = (userVieModel.loggedInUser?.userId)!
        let siteid:String = (userVieModel.loggedInUser?.userSite)!
        
        var contactAry: [Contact] = []
        
        let fields = Contact.ContactFields.map{"{Contact:\($0)}"}
        
        let querySpecAll =  SFQuerySpec.newAllQuerySpec(SoupContact, withOrderPath: "LastModifiedDate", with: SFSoupQuerySortOrder.ascending , withPageSize: 1000)
        
        var error : NSError?
        let result = sfaStore.query(with: querySpecAll, pageIndex: 0, error: &error)
        
        
//        let soqlQuery = "Select \(fields.joined(separator: ",")) from {Contact} " //where {Contact:SGWS_Account_Site_Number__c} = '\(siteid)' and {Contact:RecordType.DeveloperName} = 'Customer' and {Contact:AccountId} IN(Select {Contact:AccountId} from {Contact:AccountTeamMember where UserId = '\(userid)' "
//
//        let querySpec = SFQuerySpec.newSmartQuerySpec(soqlQuery, withPageSize: 100000)
        
 //       var error : NSError?
//        let result = sfaStore.query(with: querySpec!, pageIndex: 0, error: &error)
//
//
        if (result.count > 0) {
            for i in 0...result.count - 1 {
                var singleNoteModif = result[i] as! [String:Any]

               // let ary:[Any] = result[i] as! [Any]
                let contact = Contact(withAry: singleNoteModif)
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
                let resultDict = Dictionary(uniqueKeysWithValues: zip(Contact.ContactFields, ary))
                let contact = Contact(withAry: resultDict)
                contactAry.append(contact)
            }
        }
        else if error != nil {
            print("fetchContacts" + " error:" + (error?.localizedDescription)!)
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
        
        let sfIndex1 = SFSoupIndex(path: kSyncTargetLocal, indexType: kSoupIndexTypeString, columnName: "kSyncTargetLocal")!
        indexSpec.append(sfIndex1)
        
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
    
    func registerNotesSoup(){
        
        let notesQueryFields = AccountNotes.AccountNotesFields
        
        var indexSpec:[SFSoupIndex] = []
        for i in 0...notesQueryFields.count - 1 {
            let sfIndex = SFSoupIndex(path: notesQueryFields[i], indexType: kSoupIndexTypeString, columnName: notesQueryFields[i])!
            indexSpec.append(sfIndex)
        }
        
        indexSpec.append(SFSoupIndex(path: kSyncTargetLocal, indexType: kSoupIndexTypeString, columnName: "kSyncTargetLocal")!)

        do {
            try sfaStore.registerSoup(SoupAccountNotes, withIndexSpecs: indexSpec, error: ())
            
        } catch let error as NSError {
            SalesforceSwiftLogger.log(type(of:self), level:.error, message: "failed to register SoupAccountNotes soup: \(error.localizedDescription)")
        }
        
    }
    
    func registerVisitSoup(){
        
        let visitsQueryFields = Visit.VisitsFields
        
        var indexSpec:[SFSoupIndex] = []
        for i in 0...visitsQueryFields.count - 1 {
            let sfIndex = SFSoupIndex(path: visitsQueryFields[i], indexType: kSoupIndexTypeString, columnName: visitsQueryFields[i])!
            indexSpec.append(sfIndex)
        }
        indexSpec.append(SFSoupIndex(path:kSyncTargetLocal, indexType:kSoupIndexTypeString, columnName:nil)!)
        
        do {
            try sfaStore.registerSoup(SoupVisit, withIndexSpecs: indexSpec, error: ())
            
        } catch let error as NSError {
            SalesforceSwiftLogger.log(type(of:self), level:.error, message: "failed to register SoupAccountNotes soup: \(error.localizedDescription)")
        }
    }
    
    
    func syncDownVisits(_ completion:@escaping (_ error: NSError?)->()) {
        
        let soqlQuery = "select Id,Subject, AccountId,Account.Name,Account.AccountNumber,Account.BillingAddress,ContactId, Contact.Name,Contact.Phone,Contact.Email,Contact.SGWS_Roles__c,SGWS_Appointment_Status__c, StartDate,EndDate, SGWS_Visit_Purpose__c, Description, SGWS_Agenda_Notes__c,Status from WorkOrder"
        
        print("soql visit query is \(soqlQuery)")
        
        let syncDownTarget = SFSoqlSyncDownTarget.newSyncTarget(soqlQuery)
        let syncOptions    = SFSyncOptions.newSyncOptions(forSyncDown:
            SFSyncStateMergeMode.overwrite)
        
        sfaSyncMgr.Promises.syncDown(target: syncDownTarget, options: syncOptions, soupName: SoupVisit)
            .done { syncStateStatus in
                if syncStateStatus.isDone() {
                    print(">>>>>> visit syncDownVisit() done >>>>>")
                    completion(nil)
                }
                else if syncStateStatus.hasFailed() {
                    let meg = "ErrorDownloading: syncDownVisit() >>>>>>>"
                    let userInfo: [String: Any] =
                        [
                            NSLocalizedDescriptionKey : meg,
                            NSLocalizedFailureReasonErrorKey : meg
                    ]
                    let err = NSError(domain: "syncDownVisit()", code: 601, userInfo: userInfo)
                    completion(err as NSError?)
                }
            }
            .catch { error in
                completion(error as NSError?)
        }
    }
    
    
    func fetchVisits()->[Visit]{
        
        var visit: [Visit] = []
        
        let soapQuery = "Select * FROM {WorkOrder}"
        let querySpec = SFQuerySpec.newSmartQuerySpec(soapQuery, withPageSize: 100000)
        
        var error : NSError?
        let result = sfaStore.query(with: querySpec!, pageIndex: 0, error: &error)
        print("Result of visits is \(result)")
        if (error == nil && result.count > 0) {
            for i in 0...result.count - 1 {
                
                let modifResult = result[i] as! [Any]
                let item = modifResult[1]
                let subItem = item as! [String:Any]
                
                let flag = subItem["__locally_deleted__"] as! Bool
                // if deleted skip
                if(flag){
                    continue
                }
                
                var newarr = [Any]()
                
                newarr.append(modifResult[4])
                newarr.append(modifResult[5])
                newarr.append(modifResult[6])
                newarr.append(modifResult[7])
                newarr.append(modifResult[8])
                newarr.append(modifResult[9])
                newarr.append(modifResult[10])
                newarr.append(modifResult[11])
                newarr.append(modifResult[12])
                newarr.append(modifResult[13])
                newarr.append(modifResult[14])
                newarr.append(modifResult[15])
                newarr.append(modifResult[16])
                newarr.append(modifResult[17])
                newarr.append(modifResult[18])
                newarr.append(modifResult[19])
                newarr.append(modifResult[20])
                newarr.append(modifResult[21])
                newarr.append(modifResult[22])

                
                let ary:[Any] = result[i] as! [Any]
                let visitArray = Visit(withAry: newarr)
                visit.append(visitArray)
                print("Visit array \(ary)")
            }
        }
        else if error != nil {
            print("fetch visit  " + " error:" + (error?.localizedDescription)!)
        }
        return visit
        ////
//        var visit: [Visit] = []
//        let visitFields = Visit.VisitsFields.map{"{WorkOrder:\($0)}"}
//        let soapQuery = "Select \(visitFields.joined(separator: ",")) FROM {WorkOrder}"
//        let querySpec = SFQuerySpec.newSmartQuerySpec(soapQuery, withPageSize: 100000)
//        
//        var error : NSError?
//        let result = sfaStore.query(with: querySpec!, pageIndex: 0, error: &error)
//        print("Result of visits is \(result)")
//        if (error == nil && result.count > 0) {
//            for i in 0...result.count - 1 {
//                let ary:[Any] = result[i] as! [Any]
//                let visitArray = Visit(withAry: ary)
//                visit.append(visitArray)
//                print("notes array \(ary)")
//            }
//        }
//        else if error != nil {
//            print("fetch account notes  " + " error:" + (error?.localizedDescription)!)
//        }
//        return visit
    }

    func registerVisitSchedulerSoup(){
        
        let visitsQueryFields = PlanVisit.planVisitFields
        
        var indexSpec:[SFSoupIndex] = []
        for i in 0...visitsQueryFields.count - 1 {
            let sfIndex = SFSoupIndex(path: visitsQueryFields[i], indexType: kSoupIndexTypeString, columnName: visitsQueryFields[i])!
            indexSpec.append(sfIndex)
        }
        indexSpec.append(SFSoupIndex(path:kSyncTargetLocal, indexType:kSoupIndexTypeString, columnName:nil)!)
        
        do {
            try sfaStore.registerSoup(SoupVisit, withIndexSpecs: indexSpec, error: ())
            
        } catch let error as NSError {
            SalesforceSwiftLogger.log(type(of:self), level:.error, message: "failed to register SoupAccountNotes soup: \(error.localizedDescription)")
        }
        
    }
    
    
    func syncDownSchedulerVisits(_ completion:@escaping (_ error: NSError?)->()) {
        
        let soqlQuery = "select Id,Subject, AccountId,Account.Name,Account.AccountNumber,Account.BillingAddress,ContactId, Contact.Name,Contact.Phone,Contact.Email,Contact.SGWS_Roles__c,SGWS_Appointment_Status__c, StartDate,EndDate, SGWS_Visit_Purpose__c, Description, SGWS_Agenda_Notes__c,Status from WorkOrder"
        
        let syncDownTarget = SFSoqlSyncDownTarget.newSyncTarget(soqlQuery)
        let syncOptions    = SFSyncOptions.newSyncOptions(forSyncDown:
            SFSyncStateMergeMode.overwrite)
        
        sfaSyncMgr.Promises.syncDown(target: syncDownTarget, options: syncOptions, soupName: SoupVisit)
            .done { syncStateStatus in
                if syncStateStatus.isDone() {
                    print(">>>>>> visit syncDownVisit() done >>>>>")
                    completion(nil)
                }
                else if syncStateStatus.hasFailed() {
                    let meg = "ErrorDownloading: syncDownVisit() >>>>>>>"
                    let userInfo: [String: Any] =
                        [
                            NSLocalizedDescriptionKey : meg,
                            NSLocalizedFailureReasonErrorKey : meg
                    ]
                    let err = NSError(domain: "syncDownVisit()", code: 601, userInfo: userInfo)
                    completion(err as NSError?)
                }
            }
            .catch { error in
                completion(error as NSError?)
        }
    }
    
    
    func fetchSchedulerVisits()->[PlanVisit] {
        
        var visit: [PlanVisit] = []
        let visitFields = PlanVisit.planVisitFields.map{"{WorkOrder:\($0)}"}
        let soapQuery = "Select \(visitFields.joined(separator: ",")) FROM {WorkOrder}"
        let querySpec = SFQuerySpec.newSmartQuerySpec(soapQuery, withPageSize: 100000)
        
        var error : NSError?
        let result = sfaStore.query(with: querySpec!, pageIndex: 0, error: &error)
        print("Result of visits is \(result)")
        if (error == nil && result.count > 0) {
            for i in 0...result.count - 1 {
                let ary:[Any] = result[i] as! [Any]
                let visitArray = PlanVisit(withAry: ary)
                visit.append(visitArray)
                print("notes array \(ary)")
            }
        }
        else if error != nil {
            print("fetch account notes  " + " error:" + (error?.localizedDescription)!)
        }
        return visit
    }
    
    
    
    func syncDownNotes(_ completion:@escaping (_ error: NSError?)->()) {
        
        let soqlQuery = "SELECT Id,LastModifiedDate,Name,OwnerId,SGWS_Account__c,SGWS_Description__c FROM SGWS_Account_Notes__c"
        
        print("soql notes query is \(soqlQuery)")
        
        let syncDownTarget = SFSoqlSyncDownTarget.newSyncTarget(soqlQuery)
        let syncOptions    = SFSyncOptions.newSyncOptions(forSyncDown:
            SFSyncStateMergeMode.overwrite)
        
        sfaSyncMgr.Promises.syncDown(target: syncDownTarget, options: syncOptions, soupName: SoupAccountNotes)
            .done { syncStateStatus in
                if syncStateStatus.isDone() {
                    print(">>>>>> Notes syncDownNote() done >>>>>")
                    completion(nil)
                }
                else if syncStateStatus.hasFailed() {
                    let meg = "ErrorDownloading: syncDownNotes() >>>>>>>"
                    let userInfo: [String: Any] =
                        [
                            NSLocalizedDescriptionKey : meg,
                            NSLocalizedFailureReasonErrorKey : meg
                    ]
                    let err = NSError(domain: "syncDownNotes()", code: 601, userInfo: userInfo)
                    completion(err as NSError?)
                }
            }
            .catch { error in
                completion(error as NSError?)
        }
    }
    
    func fetchAccountsNotes()->[AccountNotes]{
        
        var acctNotes: [AccountNotes] = []
        let notesFields = AccountNotes.AccountNotesFields.map{"{SGWS_Account_Notes__c:\($0)}"}
        let soapQuery = "Select * FROM {SGWS_Account_Notes__c}"
        let querySpec = SFQuerySpec.newSmartQuerySpec(soapQuery, withPageSize: 100000)
        
        var error : NSError?
        let result = sfaStore.query(with: querySpec!, pageIndex: 0, error: &error)
        print("Result of account notes is \(result)")
        if (error == nil && result.count > 0) {
            for i in 0...result.count - 1 {
                
                let modifResult = result[i] as! [Any]
                let item = modifResult[1]
                let subItem = item as! [String:Any]
                
                let flag = subItem["__locally_deleted__"] as! Bool
                // if deleted skip
                if(flag){
                    continue
                }
                
                var newarr = [Any]()
                
                newarr.append(modifResult[4])
                newarr.append(modifResult[5])
                newarr.append(modifResult[6])
                newarr.append(modifResult[7])
                newarr.append(modifResult[8])
                newarr.append(modifResult[9])
                
                let ary:[Any] = result[i] as! [Any]
                let accountNotesArray = AccountNotes(withAry: newarr)
                acctNotes.append(accountNotesArray)
                print("notes array \(ary)")
            }
        }
        else if error != nil {
            print("fetch account notes  " + " error:" + (error?.localizedDescription)!)
        }
        return acctNotes
    }
    
    func editNotesLocally(fieldsToUpload: [String:Any]) -> Bool{
        
        let querySpecAll =  SFQuerySpec.newAllQuerySpec(SoupAccountNotes, withOrderPath: "LastModifiedDate", with: SFSoupQuerySortOrder.ascending , withPageSize: 1000)
        
        var error : NSError?
        let result = sfaStore.query(with: querySpecAll, pageIndex: 0, error: &error)
        
        var editedNote = [String: Any]()
        
        for  singleNote in result{
            var singleNoteModif = singleNote as! [String:Any]
            let singleNoteModifValue = singleNoteModif["Id"] as! String
            let fieldsIdValue = fieldsToUpload["Id"] as! String
            
            if(fieldsIdValue == singleNoteModifValue){
                singleNoteModif["Name"] = fieldsToUpload["Name"]
                singleNoteModif["SGWS_Description__c"] = fieldsToUpload["SGWS_Description__c"]
                singleNoteModif[kSyncTargetLocal] = true
                
                let createdFlag = singleNoteModif[kSyncTargetLocallyCreated] as! Bool
                
                if(createdFlag){
                    singleNoteModif[kSyncTargetLocallyUpdated] = false
                    singleNoteModif[kSyncTargetLocallyCreated] = true

                }else {
                    singleNoteModif[kSyncTargetLocallyCreated] = false
                    singleNoteModif[kSyncTargetLocallyUpdated] = true

                }
                singleNoteModif[kSyncTargetLocallyDeleted] = false
                
                singleNoteModif["LastModifiedDate"] = fieldsToUpload["LastModifiedDate"]
                editedNote = singleNoteModif
                break
            }
        }
        
        let ary = sfaStore.upsertEntries([editedNote], toSoup: SoupAccountNotes)
        if ary.count > 0 {
            var result = ary[0] as! [String:Any]
            let soupEntryId = result["_soupEntryId"]
            print("\(result) Notes is edited and saved successfully" )
            print(soupEntryId!)
            return true
        }
        else {
            print(" Error in saving edited Notes" )
            return false
        }
    }
    
    func deleteNotesLocally(fieldsToUpload: [String:Any]) -> Bool{
        
        let querySpecAll =  SFQuerySpec.newAllQuerySpec(SoupAccountNotes, withOrderPath: "LastModifiedDate", with: SFSoupQuerySortOrder.ascending , withPageSize: 1000)
        
        var error : NSError?
        let result = sfaStore.query(with: querySpecAll, pageIndex: 0, error: &error)
        
        var editedNote = [String: Any]()
        
        for  singleNote in result{
            var singleNoteModif = singleNote as! [String:Any]
            let singleNoteModifValue = singleNoteModif["Id"] as! String
            let fieldsIdValue = fieldsToUpload["Id"] as! String
            
            if(fieldsIdValue == singleNoteModifValue){

                singleNoteModif["__local__"] = true
                
                singleNoteModif["__locally_deleted__"] = true
                
                editedNote = singleNoteModif
                break
            }
        }
        
        let ary = sfaStore.upsertEntries([editedNote], toSoup: SoupAccountNotes)
        if ary.count > 0 {
            var result = ary[0] as! [String:Any]
            let soupEntryId = result["_soupEntryId"]
            print("\(result) Notes is deleted  successfully" )
            print(soupEntryId!)
            return true
        }
        else {
            print(" Error in deleting  Notes" )
            return false
        }
    }
    
    
    func createNewNotesLocally(fieldsToUpload: [String:Any]) -> Bool{
        
        let ary = sfaStore.upsertEntries([fieldsToUpload], toSoup: SoupAccountNotes)
        if ary.count > 0 {
            var result = ary[0] as! [String:Any]
            let soupEntryId = result["_soupEntryId"]
            print(result)
            print(soupEntryId!)
            return true
        }
        else {
            return false
        }
    }
    
    func fetchNoteFromStore(note: AccountNotes) -> AccountNotes {
        
        let noteEntry = sfaStore.lookupSoupEntryId(forSoupName: SoupAccountNotes, forFieldPath: "Id", fieldValue: note.Id, error: nil)
        let noteArr = sfaStore.retrieveEntries([noteEntry], fromSoup: SoupAccountNotes)
        
       return noteArr[0] as! AccountNotes

    }
    
    func syncUpNotes(fieldsToUpload: [String], completion:@escaping (_ error: NSError?)->()) {
        
        let syncOptions = SFSyncOptions.newSyncOptions(forSyncUp: fieldsToUpload, mergeMode: SFSyncStateMergeMode.leaveIfChanged)
        
        sfaSyncMgr.Promises.syncUp(options: syncOptions, soupName: SoupAccountNotes)
            .done { syncStateStatus in
                if syncStateStatus.isDone() {
                    print("syncUPNotes done")
                    let syncId = syncStateStatus.syncId
                    print(syncId)
                    //Refresh Notes List view
                     NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshNotesList"), object:nil)
                    completion(nil)
                }
                else if syncStateStatus.hasFailed() {
                    let meg = "ErrorDownloading: syncUpNotes()"
                    let userInfo: [String: Any] =
                        [
                            NSLocalizedDescriptionKey : meg,
                            NSLocalizedFailureReasonErrorKey : meg
                    ]
                    let err = NSError(domain: "syncUPNotes()", code: 601, userInfo: userInfo)
                    completion(err as NSError?)
                }
            }
            .catch { error in
                completion(error as NSError?)
        }
    }
    
    
   
    
    
    
    
    
    func createNewContactToSoup(fields: [String:Any]) -> Bool{
        var allFields = fields
        allFields["attributes"] = ["type":"Contact"]
        allFields[kSyncTargetLocal] = true
        allFields[kSyncTargetLocallyCreated] = true
        allFields[kSyncTargetLocallyUpdated] = false
        allFields[kSyncTargetLocallyDeleted] = false
        
        let ary = sfaStore.upsertEntries([allFields], toSoup: SoupContact)
        if ary.count > 0 {
            var result = ary[0] as! [String:Any]
            let soupEntryId = result["_soupEntryId"]
            print(result)
            print(soupEntryId!)
            return true
        }
        else {
            return false
        }
        
    }
    
    func createNewEntryInACR(fields: [String:Any]) -> Bool{
        var allFields = fields
        allFields["attributes"] = ["type":"AccountContactRelation"]
        allFields[kSyncTargetLocal] = true
        allFields[kSyncTargetLocallyCreated] = true
        allFields[kSyncTargetLocallyUpdated] = false
        allFields[kSyncTargetLocallyDeleted] = false
        
        let ary = sfaStore.upsertEntries([allFields], toSoup: SoupAccountContactRelation)
        if ary.count > 0 {
            var result = ary[0] as! [String:Any]
            let soupEntryId = result["_soupEntryId"]
            print(result)
            print(soupEntryId!)
            return true
        }
        else {
            return false
        }
    }
    
    
    func editContactToSoup(fields: [String:Any]) -> Bool{
        var allFields = fields
        allFields["attributes"] = ["type":"Contact"]
        allFields[kSyncTargetLocal] = true
        
        
        let querySpecAll =  SFQuerySpec.newAllQuerySpec(SoupContact, withOrderPath: "LastModifiedDate", with: SFSoupQuerySortOrder.ascending , withPageSize: 1000)
        
        var error : NSError?
        let result = sfaStore.query(with: querySpecAll, pageIndex: 0, error: &error)
        
        for  singleContact in result{
            var singleContactModif = singleContact as! [String:Any]
            let singleContactModifValue = singleContactModif["Id"] as! String
            let fieldsIdValue = allFields["Id"] as! String
            
            if(fieldsIdValue == singleContactModifValue){
                
                let createdFlag = singleContactModif[kSyncTargetLocallyCreated] as! Bool
                if(createdFlag){
                    allFields[kSyncTargetLocallyUpdated] = false
                    allFields[kSyncTargetLocallyCreated] = true
                    
                }else {
                    allFields[kSyncTargetLocallyCreated] = false
                    allFields[kSyncTargetLocallyUpdated] = true
                    
                }
                
            }
        }

        
        allFields[kSyncTargetLocallyDeleted] = false

        let ary = sfaStore.upsertEntries([allFields], toSoup: SoupContact)
        if ary.count > 0 {
            var result = ary[0] as! [String:Any]
            let soupEntryId = result["_soupEntryId"]
            print(result)
            print(soupEntryId!)
            return true
        }
        else {
            return false
        }
    }
    
    func syncUpContact(fieldsToUpload: [String], completion:@escaping (_ error: NSError?)->()) {
        let syncOptions = SFSyncOptions.newSyncOptions(forSyncUp: fieldsToUpload, mergeMode: SFSyncStateMergeMode.leaveIfChanged)
        
        sfaSyncMgr.Promises.syncUp(options: syncOptions, soupName: SoupContact)
            .done { syncStateStatus in
                if syncStateStatus.isDone() {
                    print("syncDownContact() done")
                    let syncId = syncStateStatus.syncId
                    print(syncId)
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
    
    func syncUpContactACR(parentFields: [String], completion:@escaping (_ error: NSError?)->()) {
        let parentInfo = SFParentInfo.new(withSObjectType: "Contact", soupName: SoupContact)
        
        let childrenInfo =  SFChildrenInfo.new(withSObjectType: "AccountContactRelation", sobjectTypePlural: "AccountContactRelations", soupName: SoupAccountContactRelation, parentIdFieldName:"ContactId")
        
        let parentFieldsNoId = parentFields.filter{ return $0 != "Id"} //remove "Id"
        let childrenFields: [String] = ["AccountId", "ContactId"]
        
        let syncUpTarget = SFParentChildrenSyncUpTarget.newSyncTarget(with: parentInfo, parentCreateFieldlist: parentFields, parentUpdateFieldlist: parentFieldsNoId, childrenInfo: childrenInfo, childrenCreateFieldlist: childrenFields, childrenUpdateFieldlist: childrenFields, relationshipType: SFParentChildrenRelationshipType.relationpshipMasterDetail)
        
        
        let syncOptions = SFSyncOptions.newSyncOptions(forSyncUp:parentFields, mergeMode: SFSyncStateMergeMode.leaveIfChanged)
        
        sfaSyncMgr.Promises.syncUp(target: syncUpTarget, options: syncOptions, soupName: SoupContact)
            .done { syncStateStatus in
                if syncStateStatus.isDone() {
                    print("syncUpContactACR() done")
                    completion(nil)
                }
                else if syncStateStatus.hasFailed() {
                    let meg = "Error Syncing up: syncUpContactACR()"
                    let userInfo: [String: Any] =
                        [
                            NSLocalizedDescriptionKey : meg,
                            NSLocalizedFailureReasonErrorKey : meg
                    ]
                    let err = NSError(domain: "syncUpContactACR()", code: 601, userInfo: userInfo)
                    completion(err as NSError?)
                }
            }
            .catch { error in
                completion(error as NSError?)
        }
    }
    
    // Register StrategyQA Soup
    func registerStrategyQASoup(){
        
        let strategyQAQueryFields = StrategyQA.StrategyQAFields
        
        var indexSpec:[SFSoupIndex] = []
        for i in 0...strategyQAQueryFields.count - 1 {
            let sfIndex = SFSoupIndex(path: strategyQAQueryFields[i], indexType: kSoupIndexTypeString, columnName: strategyQAQueryFields[i])!
            indexSpec.append(sfIndex)
        }
        indexSpec.append(SFSoupIndex(path:kSyncTargetLocal, indexType:kSoupIndexTypeString, columnName:nil)!)
        
        do {
            try sfaStore.registerSoup(SoupStrategyQA, withIndexSpecs: indexSpec, error: ())
            
        } catch let error as NSError {
            SalesforceSwiftLogger.log(type(of:self), level:.error, message: "failed to register SoupStrategyQA soup: \(error.localizedDescription)")
        }
        
    }
    
     //SyncDown StrategyQA Soup
    func syncDownStrategyQA(_ completion:@escaping (_ error: NSError?)->()) {
        
        
        let accIdsString = fetchAllAccountIds().joined(separator: "','")
        print("account  ids \(accIdsString)")
        let accIdsFormattedString = "'" + accIdsString + "'"
        
        //["Id","SGWS_Account__c","SGWS_Question_Sub_Type__c","SGWS_Question__c","SGWS_Notes__c","LastModifiedById","LastModifiedDate","OwnerId","SGWS_Answer_Description_List__c"]
        
       let soqlQuery = "SELECT Id, SGWS_Account__c,SGWS_Answer_Description_List__c,SGWS_Answer_Options__c,SGWS_Answer__c,SGWS_Notes__c,SGWS_Question_Description__c,SGWS_Question__c FROM SGWS_Response__c" 
        // account Ids
        
        //let soqlQuery = "SELECT Id,SGWS_Account__c,SGWS_Question__r.Id,SGWS_Answer_Options__r.Id,SGWS_Question__r.SGWS_Question_Type__c,SGWS_Question__r.SGWS_Question_Sub_Type__c,SGWS_Question_Description__c,SGWS_Answer__c,SGWS_Notes__c,LastModifiedById,LastModifiedDate,OwnerId,SGWS_Answer_Description_List__c FROM SGWS_Response__c ORDER BY SGWS_Question__r.SGWS_Sorting_Order__c"
        
        print("soql syncDownStrategyQA query is \(soqlQuery)")
        
        let syncDownTarget = SFSoqlSyncDownTarget.newSyncTarget(soqlQuery)
        let syncOptions    = SFSyncOptions.newSyncOptions(forSyncDown:
            SFSyncStateMergeMode.overwrite)
        
        sfaSyncMgr.Promises.syncDown(target: syncDownTarget, options: syncOptions, soupName: SoupStrategyQA)
            .done { syncStateStatus in
                if syncStateStatus.isDone() {
                    print(">>>>>>  syncDownStrategyQA() done >>>>>")
                    completion(nil)
                }
                else if syncStateStatus.hasFailed() {
                    let meg = "ErrorDownloading: syncDownStrategyQA() >>>>>>>"
                    let userInfo: [String: Any] =
                        [
                            NSLocalizedDescriptionKey : meg,
                            NSLocalizedFailureReasonErrorKey : meg
                    ]
                    let err = NSError(domain: "syncDownStrategyQA()", code: 601, userInfo: userInfo)
                    completion(err as NSError?)
                }
            }
            .catch { error in
                completion(error as NSError?)
        }
    }
    
    // Fetch StrategyQA...
    func fetchStrategyQA()->[StrategyQA]{
        
        ///
//        let soqlQuery = "SELECT Id,SGWS_Account__c,SGWS_Question__c,SGWS_Question__r.SGWS_Question_Type__c,SGWS_Question__r.SGWS_Question_Sub_Type__c,SGWS_Question_Description__c,SGWS_Answer_Description_List__c,SGWS_Notes__c,LastModifiedById,LastModifiedDate,OwnerId FROM SGWS_Response__c ORDER BY SGWS_Question__r.SGWS_Sorting_Order__c"
//
//        ["Id","SGWS_Account__c","SGWS_Question_Sub_Type__c","SGWS_Question__c","SGWS_Notes__c","LastModifiedById","LastModifiedDate","OwnerId","SGWS_Answer_Description_List__c"]
        //
        
        var strategyQA: [StrategyQA] = []
        let strategyFields = StrategyQA.StrategyQAFields.map{"{SGWS_Response__c:\($0)}"}
        let soapQuery = "Select \(strategyFields.joined(separator: ",")) FROM {SGWS_Response__c}"
        let querySpec = SFQuerySpec.newSmartQuerySpec(soapQuery, withPageSize: 100000)
        
        var error : NSError?
        let result = sfaStore.query(with: querySpec!, pageIndex: 0, error: &error)
        print("Result StrategyQA is \(result)")
        if (error == nil && result.count > 0) {
            for i in 0...result.count - 1 {
                let ary:[Any] = result[i] as! [Any]
                let strategyQAArray = StrategyQA(withAry: ary)
                strategyQA.append(strategyQAArray)
                print("strategyQA array \(ary)")
            }
        }
        else if error != nil {
            print("fetch strategy QA  " + " error:" + (error?.localizedDescription)!)
        }
        return strategyQA
    }
    
    // Register StrategyQuestion Soup
    func registerStrategyQuestions(){
        
        let strategyQuestionQueryFields = StrategyQuestions.StrategyQuestionsFields
        
        var indexSpec:[SFSoupIndex] = []
        for i in 0...strategyQuestionQueryFields.count - 1 {
            let sfIndex = SFSoupIndex(path: strategyQuestionQueryFields[i], indexType: kSoupIndexTypeString, columnName: strategyQuestionQueryFields[i])!
            indexSpec.append(sfIndex)
        }
        indexSpec.append(SFSoupIndex(path:kSyncTargetLocal, indexType:kSoupIndexTypeString, columnName:nil)!)
        
        do {
            try sfaStore.registerSoup(SoupStrategyQuestion, withIndexSpecs: indexSpec, error: ())
            
        } catch let error as NSError {
            SalesforceSwiftLogger.log(type(of:self), level:.error, message: "failed to register SoupStrategyQuestion soup: \(error.localizedDescription)")
        }
        
    }
    
    // SyncDown StrategyQuestions Soup
    
    func syncDownStrategyQuestions(_ completion:@escaping (_ error: NSError?)->()) {
        
        let surveyIdsString = fetchAllAccountsSurveyIds().joined(separator: "','")
        
        let surveyIdsFormattedString = "'" + surveyIdsString + "'"
        
        let soqlQuery = "SELECT Id,Name,SGWS_Deactivate__c,SGWS_Question_Sub_Type__c,SGWS_Question_Type__c,SGWS_Sorting_Order__c,SGWS_Survey_ID__c,SGWS_Question_Description__c FROM SGWS_Question__c where SGWS_Survey_ID__c IN (\(surveyIdsFormattedString))"
        
        print("soql syncDownStrategyQuestions query is \(soqlQuery)")
        
        let syncDownTarget = SFSoqlSyncDownTarget.newSyncTarget(soqlQuery)
        let syncOptions    = SFSyncOptions.newSyncOptions(forSyncDown:
            SFSyncStateMergeMode.overwrite)
        
        sfaSyncMgr.Promises.syncDown(target: syncDownTarget, options: syncOptions, soupName: SoupStrategyQuestion)
            .done { syncStateStatus in
                if syncStateStatus.isDone() {
                    print(">>>>>>  syncDownStrategyQuestions() done >>>>>")
                    completion(nil)
                }
                else if syncStateStatus.hasFailed() {
                    let meg = "ErrorDownloading: syncDownStrategyQuestions() >>>>>>>"
                    let userInfo: [String: Any] =
                        [
                            NSLocalizedDescriptionKey : meg,
                            NSLocalizedFailureReasonErrorKey : meg
                    ]
                    let err = NSError(domain: "syncDownStrategyQuestions()", code: 601, userInfo: userInfo)
                    completion(err as NSError?)
                }
            }
            .catch { error in
                completion(error as NSError?)
        }
    }
    
    // Fetch StrategyQuestions...
    func fetchStrategyQuestions(forAccount accountId:String)->[StrategyQuestions]{
        var strategyQuestions: [StrategyQuestions] = []
        
        // get questions for only applicable surveyID for this account
        let surveyIdArray = fetchAllSurveyIdsForAccoount(accountId: accountId)//.joined(separator: "','")
        
        if(surveyIdArray.count > 0){
        
        let uniqueSurvey = surveyIdArray[0] as! String
        
        
        let strategyQuestionsFields = StrategyQuestions.StrategyQuestionsFields.map{"{SGWS_Question__c:\($0)}"}
        
            let soapQuery = "Select \(strategyQuestionsFields.joined(separator: ",")) FROM {SGWS_Question__c} Where {SGWS_Question__c:SGWS_Survey_ID__c} = '\(uniqueSurvey)' order By {SGWS_Question__c:SGWS_Sorting_Order__c}"
        let querySpec = SFQuerySpec.newSmartQuerySpec(soapQuery, withPageSize: 100000)
        
        var error : NSError?
        let result = sfaStore.query(with: querySpec!, pageIndex: 0, error: &error)
       // print("Result StrategyQuestions is \(result)")
        if (error == nil && result.count > 0) {
            for i in 0...result.count - 1 {
                let ary:[Any] = result[i] as! [Any]
                let strategyQuestionsArray = StrategyQuestions(withAry: ary)
                strategyQuestions.append(strategyQuestionsArray)
                //print("strategyQuestions array \(ary)")
            }
        }
        else if error != nil {
            print("fetch strategy Questions  " + " error:" + (error?.localizedDescription)!)
        }
        }
        return strategyQuestions
    }
    
    func fetchAllQuestionsId()->[String]{
        
        var questionIdsArray:[String] = []
        
        let soqlQuery = "Select {SGWS_Question__c:Id} FROM {SGWS_Question__c}"
        
        let fetchQuerySpec = SFQuerySpec.newSmartQuerySpec(soqlQuery, withPageSize: 100000)
        
        var error : NSError?
        let result = sfaStore.query(with: fetchQuerySpec!, pageIndex: 0, error: &error)
        
        
        if result.count > 0 {
            for i in 0...result.count - 1 {
                let ary:[Any] = result[i] as! [Any]
                questionIdsArray.append(ary[0] as! String)
                
            }
        }
        print(questionIdsArray)
        
        return questionIdsArray
    }
    
    
    // Register StrategyAnswers Soup
    func registerStrategyAnswers(){
        
        let strategyAnswersQueryFields = StrategyAnswers.StrategyAnswersFields
        
        var indexSpec:[SFSoupIndex] = []
        for i in 0...strategyAnswersQueryFields.count - 1 {
            let sfIndex = SFSoupIndex(path: strategyAnswersQueryFields[i], indexType: kSoupIndexTypeString, columnName: strategyAnswersQueryFields[i])!
            indexSpec.append(sfIndex)
        }
        indexSpec.append(SFSoupIndex(path:kSyncTargetLocal, indexType:kSoupIndexTypeString, columnName:nil)!)
        
        do {
            try sfaStore.registerSoup(SoupStrategyAnswers, withIndexSpecs: indexSpec, error: ())
            
        } catch let error as NSError {
            SalesforceSwiftLogger.log(type(of:self), level:.error, message: "failed to register SoupStrategyAnswers soup: \(error.localizedDescription)")
        }
        
    }
    
    // SyncDown StrategyAnswers Soup
    func syncDownStrategyAnswers(_ completion:@escaping (_ error: NSError?)->()) {
        
        // Get All question Id's and Format as string with comma separator
        let questionIdArray = fetchAllQuestionsId().joined(separator: "','")
        
        // Formatted questionIdArray String with adding "'" at start and end
        let formattedquestionIdArray = "'" + questionIdArray + "'"
        
        
        let soqlQuery = "SELECT Id,Name,SGWS_Answer_Description__c,SGWS_Deactivate_Answer__c,SGWS_Question_Description__c,SGWS_Question__c FROM SGWS_Answer__c WHERE SGWS_Question__c IN (\(formattedquestionIdArray))"//"// for only downloaded question
        
        print("soql syncDownStrategyAnswers query is \(soqlQuery)")
        
        let syncDownTarget = SFSoqlSyncDownTarget.newSyncTarget(soqlQuery)
        let syncOptions    = SFSyncOptions.newSyncOptions(forSyncDown:
            SFSyncStateMergeMode.overwrite)
        
        sfaSyncMgr.Promises.syncDown(target: syncDownTarget, options: syncOptions, soupName: SoupStrategyAnswers)
            .done { syncStateStatus in
                if syncStateStatus.isDone() {
                    print(">>>>>>  syncDownStrategyAnswers() done >>>>>")
                    completion(nil)
                }
                else if syncStateStatus.hasFailed() {
                    let meg = "ErrorDownloading: syncDownStrategyAnswers() >>>>>>>"
                    let userInfo: [String: Any] =
                        [
                            NSLocalizedDescriptionKey : meg,
                            NSLocalizedFailureReasonErrorKey : meg
                    ]
                    let err = NSError(domain: "syncDownStrategyAnswers()", code: 601, userInfo: userInfo)
                    completion(err as NSError?)
                }
            }
            .catch { error in
                completion(error as NSError?)
        }
    }
    
    // Fetch StrategyAnswers...
    func fetchStrategyAnswers()->[StrategyAnswers]{
        var strategyAnswers: [StrategyAnswers] = []
        let strategyAnswersFields = StrategyAnswers.StrategyAnswersFields.map{"{SGWS_Answer__c:\($0)}"}
        let soapQuery = "Select \(strategyAnswersFields.joined(separator: ",")) FROM {SGWS_Answer__c}"
        let querySpec = SFQuerySpec.newSmartQuerySpec(soapQuery, withPageSize: 100000)
        
        var error : NSError?
        let result = sfaStore.query(with: querySpec!, pageIndex: 0, error: &error)
        //print("Result StrategyAnswers is \(result)")
        if (error == nil && result.count > 0) {
            for i in 0...result.count - 1 {
                let ary:[Any] = result[i] as! [Any]
                let strategyAnswersArray = StrategyAnswers(withAry: ary)
                strategyAnswers.append(strategyAnswersArray)
                //print("strategyAnswers array \(ary)")
            }
        }
        else if error != nil {
            print("fetch strategy Answers  " + " error:" + (error?.localizedDescription)!)
        }
        return strategyAnswers
    }
    
    
    func createNewVisitLocally(fieldsToUpload: [String:Any]) -> (Bool,Int){
        
        let ary = sfaStore.upsertEntries([fieldsToUpload], toSoup: SoupVisit)
        if ary.count > 0 {
            var result = ary[0] as! [String:Any]
            let soupEntryId = result["_soupEntryId"]
            print(result)
            print(soupEntryId!)
            return (true,soupEntryId as! Int)
        }
        else {
            return (false,0)
        }
    }
    
    func syncUpVisits(fieldsToUpload: [String], completion:@escaping (_ error: NSError?)->()) {
        
        let syncOptions = SFSyncOptions.newSyncOptions(forSyncUp: fieldsToUpload, mergeMode: SFSyncStateMergeMode.leaveIfChanged)
        
        sfaSyncMgr.Promises.syncUp(options: syncOptions, soupName: SoupVisit)
            .done { syncStateStatus in
                if syncStateStatus.isDone() {
                    print("syncUPVisits done")
                    let syncId = syncStateStatus.syncId
                    print(syncId)
                    //Refresh Notes List view
                  //  NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshNotesList"), object:nil)
                    completion(nil)
                }
                else if syncStateStatus.hasFailed() {
                    let meg = "ErrorDownloading: syncUpVisit()"
                    let userInfo: [String: Any] =
                        [
                            NSLocalizedDescriptionKey : meg,
                            NSLocalizedFailureReasonErrorKey : meg
                    ]
                    let err = NSError(domain: "syncUPVisit()", code: 601, userInfo: userInfo)
                    completion(err as NSError?)
                }
            }
            .catch { error in
                completion(error as NSError?)
        }
    }
    
    
    // create new Strategy QA Locally
    func createNewStrategyQALocally(fieldsToUpload: [String:Any]) -> Bool{
        
        let ary = sfaStore.upsertEntries([fieldsToUpload], toSoup: SoupStrategyQA)
        if ary.count > 0 {
            var result = ary[0] as! [String:Any]
            let soupEntryId = result["_soupEntryId"]
            print(result)
            print(soupEntryId!)
            return true
        }
        else {
            return false
        }
    }
    
    // edit  Strategy QA Locally
    func editStrategyQALocally(fieldsToUpload: [String:Any]) -> Bool{
        
        var allFields = fieldsToUpload
        allFields["attributes"] = ["type":"WorkOrder"]
        allFields[kSyncTargetLocal] = true
        var ary = [Any]()
        
        let querySpecAll =  SFQuerySpec.newAllQuerySpec(SoupStrategyQA, withOrderPath: "LastModifiedDate", with: SFSoupQuerySortOrder.ascending , withPageSize: 1000)
        
        var error : NSError?
        let result = sfaStore.query(with: querySpecAll, pageIndex: 0, error: &error)
        
        for  singleVisit in result{
            var singleVisitModif = singleVisit as! [String:Any]
            let singleVisitModifValue = singleVisitModif["Id"] as! String
            let fieldsIdValue = allFields["Id"] as! String
            
            if(fieldsIdValue == singleVisitModifValue){
                
                let createdFlag = singleVisitModif[kSyncTargetLocallyCreated] as! Bool
                
                singleVisitModif["SGWS_Account__c"] = allFields["SGWS_Account__c"]
                singleVisitModif["SGWS_Question__c"] = allFields["SGWS_Question__c"]
                singleVisitModif["SGWS_Answer_Description_List__c"] = allFields["SGWS_Answer_Description_List__c"]
                singleVisitModif["SGWS_Notes__c"] = allFields["SGWS_Notes__c"]
                singleVisitModif["LastModifiedDate"] = allFields["LastModifiedDate"]
                singleVisitModif["OwnerId"] = allFields["OwnerId"]


                if(createdFlag){
                    singleVisitModif[kSyncTargetLocal] = true
                    singleVisitModif[kSyncTargetLocallyUpdated] = false
                    singleVisitModif[kSyncTargetLocallyCreated] = true
                    
                }else {
                    singleVisitModif[kSyncTargetLocal] = true
                    singleVisitModif[kSyncTargetLocallyCreated] = false
                    singleVisitModif[kSyncTargetLocallyUpdated] = true
                    
                }
                singleVisitModif[kSyncTargetLocallyDeleted] = false
                ary = sfaStore.upsertEntries([singleVisitModif], toSoup: SoupStrategyQA)
                break
                
            }
        }
        
        if ary.count > 0 {
            var result = ary[0] as! [String:Any]
            let soupEntryId = result["_soupEntryId"]
            print(result)
            print(soupEntryId!)
            return true
        }
        else {
            return false
        }

    }
    
    
    func syncUpStrategyQA(fieldsToUpload: [String], completion:@escaping (_ error: NSError?)->()) {
        
        let syncOptions = SFSyncOptions.newSyncOptions(forSyncUp: fieldsToUpload, mergeMode: SFSyncStateMergeMode.leaveIfChanged)
        
        sfaSyncMgr.Promises.syncUp(options: syncOptions, soupName: SoupStrategyQA)
            .done { syncStateStatus in
                if syncStateStatus.isDone() {
                    print("syncUp Strategy QA done")
                    let syncId = syncStateStatus.syncId
                    print(syncId)
                    completion(nil)
                }
                else if syncStateStatus.hasFailed() {
                    let meg = "ErrorDownloading: syncUPStrategyQA()"
                    let userInfo: [String: Any] =
                        [
                            NSLocalizedDescriptionKey : meg,
                            NSLocalizedFailureReasonErrorKey : meg
                    ]
                    let err = NSError(domain: "syncUPStrategyQA()", code: 601, userInfo: userInfo)
                    completion(err as NSError?)
                }
            }
            .catch { error in
                completion(error as NSError?)
        }
    }
    
    func deleteVisitsLocally(fieldsToUpload: [String:Any]) -> Bool{
        
        let querySpecAll =  SFQuerySpec.newAllQuerySpec(SoupVisit, withOrderPath: "LastModifiedDate", with: SFSoupQuerySortOrder.ascending , withPageSize: 1000)
        
        var error : NSError?
        let result = sfaStore.query(with: querySpecAll, pageIndex: 0, error: &error)
        
        var editedVisit = [String: Any]()
        
        for  singleVisit in result{
            var singleVisitModif = singleVisit as! [String:Any]
            let singleVisitModifValue = singleVisitModif["Id"] as! String
            let fieldsIdValue = fieldsToUpload["Id"] as! String
            
            if(fieldsIdValue == singleVisitModifValue){
                
                singleVisitModif["__local__"] = true
                
                singleVisitModif["__locally_deleted__"] = true
                
                editedVisit = singleVisitModif
                break
            }
        }
        
        let ary = sfaStore.upsertEntries([editedVisit], toSoup: SoupVisit)
        if ary.count > 0 {
            var result = ary[0] as! [String:Any]
            let soupEntryId = result["_soupEntryId"]
            print("\(result) Visit is deleted  successfully" )
            print(soupEntryId!)
            return true
        }
        else {
            print(" Error in deleting  Visit" )
            return false
        }
    }
    
    
    func editVisit(fields: [String:Any]) -> Bool{
        var allFields = fields
        allFields["attributes"] = ["type":"WorkOrder"]
        allFields[kSyncTargetLocal] = true
        var ary = [Any]()
        
        let querySpecAll =  SFQuerySpec.newAllQuerySpec(SoupVisit, withOrderPath: "LastModifiedDate", with: SFSoupQuerySortOrder.ascending , withPageSize: 1000)
        
        var error : NSError?
        let result = sfaStore.query(with: querySpecAll, pageIndex: 0, error: &error)
        
        for  singleVisit in result{
            var singleVisitModif = singleVisit as! [String:Any]
            let singleVisitModifValue = singleVisitModif["Id"] as! String
            let fieldsIdValue = allFields["Id"] as! String
            
            if(fieldsIdValue == singleVisitModifValue){
                
                let createdFlag = singleVisitModif[kSyncTargetLocallyCreated] as! Bool
                
                singleVisitModif["Id"] = allFields["Id"]
                singleVisitModif["Subject"] = allFields["Subject"]
                singleVisitModif["AccountId"] = allFields["AccountId"]
                singleVisitModif["SGWS_Appointment_Status__c"] = allFields["SGWS_Appointment_Status__c"]
                singleVisitModif["StartDate"] = allFields["StartDate"]
                singleVisitModif["EndDate"] = allFields["EndDate"]
                singleVisitModif["SGWS_Visit_Purpose__c"] = allFields["SGWS_Visit_Purpose__c"]
                singleVisitModif["Description"] = allFields["Description"]
                singleVisitModif["SGWS_Agenda_Notes__c"] = allFields["SGWS_Agenda_Notes__c"]
                singleVisitModif["Status"] = allFields["Status"]
                singleVisitModif["ContactId"] = allFields["ContactId"]
                
                if(createdFlag){
                    singleVisitModif[kSyncTargetLocal] = true
                    singleVisitModif[kSyncTargetLocallyUpdated] = false
                    singleVisitModif[kSyncTargetLocallyCreated] = true
                    
                }else {
                    singleVisitModif[kSyncTargetLocal] = true
                    singleVisitModif[kSyncTargetLocallyCreated] = false
                    singleVisitModif[kSyncTargetLocallyUpdated] = true
                    
                }
                singleVisitModif[kSyncTargetLocallyDeleted] = false
                ary = sfaStore.upsertEntries([singleVisitModif], toSoup: SoupVisit)
                break
                
            }
        }
        
        if ary.count > 0 {
            var result = ary[0] as! [String:Any]
            let soupEntryId = result["_soupEntryId"]
            print(result)
            print(soupEntryId!)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshVisitSummaryScreen"), object:nil)
            return true
        }
        else {
            return false
        }
    }
    
    func fetchAllSurveyIdsForAccoount(accountId:String)->[String]{
        
        var surveyIdsArray:[String] = []
        
        let soqlQuery = "Select {AccountTeamMember:Account.SGWS_SurveyId__c} FROM {AccountTeamMember} Where {AccountTeamMember:AccountId} = '\(accountId)'"

       // let soqlQuery = "Select {SGWS_Question__c:Id} FROM {SGWS_Question__c}"
        
        let fetchQuerySpec = SFQuerySpec.newSmartQuerySpec(soqlQuery, withPageSize: 100000)
        
        var error : NSError?
        let result = sfaStore.query(with: fetchQuerySpec!, pageIndex: 0, error: &error)
        
        
        if result.count > 0 {
            for i in 0...result.count - 1 {
                let ary:[Any] = result[i] as! [Any]
                if(ary[0] is NSNull){
                } else {
                surveyIdsArray.append(ary[0] as! String)
                }
            }
        }
        print(surveyIdsArray)
        
        return surveyIdsArray
    }
    
    
}
