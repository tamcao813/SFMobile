//
//  User.swift
//  SWSApp
//
//  Created by maria.min-hui.yu on 3/22/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation

class User {
    var Id: String
    var firstName: String
    var lastName: String
    var email: String
    var accountId: String
    var employeeNumber: String
    
    init() {
        Id = ""
        firstName = ""
        lastName = ""
        email = ""
        accountId = ""
        employeeNumber = ""
    }
    
    init(json: [String: AnyObject]) {
        Id = json["Id"] as! String
        firstName = json["FirstName"] as! String
        lastName = json["LastName"] as! String
        email = json["Email"] as! String
        accountId = json["AccountId"] as! String
        employeeNumber = json["EmployeeNumber"] as! String
    }
    
    

    
}
