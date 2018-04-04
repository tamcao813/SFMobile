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
    //var firstName: String
    //var lastName: String
    var name: String
    var userName: String
    var managerName: String
    var managerName2: String
    //var email: String
    //var accountId: String
    //var employeeNumber: String
    
    init() {
        sfid = ""
        //firstName = ""
        //lastName = ""
        name = ""
        userName = ""
        managerName = ""
        managerName2 = ""
        //email = ""
        //accountId = ""
        //employeeNumber = ""
    }
    
    init(withAry ary: [Any]) {
        sfid = ary[0] as! String
        //firstName = ary[1] as! String
        //lastName = ary[2] as! String
        name = ary[1] as! String
        userName = ary[2] as! String
        managerName = ary[3] as! String
        managerName2 = ary[4] as! String
        //accountId = ary[2] as! String
    }
    
    init(json: [String: AnyObject]) {
        sfid = json["Id"] as! String
        //firstName = json["FirstName"] as! String
        //lastName = json["LastName"] as! String
        name = json["Name"] as! String
        userName = json["Username"] as! String
        managerName = ""
        managerName2 = ""
        //lastName = json["LastName"] as! String
        //email = json["Email"] as! String
        //accountId = json["AccountId"] as! String
        //employeeNumber = json["EmployeeNumber"] as! String
    }
    
    
    static func mockUser() -> User {
        let user = User()
        user.sfid = "005i0000002XxdhAAC"
        //user.firstName = "Lucas"
        //user.lastName = "Giant"
        user.name = "Lucas Giant"
        user.userName = "lua@tahoo.com"
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

