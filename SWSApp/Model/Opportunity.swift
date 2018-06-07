//
//  Opportunity.swift
//  SWSApp
//
//  Created by Thillaiganesh, C. on 07/06/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class Opportunity {

    static let opportunityFields: [String] = ["Id", "Name", "AccountId", "CloseDate", "Candidate_Product__c", "Amount", "Type", "StageName", "SGWS_Commit__c"]
    
    var id : String
    var name : String
    var accountId : String
    var closeDate : String
    var candidateProduct : String
    var amount : String
    var type : String
    var stageName : String
    var commit : String

    
    convenience init(withAry ary: [Any]) {
        let resultDict = Dictionary(uniqueKeysWithValues: zip(Opportunity.opportunityFields, ary))
        self.init(json: resultDict)
    }
    
    init(json: [String: Any]) {
        
        id = json["Id"] as? String ?? ""
        name = json["Name"] as? String ?? ""
        accountId = json["AccountId"] as? String ?? ""
        closeDate = json["CloseDate"] as? String ?? ""
        candidateProduct = json["Candidate_Product__c"] as? String ?? ""
        amount = json["Amount"] as? String ?? ""
        type = json["Type"] as? String ?? ""
        stageName = json["StageName"] as? String ?? ""
        commit = json["SGWS_Commit__c"] as? String ?? ""

    }

    init(for: String) {
        
        id = ""
        name = ""
        accountId = ""
        closeDate = ""
        candidateProduct = ""
        amount = ""
        type = ""
        stageName = ""
        commit = ""

    }
    
}
