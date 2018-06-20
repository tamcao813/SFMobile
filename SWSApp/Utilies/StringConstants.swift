//
//  StringConstants.swift
//  SWSApp
//
//  Created by manu.a.gupta on 27/04/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation
import UIKit

class StringConstants {
    
    static let emptyFieldError = "Please correct required fields"
    static let emptyFieldInNoted = "Please correct required fields"
    static let errorInField = "Please correct error above"
    static let invalidName = "Please enter a valid name"
    static let invalidEmail = "Please enter a valid email"
    static let invalidDate = "Please enter a valid date"
    static let discardChangesConfirmation = "Any changes will not be saved. Are you sure you want to close?"
    static let deleteConfirmation = "Are you sure you want to delete?"
    static let contactsSavedSuccessfully = "Your contact has been saved successfully"
    static let saveFail = ""
    
    static var globalUrlDictionary : NSDictionary!
    
    //Chatter URL
    static let secureUrl = globalUrlDictionary["secureUrl"] as! String
    static let apexChatterUrl = globalUrlDictionary["apexChatterUrl"] as! String
    static let endUrl = globalUrlDictionary["endUrl"] as! String
    static let retUrl = globalUrlDictionary["retUrl"] as! String
    
    //During Visit
    static let googleUrl = globalUrlDictionary["googleUrl"] as! String
    
    //Store Dispatcher
    static let contactPicklistValue = globalUrlDictionary["contactPicklistValue"] as! String
    static let outcomePicklistValue = globalUrlDictionary["outcomePicklistValue"] as! String
    static let rules = globalUrlDictionary["rules"] as! String
    static let serviceUrl = globalUrlDictionary["serviceUrl"] as! String
    static let contactRolesPlist = globalUrlDictionary["contactRolesPlist"] as! String
    
    static let preferredCommunicationUrl = globalUrlDictionary["preferredCommunicationUrl"] as! String
    static let contactClassification = globalUrlDictionary["contactClassification"] as! String
    static let contactPreferredPlist = globalUrlDictionary["contactPreferredPlist"] as! String
    static let contactClassificationPlist = globalUrlDictionary["contactClassificationPlist"] as! String
    
    static let workorderPicklistValue = globalUrlDictionary["workorderPicklistValue"] as! String
    static let visitPurpose = globalUrlDictionary["visitPurpose"] as! String
    static let accountVisitPurposePlist = globalUrlDictionary["accountVisitPurposePlist"] as! String

    static let swsUri = globalUrlDictionary["swsUri"] as! String
    
    //HomeScreen URLS
    static let goalsUrl = globalUrlDictionary["homeScreenUrl"] as! String
    static let netSalesUrl = globalUrlDictionary["netSalesUrl"] as! String
    
    //Objectives URLS
    static let objectivesUrl = globalUrlDictionary["objectivesUrl"] as! String
    
    //Insights URLS
    static let insightsUrl = globalUrlDictionary["insightsUrl"] as! String
    static let insightsAccountUrl = globalUrlDictionary["insightsAccountUrl"] as! String
    //Opportunities
    static let opportunitiesUrl = globalUrlDictionary["opportunitiesUrl"] as! String
    static let opportunityEndUrl = globalUrlDictionary["opportunityEndUrl"] as! String
    
    //User Title or Roles
    static let salesConsultantTitle = globalUrlDictionary["salesConsultantTitle"] as! String
    static let salesManagerTitle = globalUrlDictionary["salesManagerTitle"] as! String

    static let sgwsOutcome = globalUrlDictionary["sgwsOutcome"] as! String
    
    //Gospotcheck and topaz url
    static let gospotcheckUrl = globalUrlDictionary["gospotcheckUrl"] as! String
    static let topazUrl = globalUrlDictionary["topazUrl"] as! String
}

