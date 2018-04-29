//
//  ContactsViewModel.swift
//  SWSApp
//
//  Created by maria.min-hui.yu on 4/2/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation

class ContactsViewModel{
    
    func contactsWithBuyingPower(forAccount accountId:String) -> [Contact] {
        return StoreDispatcher.shared.fetchContactsWithBuyingPower(forAccount: accountId)
    }
    
    func contactsForSG(forAccount accountId:String) -> [Contact] {
        return StoreDispatcher.shared.fetchContactsForSG(forAccount: accountId)
    }
    
    func globalContacts() -> [Contact] {
        return StoreDispatcher.shared.fetchGlobalContacts()
    }
    
    func contacts(forAccount accountId:String) -> [Contact] {
       return StoreDispatcher.shared.fetchContacts(forAccount: accountId)
    }
    
    func accountsForContacts() -> [AccountContactRelation] {
        return StoreDispatcher.shared.fetchContactsAccounts()
    }
    
    //for testing syncup Contact
    func uploadContactToServer(object: Contact, completion: @escaping (_ error: NSError?)->() ) {
        let fields: [String:Any] = object.toJson()
        let keys = fields.map{ $0.key }
        
        StoreDispatcher.shared.syncUpContact(fieldsToUpload: keys, completion: {error in
            
            if error != nil {
                print(error?.localizedDescription ?? "error")
                completion(error)
            }
            else {
                completion(nil)
            }
        })
    }
    
    func createNewContactToSoup(object: Contact) -> Bool {
        let fields: [String:Any] = object.toJson()
        return StoreDispatcher.shared.createNewContactToSoup(fields: fields)
    }
    
    func uploadContactACRToServer(object: Contact, completion: @escaping (_ error: NSError?)->() ) {
        let fields: [String:Any] = object.toJson()
        let keys = fields.map{ $0.key }
        
        StoreDispatcher.shared.syncUpContactACR(parentFields: keys, completion: {error in
            
            if error != nil {
                print(error?.localizedDescription ?? "error")
                completion(error)
            }
            else {
                completion(nil)
            }
        })
    }
}
