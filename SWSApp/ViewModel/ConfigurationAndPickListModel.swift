//
//  ConfigurationAndPickListModel.swift
//  SWSApp
//
//  Created by soumin.nikhra on 6/5/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation

class ConfigurationAndPickListModel {
    
    
    func syncConfigurationWithServer(_ completion:@escaping (_ error: NSError?)->()) {
        
        StoreDispatcher.shared.reSyncConfiguration{error in
            if error != nil {
                print(error?.localizedDescription ?? "error")
                print("syncConfigureationWithServer: Configuration Sync up failed")
                completion(error)
            }
            else {
                completion(nil)
            }
        }
    }
    
    func syncPickListWithServer(_ completion:@escaping (_ error: NSError?)->()) {
        
        StoreDispatcher.shared.downloadVisitPLists {error in
            if error != nil {
                print(error?.localizedDescription ?? "error")
                print("downloadVisitPLists: resync done")
                completion(error)
            }
            else {
                
                StoreDispatcher.shared.downloadContactPLists {error in
                    if error != nil {
                        print(error?.localizedDescription ?? "error")
                        print("downloadContactPLists: resync done")
                        completion(error)
                    }else {
                        completion(nil)
                    }
                }
            }
        }
        StoreDispatcher.shared.getRecordTypeIdForOutcomePickListValues {error in
            if error != nil {
                print(error?.localizedDescription ?? "error")
                print("downloadOutcomePicker: resync done")
                completion(error)
            }
            else {
                
                StoreDispatcher.shared.downloadContactPLists {error in
                    if error != nil {
                        print(error?.localizedDescription ?? "error")
                        print("downloadContactPLists: resync done")
                        completion(error)
                    }else {
                        completion(nil)
                    }
                }
            }
        }
        
    }
}
