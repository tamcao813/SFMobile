//
//  NotificationsSortUtility.swift
//  SWSApp
//
//  Created by manu.a.gupta on 01/06/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation

class NotificationsSortUtility {
    
    var typeFilterAdded = false
    var readUnreadFilterAdded = false
    var wholeFilterAdded = false
    
    func searchAndFilter(searchStr: String,notifications: [Notifications]) -> [Notifications]{
        let searchOnlyArray = searchOnly(searchStr: searchStr,notifications: notifications)
        let filterOnlyArray = filterOnly(notifications: searchOnlyArray)
        return filterOnlyArray
    }
    
    func searchOnly(searchStr: String,notifications: [Notifications]) -> [Notifications]{
        let birthdayFilteredArray = notifications.filter( { return $0.sgwsContactBirthdayNotification.lowercased().contains(searchStr.lowercased()) } )
        
        let licenseExpirationFilteredArray = notifications.filter( { return $0.sgwsAccLicenseNotification.lowercased().contains(searchStr.lowercased()) } )
        
        return birthdayFilteredArray + licenseExpirationFilteredArray
    }
    
    func filterOnly(notifications: [Notifications]) -> [Notifications]{
        var filteredArray = [Notifications]()
        let filteredTypeArray = filterOnTypeBasis(notifications: notifications)
        let filteredFPOArray = filterOnReadBasis(notifications: notifications)

        if typeFilterAdded && readUnreadFilterAdded {
            var localFilteredArray = [Notifications]()
            var recordAdded = false
            if filteredFPOArray.count != 0 && filteredTypeArray.count != 0{
                for fpo in filteredFPOArray{
                    for type in filteredTypeArray{
                        if type.Id == fpo.Id {
                            localFilteredArray.append(type)
                            recordAdded = true
                        }
                    }
                }
            }
            if recordAdded {
                filteredArray = localFilteredArray
            }
        }
        
        if !typeFilterAdded && readUnreadFilterAdded{
            filteredArray = filteredFPOArray
        }
        
        if typeFilterAdded && !readUnreadFilterAdded{
            filteredArray = filteredTypeArray
        }
        
        if !typeFilterAdded && !readUnreadFilterAdded{
            filteredArray = notifications
        }
        
        return filteredArray        
    }
    
    func filterOnTypeBasis(notifications: [Notifications]) -> [Notifications]{
        var isLicenseExpiration = [Notifications]()
        var isBirthday = [Notifications]()
        
        if NotificationFilterModel.isLicenseExpiration == "YES"{
            isLicenseExpiration = notifications.filter( { return $0.sgwsType.lowercased().contains("lice") } )
            typeFilterAdded = true
        }
        
        if NotificationFilterModel.isContactBirthday == "YES"{
            isBirthday = notifications.filter( { return $0.sgwsType.lowercased().contains("birthday") } )
            typeFilterAdded = true
        }
        
        if typeFilterAdded {
            wholeFilterAdded = true
            return isLicenseExpiration + isBirthday
        }else{
            return notifications
        }
    }
    
    func filterOnReadBasis(notifications: [Notifications]) -> [Notifications]{
        var readArray = [Notifications]()
        var unreadArray = [Notifications]()
        if NotificationFilterModel.isRead == "YES"{
            readUnreadFilterAdded = true
            for notification in notifications{
                if notification.isRead {
                    readArray.append(notification)
                }
            }
        }
        
        if NotificationFilterModel.isUnread == "YES"{
            readUnreadFilterAdded = true
            for notification in notifications{
                if !notification.isRead {
                    unreadArray.append(notification)
                }
            }
        }
        
        if readUnreadFilterAdded {
            wholeFilterAdded = true
            return readArray + unreadArray
        }else{
            return notifications
        }
    }
}
