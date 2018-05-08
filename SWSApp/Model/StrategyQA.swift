//
//  StrategyQA.swift
//  SWSApp
//
//  Created by shubham.e.shukla on 4/30/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation
class StrategyQA {
    static let StrategyQAFields: [String] = ["Id","SGWS_Account__c","SGWS_Question_Sub_Type__c","SGWS_Question__c","SGWS_Notes__c","LastModifiedById","LastModifiedDate","OwnerId","SGWS_Answer_Description_List__c"]
    
    var Id:String
    var SGWS_Account__c:String
    var SGWS_Question_Sub_Type__c: String
    var SGWS_Notes__c:String
    var LastModifiedById:String
    var LastModifiedDate:String
    var OwnerId:String
    var SGWS_Answer_Description_List__c : String
    var SGWS_Question__c : String


    convenience init(withAry ary: [Any]) {
        let resultDict = Dictionary(uniqueKeysWithValues: zip(StrategyQA.StrategyQAFields, ary))
        self.init(json: resultDict)
    }
    
    init(json: [String: Any]) {
        Id = json["Id"] as? String ?? ""
        SGWS_Account__c = json["SGWS_Account__c"] as? String ?? ""
        SGWS_Question_Sub_Type__c = json["SGWS_Question_Sub_Type__c"] as? String ?? ""
        SGWS_Notes__c = json["SGWS_Notes__c"] as? String ?? ""
        LastModifiedById = json["LastModifiedById"] as? String ?? ""
        LastModifiedDate =  json["LastModifiedDate"] as? String ?? ""
        OwnerId = json["OwnerId"] as? String ?? ""
        SGWS_Answer_Description_List__c = json["SGWS_Answer_Description_List__c"] as? String ?? ""
        SGWS_Question__c = json["SGWS_Question__c"] as? String ?? ""

    }
    
    init(for: String) {
        Id = ""
        SGWS_Account__c = ""
        SGWS_Question_Sub_Type__c =  ""
        SGWS_Notes__c = ""
        LastModifiedById = ""
        LastModifiedDate = ""
        OwnerId = ""
        SGWS_Answer_Description_List__c = ""
        SGWS_Question__c = ""

        
    }
}
