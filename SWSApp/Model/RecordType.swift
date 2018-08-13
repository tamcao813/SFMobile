//
//  RecordType.swift
//  SWSApp
//
//  Created by manu.a.gupta on 19/06/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation

class RecordType {
    
    static let recordTypesFields: [String] = ["Id","DeveloperName","CreatedDate"]
    
    var Id : String
    var developerName : String
    var createdDate : String
    
    convenience init(withAry ary: [Any]) {
        let resultDict = Dictionary(uniqueKeysWithValues: zip(RecordType.recordTypesFields, ary))
        self.init(json: resultDict)
    }
    
    init(json: [String: Any]) {
        
        Id = json["Id"] as? String ?? ""
        developerName = json["DeveloperName"] as? String ?? ""
        createdDate = json["CreatedDate"] as? String ?? ""
    }
    
    init(for: String) {
        Id = ""
        developerName = ""
        createdDate = ""
    }
    
}
