//
//  Opportunity.swift
//  SWSApp
//
//  Created by Thillaiganesh, C. on 07/06/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class Opportunity {

    static let opportunityFields: [String] = ["Id", "Name", "AccountId", "Account.Name", "CloseDate", "Candidate_Product__r.Name", "Objectives__r.Name", "SGWS_Objective_Type__c", "SGWS_Product_Name__c", "SGWS_Product_Description__c", "RecordType.Name", "Amount", "Type", "StageName", "SGWS_Month_Active__c", "SGWS_Commit__c", "SGWS_PYCM_Sold__c", "SGWS_R6_Trend__c", "SGWS_R3_Trend__c", "SGWS_Acct__c", "SGWS_Segment__c", "SGWS_Gap__c", "SGWS_Comparison_Segment__c", "SGWS_Sales_Trend__c", "SGWS_Order_Size__c", "SGWS_Frequency__c", "SGWS_Unsold_Period_Days__c", "SGWS_Sold__c", "SGWS_Source__c"]
    
    var id : String
    var name : String
    var accountId : String
    var accountName : String
    var closeDate : String
    var candidateProductName : String
    var ObjectivesName : String
    var ObjectivesType : String
    var productName : String
    var productDesc : String
    var recordTypeName : String
    var amount : String
    var type : String
    var stageName : String
    var monthActive : String
    var commit : String
    var PYCMSold : String
    var R6Trend : String
    var R3Trend : String
    var acct : String
    var segment : String
    var gap : String
    var comparisonSegment : String
    var salesTrend : String
    var orderSize : String
    var frequency : String
    var unsoldPeriodDays : String
    var sold : String
    var source : String
    
    convenience init(withAry ary: [Any]) {
        let resultDict = Dictionary(uniqueKeysWithValues: zip(Opportunity.opportunityFields, ary))
        self.init(json: resultDict)
    }
    
    init(json: [String: Any]) {
        
        id = json["Id"] as? String ?? ""
        name = json["Name"] as? String ?? ""
        accountId = json["AccountId"] as? String ?? ""
        accountName = json["Account.Name"] as? String ?? ""
        closeDate = json["CloseDate"] as? String ?? ""
        candidateProductName = json["Candidate_Product__r.Name"] as? String ?? ""
        ObjectivesName = json["Objectives__r.Name"] as? String ?? ""
        ObjectivesType = json["SGWS_Objective_Type__c"] as? String ?? ""
        productName = json["SGWS_Product_Name__c"] as? String ?? ""
        productDesc = json["SGWS_Product_Description__c"] as? String ?? ""
        recordTypeName = json["RecordType.Name"] as? String ?? ""
        amount = json["Amount"] as? String ?? ""
        type = json["Type"] as? String ?? ""
        stageName = json["StageName"] as? String ?? ""
        monthActive = json["SGWS_Month_Active__c"] as? String ?? ""
        commit = json["SGWS_Commit__c"] as? String ?? ""
        PYCMSold = json["SGWS_PYCM_Sold__c"] as? String ?? ""
        R6Trend = json["SGWS_R6_Trend__c"] as? String ?? ""
        R3Trend = json["SGWS_R3_Trend__c"] as? String ?? ""
        acct = json["SGWS_Acct__c"] as? String ?? ""
        segment = json["SGWS_Segment__c"] as? String ?? ""
        gap = json["SGWS_Gap__c"] as? String ?? ""
        comparisonSegment = json["SGWS_Comparison_Segment__c"] as? String ?? ""
        salesTrend = json["SGWS_Sales_Trend__c"] as? String ?? ""
        orderSize = json["SGWS_Order_Size__c"] as? String ?? ""
        frequency = json["SGWS_Frequency__c"] as? String ?? ""
        unsoldPeriodDays  = json["SGWS_Unsold_Period_Days__c"] as? String ?? ""
        sold = json["SGWS_Sold__c"] as? String ?? ""
        source = json["SGWS_Source__c"] as? String ?? ""

    }

    init(for: String) {
        
        id = ""
        name = ""
        accountId = ""
        accountName = ""
        closeDate = ""
        candidateProductName = ""
        ObjectivesName = ""
        ObjectivesType = ""
        productName = ""
        productDesc = ""
        recordTypeName = ""
        amount = ""
        type = ""
        stageName = ""
        monthActive = ""
        commit = ""
        PYCMSold = ""
        R6Trend = ""
        R3Trend = ""
        acct = ""
        segment = ""
        gap = ""
        comparisonSegment = ""
        salesTrend = ""
        orderSize = ""
        frequency = ""
        unsoldPeriodDays  = ""
        sold = ""
        source = ""

    }
    
}
