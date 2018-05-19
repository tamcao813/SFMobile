//
//  AccountsNotesViewModel.swift
//  SWSApp
//
//  Created by Jagadeeshwar Reddy on 27/04/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation

class AccountsActionItemViewModel {
    
    //    let accountsForLoggedUser: [Account] = StoreDispatcher.shared.fetchAccountsForLoggedUser()
    
    func getAcctionItemForUser() -> [ActionItem] {
        return StoreDispatcher.shared.fetchAcctionItem()
    }
    func createNewActionItemLocally(fields:[String:Any]) -> Bool {
        return StoreDispatcher.shared.createNewActionItemLocally(fieldsToUpload:fields)
    }
    func editActionItemLocally(fields: [String:Any]) -> Bool {
        return StoreDispatcher.shared.editActionItemLocally(fieldsToUpload:fields)
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
    
    
    
    
    
}
