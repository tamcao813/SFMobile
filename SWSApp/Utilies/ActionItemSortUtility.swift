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
    var wholeFilterAdded = false
    var statusFilterAdded = false
    var urgentFilterAdded = false
    var dueFilterAdded = false
    var filteredArray = [ActionItem]()
    
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
        
        let filteredArray = subjectFilteredArray + accountNameFilteredArray + accountNunberFilteredArray
        return filteredArray.unique()
    }
    
    func filterOnly(actionItems: [ActionItem]) -> [ActionItem]{
        var filteredArray = [ActionItem]()
        let filterOnTeamArray = filterOnTeamBasis(actionItems: actionItems)
        let filteredStatusArray = filterOnStatusBasis(actionItems: filterOnTeamArray)
        let filteredUrgentArray = filterOnUrgentBasis(actionItems: filterOnTeamArray)
        let filteredDueDateArray = filterOnDueDateBasis(actionItems: filterOnTeamArray)
        
        if statusFilterAdded && urgentFilterAdded && dueFilterAdded {
            var localFilteredArray = [ActionItem]()
            var recordAdded = false
            if filteredStatusArray.count != 0 && filteredUrgentArray.count != 0 && filteredDueDateArray.count != 0{
                for a in filteredStatusArray {
                    for b in filteredUrgentArray {
                        for c in filteredDueDateArray{
                            if a.Id == b.Id,a.Id == c.Id{
                                localFilteredArray.append(a)
                                recordAdded = true
                            }
                        }
                    }
                }
            }
            if recordAdded {
                filteredArray = localFilteredArray
            }
        }
        
        if statusFilterAdded && !urgentFilterAdded && dueFilterAdded {
            var localFilteredArray = [ActionItem]()
            var recordAdded = false
            if filteredStatusArray.count != 0 && filteredDueDateArray.count != 0{
                for status in filteredStatusArray{
                    for due in filteredDueDateArray{
                        if status.Id == due.Id {
                            localFilteredArray.append(status)
                            recordAdded = true
                        }
                    }
                }
            }
            if recordAdded {
                filteredArray = localFilteredArray
            }
        }
        
        if statusFilterAdded && urgentFilterAdded && !dueFilterAdded {
            var localFilteredArray = [ActionItem]()
            var recordAdded = false
            if filteredUrgentArray.count != 0 && filteredStatusArray.count != 0{
                for urgent in filteredUrgentArray{
                    for status in filteredStatusArray{
                        if urgent.Id == status.Id {
                            localFilteredArray.append(status)
                            recordAdded = true
                        }
                    }
                }
            }
            if recordAdded {
                filteredArray = localFilteredArray
            }
        }
        
        if !statusFilterAdded && urgentFilterAdded && dueFilterAdded{
            var localFilteredArray = [ActionItem]()
            var recordAdded = false
            if filteredUrgentArray.count != 0 && filteredDueDateArray.count != 0{
                for urgent in filteredUrgentArray{
                    for due in filteredDueDateArray{
                        if urgent.Id == due.Id {
                            localFilteredArray.append(urgent)
                            recordAdded = true
                        }
                    }
                }
            }
            if recordAdded {
                filteredArray = localFilteredArray
            }
        }
        
        if !statusFilterAdded && urgentFilterAdded && !dueFilterAdded {
            filteredArray = filteredUrgentArray
        }
        
        if statusFilterAdded && !urgentFilterAdded && !dueFilterAdded {
            filteredArray = filteredStatusArray
        }
        
        if !statusFilterAdded && urgentFilterAdded && !dueFilterAdded {
            filteredArray = filteredUrgentArray
        }
        
        if !statusFilterAdded && !urgentFilterAdded && dueFilterAdded {
            filteredArray = filteredDueDateArray
        }
        
        if !statusFilterAdded && !urgentFilterAdded && !dueFilterAdded {
            filteredArray = filterOnTeamArray
        }
        
        return filteredArray
    }
    
    func filterOnTeamBasis(actionItems: [ActionItem]) -> [ActionItem]{
        if let id = ActionItemFilterModel.selectedConsultant?.id {
            return actionItems.filter( { return $0.ownerId.contains(id) } )
        }
        
        return actionItems
    }
    
    func filterOnStatusBasis(actionItems: [ActionItem]) -> [ActionItem]{
        var isCompleteArray = [ActionItem]()
        var isOpenArray = [ActionItem]()
        var isOverdueArray = [ActionItem]()
        if ActionItemFilterModel.isComplete == "YES"{
            isCompleteArray = actionItems.filter( { return $0.status.lowercased().contains("comp") } )
            statusFilterAdded = true
        }
        
        if ActionItemFilterModel.isOpen == "YES"{
            isOpenArray = actionItems.filter( { return $0.status.lowercased().contains("open") } )
            statusFilterAdded = true
        }
        
        if ActionItemFilterModel.isOverdue == "YES"{
            isOverdueArray = actionItems.filter( { return $0.status.lowercased().contains("overdue") } )
            statusFilterAdded = true
        }
        
        if statusFilterAdded {
            wholeFilterAdded = true
            return isCompleteArray + isOpenArray + isOverdueArray
        }else{
            return actionItems
        }
        
    }
    
    func filterOnUrgentBasis(actionItems: [ActionItem]) -> [ActionItem]{
        var urgentArray = [ActionItem]()
        var notUrgentArray = [ActionItem]()
        if ActionItemFilterModel.isUrgent == "YES"{
            urgentFilterAdded = true
            for actionItem in actionItems{
                if actionItem.isUrgent {
                    urgentArray.append(actionItem)
                    
                }
            }
        }
        
        if ActionItemFilterModel.isNotUrgent == "YES"{
            urgentFilterAdded = true
            for actionItem in actionItems{
                if !actionItem.isUrgent {
                    notUrgentArray.append(actionItem)
                }
            }
        }
        
        if urgentFilterAdded {
            wholeFilterAdded = true
            return urgentArray + notUrgentArray
        }else{
            return actionItems
        }
    }
    
    func filterOnDueDateBasis(actionItems: [ActionItem]) -> [ActionItem]{
        var dueYes = [ActionItem]()
        var dueNo = [ActionItem]()
        
        if ActionItemFilterModel.dueYes == "YES"{
            dueFilterAdded = true
            for action in actionItems {
                if action.activityDate != ""{
                    dueYes.append(action)
                }
            }
        }
        
        if ActionItemFilterModel.dueNo == "YES"{
            dueFilterAdded = true
            for action in actionItems {
                if action.activityDate == ""{
                    dueNo.append(action)
                }
            }
        }
        if dueFilterAdded {
            wholeFilterAdded = true
            return dueYes + dueNo
        }else{
            return actionItems
        }
    }
    
    func isItOpenState(dueDate: String) -> Bool{
        if dueDate == "" {
            return true
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date())
        if let mmddyyDate = dateFormatter.date(from: dueDate) {
            if mmddyyDate >= yesterday! {
                return true
            }else{
                return false
            }
        }else{
            dateFormatter.dateFormat = "yyyy/MM/dd"
            if let dateyymmdd = dateFormatter.date(from: dueDate){
                if dateyymmdd >= yesterday! {
                    return true
                }else{
                    return false
                }
            }
        }
        return false
    }
}

extension Sequence where Iterator.Element: Hashable {
    func unique() -> [Iterator.Element] {
        var seen: [Iterator.Element: Bool] = [:]
        return self.filter { seen.updateValue(true, forKey: $0) == nil }
    }
}
