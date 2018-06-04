//
//  StringConstants.swift
//  SWSApp
//
//  Created by manu.a.gupta on 27/04/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation

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
    
    
    //Chatter URL
    static let secureUrl = "/secur/frontdoor.jsp?sid="
    static let apexChatterUrl = "&retURL=/apex/sgwsACNChatter?id="
    static let endUrl = "/one/one.app?source=alohaHeader#/sObject/Event/home"
    static let retUrl = "&retURL="
    
    //During Visit
    static let googleUrl = "http://www.google.com"
    
    //Store Dispatcher
    static let contactPicklistValue = "ui-api/object-info/Contact/picklist-values/"
    static let rules = "/SGWS_Roles__c"
    static let serviceUrl = "/services/data/v41.0/"
    static let contactRolesPlist = "/ContactRoles.plist"
    
    static let preferredCommunicationUrl = "/SGWS_Preferred_Communication_Method__c"
    static let contactClassification = "/SGWS_Contact_Classification__c"
    static let contactPreferredPlist = "/ContactPreferred.plist"
    static let contactClassificationPlist = "/ContactClassification.plist"
    
    static let workorderPicklistValue = "ui-api/object-info/WorkOrder/picklist-values/"
    static let visitPurpose = "/SGWS_Visit_Purpose__c"
    static let accountVisitPurposePlist = "/AccountVisitPurpose.plist"

}


