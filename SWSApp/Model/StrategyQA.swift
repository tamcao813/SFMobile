//
//  StrategyQA.swift
//  SWSApp
//
//  Created by shubham.e.shukla on 4/30/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation
class StrategyQA {
    static let StrategyQAFields: [String] = ["Id","SGWS_Account__c","SGWS_Question__r.Id","SGWS_Answer_Options__r.Id","SGWS_Question__r.SGWS_Question_Type__c","SGWS_Question__r.SGWS_Question_Sub_Type__c","SGWS_Question_Description__c","SGWS_Answer__c","SGWS_Notes__c","LastModifiedById","LastModifiedDate","OwnerId"]
    
    var Id:String
    var SGWS_Account__c:String
    var SGWS_Question__r_Id: String
    var SGWS_Answer_Options__r_Id: String
    var SGWS_Question__r_SGWS_Question_Type__c: String
    var SGWS_Question__r_SGWS_Question_Sub_Type__c: String
    var SGWS_Question_Description__c:String
    var SGWS_Answer__c:String
    var SGWS_Notes__c:String
    var LastModifiedById:String
    var LastModifiedDate:String
    var OwnerId:String
    
    
    
    
    
    convenience init(withAry ary: [Any]) {
        let resultDict = Dictionary(uniqueKeysWithValues: zip(StrategyQA.StrategyQAFields, ary))
        self.init(json: resultDict)
    }
    
    init(json: [String: Any]) {
        Id = json["Id"] as? String ?? ""
        SGWS_Account__c = json["SGWS_Account__c"] as? String ?? ""
        SGWS_Question__r_Id = json["SGWS_Question__r.Id"] as? String ?? ""
        SGWS_Answer_Options__r_Id = json["SGWS_Answer_Options__r.Id"] as? String ?? ""
        SGWS_Question__r_SGWS_Question_Type__c = json["GWS_Question__r.SGWS_Question_Type__c"] as? String ?? ""
        SGWS_Question__r_SGWS_Question_Sub_Type__c = json["SGWS_Question__r.SGWS_Question_Sub_Type__c"] as? String ?? ""
        SGWS_Question_Description__c = json["SGWS_Question_Description__c"] as?String ?? ""
        SGWS_Answer__c = json["SGWS_Answer__c"] as? String ?? ""
        SGWS_Notes__c = json["SGWS_Notes__c"] as? String ?? ""
        LastModifiedById = json["LastModifiedById"] as? String ?? ""
        LastModifiedDate =  json["LastModifiedDate"] as? String ?? ""
        OwnerId = json["OwnerId"] as? String ?? ""
    }
    
    init(for: String) {
        Id = ""
        SGWS_Account__c = ""
        SGWS_Question__r_Id = ""
        SGWS_Answer_Options__r_Id = ""
        SGWS_Question__r_SGWS_Question_Type__c =  ""
        SGWS_Question__r_SGWS_Question_Sub_Type__c =  ""
        SGWS_Question_Description__c = ""
        SGWS_Answer__c = ""
        SGWS_Notes__c = ""
        LastModifiedById = ""
        LastModifiedDate = ""
        OwnerId = ""
        
}
}
