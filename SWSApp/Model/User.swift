//
//  User.swift
//  SWSApp
//
//  Created by maria.min-hui.yu on 3/22/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation

class User {
    var sfid: String
    var firstName: String
    //var name: String
    //var userName: String
    //var email: String
    //var accountId: String
    //var employeeNumber: String
    
    init() {
        sfid = ""
        firstName = ""
        //name = ""
        //userName = ""
        //lastName = ""
        //email = ""
        //accountId = ""
        //employeeNumber = ""
    }
    
    init(withAry ary: [Any]) {
        sfid = ary[0] as! String
        firstName = ary[1] as! String
        
        //name = ary[1] as! String
        //userName = ary[2] as! String
        //accountId = ary[2] as! String
    }
    
    init(json: [String: AnyObject]) {
        sfid = json["Id"] as! String
        firstName = json["FirstName"] as! String
        //name = json["Name"] as! String
        //userName = json["Username"] as! String
        //lastName = json["LastName"] as! String
        //email = json["Email"] as! String
        //accountId = json["AccountId"] as! String
        //employeeNumber = json["EmployeeNumber"] as! String
    }
    
    
    static func mockUser() -> User {
        let user = User()
        user.sfid = "005i0000002XxdhAAC"
        user.firstName = "Lucas"
        
        return user
    }
    
}

extension User {
    var myManager: User {
        //we should retrieve and construct a user object for manager
        
        //for now
        return User()
    }
    
    var myConsultants: [User]? {
        ///if the logged in user is a manager
        //retuen the consultans array
        //else
        return nil
    }
}

