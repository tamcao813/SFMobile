//
//  AccountsNotesViewModel.swift
//  SWSApp
//
//  Created by Jagadeeshwar Reddy on 27/04/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation

class AccountsNotesViewModel {
    
    //    let accountsForLoggedUser: [Account] = StoreDispatcher.shared.fetchAccountsForLoggedUser()
    
    func accountsNotesForUser() -> [AccountNotes] {
        return StoreDispatcher.shared.fetchAccountsNotes()
    }
    
    
}
