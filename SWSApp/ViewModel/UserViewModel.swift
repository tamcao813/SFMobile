//
//  UserViewModel.swift
//  SWSApp
//
//  Created by maria.min-hui.yu on 4/2/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation

struct Consultant {
    var name: String
    var id: String
    
    init(name: String, id: String) {
        self.name = name
        self.id = id
    }
}

class UserViewModel {
    
    var loggedInUser: User? {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        if let currentUser = appDelegate.loggedInUser {
            return currentUser
        }
        else {
            return nil
        }
    }
    
    var selectedUserId: String {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        return appDelegate.currentSelectedUserId
    }
    
    var consultants: [Consultant] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        return appDelegate.consultants
    }
}

extension UserViewModel {
    
    var myManager: User? {
        if let user = self.loggedInUser {
            return user.myManager
        }
        return nil
    }
    
    var myConsultants: [String]? {
        if let user = loggedInUser {
            return user.myConsultants
        }
        return nil
    }
}
