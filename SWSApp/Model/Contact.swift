//
//  Contact.swift
//  SWSApp
//
//  Created by maria.min-hui.yu on 3/25/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation

class Contact {
    var sfid: String
    var name: String
    var phoneuNmber: String
    var email: String
    var functionRole: String
    
    init() {
        sfid = ""
        name = ""
        phoneuNmber = ""
        email = ""
        functionRole = ""
    }
    
    static func mockBuyingPowerContact1() -> Contact {
        let contact = Contact()
        contact.sfid =  "111AAW"
        contact.name = "Daniel Brown"
        contact.phoneuNmber = "(676) 738-76277"
        contact.email = "daniel@eec.com"
        contact.functionRole = "Buying power"
        
        return contact
    }
    static func mockContactSG1() -> Contact {
        let contact = Contact()
        contact.sfid =  "xxxAAW"
        contact.name = "Devin Miller"
        contact.phoneuNmber = "(123) 643-2465"
        contact.email = "Devin@abc.com"
        contact.functionRole = "SG"
        
        return contact
    }
    
    static func mockContactSG2() -> Contact {
        let contact = Contact()
        contact.sfid =  "xxx001"
        contact.name = "Keaton Mckinneyr"
        contact.phoneuNmber = "(123) 245-6677"
        contact.email = "Keaton@ffc.com"
        contact.functionRole = "SG"  //made-up
        
        return contact
    }
    
    static func mockContactSG3() -> Contact {
        let contact = Contact()
        contact.sfid =  "AGH007"
        contact.name = "James Bond"
        contact.phoneuNmber = "(145) 276-7543"
        contact.email = "James@ffc.com"
        contact.functionRole = "SG"  //made-up
        
        return contact
    }
    static func mockContactSG4() -> Contact {
        let contact = Contact()
        contact.sfid =  "xBHJD"
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
        
        let initials = name.components(separatedBy: " ").reduce("") { ($0 == "" ? "" : "\($0.first!)") + "\($1.first!)" }
        
        print("My Initials are \(initials)")
        return initials
    }
    
}
