//
//  User.swift
//  SWSApp
//
//  Created by maria.min-hui.yu on 3/22/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation

class User {
    static let UserFields = ["Id", "Name", "Username", "FirstName", "LastName", "SGWS_Site__c"]
    
    var userid: String
    var firstName: String
    var lastName: String
    var name: String
    var userName: String
    var userSite: String
    
    convenience init(withAry ary: [Any]) {
        let resultDict = Dictionary(uniqueKeysWithValues: zip(User.UserFields, ary))
        self.init(json: resultDict)
    }
    
    init(json: [String: Any]) {
        userid = json[User.UserFields[0]] as! String
        firstName = json[User.UserFields[3]] as! String
        lastName = json[User.UserFields[4]] as! String
        name = json[User.UserFields[1]] as! String
        userName = json[User.UserFields[2]] as! String
        userSite = ""//json[User.UserFields[2]] as! String
    }
    
    init(for: String) {
        userid = ""
        firstName = ""
        lastName = ""
        name = ""
        userName = ""
        userSite = ""
    }
    
    static func mockUser() -> User {
        let user = User(for: "mockup")
        user.userid = "005i0000002XxdhAAC"
        user.firstName = "Lucas"
        user.lastName = "Giant"
        user.name = "Lucas Giant"
        user.userName = "lua@tahoo.com"
        user.userSite = "70010"
        return user
    }
}

extension User {
    var myManager: User {
        //we should retrieve and construct a user object for manager
        
        //for now
        return User(for: "mockup")
    }
    
    var myConsultants: [User]? {
        ///if the logged in user is a manager
        //retuen the consultans array
        //else
        return nil
    }
}
