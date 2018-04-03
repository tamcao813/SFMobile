//
//  ContactsViewModel.swift
//  SWSApp
//
//  Created by maria.min-hui.yu on 4/2/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation

class ContactsViewModel{
    
    func contactsWithBuyingPower(forUser uid:String) -> [Contact] {
        return StoreDispatcher.shared.fetchContactsWithBuyingPower(forUser: uid)
    }
    
    func contactsForSG(forUser uid:String) -> [Contact] {
        return StoreDispatcher.shared.fetchContactsForSG(forUser: uid)
    }
    
}
