//
//  ActionItem.swift
//  SWSApp
//
//  Created by manu.a.gupta on 14/05/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation


class ActionItem {
    var id: String?
    var title: String?
    var dueDate: String?
    var account: String?
    var status: ActionItemStatus?
    var description: String?
    var isItUrgent: Bool?
    
    init(id: String?,title: String?,dueDate: String?,account: String?, status: ActionItemStatus?, description: String?, isItUrgent: Bool?) {
        self.id = id
        self.title = title
        self.dueDate = dueDate
        self.account = account
        self.status = status
        self.description = description
        self.isItUrgent = isItUrgent
    }
}

enum ActionItemStatus {
    case complete
    case open
    case overdue
}
