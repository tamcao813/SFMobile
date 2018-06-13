//
//  Opportunity.swift
//  SWSApp
//
//  Created by Thillaiganesh, C. on 07/06/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class Opportunity {

    static let opportunityFields: [String] = [ "Id", "AccountId", "SGWS_Opportunity_source__c", "SGWS_PYCM_Sold__c", "SGWS_Commit__c", "SGWS_Sold__c", "SGWS_Month_Active__c", "SGWS_Status__c", "SGWS_R12__c", "SGWS_R6_Trend__c", "SGWS_R3_Trend__c", "Opportunity_Objective_Junction__r", "OpportunityLineItems" ]
    
    var id: String
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
    var isOpportunitySelected:Bool

    convenience init(withAry ary: [Any]) {
        let resultDict = Dictionary(uniqueKeysWithValues: zip(Opportunity.opportunityFields, ary))
        self.init(json: resultDict)
    }
    
    init(json: [String: Any]) {
        
        id = json["Id"] as? String ?? ""
        accountId = json["AccountId"] as? String ?? ""
        source = json["SGWS_Opportunity_source__c"] as? String ?? ""
        PYCMSold = json["SGWS_PYCM_Sold__c"] as? String ?? ""
        commit = json["SGWS_Commit__c"] as? String ?? ""
        sold = json["SGWS_Sold__c"] as? String ?? ""
        monthActive = json["SGWS_Month_Active__c"] as? String ?? ""
        status = json["SGWS_Status__c"] as? String ?? ""
        R12 = json["SGWS_R12__c"] as? String ?? ""
        R6Trend = json["SGWS_R6_Trend__c"] as? String ?? ""
        R3Trend = json["SGWS_R3_Trend__c"] as? String ?? ""
        isOpportunitySelected = false

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

        if !(json["Opportunity_Objective_Junction__r"] is NSNull) {
            if let jsonString = json["Opportunity_Objective_Junction__r"] as? String {
                do {
                    if let object = try JSONSerialization.jsonObject(with: jsonString.data(using: .utf8)!, options: []) as? [String: Any] {
                        print("Opportunity_Objective_Junction__r : dictionary is : \(object)")
                        
                        processObjectiveJunction(object)
                    }
                } catch {
                }
            }
        }

        if !(json["OpportunityLineItems"] is NSNull) {
            if let jsonString = json["OpportunityLineItems"] as? String {
                do {
                    if let object = try JSONSerialization.jsonObject(with: jsonString.data(using: .utf8)!, options: []) as? [String: Any] {
                        print("OpportunityLineItems : dictionary is : \(object)")
                        
                        processOpportunityLineItems(object)
                    }
                } catch {
                }
            }
        }

        PYCMSold9L = valueAfter9Lcalculation(PYCMSold)
        commit9L = valueAfter9Lcalculation(commit)
        sold9L = valueAfter9Lcalculation(sold)
        
    }
    
    func processObjectiveJunction(_ jsonDict: [String: Any]) {
        
        var namesString: String = ""
        var typesString: String = ""

        if let resultObj = jsonDict["records"] as? NSArray {
            print("resultObj is : \(resultObj)")
            
            for obj in resultObj {
                if let objDic = obj as? [String: Any] {
                    if let nameString = objDic["Name"] as? String {
                        if namesString == "" {
                            namesString = nameString
                        }
                        else {
                            namesString = namesString + ", " + nameString
                        }
                    }

                    if let typeString = objDic["SGWS_Select_Objective_Type__c"] as? String {
                        if typesString == "" {
                            typesString = typeString
                        }
                        else {
                            typesString = typesString + ", " + typeString
                        }
                    }
                }
            }
        }
        
        objectiveNames = namesString
        objectiveTypes = typesString
    }

    func processOpportunityLineItems(_ jsonDict: [String: Any]) {
        
        if let resultObj = jsonDict["records"] as? NSArray {
            print("resultObj is : \(resultObj)")
            
            if resultObj.count > 0 {
                if let productDic = resultObj[0] as? [String: Any] {
                    productID = productDic["Product2Id"] as? String ?? ""
                    
                    if let product2Dic = productDic["Product2"] as? [String: Any] {
                        productName = product2Dic["Name"] as? String ?? ""
                        
                        itemBottlesPerCase = ((product2Dic["SGWS_CORP_ITEM_BOTTLES_PER_CASE__c"] as? String ?? "") as NSString).floatValue
                        if itemBottlesPerCase == 0 {
                            itemBottlesPerCase = 1.0
                        }
                        
                        let bottlePerCase = product2Dic["SGWS_CORP_ITEM_SIZE__c"] as? String ?? ""
                        itemSize = valueAfterConversionToLiters(bottlePerCase)
                        
                        brand = product2Dic["SGWS_Corp_Brand__c"] as? String ?? ""
                    }
                }
            }
        }
    }
    
    // (<Value> * the Bottles Per Case for that product * the Size (in Liters) of that product) / 9
    func valueAfter9Lcalculation(_ valueToConvert: String) -> String {
        
        guard valueToConvert != "" else {
            return ""
        }

        let valueInt: Float = (valueToConvert as NSString).floatValue
        
        return String(format: "%.2f", String((valueInt * itemBottlesPerCase * itemSize) / 9.0))
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
    
    init(for: String) {
        
        id = ""
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
        isOpportunitySelected = false

    }

}
