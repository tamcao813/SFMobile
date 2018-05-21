//
//  SyncConfiguration.swift
//  SWSApp
//
//  Created by soumin.nikhra on 5/14/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation

class SyncConfiguration {
    
    static let syncConfigurationFields: [String] = ["Id","DeveloperName","SObjectType"]
    
    var id : String
    var developerName : String
    var sObjectType : String
   // var recordTypeId : String


    convenience init(withAry ary: [Any]) {
        let resultDict = Dictionary(uniqueKeysWithValues: zip(SyncConfiguration.syncConfigurationFields, ary))
        self.init(json: resultDict)
    }
    
    init(json: [String: Any]) {
        
        id = json["Id"] as? String ?? ""
        developerName = json["DeveloperName"] as? String ?? ""
        sObjectType = json["SObjectType"] as? String ?? ""
        //recordTypeId = json["RecordTypeId"] as? String ?? ""

    }

}
