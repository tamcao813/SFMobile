//
//  OpportunitySortUtility.swift
//  SWSApp
//
//  Created by Thillaiganesh, C. on 07/06/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class OpportunitySortUtility {

    func opportunityFor(forAccount accountId: String) -> [Opportunity] {
        return GlobalOpportunityModel.globalOpportunity.filter( { return $0.accountId == accountId } )
    }
    
    func opportunitySort(_ opportunityToSort: [Opportunity]) -> [Opportunity] {
        
        var opportunitySorted = [Opportunity]()
        
        if OpportunitiesFilterMenuModel.isAscendingProductName != "" {
             opportunitySorted = opportunitySortProductName(opportunityToSort)
        }
        else if OpportunitiesFilterMenuModel.isAscendingSource != "" {
            opportunitySorted = opportunitySortSource(opportunityToSort)
        }
        else if OpportunitiesFilterMenuModel.isAscendingPYCMSold != "" {
            opportunitySorted = opportunitySortPYCMSold(opportunityToSort)
        }
        else if OpportunitiesFilterMenuModel.isAscendingCommit != "" {
            opportunitySorted = opportunitySortCommit(opportunityToSort)
        }
        else if OpportunitiesFilterMenuModel.isAscendingSold != "" {
            opportunitySorted = opportunitySortSold(opportunityToSort)
        }
        else if OpportunitiesFilterMenuModel.isAscendingMonth != "" {
            opportunitySorted = opportunitySortMonth(opportunityToSort)
        }
        else if OpportunitiesFilterMenuModel.isAscendingStatus != "" {
            opportunitySorted = opportunitySortStatus(opportunityToSort)
        }

        return opportunitySorted
    }
    
    func opportunitySortProductName(_ opportunityToSort: [Opportunity]) -> [Opportunity] {
        
        var opportunitySorted = [Opportunity]()
        
        if OpportunitiesFilterMenuModel.isAscendingProductName == "YES" {
            opportunitySorted = opportunityToSort.sorted(by: { $0.productName.lowercased() < $1.productName.lowercased() })
        }
        else {
            opportunitySorted = opportunityToSort.sorted(by: { $0.productName.lowercased() > $1.productName.lowercased() })
        }
        return opportunitySorted
    }
    
    func opportunitySortSource(_ opportunityToSort: [Opportunity]) -> [Opportunity] {
        
        var opportunitySorted = [Opportunity]()
        
        if OpportunitiesFilterMenuModel.isAscendingSource == "YES" {
            opportunitySorted = opportunityToSort.sorted(by: { $0.source.lowercased() < $1.source.lowercased() })
        }
        else {
            opportunitySorted = opportunityToSort.sorted(by: { $0.source.lowercased() > $1.source.lowercased() })
        }
        
        return opportunitySorted
    }
    
    func opportunitySortPYCMSold(_ opportunityToSort: [Opportunity]) -> [Opportunity] {
        
        var opportunitySorted = [Opportunity]()
        
        if OpportunitiesFilterMenuModel.viewByCaseDecimal == "YES" {
            if OpportunitiesFilterMenuModel.isAscendingPYCMSold == "YES" {
                opportunitySorted = opportunityToSort.sorted(by: { $0.PYCMSold.lowercased() < $1.PYCMSold.lowercased() })
            }
            else {
                opportunitySorted = opportunityToSort.sorted(by: { $0.PYCMSold.lowercased() > $1.PYCMSold.lowercased() })
            }
        }
        else {
            if OpportunitiesFilterMenuModel.isAscendingPYCMSold == "YES" {
                opportunitySorted = opportunityToSort.sorted(by: { $0.PYCMSold9L.lowercased() < $1.PYCMSold9L.lowercased() })
            }
            else {
                opportunitySorted = opportunityToSort.sorted(by: { $0.PYCMSold9L.lowercased() > $1.PYCMSold9L.lowercased() })
            }
        }
        
        return opportunitySorted
    }
    
    func opportunitySortCommit(_ opportunityToSort: [Opportunity]) -> [Opportunity] {
        
        var opportunitySorted = [Opportunity]()
        
        if OpportunitiesFilterMenuModel.viewByCaseDecimal == "YES" {
            if OpportunitiesFilterMenuModel.isAscendingCommit == "YES" {
                opportunitySorted = opportunityToSort.sorted(by: { $0.commit.lowercased() < $1.commit.lowercased() })
            }
            else {
                opportunitySorted = opportunityToSort.sorted(by: { $0.commit.lowercased() > $1.commit.lowercased() })
            }
        }
        else {
            if OpportunitiesFilterMenuModel.isAscendingPYCMSold == "YES" {
                opportunitySorted = opportunityToSort.sorted(by: { $0.commit9L.lowercased() < $1.commit9L.lowercased() })
            }
            else {
                opportunitySorted = opportunityToSort.sorted(by: { $0.commit9L.lowercased() > $1.commit9L.lowercased() })
            }
        }

        return opportunitySorted
    }
    
    func opportunitySortSold(_ opportunityToSort: [Opportunity]) -> [Opportunity] {
        
        var opportunitySorted = [Opportunity]()
        
        if OpportunitiesFilterMenuModel.viewByCaseDecimal == "YES" {
            if OpportunitiesFilterMenuModel.isAscendingSold == "YES" {
                opportunitySorted = opportunityToSort.sorted(by: { $0.sold.lowercased() < $1.sold.lowercased() })
            }
            else {
                opportunitySorted = opportunityToSort.sorted(by: { $0.sold.lowercased() > $1.sold.lowercased() })
            }
        }
        else {
            if OpportunitiesFilterMenuModel.isAscendingPYCMSold == "YES" {
                opportunitySorted = opportunityToSort.sorted(by: { $0.sold9L.lowercased() < $1.sold9L.lowercased() })
            }
            else {
                opportunitySorted = opportunityToSort.sorted(by: { $0.sold9L.lowercased() > $1.sold9L.lowercased() })
            }
        }
        
        return opportunitySorted
    }
    
    func opportunitySortMonth(_ opportunityToSort: [Opportunity]) -> [Opportunity] {
        
        var opportunitySorted = [Opportunity]()
        
        if OpportunitiesFilterMenuModel.isAscendingMonth == "YES" {
            opportunitySorted = opportunityToSort.sorted(by: { $0.monthActive.lowercased() < $1.monthActive.lowercased() })
        }
        else {
            opportunitySorted = opportunityToSort.sorted(by: { $0.monthActive.lowercased() > $1.monthActive.lowercased() })
        }

        return opportunitySorted
    }
    
    func opportunitySortStatus(_ opportunityToSort: [Opportunity]) -> [Opportunity] {
        
        var opportunitySorted = [Opportunity]()
        
        if OpportunitiesFilterMenuModel.isAscendingStatus == "YES" {
            opportunitySorted = opportunityToSort.sorted(by: { $0.status.lowercased() < $1.status.lowercased() })
        }
        else {
            opportunitySorted = opportunityToSort.sorted(by: { $0.status.lowercased() > $1.status.lowercased() })
        }

        return opportunitySorted
    }
    
    func searchOpportunityBySearchBarQuery(opportunityToSearch:[Opportunity]?, searchText:String) -> [Opportunity]?
    {

        guard opportunityToSearch != nil else {
            return [Opportunity]()
        }
        
        guard opportunityToSearch!.count > 0  else {
            return [Opportunity]()
        }
        
        var filteredOpportunityArray = [Opportunity]()
        var filteredByReturnArray = [Opportunity]()
        var enteredAnyFilterCaseReturn = false

        // filter by Status
        (enteredAnyFilterCaseReturn, filteredByReturnArray) = OpportunitySortUtility.filterOpportunityByFilterByStatus(opportunityToBeFiltered: opportunityToSearch!)
        if enteredAnyFilterCaseReturn {
            filteredOpportunityArray += filteredByReturnArray
        }
        
        // filter by Source
        (enteredAnyFilterCaseReturn, filteredByReturnArray) = OpportunitySortUtility.filterOpportunityByFilterBySource(opportunityToBeFiltered: opportunityToSearch!)
        if enteredAnyFilterCaseReturn {
            filteredOpportunityArray += filteredByReturnArray
        }
        
        // filter by Objective
        (enteredAnyFilterCaseReturn, filteredByReturnArray) = OpportunitySortUtility.filterOpportunityByFilterByObjective(opportunityToBeFiltered: opportunityToSearch!)
        if enteredAnyFilterCaseReturn {
            filteredOpportunityArray += filteredByReturnArray
        }
        
        // now search filtered list by search text
        let trimmedSearchString = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        if(trimmedSearchString != ""){
            (enteredAnyFilterCaseReturn, filteredByReturnArray) = OpportunitySortUtility.filterOpportunityByFilterBySearchText(opportunityToBeFiltered: opportunityToSearch!, searchText: trimmedSearchString)
            if enteredAnyFilterCaseReturn {
                filteredOpportunityArray += filteredByReturnArray
            }
        }

        return filteredOpportunityArray
    }
    
    static func filterOpportunityByFilterByStatus(opportunityToBeFiltered : [Opportunity])-> (Bool, [Opportunity]){
        
        var filteredOpportunityArray = [Opportunity]()
        var enteredAnyFilterCase = false
        
        if OpportunitiesFilterMenuModel.statusOpen == "YES"{

            var filteredStatusOpenOpportunityArray = [Opportunity]()

            enteredAnyFilterCase = true
            filteredStatusOpenOpportunityArray = opportunityToBeFiltered.filter( { return $0.status == "Open" } )

            if filteredStatusOpenOpportunityArray.count > 0 {
                filteredOpportunityArray += filteredStatusOpenOpportunityArray
            }
        }

        if OpportunitiesFilterMenuModel.statusPlanned == "YES"{

            var filteredStatusPlannedOpportunityArray = [Opportunity]()

            enteredAnyFilterCase = true
            filteredStatusPlannedOpportunityArray = opportunityToBeFiltered.filter( { return $0.status == "Planned" } )

            if filteredStatusPlannedOpportunityArray.count > 0 {
                filteredOpportunityArray += filteredStatusPlannedOpportunityArray
            }
        }
        
        if OpportunitiesFilterMenuModel.statusClosedWon == "YES"{
            
            var filteredStatusClosedWonOpportunityArray = [Opportunity]()
            
            enteredAnyFilterCase = true
            filteredStatusClosedWonOpportunityArray = opportunityToBeFiltered.filter( { return $0.status == "Closed-Won" } )
            
            if filteredStatusClosedWonOpportunityArray.count > 0 {
                filteredOpportunityArray += filteredStatusClosedWonOpportunityArray
            }
        }
        
        if OpportunitiesFilterMenuModel.statusClosed == "YES"{
            
            var filteredStatusClosedOpportunityArray = [Opportunity]()
            
            enteredAnyFilterCase = true
            filteredStatusClosedOpportunityArray = opportunityToBeFiltered.filter( { return $0.status == "Closed" } )
            
            if filteredStatusClosedOpportunityArray.count > 0 {
                filteredOpportunityArray += filteredStatusClosedOpportunityArray
            }
        }
        
        return (enteredAnyFilterCase, filteredOpportunityArray)
    }
    
    static func filterOpportunityByFilterBySource(opportunityToBeFiltered : [Opportunity])-> (Bool, [Opportunity]){
        
        var filteredOpportunityArray = [Opportunity]()
        var enteredAnyFilterCase = false
        
        if OpportunitiesFilterMenuModel.sourceBookOfBusiness == "YES"{
            
            var filteredSourceOpenOpportunityArray = [Opportunity]()
            
            enteredAnyFilterCase = true
            filteredSourceOpenOpportunityArray = opportunityToBeFiltered.filter( { return $0.source == "Book Of Business" } )
            
            if filteredSourceOpenOpportunityArray.count > 0 {
                filteredOpportunityArray += filteredSourceOpenOpportunityArray
            }
        }
        
        if OpportunitiesFilterMenuModel.sourceTopSellers == "YES"{
            
            var filteredSourceOpenOpportunityArray = [Opportunity]()
            
            enteredAnyFilterCase = true
            filteredSourceOpenOpportunityArray = opportunityToBeFiltered.filter( { return $0.source == "Top Sellers" } )
            
            if filteredSourceOpenOpportunityArray.count > 0 {
                filteredOpportunityArray += filteredSourceOpenOpportunityArray
            }
        }
        
        if OpportunitiesFilterMenuModel.sourceUndersold == "YES"{
            
            var filteredSourceOpenOpportunityArray = [Opportunity]()
            
            enteredAnyFilterCase = true
            filteredSourceOpenOpportunityArray = opportunityToBeFiltered.filter( { return $0.source == "Undersold " } )
            
            if filteredSourceOpenOpportunityArray.count > 0 {
                filteredOpportunityArray += filteredSourceOpenOpportunityArray
            }
        }
        
        if OpportunitiesFilterMenuModel.sourceHotNot == "YES"{
            
            var filteredSourceOpenOpportunityArray = [Opportunity]()
            
            enteredAnyFilterCase = true
            filteredSourceOpenOpportunityArray = opportunityToBeFiltered.filter( { return $0.source == "What’s Hot/What’s Not" } )
            
            if filteredSourceOpenOpportunityArray.count > 0 {
                filteredOpportunityArray += filteredSourceOpenOpportunityArray
            }
        }
        
        if OpportunitiesFilterMenuModel.sourceUnsold == "YES"{
            
            var filteredSourceOpenOpportunityArray = [Opportunity]()
            
            enteredAnyFilterCase = true
            filteredSourceOpenOpportunityArray = opportunityToBeFiltered.filter( { return $0.source == "Unsold" } )
            
            if filteredSourceOpenOpportunityArray.count > 0 {
                filteredOpportunityArray += filteredSourceOpenOpportunityArray
            }
        }
        
        return (enteredAnyFilterCase, filteredOpportunityArray)
    }
    
    static func filterOpportunityByFilterByObjective(opportunityToBeFiltered : [Opportunity])-> (Bool, [Opportunity]){
        
        var filteredOpportunityArray = [Opportunity]()
        var enteredAnyFilterCase = false
        
        if OpportunitiesFilterMenuModel.objective9L == "YES"{
            
            var filteredObjectiveOpenOpportunityArray = [Opportunity]()
            
            enteredAnyFilterCase = true
            filteredObjectiveOpenOpportunityArray = opportunityToBeFiltered.filter( { return ($0.objectiveTypes.self.range(of: "9L", options: .caseInsensitive) != nil) } )
            
            if filteredObjectiveOpenOpportunityArray.count > 0 {
                filteredOpportunityArray += filteredObjectiveOpenOpportunityArray
            }
        }
        
        if OpportunitiesFilterMenuModel.objectiveDecimal == "YES"{
            
            var filteredObjectiveOpenOpportunityArray = [Opportunity]()
            
            enteredAnyFilterCase = true
            filteredObjectiveOpenOpportunityArray = opportunityToBeFiltered.filter( { return ($0.objectiveTypes.self.range(of: "Decimal", options: .caseInsensitive) != nil) } )
            
            if filteredObjectiveOpenOpportunityArray.count > 0 {
                filteredOpportunityArray += filteredObjectiveOpenOpportunityArray
            }
        }
        
        if OpportunitiesFilterMenuModel.objectiveRevenue == "YES"{
            
            var filteredObjectiveOpenOpportunityArray = [Opportunity]()
            
            enteredAnyFilterCase = true
            filteredObjectiveOpenOpportunityArray = opportunityToBeFiltered.filter( { return ($0.objectiveTypes.self.range(of: "Revenue", options: .caseInsensitive) != nil) } )
            
            if filteredObjectiveOpenOpportunityArray.count > 0 {
                filteredOpportunityArray += filteredObjectiveOpenOpportunityArray
            }
        }
        
        if OpportunitiesFilterMenuModel.objectiveACS == "YES"{
            
            var filteredObjectiveOpenOpportunityArray = [Opportunity]()
            
            enteredAnyFilterCase = true
            filteredObjectiveOpenOpportunityArray = opportunityToBeFiltered.filter( { return ($0.objectiveTypes.self.range(of: "ACS", options: .caseInsensitive) != nil) } )
            
            if filteredObjectiveOpenOpportunityArray.count > 0 {
                filteredOpportunityArray += filteredObjectiveOpenOpportunityArray
            }
        }
        
        if OpportunitiesFilterMenuModel.objectivePOD == "YES"{
            
            var filteredObjectiveOpenOpportunityArray = [Opportunity]()
            
            enteredAnyFilterCase = true
            filteredObjectiveOpenOpportunityArray = opportunityToBeFiltered.filter( { return ($0.objectiveTypes.self.range(of: "POD", options: .caseInsensitive) != nil) } )
            
            if filteredObjectiveOpenOpportunityArray.count > 0 {
                filteredOpportunityArray += filteredObjectiveOpenOpportunityArray
            }
        }
        
        return (enteredAnyFilterCase, filteredOpportunityArray)
    }
    
    static func filterOpportunityByFilterBySearchText(opportunityToBeFiltered : [Opportunity], searchText: String)-> (Bool, [Opportunity]){
        
        var filteredOpportunityArray = [Opportunity]()
        var enteredAnyFilterCase = false
        
        if searchText != "" {
            
            var filteredObjectiveOpenOpportunityArray = [Opportunity]()
            
            enteredAnyFilterCase = true
            filteredObjectiveOpenOpportunityArray = opportunityToBeFiltered.filter( { return (($0.productName.self.range(of: searchText, options: .caseInsensitive) != nil) || ($0.productID.self.range(of: searchText, options: .caseInsensitive) != nil)) } )
            
            if filteredObjectiveOpenOpportunityArray.count > 0 {
                filteredOpportunityArray += filteredObjectiveOpenOpportunityArray
            }
        }
        
        
        return (enteredAnyFilterCase, filteredOpportunityArray)
    }
    
}

