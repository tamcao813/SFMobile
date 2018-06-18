//
//  NotificationsViewModel.swift
//  SWSApp
//
//  Created by shubham.e.shukla on 5/30/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation
class NotificationsViewModel {
    
    func notificationsForUser() -> [Notifications] {
        let notificationsArray = StoreDispatcher.shared.fetchNotifications()
//        var filteredNotificationArray = SyncConfigurationSortUtility.getNotificationDataUsingSyncTime(objectArray: notificationsArray)
//        filteredNotificationArray = filteredNotificationArray.sorted(by: { $0.createdDate < $1.createdDate })
        return notificationsArray
    }
    
    func editNotificationsLocally(fields: [String:Any]) -> Bool {
        return StoreDispatcher.shared.editNotificationsLocally(fieldsToUpload:fields)
    }
    
    func unreadNotificationsCountForUser()->Int {
        return StoreDispatcher.shared.fetchUnreadNotificationsCount()
    }
    
    func syncNotificationWithServer(_ completion:@escaping (_ error: NSError?)->()) {
        
        StoreDispatcher.shared.reSyncNotifications{ error in
            if error != nil {
                print(error?.localizedDescription ?? "error")
                print("syncNotificationWithServer: Notification reSync failed")
                completion(error)
            }
            else {
                completion(nil)
            }
        }
    }
    
}
