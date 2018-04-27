//
//  Contact.swift
//  SWSApp
//
//  Created by maria.min-hui.yu on 3/25/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation

class Contact {
    static let ContactFields: [String] = ["Id", "Name", "FirstName", "LastName", "Phone", "Email", "Birthdate", "AccountId", "Account.SWS_Account_Site__c","SGWS_Account_Site_Number__c","SGWS_Buyer_Flag__c","SGWS_Roles__c","Title","Department","SGWS_Preferred_Name__c","SGWS_Contact_Hours__c","SGWS_Preferred_Communication_Method__c","SGWS_Notes__c", "LastModifiedBy.Name","SGWS_Child_1_Name__c","SGWS_Child_1_Birthday__c","SGWS_Child_2_Name__c","SGWS_Child_2_Birthday__c","SGWS_Child_3_Name__c","SGWS_Child_3_Birthday__c","SGWS_Child_4_Name__c","SGWS_Child_4_Birthday__c","SGWS_Child_5_Name__c","SGWS_Child_5_Birthday__c","SGWS_Anniversary__c","SGWS_Likes__c","SGWS_Dislikes__c","SGWS_Favorite_Activities__c","SGWS_Life_Events__c","SGWS_Life_Events_Date__c"]
    
    var contactId: String
    var name: String
    var firstName: String
    var lastName: String
    //var preferredName: String
    var phoneuNmber: String
    var email: String
    var birthDate: Date
    var accountId: String
    var accountSite: String
    var sccountSiteNumber: String
    var functionRole: String
    var buyerFlag: String
    var title: String
    var department:String
    var preferredName:String
    var contactHours:String
    var preferredCommunicationMethod:String
    var sgwsNotes:String
    var lastModifiedByName:String
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
    


    convenience init(withAry ary: [Any]) {
        let resultDict = Dictionary(uniqueKeysWithValues: zip(Contact.ContactFields, ary))
        self.init(json: resultDict)
    }
    
    init(json: [String: Any]) {
        contactId = json["Id"] as! String
        name = json["Name"] as? String ?? ""
        firstName = json["FirstName"] as? String ?? ""
        lastName = json["LastName"] as? String ?? ""
        //preferredName = json["PreferredName"] as! String
        phoneuNmber = json["Phone"] as? String ?? ""
        email = json["Email"] as? String ?? ""
        birthDate = json["Birthdate"] as? Date ?? Date() //need to check if ok to have a default or make it a string
        accountId = json["AccountId"] as? String ?? ""
        accountSite = json["Account.SWS_Account_Site__c"] as? String ?? ""
        sccountSiteNumber = json["SGWS_Account_Site_Number__c"] as? String ?? ""
        functionRole = json["SGWS_Roles__c"] as? String ?? ""
        buyerFlag = json["SGWS_Buyer_Flag__c"] as? String ?? ""
        title = json["Title"] as? String ?? ""
        department = json["Department"] as? String ?? ""
        preferredName = json["SGWS_Preferred_Name__c"] as? String ?? ""
        contactHours = json["SGWS_Contact_Hours__c"] as? String ?? ""
        preferredCommunicationMethod = json["SGWS_Preferred_Communication_Method__c"] as? String ?? ""
        sgwsNotes = json["SGWS_Notes__c"] as? String ?? ""
        lastModifiedByName = json["LastModifiedBy.Name"] as? String ?? ""
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
        dislikes = json["SGWS_Disikes__c"] as? String ?? ""
        favouriteActivities = json["SGWS_Favorite_Activities__c"] as? String ?? ""
        lifeEvents = json["SGWS_Life_Events__c"] as? String ?? ""
        lifeEventDate = json["SGWS_Life_Events_Date__c"] as? String ?? ""
        
    }
    
    init(for: String) {
        contactId = ""
        name = ""
        firstName = ""
        lastName = ""
        //preferredName = ""
        phoneuNmber = ""
        email = ""
        birthDate = Date()
        accountId = ""
        accountSite = ""
        sccountSiteNumber = ""
        functionRole = ""
        buyerFlag = ""
        title = ""
        department = ""
        preferredName = ""
        contactHours = ""
        preferredCommunicationMethod = ""
        sgwsNotes = ""
        lastModifiedByName = ""
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
    }
    
    static func mockBuyingPowerContact1() -> Contact {
        let contact = Contact(for: "mockup")
        contact.contactId =  "111AAW"
        contact.name = "Daniel Brown"
        contact.phoneuNmber = "(676) 738-76277"
        contact.email = "daniel@eec.com"
        contact.functionRole = "Buying power"
        
        return contact
    }
    
    static func mockBuyingPowerContact2() -> Contact{
        let contact = Contact(for: "mockup")
        contact.contactId = "111ASD"
        contact.name = "Justin Timber"
        contact.phoneuNmber = "(765) 764-5634"
        contact.email = "justin@bhd.com"
        contact.functionRole = "Buying Power"
        return contact
        
    }
    
    static func mockBuyingPowerContact3() -> Contact{
        let contact = Contact(for: "mockup")
        contact.contactId = "212ASD"
        contact.name = "Amber Heard"
        contact.phoneuNmber = "(734) 732 8734"
        contact.email = "Amber@bhd.com"
        contact.functionRole = "Buying Power"
        return contact
        
    }
    
    static func mockContactSG1() -> Contact {
        let contact = Contact(for: "mockup")
        contact.contactId =  "xxxAAW"
        contact.name = "Devin Miller"
        contact.phoneuNmber = "(123) 643-2465"
        contact.email = "Devin@abc.com"
        contact.functionRole = "SG"
        
        return contact
    }
    
    static func mockContactSG2() -> Contact {
        let contact = Contact(for: "mockup")
        contact.contactId =  "xxx001"
        contact.name = "Keaton Mckinneyr"
        contact.phoneuNmber = "(123) 245-6677"
        contact.email = "Keaton@ffc.com"
        contact.functionRole = "SG"  //made-up
        
        return contact
    }
    
    static func mockContactSG3() -> Contact {
        let contact = Contact(for: "mockup")
        contact.contactId =  "AGH007"
        contact.name = "James Bond"
        contact.phoneuNmber = "(145) 276-7543"
        contact.email = "James@ffc.com"
        contact.functionRole = "SG"  //made-up
        
        return contact
    }
    static func mockContactSG4() -> Contact {
        let contact = Contact(for: "mockup")
        contact.contactId =  "xBHJD"
        contact.name = "Rosh Jacob"
        contact.phoneuNmber = "(423) 643-2465"
        contact.email = "Rosh@abc.com"
        contact.functionRole = "SG"
        
        return contact
    }
    
    /* Convertthese mock data to the above contact object format
     //TODO: convert below data to the above contact object format
     // Static data for Southern Glazer's Contact TableView
     let contactNameArray = ["Devin Miller","Alice Stewert","Ciera Morales","Tasha Howell","Keaton Mckinney","Tiffany Mccarthy"]
     let contactArray    =   ["1236432465","5565789036","3412456677","67673876277","1237645672","58754234456"]
     let contactEmailArray  = ["Devin@abc.com","Alice@bbc.com","Ciera@ccd.com","Tasha@eec.com","Keaton@ffc.com","Tiffany@ggc.com"]
     var southernInitialArray:[String] = []
     
     // Static data for Crown Liquor Contacts TableView
     let crownNameArray = ["Daniel Brown","Cory Gutierrez","Lawrence Sherman"]
     let crownContactArray    =   ["67673876277","1237645672","58754234456"]
     let crownEmailArray  = ["daniel@eec.com","cory@ffc.com","lawrence@ggc.com"]
     var crownInitialArray:[String] = []
     */
    
    func getIntials(name: String) -> String{
        if name == "" { return "" }
        
        let nameSep = name.components(separatedBy: " ")
        if (nameSep == [name]) || (nameSep == ["", nameSep[1]]) || (nameSep == [nameSep[0], ""])  {
            if name.count >= 2 {
                return String(name.prefix(2))
            }
            else {
                return name
            }
        }

        
        let initials = name.components(separatedBy: " ")
        print(initials)
        var firstChar = ""
        
        if(initials[0] != "") {
            var firstCharIndex = initials[0].index(initials[0].startIndex, offsetBy: 1)
            firstChar = initials[0].substring(to: firstCharIndex)
            print(firstChar)
        }
        if(initials[1] != "") {
            var firstCharIndex = initials[1].index(initials[1].startIndex, offsetBy: 1)
            firstChar = firstChar+initials[1].substring(to: firstCharIndex)
            print(firstChar)
        }
        
//        let initials = name.components(separatedBy: " ").reduce("") { ($0 == "" ? "" : "\($0.first!)") + "\($1.first!)" }
        
       // print("My Initials are \(initials)")
        return firstChar
    }
    
}
