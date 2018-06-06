//
//  AccountsViewModel.swift
//  SWSApp
//
//  Created by maria.min-hui.yu on 4/2/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation

class AccountsViewModel {
    
    //let accountsForLoggedUser: [Account] = StoreDispatcher.shared.fetchAccountsForLoggedUser()
    
    func accountsForLoggedUser() -> [Account] {
        return StoreDispatcher.shared.fetchAccountsForLoggedUser()
    }
    
    func accountsForSelectedUser() -> [Account] {
        return StoreDispatcher.shared.fetchAccounts()
    }
    
    func accountNameFor(accountId: String) -> String {
        return StoreDispatcher.shared.fetchAccountName(for: accountId)
    }
}
