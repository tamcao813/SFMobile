//
//  AccountsNotesViewModel.swift
//  SWSApp
//
//  Created by Jagadeeshwar Reddy on 27/04/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation

class AccountsActionItemViewModel {
    
    //    let accountsForLoggedUser: [Account] = StoreDispatcher.shared.fetchAccountsForLoggedUser()
    
    func actionItemFourMonthsSorted() -> [ActionItem] {
        
        var actionItemsArray = getAcctionItemForUser()
        
        let prevMonthDate = Date().add(component: .month, value: -1)
        let next3MonthDate = Date().add(component: .month, value: 3)
        
        actionItemsArray = actionItemsArray.filter {
            if let activityDate = DateTimeUtility.getDateActionItemFromDateString(dateString: $0.activityDate) {
                if activityDate.isLater(than: prevMonthDate), activityDate.isEarlier(than: next3MonthDate) {
                    return true
                }
                else {
                    return false
                }
            }
            return true
        }
        
        actionItemsArray = actionItemsArray.sorted(by: { $0.activityDate < $1.activityDate })
        return actionItemsArray
    }

    
    
    func getAcctionItemForUser() -> [ActionItem] {
        return StoreDispatcher.shared.fetchActionItem()
    }
    
    func createNewActionItemLocally(fields:[String:Any]) -> Bool {
        return StoreDispatcher.shared.createNewActionItemLocally(fieldsToUpload:fields)
    }
    
    func editActionItemLocally(fields: [String:Any]) -> Bool {
        return StoreDispatcher.shared.editActionItemLocally(fieldsToUpload:fields)
    }
    
    
    func editActionItemStatusLocally(fields: [String:Any]) -> Bool {
        return StoreDispatcher.shared.editActionItemStatusLocally(fieldsToUpload:fields)
    }
    
    func deleteActionItemLocally(fields: [String:Any]) -> Bool {
        return StoreDispatcher.shared.deleteActionItemLocally(fieldsToUpload:fields)
    }
    
    func uploadActionItemToServer(fields: [String], completion: @escaping (_ error: NSError?)->() ) {
        StoreDispatcher.shared.syncUpActionItem(fieldsToUpload: fields, completion: {error in
            
            if error != nil {
                print(error?.localizedDescription ?? "error")
                completion(error)
            }
            else {
                
                completion(nil)
            }
        })
    }
    
    func actionItemForUserTwoWeeksUpcoming() -> [ActionItem] {
        
        var actionForUserArray = getAcctionItemForUser()
        
        let prevWeekDate = Date().add(component: .day, value: -1)
        let nextTwoWeekDate = Date().add(component: .day, value: 14)
        
        actionForUserArray = actionForUserArray.filter {
            
            if let startDate = DateTimeUtility.getDateActionItemFromDateString(dateString: $0.activityDate) {
                if startDate.isLater(than: prevWeekDate), startDate.isEarlier(than: nextTwoWeekDate) {
                    return true
                }
                else {
                    return false
                }
            }
            return false
            
        }
        
        actionForUserArray = actionForUserArray.sorted(by: { $0.isUrgent && !$1.isUrgent })
        
        return actionForUserArray
        
    }
    
    
    func actionItemForUserOneWeeksPast() -> [ActionItem] {
        
        var actionForUserArray = getAcctionItemForUser()
        
        let prevWeekDate = Date().add(component: .day, value: -7)
        let nextWeekDate = Date().add(component: .day, value: -1)
        
        actionForUserArray = actionForUserArray.filter {
            
            if let startDate = DateTimeUtility.getDateActionItemFromDateString(dateString: $0.activityDate) {
                if startDate.isLater(than: prevWeekDate), startDate.isEarlier(than: nextWeekDate) {
                    return true
                }
                else {
                    return false
                }
            }
            return false
            
        }
        
        actionForUserArray = actionForUserArray.sorted(by: { $0.isUrgent && !$1.isUrgent })
        
        return actionForUserArray
        
    }
    
    
    
    
    
}

