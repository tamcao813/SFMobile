//
//  OpportunityObjective.swift
//  SWSApp
//
//  Created by Thillaiganesh, C. on 03/07/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class OpportunityObjective {

//    static let opportunityObjectiveFields: [String] = [ "Id", "OpportunityId", "ObjectiveName", "ObjectiveType" ]
    static let opportunityObjectiveFields: [String] = [ "Id", "SGWS_Opportunity__r", "SGWS_Objectives__r" ]

    var recordId: String
    var OpportunityId: String
    var ObjectiveName: String
    var ObjectiveType: String
    
    convenience init(withAry ary: [Any]) {
        
        let resultDict = Dictionary(uniqueKeysWithValues: zip(OpportunityObjective.opportunityObjectiveFields, ary))
        self.init(json: resultDict)
    }
    
    init(json: [String: Any]) {
        
        print("OpportunityObjective : json : \(json)")
        
        recordId = json["Id"] as? String ?? ""
        OpportunityId = ""
        ObjectiveName = ""
        ObjectiveType = ""
        
        if let jsonString = json["SGWS_Opportunity__r"] as? String {
            do {
                if let object = try JSONSerialization.jsonObject(with: jsonString.data(using: .utf8)!, options: []) as? [String: Any] {
                    print("SGWS_Opportunity__r : dictionary is : \(object)")
                    
                    processOpportunity(object)
                }
            } catch {
            }
        }

        if let jsonString = json["SGWS_Objectives__r"] as? String {
            do {
                if let object = try JSONSerialization.jsonObject(with: jsonString.data(using: .utf8)!, options: []) as? [String: Any] {
                    print("SGWS_Objectives__r : dictionary is : \(object)")
                    
                    processObjectiveJunction(object)
                }
            } catch {
            }
        }

    }
    
    init(for: String) {
        
        recordId = ""
        OpportunityId = ""
        ObjectiveName = ""
        ObjectiveType = ""
    }
    
    func processOpportunity(_ jsonDict: [String: Any]) {
        
        OpportunityId = jsonDict["Id"] as? String ?? ""
    }
    
    func processObjectiveJunction(_ jsonDict: [String: Any]) {
        
        ObjectiveName = jsonDict["Name"] as? String ?? ""
        ObjectiveType = jsonDict["SGWS_Select_Objective_Type__c"] as? String ?? ""        
    }
    
}
