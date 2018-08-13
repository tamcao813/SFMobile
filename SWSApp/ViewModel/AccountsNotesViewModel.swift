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
        let notesArray = StoreDispatcher.shared.fetchAccountsNotes()
        return SyncConfigurationSortUtility.getAccountNotesDataUsingSyncTime(objectArray: notesArray)        
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
            }
            else {

                completion(nil)
            }
        })
    }
    
    //sync up Notes then resync down
    func syncNotesWithServer(_ completion:@escaping (_ error: NSError?)->()) {
        let fields: [String] = AccountNotes.AccountNotesFields
        
        var isError:Bool = false
        
        StoreDispatcher.shared.syncUpNotes(fieldsToUpload: fields, completion: {error in
            if error != nil {
                print(error?.localizedDescription ?? "error")
                print("syncNotesWithServer: Note Sync up failed")
                isError =  true
            }

            StoreDispatcher.shared.reSyncNote { error in
                if isError || error != nil {
                    print(error?.localizedDescription ?? "error")
                    print("syncNotesWithServer: Note reSync failed")
                    completion(error)
                }
                else {
                    completion(nil)
                }
            }

        })
    }
    
}
