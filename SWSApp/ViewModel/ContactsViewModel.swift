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
    
    
}
