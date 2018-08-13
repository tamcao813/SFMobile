//
//  Opportunity.swift
//  SWSApp
//
//  Created by Thillaiganesh, C. on 07/06/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class Opportunity {

    static let opportunityFields: [String] = [ "Id", "Opportunity", "Product2" ]
    
    static let opportunityUploadSyncDownFields: [String] = [ "Id", "SGWS_Commit__c" ]
    static let opportunityUploadSyncUpFields: [String] = [ "SGWS_Commit__c" ]
//    static let opportunityUploadSyncUpFields: [String] = [ "Opportunity" ]

    var recordId: String
    var id: String
    var ownerId: String
    var accountId: String
    var source: String
    var PYCMSold: String
    var commit: String
    var sold: String
    var monthActive: String
    var status: String
    var R12: String
    var R6Trend: String
    var R3Trend: String
    var acct: String
    var segment: String
    var gap: String
    var salesTrend: String
    var orderSize: String
    var orderFrequency: String
    var unsoldPeriodDays: String

    var objectiveNames: String
    var objectiveTypes: String

    var productName: String
    var productID: String
    var itemBottlesPerCase: Float
    var itemSize: Float
    var brand: String

    var PYCMSold9L: String
    var commit9L: String
    var sold9L: String
    
    convenience init(withAry ary: [Any]) {
        let resultDict = Dictionary(uniqueKeysWithValues: zip(Opportunity.opportunityFields, ary))
        self.init(json: resultDict)
    }
    
    init(json: [String: Any]) {
        
        print("Opportunity : json : \(json)")
        
        recordId = json["Id"] as? String ?? ""
        id = ""
        ownerId = ""
        accountId = ""
        source = ""
        PYCMSold = ""
        commit = ""
        sold = ""
        monthActive = ""
        status = ""
        R12 = ""
        R6Trend = ""
        R3Trend = ""
        acct = ""
        segment = ""
        gap = ""
        salesTrend = ""
        orderSize = ""
        orderFrequency = ""
        unsoldPeriodDays = ""

        productName = ""
        productID = ""
        itemBottlesPerCase = 1.0
        itemSize = 0.0
        brand = ""

        PYCMSold9L = ""
        commit9L = ""
        sold9L = ""

        objectiveNames = ""
        objectiveTypes = ""
        
        if let jsonString = json["Opportunity"] as? String {
            do {
                if let object = try JSONSerialization.jsonObject(with: jsonString.data(using: .utf8)!, options: []) as? [String: Any] {
                    print("Opportunity : dictionary is : \(object)")
                    
                    processOpportunity(object)
                }
            } catch {
            }
        }

        if let jsonString = json["Product2"] as? String {
            do {
                if let object = try JSONSerialization.jsonObject(with: jsonString.data(using: .utf8)!, options: []) as? [String: Any] {
                    print("Product2 : dictionary is : \(object)")
                    
                    processOpportunityLineItems(object)
                }
            } catch {
            }
        }
        
        PYCMSold9L = valueAfter9Lcalculation(PYCMSold)
        commit9L = valueAfter9Lcalculation(commit)
        sold9L = valueAfter9Lcalculation(sold)
        
        processObjectiveJunction()
        
    }
    
    func processOpportunity(_ jsonDict: [String: Any]) {
        
        id = jsonDict["Id"] as? String ?? ""
        ownerId = jsonDict["OwnerId"] as? String ?? ""
        accountId = jsonDict["AccountId"] as? String ?? ""
        source = jsonDict["SGWS_Source__c"] as? String ?? ""
        PYCMSold = valueAfterConversionToString(jsonDict, key: "SGWS_PYCM_Sold__c")
        commit = valueAfterConversionToString(jsonDict, key: "SGWS_Commit__c")
        sold = valueAfterConversionToString(jsonDict, key: "SGWS_Sold__c")
        monthActive = jsonDict["SGWS_Month_Active__c"] as? String ?? ""
        status = jsonDict["StageName"] as? String ?? ""
        R12 = valueAfterConversionToString(jsonDict, key: "SGWS_R12__c")
        R6Trend = valueAfterConversionToString(jsonDict, key: "SGWS_R6_Trend__c")
        R3Trend = valueAfterConversionToString(jsonDict, key: "SGWS_R3_Trend__c")
        acct = valueAfterConversionToString(jsonDict, key: "SGWS_Acct__c")
        segment = valueAfterConversionToString(jsonDict, key: "SGWS_Segment__c")
        gap = valueAfterConversionToString(jsonDict, key: "SGWS_Gap__c")
        salesTrend = valueAfterConversionToString(jsonDict, key: "SGWS_Sales_Trend__c")
        orderSize = valueAfterConversionToString(jsonDict, key: "SGWS_Order_Size__c")
        orderFrequency = valueAfterConversionToString(jsonDict, key: "SGWS_Order_Frequency__c")
        unsoldPeriodDays = jsonDict["SGWS_Unsold_Period_Days__c"] as? String ?? ""
    }
    
    func processOpportunityLineItems(_ jsonDict: [String: Any]) {
        
        productID = jsonDict["Product2Id"] as? String ?? ""
        productName = jsonDict["Name"] as? String ?? ""
        
        itemBottlesPerCase = ((jsonDict["SGWS_CORP_ITEM_BOTTLES_PER_CASE__c"] as? String ?? "") as NSString).floatValue
        if itemBottlesPerCase == 0 {
            itemBottlesPerCase = 1.0
        }
        
        let bottlePerCase = jsonDict["SGWS_CORP_ITEM_SIZE__c"] as? String ?? ""
        if bottlePerCase == "" {
            itemSize = 1.0
        }
        else {
            itemSize = valueAfterConversionToLiters(bottlePerCase)
        }
        
        brand = jsonDict["SGWS_Corp_Brand__c"] as? String ?? ""
    }

    func processObjectiveJunction() {
        
        let opportunitiesList = OpportunityObjectiveSortUtility.filterOpportunityObjectiveByFilterByOpportunity(opportunityIdToBeFiltered: id)
        for object in opportunitiesList {
            
            if objectiveNames == "" {
                objectiveNames = object.ObjectiveName
            }
            else {
                objectiveNames = objectiveNames + ", " + object.ObjectiveName
            }

            if objectiveTypes == "" {
                objectiveTypes = object.ObjectiveType
            }
            else {
                objectiveTypes = objectiveTypes + ", " + object.ObjectiveType
            }
        }
    }
    
    // (<Value> * the Bottles Per Case for that product * the Size (in Liters) of that product) / 9
    func valueAfter9Lcalculation(_ valueToConvert: String) -> String {
        
        guard valueToConvert != "" else {
            return ""
        }

        let valueInt: Float = (valueToConvert as NSString).floatValue
        
        let finalInt: Float = (valueInt * itemBottlesPerCase * itemSize) / 9.0
        return String(format: "%.2f", finalInt)
    }

    func valueAfterConversionToLiters(_ valueToConvert: String) -> Float {
        
        guard valueToConvert != "" else {
            return 0.0
        }
        
        if let index = valueToConvert.range(of: "ML", options: .backwards)?.lowerBound {
            let substring = String(valueToConvert[..<index])
            let mlValue = (substring as NSString).floatValue
            return (mlValue/1000.0)
        }
        else if let index = valueToConvert.range(of: "L", options: .backwards)?.lowerBound {
            let substring = String(valueToConvert[..<index])
            return (substring as NSString).floatValue
        }

        return 0.0
    }
    
    func valueAfterConversionToString(_ jsonDict: [String: Any], key: String) -> String {
        
        var convertedString = jsonDict[key] as? String ?? ""
        if convertedString == "" {
            if let dValue: Double = jsonDict[key] as? Double {
                convertedString = String(dValue)
            }
        }

        return convertedString
    }
    
    init(for: String) {
        
        recordId = ""
        id = ""
        ownerId = ""
        accountId = ""
        source = ""
        PYCMSold = ""
        commit = ""
        sold = ""
        monthActive = ""
        status = ""
        R12 = ""
        R6Trend = ""
        R3Trend = ""
        acct = ""
        segment = ""
        gap = ""
        salesTrend = ""
        orderSize = ""
        orderFrequency = ""
        unsoldPeriodDays = ""

        objectiveNames = ""
        objectiveTypes = ""

        productName = ""
        productID = ""
        itemBottlesPerCase = 1.0
        itemSize = 0.0
        brand = ""

        PYCMSold9L = ""
        commit9L = ""
        sold9L = ""
        
    }

}
