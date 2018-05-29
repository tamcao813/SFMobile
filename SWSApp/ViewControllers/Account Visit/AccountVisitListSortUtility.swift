//
//  AccountVisitListSortUtility.swift
//  SWSApp
//
//  Created by r.a.jantakal on 27/05/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation
import UIKit

class AccountVisitListSortUtility {
    
    var recordTypeAdded = false
    var dateRangeAdded = false
    var statusAdded = false
    var pastVisitsAdded = false
    
    var filteredArray = [WorkOrderUserObject]()
    var date = Date()
    let dateFormatter = DateFormatter()
    
    func searchAndFilter(searchStr: String,actionItems: [WorkOrderUserObject]) -> [WorkOrderUserObject]{
        let searchOnlyArray = searchOnly(searchStr: searchStr,actionItems: actionItems)

        let filterOnlyArray = filterOnly(actionItems: searchOnlyArray)
        
        return filterOnlyArray
    }
    
    func searchOnly(searchStr: String,actionItems: [WorkOrderUserObject]) -> [WorkOrderUserObject]{
        let subjectFilteredArray = actionItems.filter( { return $0.subject.lowercased().contains(searchStr.lowercased()) } )
        
        let accountNameFilteredArray = actionItems.filter( { return $0.accountName.lowercased().contains(searchStr.lowercased()) } )
        
        let accountNunberFilteredArray = actionItems.filter( { return $0.accountNumber.lowercased().contains(searchStr.lowercased()) } )
        
        let addressFilteredArray = actionItems.filter( { return $0.shippingState.lowercased().contains(searchStr.lowercased()) } )
        
        let shippingFilteredArray = actionItems.filter( { return $0.shippingStreet.lowercased().contains(searchStr.lowercased()) } )
        
        let cityFilteredArray = actionItems.filter( { return $0.shippingCity.lowercased().contains(searchStr.lowercased()) } )
        
        let locationFilteredArray = actionItems.filter( { return $0.location.lowercased().contains(searchStr.lowercased()) } )
        
        let filteredArray = subjectFilteredArray + accountNameFilteredArray +  accountNunberFilteredArray + addressFilteredArray + shippingFilteredArray + cityFilteredArray + locationFilteredArray
        
        return filteredArray.uniqueValues()
    }
    
    func filterOnly(actionItems: [WorkOrderUserObject]) -> [WorkOrderUserObject]{
        var filteredArray = [WorkOrderUserObject]()
        
        let filteredRecordTypeArray = filterOnRecordTypeBasis(actionItems: actionItems)
        let filteredDateRangeArray = filterOnDateRangeBasis(actionItems: actionItems)
        let filteredStatusArray = filterOnStatusBasis(actionItems: actionItems)
        //let filteredPastVisitsArray = filterOnPastVisitsBasis(actionItems: actionItems)
        
        if recordTypeAdded && dateRangeAdded && statusAdded {
            var localFilteredArray = [WorkOrderUserObject]()
            var recordAdded = false
            if filteredRecordTypeArray.count != 0 && filteredDateRangeArray.count != 0 && filteredStatusArray.count != 0{
                for a in filteredRecordTypeArray {
                    for b in filteredDateRangeArray {
                        for c in filteredStatusArray{
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
        
        if recordTypeAdded && !dateRangeAdded && statusAdded {
            var localFilteredArray = [WorkOrderUserObject]()
            var recordAdded = false
            if filteredRecordTypeArray.count != 0 && filteredStatusArray.count != 0{
                for status in filteredRecordTypeArray{
                    for due in filteredStatusArray{
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
        
        if recordTypeAdded && dateRangeAdded && !statusAdded {
            var localFilteredArray = [WorkOrderUserObject]()
            var recordAdded = false
            if filteredRecordTypeArray.count != 0 && filteredDateRangeArray.count != 0{
                for urgent in filteredRecordTypeArray{
                    for status in filteredDateRangeArray{
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
        
        if !recordTypeAdded && dateRangeAdded && statusAdded{
            var localFilteredArray = [WorkOrderUserObject]()
            var recordAdded = false
            if filteredDateRangeArray.count != 0 && filteredStatusArray.count != 0{
                for urgent in filteredDateRangeArray{
                    for due in filteredStatusArray{
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
        
        if !recordTypeAdded && dateRangeAdded && !statusAdded {
            filteredArray = filteredDateRangeArray
        }
        
        if recordTypeAdded && !dateRangeAdded && !statusAdded {
            filteredArray = filteredRecordTypeArray
        }
        
        if !recordTypeAdded && !dateRangeAdded && statusAdded {
            filteredArray = filteredStatusArray
        }
        
        if !recordTypeAdded && !dateRangeAdded && !statusAdded {
            filteredArray = actionItems
        }
        
        let pastEventsArray = filterOnPastVisitsBasis(actionItems: filteredArray)
        
        return pastEventsArray
    }
    
    func filterOnRecordTypeBasis(actionItems: [WorkOrderUserObject]) -> [WorkOrderUserObject]{
        var isVisitArray = [WorkOrderUserObject]()
        var isEventArray = [WorkOrderUserObject]()
        
        if AccountVisitListFilterModel.isTypeVisit == "YES"{
            isVisitArray = actionItems.filter( { return $0.recordTypeId == StoreDispatcher.shared.workOrderRecordTypeIdVisit } )
            recordTypeAdded = true
        }
        
        if AccountVisitListFilterModel.isTypeEvent == "YES"{
            isEventArray = actionItems.filter( { return $0.recordTypeId == StoreDispatcher.shared.workOrderRecordTypeIdEvent } )
            recordTypeAdded = true
        }
        
        if recordTypeAdded {
            return isVisitArray + isEventArray
        }else{
            return actionItems
        }
    }
    
    func filterOnDateRangeBasis(actionItems: [WorkOrderUserObject]) -> [WorkOrderUserObject]{
  
        var todayArray = [WorkOrderUserObject]()
        var tomorrowDateArray = [WorkOrderUserObject]()
        var dateRangeArray = [WorkOrderUserObject]()
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if AccountVisitListFilterModel.isToday == "YES"{
            let timeStamp = dateFormatter.string(from: date)
            
            todayArray = actionItems.filter( {
                let dateSeperator = $0.startDate.components(separatedBy: "T")
                var dateOnly = ""
                if dateSeperator.count > 0{
                    dateOnly = dateSeperator[0]
                }
                return dateOnly == timeStamp
            } )
            dateRangeAdded = true
        }
        
        if AccountVisitListFilterModel.isTomorrow == "YES"{
            date.addTimeInterval(60 * 60 * 24)
            let timeStamp = dateFormatter.string(from: date)
            
            tomorrowDateArray = actionItems.filter( {
                let dateSeperator = $0.startDate.components(separatedBy: "T")
                var dateOnly = ""
                if dateSeperator.count > 0{
                    dateOnly = dateSeperator[0]
                }
                return dateOnly == timeStamp
            } )
            dateRangeAdded = true
        }
        
        //DATE RANGE for this week
        if AccountVisitListFilterModel.isThisWeek == "YES"{
            print(Date().endOfWeek.add(component: .day, value: 1))
            
            let timeStamp = dateFormatter.string(from: date.endOfWeek.add(component: .day, value: 1))
            
            dateRangeArray = actionItems.filter( {
                let dateSeperator = $0.startDate.components(separatedBy: "")
                var dateOnly = ""
                if dateSeperator.count > 0{
                    dateOnly = dateSeperator[0]
                }
                return dateOnly <= timeStamp
            } )
            dateRangeAdded = true
        }
        
        if dateRangeAdded{
            return todayArray + tomorrowDateArray + dateRangeArray
        }else{
            return actionItems
        }
    }
    
    func filterOnStatusBasis(actionItems: [WorkOrderUserObject]) -> [WorkOrderUserObject]{
        var scheduledArray = [WorkOrderUserObject]()
        var planned = [WorkOrderUserObject]()
        var inProgress = [WorkOrderUserObject]()
        var complete = [WorkOrderUserObject]()
        
        if AccountVisitListFilterModel.isStatusScheduled == "YES"{
            scheduledArray = actionItems.filter( { return $0.status.lowercased().contains("scheduled") } )
            statusAdded = true
        }
        
        if AccountVisitListFilterModel.isStatusPlanned == "YES"{
            planned = actionItems.filter( { return $0.status.lowercased().contains("planned") } )
            statusAdded = true
        }
        
        if AccountVisitListFilterModel.isInProgress == "YES"{
            inProgress = actionItems.filter( { return $0.status.lowercased().contains("in-progress") } )
            statusAdded = true
        }
        
        if AccountVisitListFilterModel.isComplete == "YES"{
            complete = actionItems.filter( { return $0.status.lowercased().contains("completed") } )
            statusAdded = true
        }
        
        if statusAdded {
            return scheduledArray + planned + inProgress + complete
        }else{
            return actionItems
        }
    }
    
    func filterOnPastVisitsBasis(actionItems: [WorkOrderUserObject]) -> [WorkOrderUserObject]{
        var pastVisitsArray = [WorkOrderUserObject]()
        
        if AccountVisitListFilterModel.isPastVisits == "YES"{
            date.addTimeInterval(-(60 * 60 * 24))
            let timeStamp = dateFormatter.string(from: date)
            
            pastVisitsArray = actionItems.filter( {
                let dateSeperator = $0.startDate.components(separatedBy: "T")
                var dateOnly = ""
                if dateSeperator.count > 0{
                    dateOnly = dateSeperator[0]
                }
                return dateOnly == timeStamp
            } )
            pastVisitsAdded = true
        }

        if pastVisitsAdded{
            return pastVisitsArray
        }else{
            return actionItems
        }
    }
}

//MARK:- Used to get Unique set of WorkorderObject values
extension Sequence where Iterator.Element: Hashable {
    func uniqueValues() -> [Iterator.Element] {
        var seen: [Iterator.Element: Bool] = [:]
        return self.filter { seen.updateValue(true, forKey: $0) == nil }
    }
}

