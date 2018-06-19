//
//  AccountsViewModel.swift
//  SWSApp
//
//  Created by maria.min-hui.yu on 4/2/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation

class AccountsViewModel {
    
    func accountsForLoggedUser() -> [Account] {
        return StoreDispatcher.shared.fetchAccountsForLoggedUser()
    }
    
    func accountsForSelectedUser() -> [Account] {
        return StoreDispatcher.shared.fetchAccounts()
    }
    
    func accountNameFor(accountId: String) -> String {
        return StoreDispatcher.shared.fetchAccountName(for: accountId)
    }
    
    func syncAccountWithServer(_ completion:@escaping (_ error: NSError?)->()) {
        
        //        StoreDispatcher.shared.reSyncUser { error in
        //            if error != nil {
        //
        //            }
        //
        //            //1.Sync down User Data
        //            StoreDispatcher.shared.syncDownUserDataForAccounts{ error in
        //                if error != nil {
        //
        //                }
        //            }
        
        // 2. Sync down Accounts
        StoreDispatcher.shared.syncDownAccount{ error in
            if error == nil {
                
                StoreDispatcher.shared.syncDownUserDataForAccounts{ error in
                    if error != nil {
                        completion(error)
                        
                    } else {
                        
                        completion(nil)
                        
                    }
                }
                
            }
            else {
                completion(error)
            }
        }
    }
}
