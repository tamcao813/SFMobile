//
//  ActionItemSortUtility.swift
//  SWSApp
//
//  Created by manu.a.gupta on 22/05/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation

class ActionItemSortUtility {
    var searchStarted = false
    func searchAndFilter(searchStr: String,actionItems: [ActionItem]) -> [ActionItem]{
        let searchOnlyArray = searchOnly(searchStr: searchStr,actionItems: actionItems)
        searchStarted = true
        let filterOnlyArray = filterOnly(actionItems: searchOnlyArray)
        return filterOnlyArray
    }
    
    func searchOnly(searchStr: String,actionItems: [ActionItem]) -> [ActionItem]{
        let subjectFilteredArray = actionItems.filter( { return $0.subject.lowercased().contains(searchStr.lowercased()) } )
        let accountNameFilteredArray = actionItems.filter( { return $0.accountName.lowercased().contains(searchStr.lowercased()) } )
        let accountNunberFilteredArray = actionItems.filter( { return $0.accountNumber.lowercased().contains(searchStr.lowercased()) } )
        return subjectFilteredArray + accountNameFilteredArray + accountNunberFilteredArray
    }
    
    func filterOnly(actionItems: [ActionItem]) -> [ActionItem]{
//        var filteredArray = [ActionItem]()
        var filterAdded = false
        var uniqueFilteredArray = [ActionItem]()
        let filteredStatusArray = filterOnStatusBasis(actionItems: actionItems)
        let filteredUrgentArray = filterOnUrgentBasis(actionItems: actionItems)
        let filteredDueDateArray = filterOnDueDateBasis(actionItems: actionItems)
        
        if filteredStatusArray.count > 0 && filteredUrgentArray.count > 0 && filteredDueDateArray.count > 0{
            for a in filteredStatusArray {
                for b in filteredUrgentArray {
                    for c in filteredDueDateArray{
                        if a.Id == b.Id,a.Id == c.Id{
                            uniqueFilteredArray.append(a)
                            filterAdded = true
                            break
                        }
                    }
                }
            }
        }
        
        if filteredStatusArray.count > 0 && filteredUrgentArray.count > 0 && filteredDueDateArray.count == 0 {
            for a in filteredStatusArray {
                for b in filteredUrgentArray {
                    if a.Id == b.Id{
                        uniqueFilteredArray.append(a)
                        filterAdded = true
                        break
                    }
                }
            }
        }
        
        if filteredStatusArray.count == 0 && filteredUrgentArray.count > 0 && filteredDueDateArray.count > 0{
            for b in filteredUrgentArray {
                for c in filteredDueDateArray{
                    if b.Id == c.Id{
                        uniqueFilteredArray.append(b)
                        filterAdded = true
                        break
                    }
                }
            }
        }
        
        if filteredStatusArray.count > 0 && filteredUrgentArray.count == 0 && filteredDueDateArray.count > 0{
            for a in filteredStatusArray {
                for c in filteredDueDateArray{
                    if a.Id == c.Id{
                        uniqueFilteredArray.append(a)
                        filterAdded = true
                        break
                    }
                }
            }
        }
        
        if filteredStatusArray.count > 0 && filteredUrgentArray.count == 0 && filteredDueDateArray.count == 0{
            uniqueFilteredArray = filteredStatusArray
            filterAdded = true
        }
        
        if filteredStatusArray.count == 0 && filteredUrgentArray.count > 0 && filteredDueDateArray.count == 0{
            uniqueFilteredArray = filteredUrgentArray
            filterAdded = true
        }
        
        if filteredStatusArray.count == 0 && filteredUrgentArray.count == 0 && filteredDueDateArray.count > 0{
            uniqueFilteredArray = filteredDueDateArray
            filterAdded = true
        }
        
        if searchStarted {
            return actionItems            
        }else{
            return uniqueFilteredArray
        }
    }
    
    func filterOnStatusBasis(actionItems: [ActionItem]) -> [ActionItem]{
        var isCompleteArray = [ActionItem]()
        var isOpenArray = [ActionItem]()
        var isOverdueArray = [ActionItem]()
        if ActionItemFilterModel.isComplete == "YES"{
            isCompleteArray = actionItems.filter( { return $0.status.lowercased().contains("comp") } )
        }
        
        if ActionItemFilterModel.isOpen == "YES"{
            isOpenArray = actionItems.filter( { return $0.status.lowercased().contains("open") } )
        }
        
        if ActionItemFilterModel.isOverdue == "YES"{
            isOverdueArray = actionItems.filter( { return $0.status.lowercased().contains("overdue") } )
        }
        
        return isCompleteArray + isOpenArray + isOverdueArray
    }
    
    func filterOnUrgentBasis(actionItems: [ActionItem]) -> [ActionItem]{
        var urgentArray = [ActionItem]()
        var notUrgentArray = [ActionItem]()
        
        if ActionItemFilterModel.isUrgent == "YES"{
            for actionItem in actionItems{
                if actionItem.isUrgent {
                    urgentArray.append(actionItem)
                }
            }
        }
        
        if ActionItemFilterModel.isNotUrgent == "YES"{
            for actionItem in actionItems{
                if !actionItem.isUrgent {
                    notUrgentArray.append(actionItem)
                }
            }
        }
        
        return urgentArray + notUrgentArray
    }
    
    func filterOnDueDateBasis(actionItems: [ActionItem]) -> [ActionItem]{
        var dueYes = [ActionItem]()
        var dueNo = [ActionItem]()
        
        if ActionItemFilterModel.dueYes == "YES"{
            for action in actionItems {
                if action.activityDate != ""{
                    dueYes.append(action)
                }
            }
        }
        
        if ActionItemFilterModel.dueNo == "YES"{
            for action in actionItems {
                if action.activityDate == ""{
                    dueNo.append(action)
                }
            }
        }
        
        return dueYes + dueNo
    }
    
}

extension Sequence where Iterator.Element: Hashable {
    func unique() -> [Iterator.Element] {
        var seen: [Iterator.Element: Bool] = [:]
        return self.filter { seen.updateValue(true, forKey: $0) == nil }
    }
}
