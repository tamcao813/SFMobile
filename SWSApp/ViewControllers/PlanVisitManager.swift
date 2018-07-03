//
//  PlanVisitManager.swift
//  SWSApp
//
//  Created by vipin.vijay on 03/05/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import SmartSync

struct VisitModelForUIAPI {
    static var isEditMode = false
}

class PlanVisitManager {
    static let sharedInstance = PlanVisitManager()
    
    var visit:WorkOrderUserObject? = WorkOrderUserObject(for: "")
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
    var workOrderType = ""
    var startLatitude = 0.0
    var startLongitude = 0.0
    var endLatitude = 0.0
    var endLongitude = 0.0
    
    // Networking: communicating server
    func network() {
        // get everything
    }
    
    init() {
        print("CloudCodeExecutor has been initialized")
    }
    
    func editAndSaveVisit()->Bool{
        //Check is it getting called for Edit Mode if yes , if network available call UI API else Show Alert
        if VisitModelForUIAPI.isEditMode{
            VisitModelForUIAPI.isEditMode = false
            if AppDelegate.isConnectedToNetwork(){
                
                //Check the Visit/Event is created Locally which is not synced up
                if StoreDispatcher.shared.isWorkOrderSynced(id: visit!.Id){
                    
                    self.editAndSaveVisitData()
                    
                }else{
                    //Call UI API , after success of that Save in Local
                    StoreDispatcher.shared.editVisitFromOutlook(VisitData: visit!) { (data) in
                        if data == nil{
                            //Success Save to DB
                            self.editAndSaveVisitData()
                            
                        }else{
                            //Failure Show Alert
                            let alert = UIAlertView()
                            alert.title = "Alert"
                            alert.message = "Saving of Visit has failed, Please try again"
                            alert.addButton(withTitle: "OK")
                            alert.show()
                            
                        }
                    }
                }
            }
            
        }else{
            self.editAndSaveVisitData()
        }
        return true
    }
    
    func editAndSaveVisitData(){
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000+0000"
        let timeStamp = dateFormatter.string(from: date)
        
        let new_visit = PlanVisit(for: "newVisit")
        new_visit.soupEntryId = (visit?.soupEntryId)!
        new_visit.Id = (visit?.Id)!
        new_visit.subject = (visit?.subject)!
        new_visit.accountId = visit!.accountId
        new_visit.sgwsAppointmentStatus = (visit?.sgwsAppointmentStatus)!
        new_visit.startDate =  (visit?.startDate)!
        new_visit.endDate = (visit?.endDate)!
        new_visit.sgwsVisitPurpose = (PlanVisitManager.sharedInstance.visit?.sgwsVisitPurpose)!
        new_visit.sgwsAgendaNotes = (PlanVisitManager.sharedInstance.visit?.sgwsAgendaNotes)!
        new_visit.status = (visit?.status)!
        new_visit.description = (visit?.description)!
        new_visit.contactId = (visit?.contactId)!
        new_visit.lastModifiedDate = timeStamp
        new_visit.recordTypeId = (visit?.recordTypeId)!
        new_visit.location = (visit?.location)!
        new_visit.sgwsAlldayEvent = (visit?.sgwsAlldayEvent)!
        
        if (visit?.status)! == "In-Progress" &&
            (geoLocationForVisit.lastVisitStatus == "Scheduled" ||
            geoLocationForVisit.lastVisitStatus == "Planned") {
            new_visit.startLatitude = geoLocationForVisit.startLatitude
            new_visit.startLongitude = geoLocationForVisit.startLongitude
            new_visit.startTime_of_Visit = geoLocationForVisit.startTime
        }
        else if (visit?.status)! == "Completed" {
            new_visit.endLatitude =  geoLocationForVisit.endLatitude
            new_visit.endLongitude = geoLocationForVisit.endLongitude
            new_visit.endTime_of_Visit = DateTimeUtility.getCurrentTimeStampInUTCAsString()
        }
        
        let attributeDict = ["type":"WorkOrder"]
        
        let addNewDict: [String:Any] = [
            
            PlanVisit.planVisitFields[0]: new_visit.Id,
            PlanVisit.planVisitFields[1]: new_visit.subject,
            PlanVisit.planVisitFields[2]: new_visit.accountId,
            PlanVisit.planVisitFields[3]: new_visit.sgwsAppointmentStatus,
            PlanVisit.planVisitFields[4]: new_visit.startDate,
            PlanVisit.planVisitFields[5]: new_visit.endDate,
            PlanVisit.planVisitFields[6]: new_visit.sgwsVisitPurpose,
            PlanVisit.planVisitFields[7]: new_visit.description,
            PlanVisit.planVisitFields[8]: new_visit.sgwsAgendaNotes,
            PlanVisit.planVisitFields[9]: new_visit.status,
            PlanVisit.planVisitFields[10]:new_visit.lastModifiedDate,
            PlanVisit.planVisitFields[11]: new_visit.contactId,
            PlanVisit.planVisitFields[12]:new_visit.recordTypeId,
            PlanVisit.planVisitFields[13]:new_visit.soupEntryId,
            PlanVisit.planVisitFields[14]:new_visit.location,
            PlanVisit.planVisitFields[15]:new_visit.sgwsAlldayEvent,
            PlanVisit.planVisitFields[21]:new_visit.startLatitude,
            PlanVisit.planVisitFields[22]:new_visit.startLongitude,
            PlanVisit.planVisitFields[23]:new_visit.startTime_of_Visit,
            PlanVisit.planVisitFields[24]:new_visit.endLatitude,
            PlanVisit.planVisitFields[25]:new_visit.endLongitude,
            PlanVisit.planVisitFields[26]:new_visit.endTime_of_Visit,
            
            
            
            kSyncTargetLocal:true,
            kSyncTargetLocallyCreated:true,
            kSyncTargetLocallyUpdated:false,
            kSyncTargetLocallyDeleted:false,
            "attributes":attributeDict]
        
        let success = VisitSchedulerViewModel().editVisitToSoup(fields: addNewDict)
        let visitDataDict:[String: WorkOrderUserObject] = ["visit": visit!]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshAccountVisit"), object:nil, userInfo: visitDataDict)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshAccountOverView"), object:nil)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshVisitEventList"), object:nil)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshCalendar"), object:nil)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "REFRESH_MONTH_CALENDAR"), object:nil)
        
        print("Success is here \(success)")
        
    }
    
}
