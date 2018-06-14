//
//  User.swift
//  SWSApp
//
//  Created by maria.min-hui.yu on 3/22/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation


class User {
    static let UserFields = ["Id", "User.Username", "User.Name", "AccountId", "UserId", "User.Email","User.Phone","TeamMemberRole","User.SGWS_Site__c","User.ManagerId", "Account.RecordTypeId","User.SGWS_Employee_Contact_Id__c"] // Stage 1
    
    static let UserSimpleFields =
     ["Id", "Username", "Name", "AccountId", "Email","Phone","SGWS_Site__c","ManagerId", "Account.RecordTypeId"]
    
    var id: String
    var username: String
    var fullName: String
    var accountId: String
    var userId: String
    
    var userEmail: String
    var userPhone: String
    var userTeamMemberRole: String
    var userSite: String
    var userManagerId: String
    
    var recordTypeId: String
    
    var sgws_Employee_Contact: String
    
    convenience init(withAry ary: [Any]) {
        let resultDict = Dictionary(uniqueKeysWithValues: zip(User.UserFields, ary))
        self.init(json: resultDict)
    }
    
    init(json: [String: Any]) {
        print(json)
        
        if json[User.UserFields[0]] is NSNull {
            id = ""
        } else {
            id = json[User.UserFields[0]] as! String
        }
        
        if json[User.UserFields[1]] is NSNull {
            username = ""
        } else {
            username = json[User.UserFields[1]] as! String
        }
        if json[User.UserFields[2]] is NSNull {
            fullName = ""
        } else {
            fullName = json[User.UserFields[2]] as! String
        }
        if json[User.UserFields[3]] is NSNull {
            accountId = ""
        } else {
            accountId = json[User.UserFields[3]] as! String
        }
        if json[User.UserFields[4]] is NSNull {
            userId = ""
        } else {
            userId = json[User.UserFields[4]] as! String
        }
        if json[User.UserFields[5]] is NSNull {
            userEmail = ""
        } else {
            userEmail = json[User.UserFields[5]] as! String
        }
        if json[User.UserFields[6]] is NSNull {
            userPhone = ""
        } else {
            userPhone = json[User.UserFields[6]] as! String
            
        }
        if json[User.UserFields[7]] is NSNull {
            userTeamMemberRole = ""
        } else {
            userTeamMemberRole = json[User.UserFields[7]] as! String
        }
        if json[User.UserFields[8]] is NSNull {
            userSite = ""
        } else {
            userSite = json[User.UserFields[8]] as! String
        }
        if json[User.UserFields[9]] is NSNull {
            userManagerId = ""
        } else {
            userManagerId = json[User.UserFields[9]] as! String            
        }
        
        recordTypeId = json["Account.RecordTypeId"] as? String ?? ""
        
        if json[User.UserFields[10]] is NSNull {
            sgws_Employee_Contact = ""
        } else {
            sgws_Employee_Contact = json[User.UserFields[10]] as! String
        }
    }
    
    convenience init(withAryForUserSimple ary: [Any]) {
        let resultDict = Dictionary(uniqueKeysWithValues: zip(User.UserSimpleFields, ary))
        self.init(jsonSimple: resultDict)
    }
    
    init(jsonSimple: [String: Any]) {
        
        id = jsonSimple["Id"] as? String ?? ""
        userId = id
        username = jsonSimple["Username"] as? String ?? ""
        fullName = jsonSimple["Name"] as? String ?? ""
        accountId = jsonSimple["AccountId"] as? String ?? ""
        userEmail = jsonSimple["Email"] as? String ?? ""
        userPhone = jsonSimple["Phone"] as? String ?? ""
        userSite = jsonSimple["SGWS_Site__c"] as? String ?? ""
        userManagerId = jsonSimple["ManagerId"] as? String ?? ""
        recordTypeId = jsonSimple["Account.RecordTypeId"] as? String ?? ""
        userTeamMemberRole = ""
        sgws_Employee_Contact = jsonSimple["SGWS_Employee_Contact_Id__c"] as? String ?? ""
    }
    
    init(for: String) {
        id = ""
        username = ""
        fullName = ""
        accountId = ""
        userId = ""
        userEmail = ""
        userPhone = ""
        userTeamMemberRole = ""
        userSite = ""
        userManagerId = ""
        recordTypeId = ""
        sgws_Employee_Contact = ""
    }
}


