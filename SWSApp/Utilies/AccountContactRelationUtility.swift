//
//  AccountContactRelationUtility.swift
//  SWSApp
//
//  Created by Thillaiganesh, C. on 25/04/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class AccountContactRelationUtility {

    static func getAccountByFilterByContactId(contactId :String)-> ( [AccountContactRelation]){
        
        let accountsListWithContactId = ContactsViewModel().accountsForContacts().filter( { return $0.contactId == contactId } )

        return accountsListWithContactId
    }
    
}
