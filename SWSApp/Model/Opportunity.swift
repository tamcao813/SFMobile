//
//  Opportunity.swift
//  SWSApp
//
//  Created by Thillaiganesh, C. on 07/06/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class Opportunity {

    static let opportunityFields: [String] = [ "Id", "AccountId", "SGWS_Product_Name__c", "SGWS_Opportunity_source__c", "SGWS_PYCM_Sold__c", "SGWS_Commit__c", "SGWS_Sold__c", "SGWS_Month_Active__c", "SGWS_Status__c", "SGWS_R12__c", "SGWS_R6_Trend__c", "SGWS_R3_Trend__c", "Opportunity_Objective_Junction__r" ]
    
    var id: String
    var accountId: String
    var productName: String
    var source: String
    var PYCMSold: String
    var commit: String
    var sold: String
    var monthActive: String
    var status: String
    var R12: String
    var R6Trend: String
    var R3Trend: String
    var objectiveJunction: String

    var PYCMSold9L: String
    var commit9L: String
    var sold9L: String

    convenience init(withAry ary: [Any]) {
        let resultDict = Dictionary(uniqueKeysWithValues: zip(Opportunity.opportunityFields, ary))
        self.init(json: resultDict)
    }
    
    init(json: [String: Any]) {
        
        id = json["Id"] as? String ?? ""
        accountId = json["AccountId"] as? String ?? ""
        productName = json["SGWS_Product_Name__c"] as? String ?? ""
        source = json["SGWS_Opportunity_source__c"] as? String ?? ""
        PYCMSold = json["SGWS_PYCM_Sold__c"] as? String ?? ""
        commit = json["SGWS_Commit__c"] as? String ?? ""
        sold = json["SGWS_Sold__c"] as? String ?? ""
        monthActive = json["SGWS_Month_Active__c"] as? String ?? ""
        status = json["SGWS_Status__c"] as? String ?? ""
        R12 = json["SGWS_R12__c"] as? String ?? ""
        R6Trend = json["SGWS_R6_Trend__c"] as? String ?? ""
        R3Trend = json["SGWS_R3_Trend__c"] as? String ?? ""
        objectiveJunction = ""

        PYCMSold9L = ""
        commit9L = ""
        sold9L = ""

        PYCMSold9L = valueAfter9Lcalculation(PYCMSold)
        commit9L = valueAfter9Lcalculation(commit)
        sold9L = valueAfter9Lcalculation(sold)

        if !(json["Opportunity_Objective_Junction__r"] is NSNull) {
            if let jsonString = json["Opportunity_Objective_Junction__r"] as? String {
                do {
                    if let object = try JSONSerialization.jsonObject(with: jsonString.data(using: .utf8)!, options: []) as? [String: Any] {
                        print("dictionary is : \(object)")
                        
                        objectiveJunction = processObjectiveJunction(object)
                        print("objectiveJunction is \(objectiveJunction)")
                    }
                } catch {
                }
            }
        }

    }
    
    func processObjectiveJunction(_ jsonDict: [String: Any]) -> String {
        
        var resultString: String = ""
        
        if let resultObj = jsonDict["records"] as? NSArray {
            print("resultObj is : \(resultObj)")
            
            for obj in resultObj {
                if let objDic = obj as? [String: Any] {
                    if let nameString = objDic["Name"] as? String {
                        if resultString == "" {
                            resultString = nameString
                        }
                        else {
                            resultString = resultString + ", " + nameString
                        }
                    }
                }
            }
        }
        
        return resultString
    }

    // (<Value> * the Bottles Per Case for that product * the Size (in Liters) of that product) / 9
    func valueAfter9Lcalculation(_ valueToConvert: String) -> String {
        
        // TBD to check for null values input values
        
        let valueInt: Int = (valueToConvert as NSString).integerValue
        let bottlesPerCaseInt: Int = 1 // (valueToConvert as NSString).integerValue //TBD not sure with column mapping
        let sizeInt: Int = 1 // (opportunityDetails.orderSize as NSString).integerValue
        
        return String((valueInt * bottlesPerCaseInt * sizeInt) / 9)
    }

    init(for: String) {
        
        id = ""
        accountId = ""
        productName = ""
        source = ""
        PYCMSold = ""
        commit = ""
        sold = ""
        monthActive = ""
        status = ""
        R12 = ""
        R6Trend = ""
        R3Trend = ""
        objectiveJunction = ""

        PYCMSold9L = ""
        commit9L = ""
        sold9L = ""

    }

}
