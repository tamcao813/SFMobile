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
    
    func contactsForSG(forUser uid:String) -> [Contact] {
        return StoreDispatcher.shared.fetchContactsForSG(forUser: uid)
    }
    
    func globalContacts() -> [Contact] {
        return StoreDispatcher.shared.fetchGlobalContacts()
    }
}
