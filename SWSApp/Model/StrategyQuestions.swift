//
//  StrategyQuestions.swift
//  SWSApp
//
//  Created by shubham.e.shukla on 5/2/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation
class StrategyQuestions {
    static let StrategyQuestionsFields: [String] = ["Id","Name","SGWS_Deactivate__c","SGWS_Question_Description__c","SGWS_Question_Sub_Type__c","SGWS_Question_Type__c","SGWS_Sorting_Order__c","SGWS_Survey_ID__c","SGWS_Answer__c","SGWS_Answer_Type__c"]
    
    var Id:String
    var Name:String
    var SGWS_Deactivate__c: String
    var SGWS_Question_Description__c: String
    var SGWS_Question_Sub_Type__c: String
    var SGWS_Question_Type__c: String
    var SGWS_Sorting_Order__c:String
    var SGWS_Survey_ID__c:String
    var SGWS_Answer__c : String
    var SGWS_Answer_Type__c : String
    
    
    convenience init(withAry ary: [Any]) {
        let resultDict = Dictionary(uniqueKeysWithValues: zip(StrategyQuestions.StrategyQuestionsFields, ary))
        self.init(json: resultDict)
    }
    
    init(json: [String: Any]) {
        Id = json["Id"] as? String ?? ""
        Name = json["Name"] as? String ?? ""
        SGWS_Deactivate__c = json["SGWS_Deactivate__c"] as? String ?? ""
        SGWS_Question_Description__c = json["SGWS_Question_Description__c"] as? String ?? ""
        SGWS_Question_Sub_Type__c = json["SGWS_Question_Sub_Type__c"] as? String ?? ""
        SGWS_Question_Type__c = json["SGWS_Question_Type__c"] as? String ?? ""
        SGWS_Sorting_Order__c = json["SGWS_Sorting_Order__c"] as?String ?? ""
        SGWS_Survey_ID__c = json["SGWS_Survey_ID__c"] as? String ?? ""
        SGWS_Answer__c = json["SGWS_Answer__c"] as? String ?? ""
        SGWS_Answer_Type__c = json["SGWS_Answer_Type__c"] as? String ?? ""
    }
    
    init(for: String) {
        Id = ""
        Name = ""
        SGWS_Deactivate__c = ""
        SGWS_Question_Description__c = ""
        SGWS_Question_Sub_Type__c =  ""
        SGWS_Question_Type__c =  ""
        SGWS_Sorting_Order__c = ""
        SGWS_Survey_ID__c = ""
        SGWS_Answer__c = ""
        SGWS_Answer_Type__c = ""
    }
}
