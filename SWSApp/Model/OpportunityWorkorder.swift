//
//  OpportunityWorkorder.swift
//  SWSApp
//
//  Created by Thillaiganesh, C. on 13/06/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class OpportunityWorkorder {

    static let opportunityWorkorderFields: [String] = [ "Id", "SGWS_Opportunity__c", "SGWS_Work_Order__c", "SGWS_Outcome__c" ]
    static let opportunityWorkorderSyncUpFields: [String] = [ "SGWS_Opportunity__c", "SGWS_Work_Order__c", "SGWS_Outcome__c" ]

    var id: String
    var opportunityId: String
    var workOrder: String
    var outcome: String

    convenience init(withAry ary: [Any]) {
        
        let resultDict = Dictionary(uniqueKeysWithValues: zip(Opportunity.opportunityFields, ary))
        self.init(json: resultDict)
    }
    
    init(json: [String: Any]) {
        
        print("OpportunityWorkorder : json : \(json)")
        
        id = json["Id"] as? String ?? ""
        opportunityId = json["SGWS_Opportunity__c"] as? String ?? ""
        if opportunityId == "" {
            opportunityId = json["AccountId"] as? String ?? ""
        }
        workOrder = json["SGWS_Work_Order__c"] as? String ?? ""
        if workOrder == "" {
            workOrder = json["sgws_source__c"] as? String ?? ""
        }
        outcome = json["SGWS_Outcome__c"] as? String ?? ""
        if outcome == "" {
            outcome = json["SGWS_PYCM_Sold__c"] as? String ?? ""
        }
    }
    
    init(for: String) {
        
        id = ""
        opportunityId = ""
        workOrder = ""
        outcome = ""
    }

}
