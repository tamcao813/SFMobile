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
        return StoreDispatcher.shared.fetchNotifications()
    } 
    
}
