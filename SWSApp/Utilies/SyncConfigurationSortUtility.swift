//
//  SyncConfigurationSortUtility.swift
//  SWSApp
//
//  Created by Thillaiganesh, C. on 29/05/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class SyncConfigurationSortUtility {
    
    static func searchSyncConfigurationByRecordTypeId(_ recordTypeId: String) -> SyncConfiguration?
    {
        
        let syncConfigurationList = SyncConfigurationViewModel().syncConfiguration().filter( { return $0.id == recordTypeId } )
        if syncConfigurationList.count > 0 {
            return syncConfigurationList[0]
        }
        else {
            return nil
        }
        
    }
    
    static func searchSyncConfigurationByRecordTypeId(syncConfigurationList: [SyncConfiguration], recordTypeId: String) -> SyncConfiguration?
    {
        
        let syncConfigurationList = syncConfigurationList.filter( { return $0.recordTypeId == recordTypeId } )
        if syncConfigurationList.count > 0 {
            return syncConfigurationList[0]
        }
        else {
            return nil
        }
        
    }
    
    static func searchSyncConfigurationByDeveloperName(syncConfigurationList: [SyncConfiguration], developerName: String) -> SyncConfiguration?
    {
        
        let syncConfigurationList = syncConfigurationList.filter( { return $0.developerName ==  developerName} )
        if syncConfigurationList.count > 0 {
            return syncConfigurationList[0]
        }
        else {
            return nil
        }
        
    }
    
    static func getActionItemDataUsingSyncTime(objectArray: Array<ActionItem>) -> Array<ActionItem>  {
        
        let globalSyncConfigurationList = SyncConfigurationViewModel().syncConfiguration()
        let isManager:Bool = UserViewModel().consultants.count > 0
        
        let objectArray = objectArray.filter {
            if let systemConfigurationObject = SyncConfigurationSortUtility.searchSyncConfigurationByRecordTypeId(syncConfigurationList: globalSyncConfigurationList, recordTypeId: $0.recordTypeId) {
                if systemConfigurationObject.developerName == "SGWS_Task" {
                    if isManager {
                        if !systemConfigurationObject.salesManagerSyncFrom.isEmpty {
                            let prevMonthDate = Date().add(component: .day, value: -Int((systemConfigurationObject.salesManagerSyncFrom as NSString).floatValue))
                            let next3MonthDate = Date().add(component: .day, value: Int((systemConfigurationObject.salesManagerSyncTo as NSString).floatValue))
                            if let startDate = $0.dateStart {
                                if startDate.isLater(than: prevMonthDate), startDate.isEarlier(than: next3MonthDate) {
                                    return true
                                }
                                else {
                                    return false
                                }
                            }
                            else{
                                return true
                            }                            
                        } else {
                            let prevMonthDate = Date().add(component: .month, value: -1)
                            let next3MonthDate = Date().add(component: .month, value: 3)
                            /* REPLACE dateStart With YOUR DATE PROPERTY */
                            if let startDate = $0.dateStart {
                                if startDate.isLater(than: prevMonthDate), startDate.isEarlier(than: next3MonthDate) {
                                    return true
                                }
                                else {
                                    return false
                                }
                            }
                            else{
                                return true
                            }
                        }
                    }else {
                        if !systemConfigurationObject.salesConsultantSyncFrom.isEmpty {
                            let prevMonthDate = Date().add(component: .day, value: -Int((systemConfigurationObject.salesConsultantSyncFrom as NSString).floatValue))
                            let next3MonthDate = Date().add(component: .day, value: Int((systemConfigurationObject.salesConsultantSyncTo as NSString).floatValue))
                            /* REPLACE dateStart With YOUR DATE PROPERTY */
                            if let startDate = $0.dateStart{
                                if startDate.isLater(than: prevMonthDate), startDate.isEarlier(than: next3MonthDate) {
                                    return true
                                }
                                else {
                                    return false
                                }
                            }else{
                                return true
                            }
                            
                            
                        } else {
                            let prevMonthDate = Date().add(component: .month, value: -1)
                            let next3MonthDate = Date().add(component: .month, value: 3)
                            /* REPLACE dateStart With YOUR DATE PROPERTY */
                            if let startDate = $0.dateStart {
                                if startDate.isLater(than: prevMonthDate), startDate.isEarlier(than: next3MonthDate) {
                                    return true
                                }
                                else {
                                    return false
                                }
                            }
                            else{
                                return true
                            }
                        }
                    }
                }
            }
            return false
        }
        return objectArray
    }
    
    static func getNotificationDataUsingSyncTime(objectArray: Array<Notifications>) -> Array<Notifications>  {
        
        let globalSyncConfigurationList = SyncConfigurationViewModel().syncConfiguration()
        let isManager:Bool = UserViewModel().consultants.count > 0
        var recordTypeId = ""
        
        let recordTypeIdArray = RecordTypeViewModel().getRecordTypeForDeveloper()
        let notficationRecordTypeId = recordTypeIdArray.filter( { return $0.developerName == "SGWS_Notification" } )
        recordTypeId = notficationRecordTypeId[0].Id
        if recordTypeId == ""{
            return
        }
        let objectArray = objectArray.filter {
            if let systemConfigurationObject = SyncConfigurationSortUtility.searchSyncConfigurationByRecordTypeId(syncConfigurationList: globalSyncConfigurationList, recordTypeId: recordTypeId) {
                if isManager {
                    if !systemConfigurationObject.salesManagerSyncFrom.isEmpty {
                        let prevMonthDate = Date().add(component: .day, value: -Int((systemConfigurationObject.salesManagerSyncFrom as NSString).floatValue))
                        let next3MonthDate = Date().add(component: .day, value: Int((systemConfigurationObject.salesManagerSyncTo as NSString).floatValue))
                        
                        /* REPLACE dateStart With YOUR DATE PROPERTY */
                        if let startDate = $0.createdDataInDateType {
                            if startDate.isLater(than: prevMonthDate), startDate.isEarlier(than: next3MonthDate) {
                                return true
                            }
                            else {
                                return false
                            }
                        }
                        
                    } else {
                        let prevMonthDate = Date().add(component: .month, value: -1)
                        let next3MonthDate = Date().add(component: .month, value: 3)
                        /* REPLACE dateStart With YOUR DATE PROPERTY */
                        if let startDate = $0.createdDataInDateType {
                            if startDate.isLater(than: prevMonthDate), startDate.isEarlier(than: next3MonthDate) {
                                return true
                            }
                            else {
                                return false
                            }
                        }
                    }
                } else {
                    if !systemConfigurationObject.salesConsultantSyncFrom.isEmpty {
                        let prevMonthDate = Date().add(component: .day, value: -Int((systemConfigurationObject.salesConsultantSyncFrom as NSString).floatValue))
                        let next3MonthDate = Date().add(component: .day, value: Int((systemConfigurationObject.salesConsultantSyncTo as NSString).floatValue))
                        /* REPLACE dateStart With YOUR DATE PROPERTY */
                        if let startDate = $0.createdDataInDateType {
                            if startDate.isLater(than: prevMonthDate), startDate.isEarlier(than: next3MonthDate) {
                                return true
                            }
                            else {
                                return false
                            }
                        }
                        
                        
                    } else {
                        let prevMonthDate = Date().add(component: .month, value: -1)
                        let next3MonthDate = Date().add(component: .month, value: 3)
                        /* REPLACE dateStart With YOUR DATE PROPERTY */
                        if let startDate = $0.createdDataInDateType {
                            if startDate.isLater(than: prevMonthDate), startDate.isEarlier(than: next3MonthDate) {
                                return true
                            }
                            else {
                                return false
                            }
                        }
                        
                    }
                }
            }
            return false
        }
        
        return objectArray
    }
    
    static func getAccountNotesDataUsingSyncTime(objectArray: Array<AccountNotes>) -> Array<AccountNotes>  {
        
        let globalSyncConfigurationList = SyncConfigurationViewModel().syncConfiguration()
        let isManager:Bool = UserViewModel().consultants.count > 0
        
        let objectArray = objectArray.filter {
            if let systemConfigurationObject = SyncConfigurationSortUtility.searchSyncConfigurationByRecordTypeId(syncConfigurationList: globalSyncConfigurationList, recordTypeId: $0.Id) { // CHANGE ID TO RECORD ID
                if systemConfigurationObject.developerName == "" {
                    if isManager {
                        if !systemConfigurationObject.salesManagerSyncFrom.isEmpty {
                            let prevMonthDate = Date().add(component: .day, value: -Int((systemConfigurationObject.salesManagerSyncFrom as NSString).floatValue))
                            let next3MonthDate = Date().add(component: .day, value: Int((systemConfigurationObject.salesManagerSyncTo as NSString).floatValue))
                            
                            /* REPLACE dateStart With YOUR DATE PROPERTY */
                            //                            if let startDate = $0.dateStart {
                            //                                if startDate.isLater(than: prevMonthDate), startDate.isEarlier(than: next3MonthDate) {
                            //                                    return true
                            //                                }
                            //                                else {
                            //                                    return false
                            //                                }
                            //                            }
                            
                        } else {
                            let prevMonthDate = Date().add(component: .month, value: -1)
                            let next3MonthDate = Date().add(component: .month, value: 0)
                            /* REPLACE dateStart With YOUR DATE PROPERTY */
                            //                            if startDate.isLater(than: prevMonthDate), startDate.isEarlier(than: next3MonthDate) {
                            //                                return true
                            //                            }
                            //                            else {
                            //                                return false
                            //                            }
                            //                        }
                            
                        }
                    } else {
                        if !systemConfigurationObject.salesConsultantSyncFrom.isEmpty {
                            let prevMonthDate = Date().add(component: .day, value: -Int((systemConfigurationObject.salesConsultantSyncFrom as NSString).floatValue))
                            let next3MonthDate = Date().add(component: .day, value: Int((systemConfigurationObject.salesConsultantSyncTo as NSString).floatValue))
                            /* REPLACE dateStart With YOUR DATE PROPERTY */
                            //                            if let startDate = $0.dateStart {
                            //                                if startDate.isLater(than: prevMonthDate), startDate.isEarlier(than: next3MonthDate) {
                            //                                    return true
                            //                                }
                            //                                else {
                            //                                    return false
                            //                                }
                            //                            }
                            
                            
                        } else {
                            let prevMonthDate = Date().add(component: .month, value: -1)
                            let next3MonthDate = Date().add(component: .month, value: 0)
                            /* REPLACE dateStart With YOUR DATE PROPERTY */
                            //                            if let startDate = $0.dateStart {
                            //                                if startDate.isLater(than: prevMonthDate), startDate.isEarlier(than: next3MonthDate) {
                            //                                    return true
                            //                                }
                            //                                else {
                            //                                    return false
                            //                                }
                            //                            }
                            
                        }
                    }
                }
            }
            return false
        }
        
        return objectArray
    }
    
    func getDateRangeForActionItemFromSyncConfig() -> (syncFrom: Int, syncTo: Int){
        let globalSyncConfigurationList = SyncConfigurationViewModel().syncConfiguration()
        let isManager:Bool = UserViewModel().consultants.count > 0
        
        if let systemConfigurationObject = SyncConfigurationSortUtility.searchSyncConfigurationByRecordTypeId(syncConfigurationList: globalSyncConfigurationList, recordTypeId: "0120t0000008cMCAAY") { /// REPLACE ID WITH RECORD ID
            if systemConfigurationObject.developerName == "SGWS_Task" {
                if isManager {
                    if !systemConfigurationObject.salesManagerSyncFrom.isEmpty {
                        return ( Int(systemConfigurationObject.salesManagerSyncFrom)!, Int(systemConfigurationObject.salesManagerSyncTo)!)
                        
                    } else {
                        return (30,90)
                    }
                    
                } else {
                    
                    if !systemConfigurationObject.salesManagerSyncFrom.isEmpty {
                        return ( Int(systemConfigurationObject.salesConsultantSyncFrom)!, Int(systemConfigurationObject.salesConsultantSyncTo)!)
                        
                    } else {
                        return (30,90)
                    }
                }
            }
        }
        return (30,90)
    }
    
    func getDateRangeForNotificationsFromSyncConfig() -> (syncFrom: Int, syncTo: Int){
        let globalSyncConfigurationList = SyncConfigurationViewModel().syncConfiguration()
        let isManager:Bool = UserViewModel().consultants.count > 0
        
        if let systemConfigurationObject = SyncConfigurationSortUtility.searchSyncConfigurationByRecordTypeId(syncConfigurationList: globalSyncConfigurationList, recordTypeId: "0120t0000008cMBAAY") { /// REPLACE ID WITH RECORD ID
            if systemConfigurationObject.developerName == "SGWS_Notification" {
                if isManager {
                    if !systemConfigurationObject.salesManagerSyncFrom.isEmpty {
                        return ( Int(systemConfigurationObject.salesManagerSyncFrom)!, Int(systemConfigurationObject.salesManagerSyncTo)!)
                        
                    } else {
                        return (30,90)
                    }
                    
                } else {
                    
                    if !systemConfigurationObject.salesManagerSyncFrom.isEmpty {
                        return ( Int(systemConfigurationObject.salesConsultantSyncFrom)!, Int(systemConfigurationObject.salesConsultantSyncTo)!)
                        
                    } else {
                        return (30,90)
                    }
                }
            }
        }
        return (30,90)
    }
}
