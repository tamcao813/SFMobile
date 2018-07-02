//
//  ContactFilterViewModel.swift
//  SWSApp
//
//  Created by Thillaiganesh, C. on 23/04/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class ContactFilter {
    
    var sectionNames : Array<Any>  = ["Contact Association", "Function/Role", "Buying Power"]
    
    var sectionItems : Array<Any> = [ ["All Contacts", "Contacts On My Route"],
                                      ["All"],
                                      ["All", "Buying Power", "No Buying Power"] ]
    
}

let ContactFilterCell = "customContactCell1"
let ContacLocationCell = "customContactCell2"

struct ContactFilterMenuModel {
    
    static var allContacts = ""
    static var contactsOnMyRoute = "YES"
    
    static var allRole = ""
    static var functionRoles = [String]()
    
    static var allBuyingPower = ""
    static var buyingPower = ""
    static var nobuyingPower = ""
    
    static var comingFromDetailsScreen = ""
    static var selectedContactId = ""
    static var selectedContactIdFromDetailScreen = ""
    
}
