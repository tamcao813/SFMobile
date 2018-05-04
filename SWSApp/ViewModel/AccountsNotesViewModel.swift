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
    func createNewNotesLocally(fields: [String:Any]) -> Bool {
        return StoreDispatcher.shared.createNewNotesLocally(fieldsToUpload:fields)
    }
    func editNotesLocally(fields: [String:Any]) -> Bool {
        return StoreDispatcher.shared.editNotesLocally(fieldsToUpload:fields)
    }
    
    func deleteNotesLocally(fields: [String:Any]) -> Bool {
        return StoreDispatcher.shared.deleteNotesLocally(fieldsToUpload:fields)
    }
    
    func uploadNotesToServer(fields: [String], completion: @escaping (_ error: NSError?)->() ) {
        StoreDispatcher.shared.syncUpNotes(fieldsToUpload: fields, completion: {error in
            
            if error != nil {
                print(error?.localizedDescription ?? "error")
                completion(error)
                DispatchQueue.main.async {
                    MBProgressHUD.hide(forWindow: true)
                }
            }
            else {
                
                StoreDispatcher.shared.downloadAllSoups({ (error) in
                    if error != nil {
                        print("PostSyncUp:downloadAllSoups")
                    }
                    DispatchQueue.main.async {
                        MBProgressHUD.hide(forWindow: true)
                    }
                })
                DispatchQueue.main.async {
                    MBProgressHUD.hide(forWindow: true)
                }

                completion(nil)
            }
        })
    }
    
    
    
    
    
}
