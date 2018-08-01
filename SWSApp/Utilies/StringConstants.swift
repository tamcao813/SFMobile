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
    static let deleteNoteConfirmation = "Are you sure you want to delete this note?"
    static let contactsSavedSuccessfully = "Your contact has been saved successfully"
    static let saveFail = ""
    static let deleteVisitMessage = "Deletion of Visit/Event has failed. Please try again or contact the National Service Desk if you experience an ongoing issue."
    static let deleteVisitNotAllowedMessage = "Deletion of a Visit/Event is not allowed in offline mode. Please try again when you are online."
    static let deleteEventMessage = "Deletion of Visit/Event has failed. Please try again or contact the National Service Desk if you experience an ongoing issue."
    static let deleteEventNotAllowedMessage = "Deletion of a Visit/Event is not allowed in offline mode. Please try again when you are online."
    static let unauthorisedLoginMessage = "You are not authorized to login to this application or do not have a SalesForce CRM account. Please contact the National Service Desk for assistance."
    
    static let topazAlertMessage = "Topaz is not installed or outdated version"
    
    static let workOrderIdNotExists = "You do not have permissions to delete this Visit/Event because you are not the record creator. Please contact the record creator to delete or contact the National Service Desk if you experience an ongoing issue."
    
    static let uiApiFailureMessage = "Saving of Visit/Event has failed. Please try again or contact the National Service Desk if you experience an ongoing issue.​"
    
    static var globalUrlDictionary : NSDictionary!
    
    //Chatter URL
    static let secureUrl = globalUrlDictionary["secureUrl"] as! String
    static let apexChatterUrl = globalUrlDictionary["apexChatterUrl"] as! String
    static let endUrl = globalUrlDictionary["endUrl"] as! String
    static let retUrl = globalUrlDictionary["retUrl"] as! String
    static let globalChatter = globalUrlDictionary["globalChatter"] as! String
    
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
    static let workOrderPlist = globalUrlDictionary["workOrderPlist"] as! String

    static let swsUri = globalUrlDictionary["swsUri"] as! String
    
    //HomeScreen URLS
    static let homeScreenUrl = globalUrlDictionary["homeScreenUrl"] as! String
    static let homeScreenBoBURL = globalUrlDictionary["homeScreenBoB"] as! String
    static let homeScreenWHWNURL = globalUrlDictionary["homeScreenWHWN"] as! String
    
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
    static let gospotItuneUrl = globalUrlDictionary["gospotItuneUrl"] as! String
    
    //Event URL
    static let eventUrl = globalUrlDictionary["eventUrl"] as! String
    
    //DetestServer Url
    static let detestServerUrl = globalUrlDictionary["detestServerUrl"] as! String
    
    //Alert for offline contact in Visits and Events
    static let checkContactId = globalUrlDictionary["visitContactAlertMessage"] as! String
    static let eventCheckContactId = globalUrlDictionary["eventContactAlertMessage"] as! String
    
    //Reports Url
    static let reportsUrl = globalUrlDictionary["reportsEndUrl"] as! String
    
    //Contact Role
    static let contactRole = globalUrlDictionary["contactRole"] as! String
    
}

