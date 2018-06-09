//
//  AccountNotes.swift
//  SWSApp
//
//  Created by Jagadeeshwar Reddy on 27/04/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation

class AccountNotes {
    static let AccountNotesFields: [String] = ["Id","SGWS_AppModified_DateTime__c","Name","OwnerId","SGWS_Account__c","SGWS_Description__c"]
    
    var Id:String
    var lastModifiedDate:String
    var name: String
    var ownerId: String
    var accountId: String
    var accountNotesDesc: String
    
    convenience init(withAry ary: [Any]) {
        let resultDict = Dictionary(uniqueKeysWithValues: zip(AccountNotes.AccountNotesFields, ary))
        self.init(json: resultDict)
    }
    
    init(json: [String: Any]) {
        Id = json["Id"] as? String ?? ""
        lastModifiedDate = json["SGWS_AppModified_DateTime__c"] as? String ?? ""
        name = json["Name"] as? String ?? ""
        ownerId = json["OwnerId"] as? String ?? ""
        accountId = json["SGWS_Account__c"] as? String ?? ""
        accountNotesDesc = json["SGWS_Description__c"] as? String ?? ""
    }
    
    init(for: String) {
        Id = ""
        lastModifiedDate = ""
        name = ""
        ownerId = ""
        accountId =  ""
        accountNotesDesc =  ""
        
    }
}
