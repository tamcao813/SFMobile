//
//  StrategyAnswers.swift
//  SWSApp
//
//  Created by shubham.e.shukla on 5/2/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation
class StrategyAnswers {
    static let StrategyAnswersFields: [String] = ["Id","Name","SGWS_Answer_Description__c","SGWS_Deactivate_Answer__c","SGWS_Question_Description__c","SGWS_Question__c"]
    
    var Id:String
    var Name:String
    var SGWS_Answer_Description__c: String
    var SGWS_Deactivate_Answer__c: String
    var SGWS_Question_Description__c: String
    var SGWS_Question__c:String
    
    
    
    
    convenience init(withAry ary: [Any]) {
        let resultDict = Dictionary(uniqueKeysWithValues: zip(StrategyQA.StrategyQAFields, ary))
        self.init(json: resultDict)
    }
    
    init(json: [String: Any]) {
        Id = json["Id"] as? String ?? ""
        Name = json["Name"] as? String ?? ""
        SGWS_Answer_Description__c = json["SGWS_Answer_Description__c"] as? String ?? ""
        SGWS_Deactivate_Answer__c = json["SGWS_Deactivate_Answer__c"] as? String ?? ""
        SGWS_Question_Description__c = json["SGWS_Question_Description__c"] as? String ?? ""
        SGWS_Question__c = json["SGWS_Question__c"] as?String ?? ""
        
        
    }
    
    init(for: String) {
        Id = ""
        Name = ""
        SGWS_Answer_Description__c = ""
        SGWS_Deactivate_Answer__c =  ""
        SGWS_Question_Description__c =  ""
        SGWS_Question__c = ""
       
        
        
    }
}
