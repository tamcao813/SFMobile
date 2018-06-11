//
//  Contact.swift
//  SWSApp
//
//  Created by maria.min-hui.yu on 3/25/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation

class Contact {
    
    static let ContactFields: [String] = ["Id", "SGWS_TECH_MobileField__c", "Name", "FirstName", "LastName", "Phone", "Email", "Birthdate","SGWS_Buying_Power__c","AccountId", "Account.SWS_Account_Site__c","SGWS_Site_Number__c","Title","Department","SGWS_Preferred_Name__c","SGWS_Contact_Hours__c","SGWS_Notes__c", "LastModifiedBy.Name","SGWS_AppModified_DateTime__c","SGWS_Child_1_Name__c","SGWS_Child_1_Birthday__c","SGWS_Child_2_Name__c","SGWS_Child_2_Birthday__c","SGWS_Child_3_Name__c","SGWS_Child_3_Birthday__c","SGWS_Child_4_Name__c","SGWS_Child_4_Birthday__c","SGWS_Child_5_Name__c","SGWS_Child_5_Birthday__c","SGWS_Anniversary__c","SGWS_Likes__c","SGWS_Dislikes__c","SGWS_Favorite_Activities__c","SGWS_Life_Events__c","SGWS_Life_Events_Date__c","Fax","SGWS_Other_Specification__c","SGWS_Roles__c","SGWS_Preferred_Communication_Method__c", "SGWS_Contact_Classification__c"]
    
    
    var contactId: String
    var name: String
    var firstName: String
    var lastName: String
    var phoneNumber: String
    var email: String
    var birthDate: String
    var buyerFlag: Bool
    var accountId: String
    var accountSite: String
    var accountSiteNumber: String
    var functionRole: String
    var title: String
    var department:String
    var preferredName:String
    var contactHours:String
    var preferredCommunicationMethod:String
    var sgwsNotes:String
    var lastModifiedByName:String
    var lastModifiedDate:String
    var child1Name:String
    var child1Birthday:String
    var child2Name:String
    var child2Birthday:String
    var child3Name:String
    var child3Birthday:String
    var child4Name:String
    var child4Birthday:String
    var child5Name:String
    var child5Birthday:String
    var anniversary:String
    var likes:String
    var dislikes:String
    var favouriteActivities:String
    var lifeEvents:String
    var lifeEventDate:String
    var fax:String
    var contactClassification: String
    var otherSpecification: String
    var _soupEntryId: Int  //should not need this
    var tempId: String
    
    
    convenience init(withAry resultDict: [String:Any]) {
        //  let resultDict = Dictionary(uniqueKeysWithValues: zip(Contact.ContactFields, ary))
        self.init(json: resultDict)
    }
    
    init(json: [String: Any]) {
        contactId = json["Id"] as! String
        firstName = json["FirstName"] as? String ?? ""
        lastName = json["LastName"] as? String ?? ""
        name = json["Name"] as? String ?? ""
        if(name == ""){
            name = firstName + " " + lastName
        }
        phoneNumber = json["Phone"] as? String ?? ""
        email = json["Email"] as? String ?? ""
        birthDate = json["Birthdate"] as? String ?? ""
        accountId = json["AccountId"] as? String ?? ""
        accountSite = json["Account.SWS_Account_Site__c"] as? String ?? ""
        accountSiteNumber = json["SGWS_Site_Number__c"] as? String ?? ""
        functionRole = json["SGWS_Roles__c"] as? String ?? ""
        buyerFlag = json["SGWS_Buying_Power__c"] as? Bool ?? false
        let buyerFlagString = json["SGWS_Buying_Power__c"] as? String ?? ""
        if buyerFlagString == "true" {
            buyerFlag = true
        }
        if buyerFlagString == "1" {
            buyerFlag = true
        }
        title = json["Title"] as? String ?? ""
        department = json["Department"] as? String ?? ""
        preferredName = json["SGWS_Preferred_Name__c"] as? String ?? ""
        contactHours = json["SGWS_Contact_Hours__c"] as? String ?? ""
        preferredCommunicationMethod = json["SGWS_Preferred_Communication_Method__c"] as? String ?? ""
        sgwsNotes = json["SGWS_Notes__c"] as? String ?? ""
        let lastModifiedByString = json["LastModifiedBy"] as? [String:Any]
        if let name = lastModifiedByString!["Name"] as? String {
            lastModifiedByName = name
        }else{
            lastModifiedByName = ""
        }
        
        lastModifiedDate = json["SGWS_AppModified_DateTime__c"] as? String ?? ""
        child1Name = json["SGWS_Child_1_Name__c"] as? String ?? ""
        child1Birthday = json["SGWS_Child_1_Birthday__c"] as? String ?? ""
        child2Name = json["SGWS_Child_2_Name__c"] as? String ?? ""
        child2Birthday = json["SGWS_Child_2_Birthday__c"] as? String ?? ""
        child3Name = json["SGWS_Child_3_Name__c"] as? String ?? ""
        child3Birthday = json["SGWS_Child_3_Birthday__c"] as? String ?? ""
        child4Name = json["SGWS_Child_4_Name__c"] as? String ?? ""
        child4Birthday = json["SGWS_Child_4_Birthday__c"] as? String ?? ""
        child5Name = json["SGWS_Child_5_Name__c"] as? String ?? ""
        child5Birthday = json["SGWS_Child_5_Birthday__c"] as? String ?? ""
        anniversary = json["SGWS_Anniversary__c"] as? String ?? ""
        likes = json["SGWS_Likes__c"] as? String ?? ""
        dislikes = json["SGWS_Dislikes__c"] as? String ?? ""
        favouriteActivities = json["SGWS_Favorite_Activities__c"] as? String ?? ""
        lifeEvents = json["SGWS_Life_Events__c"] as? String ?? ""
        lifeEventDate = json["SGWS_Life_Events_Date__c"] as? String ?? ""
        fax = json["Fax"] as? String ?? ""
        contactClassification = json["SGWS_Contact_Classification__c"] as? String ?? ""
        otherSpecification = json["SGWS_Other_Specification__c"] as? String ?? ""
        _soupEntryId = json["_soupEntryId"] as? Int ?? 0
        tempId = json["SGWS_TECH_MobileField__c"] as? String ?? ""
    }
    
    func toJson() -> [String:Any] { //only pak the fields we need
        var json = [String:Any]()
        
        json["Id"] = contactId
        
        json["SGWS_TECH_MobileField__c"] = tempId
        
        json["FirstName"] = firstName
        
        json["LastName"] = lastName
        
        json["AccountId"] = accountId
        
        json["Phone"] = phoneNumber
        
        json["Email"] = email
        
        json["SGWS_AppModified_DateTime__c"] = lastModifiedDate
        
        if birthDate.count > 0 {
            json["Birthdate"] = birthDate
        }
        /* //Unable to create/update field - check with SF team
         if accountSiteNumber.count > 0 {
         json["SGWS_Account_Site_Number__c"] = accountSiteNumber
         }
         */
        
        if accountSiteNumber.count > 0 {
            json["SGWS_Site_Number__c"] = accountSiteNumber
        }
        
        if functionRole.count > 0 { //plist
            json["SGWS_Roles__c"] = functionRole
        }
        
        json["SGWS_Buying_Power__c"] = buyerFlag ? "true" : "false"
        
        json["Title"] = title
        
        json["Department"] = department
        
        json["SGWS_Preferred_Name__c"] = preferredName
        
        json["SGWS_Contact_Hours__c"] = contactHours
        
        if preferredCommunicationMethod.count > 0 { //plist
            json["SGWS_Preferred_Communication_Method__c"] = preferredCommunicationMethod
        }
        
        json["SGWS_Notes__c"] = sgwsNotes
        
        json["LastModifiedBy.Name"] = lastModifiedByName //don't save to soup or sync up // TBD
        
        json["SGWS_Child_1_Name__c"] = child1Name
        
        if child1Birthday.count > 0 {
            json["SGWS_Child_1_Birthday__c"] = child1Birthday
        }
        
        json["SGWS_Child_2_Name__c"] = child2Name
        
        if child2Birthday.count > 0 {
            json["SGWS_Child_2_Birthday__c"] = child2Birthday
        }
        
        json["SGWS_Child_3_Name__c"] = child3Name
        
        if child3Birthday.count > 0 {
            json["SGWS_Child_3_Birthday__c"] = child3Birthday
        }
        
        json["SGWS_Child_4_Name__c"] = child4Name
        
        if child4Birthday.count > 0 {
            json["SGWS_Child_4_Birthday__c"] = child4Birthday
        }
        
        json["SGWS_Child_5_Name__c"] = child5Name
        
        if child5Birthday.count > 0 {
            json["SGWS_Child_5_Birthday__c"] = child5Birthday
        }
        
        if anniversary.count > 0 {
            json["SGWS_Anniversary__c"] = anniversary
        }
        
        json["SGWS_Likes__c"] = likes
        
        json["SGWS_Dislikes__c"] = dislikes
        
        json["SGWS_Favorite_Activities__c"] = favouriteActivities
        
        json["SGWS_Life_Events__c"] = lifeEvents
        
        if lifeEventDate.count > 0 {
            json["SGWS_Life_Events_Date__c"] = lifeEventDate
        }
        
        json["Fax"] = fax
        
        if contactClassification.count > 0 { //plist
            json["SGWS_Contact_Classification__c"] = contactClassification
        }
        
        json["SGWS_Other_Specification__c"] = otherSpecification
        
        json["_soupEntryId"] = _soupEntryId
        
        return json
    }
    
    init(for: String) {
        let n = Int(arc4random_uniform(100000000))
        contactId = "NEW" + "\(n)"
        tempId = contactId
        name = ""
        firstName = ""
        lastName = ""
        phoneNumber = ""
        email = ""
        birthDate = ""
        accountId = ""
        accountSite = ""
        accountSiteNumber = ""
        functionRole = ""
        buyerFlag = false
        title = ""
        department = ""
        preferredName = ""
        contactHours = ""
        preferredCommunicationMethod = ""
        sgwsNotes = ""
        lastModifiedByName = ""
        lastModifiedDate = ""
        child1Name = ""
        child1Birthday = ""
        child2Name = ""
        child2Birthday = ""
        child3Name = ""
        child3Birthday = ""
        child4Name = ""
        child4Birthday = ""
        child5Name = ""
        child5Birthday = ""
        anniversary = ""
        likes = ""
        dislikes = ""
        favouriteActivities = ""
        lifeEvents = ""
        lifeEventDate = ""
        fax = ""
        contactClassification = ""
        otherSpecification = ""
        _soupEntryId = 0
    }
    
    func getIntials(name: String) -> String{
        if name == "" { return "" }
        let nameSep = name.components(separatedBy: " ")
        if (nameSep == [name]) || (nameSep == ["", nameSep[1]]) || (nameSep == [nameSep[0], ""])  {
            if name.count >= 2 {
                return String(name.prefix(2))
            }else {
                return name
            }
        }
        
        var firstChar = ""
        if(firstName != "") {
            let firstCharIndex = firstName.index(firstName.startIndex, offsetBy: 1)
            firstChar = String(firstName[..<firstCharIndex])
        }
        if(lastName != "") {
            let firstCharIndex = lastName.index(lastName.startIndex, offsetBy: 1)
            firstChar = firstChar+String(lastName[..<firstCharIndex])
        }
        return firstChar
    }
}
