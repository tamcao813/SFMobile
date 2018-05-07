//
//  PlanVistManager.swift
//  SWSApp
//
//  Created by vipin.vijay on 03/05/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

class PlanVistManager {
    static let sharedInstance = PlanVistManager()
    
    var userInfo = (ID: "bobthedev", Password: 01036343984)
    var visit:Visit? = Visit(for: "")
    var editPlanVisit = false
    var Id = ""
    var subject = ""
    var accountId = ""
    var accountName = ""
    var accountNumber = ""
    var accountBillingAddress = ""
    var contactId = ""
    var contactName = ""
    var contactPhone = ""
    var contactEmail = ""
    var contactSGWS_Roles = ""
    var sgwsAppointmentStatus = ""
    var startDate = ""
    var endDate = ""
    var sgwsVisitPurpose = ""
    var description = ""
    var sgwsAgendaNotes = ""
    var status = ""
    var lastModifiedDate = ""
    var userID = ""
    // Networking: communicating server
    func network() {
        // get everything
    }
    
    init() {
        print("CloudCodeExecutor has been initialized")
    }
}
