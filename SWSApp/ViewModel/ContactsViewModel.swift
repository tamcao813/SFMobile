//
//  ContactsViewModel.swift
//  SWSApp
//
//  Created by maria.min-hui.yu on 4/2/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation

class ContactsViewModel{
    var userVieModel: UserViewModel {
        return UserViewModel()
    }
    
    func contactsWithBuyingPower(forAccount accountId:String) -> [Contact] {
        return StoreDispatcher.shared.fetchContactsWithBuyingPower(forAccount: accountId)
    }
    
    func contactsForSG(forAccount accountId:String) -> [Contact] {
        return StoreDispatcher.shared.fetchContactsForSG(forAccount: accountId)
    }
    
    func globalContacts() -> [Contact] {
        return StoreDispatcher.shared.fetchGlobalContacts()
    }
    
    func sgwsEmployeeContacts() -> [Contact] {
        return StoreDispatcher.shared.fetchAllSGWSEmployeeContacts()
    }
    
    func contacts(forAccount accountId:String) -> [Contact] {
        return StoreDispatcher.shared.fetchContacts(forAccount: accountId)
    }
    
    func accountsForContacts() -> [AccountContactRelation] {
        return StoreDispatcher.shared.fetchContactsAccounts()
    }
    
    func accountsForSetOfAccounts(For accountIds: [String]) -> [AccountContactRelation] {
        return StoreDispatcher.shared.fetchLinkedActiveSetOfAccounts(For: accountIds)
    }
    
    func accountsForSetOfContacts(For contactIds: [String]) -> [AccountContactRelation] {
        return StoreDispatcher.shared.fetchLinkedActiveSetOfContacts(For: contactIds)
    }
    
    func activeAccountsForContacts() -> [AccountContactRelation] {
        return StoreDispatcher.shared.fetchContactsActiveAccounts()
    }
    
    func linkedAccountsForContact(with contactId:String) -> [AccountContactRelation] {
        return StoreDispatcher.shared.fetchLinkedActiveAccounts(For: contactId)
    }
    
    func contactIdForACR(with tempId: String) -> String {
        return StoreDispatcher.shared.fetchContactId(for: tempId)
    }
    
    //sync up Contact then sync down
    func syncContactWithServer(_ completion:@escaping (_ error: NSError?)->()) {
        let fields: [String] = Contact.ContactFields
        
        var isError:Bool = false

        StoreDispatcher.shared.syncUpContact(fieldsToUpload: fields, completion: {error in
            if error != nil {
                print(error?.localizedDescription ?? "error")
                print("syncContactWithServer: Contacts Sync up failed")
                isError = true
                //completion(error)
            }//else {
                StoreDispatcher.shared.reSyncContact( { error in
                    if isError || error != nil {
                        print(error?.localizedDescription ?? "error")
                        print("syncContactWithServer: Contacts reSync failed")
                        completion(error)
                    }else {
                        completion(nil)
                    }
                })
           // }
        })
    }
    
    //sync up ACR then sync down
    func syncACRwithServer(_ completion:@escaping (_ error: NSError?)->()) {
        let fields: [String] = AccountContactRelation.AccountContactRelationFields
        
        var isError:Bool = false
        
        StoreDispatcher.shared.syncUpACR(fieldsToUpload: fields, completion: {error in
            if error != nil {
                print(error?.localizedDescription ?? "error")
                print("syncACRwithServer: ACR Sync up failed")
                isError =  true
                //completion(error)
            }//else {
                StoreDispatcher.shared.reSyncACR( { error in
                    if isError || error != nil {
                        print(error?.localizedDescription ?? "error")
                        print("syncACRwithServer: ACR resync failed")
                        completion(error)
                    }else {
                        completion(nil)
                    }
                })
            //}
        })
    }
    
    //for testing syncup Contact
    func uploadContactToServer(object: Contact, completion: @escaping (_ error: NSError?)->() ) {
        let fields: [String:Any] = object.toJson()
        let keys = fields.map{ $0.key }
        StoreDispatcher.shared.syncUpContact(fieldsToUpload: keys, completion: {error in
            if error != nil {
                print(error?.localizedDescription ?? "error")
                completion(error)
            }else {
                completion(nil)
            }
        })
    }
    
    func uploadContactToServerAndSyncDownACR( completion: @escaping (_ error: NSError?)->() ) {
        let fields: [String] = Contact.ContactFields
        StoreDispatcher.shared.syncUpContact(fieldsToUpload: fields, completion: {error in
            if error != nil {
                print(error?.localizedDescription ?? "error")
                print("Contacts Sync up failed")
                completion(error)
            }else {
                StoreDispatcher.shared.syncDownACR( { error in
                    completion(error)
                })
            }
        })
    }
    
    func createNewContactToSoup(object: Contact) -> Bool {
        var contactfields: [String:Any] = object.toJson()
        contactfields.removeValue(forKey: "_soupEntryId")
        return StoreDispatcher.shared.createNewContactToSoup(fields: contactfields)
    }
    
    func createNewACRToSoup(object: AccountContactRelation) -> Bool{
        let acrFields: [String:Any] = object.toJson()
        return StoreDispatcher.shared.createNewACRToSoup(fields: acrFields)
    }
    
    func updateACRToSoup(objects: [AccountContactRelation]) -> Bool {
        var success = false
        for obj in objects {
            let acrFields: [String:Any] = obj.toJson()
            success = StoreDispatcher.shared.updateACRToSoup(fields: acrFields)
            
            if !success {
                print("updateACRToSoup failed for " + obj.contactName + " " + obj.contactId)
                break
            }
        }
        return success
    }
    
    func editNewContactToSoup(object: Contact) -> Bool {
        let fields: [String:Any] = object.toJson()
        return StoreDispatcher.shared.editContactToSoup(fields: fields)
    }
}
