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
        if GlobalOpportunityModel.globalOpportunity.count == 0 {
            _ = OpportunityViewModel().globalOpportunityReload()
        }
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
        else {
            opportunitySorted = opportunityToSort
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
        var filterCaseReturn = false
        var enteredAnyFilterCaseReturn = false


        // filter by Status
        (filterCaseReturn, filteredByReturnArray) = OpportunitySortUtility.filterOpportunityByFilterByStatus(opportunityToBeFiltered: opportunityToSearch!)
        if filterCaseReturn {
            enteredAnyFilterCaseReturn = true
            filteredOpportunityArray += filteredByReturnArray
        }
        
        // filter by Source
        (filterCaseReturn, filteredByReturnArray) = OpportunitySortUtility.filterOpportunityByFilterBySource(opportunityToBeFiltered: opportunityToSearch!)
        if filterCaseReturn {
            enteredAnyFilterCaseReturn = true
            filteredOpportunityArray += filteredByReturnArray
        }
        
        // filter by Objective
        (filterCaseReturn, filteredByReturnArray) = OpportunitySortUtility.filterOpportunityByFilterByObjective(opportunityToBeFiltered: opportunityToSearch!)
        if filterCaseReturn {
            enteredAnyFilterCaseReturn = true
            filteredOpportunityArray += filteredByReturnArray
        }
        
        // now search filtered list by search text
        let trimmedSearchString = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        if(trimmedSearchString != ""){
            (filterCaseReturn, filteredByReturnArray) = OpportunitySortUtility.filterOpportunityByFilterBySearchText(opportunityToBeFiltered : enteredAnyFilterCaseReturn ? filteredOpportunityArray : opportunityToSearch!, searchText: trimmedSearchString)
            if filterCaseReturn {
                enteredAnyFilterCaseReturn = true
                filteredOpportunityArray = filteredByReturnArray
            }
        }

        if enteredAnyFilterCaseReturn {
            
            filteredOpportunityArray = opportunityRemoveDuplicates(filteredOpportunityArray)
            filteredOpportunityArray = opportunitySort(filteredOpportunityArray)
                        
            return filteredOpportunityArray
        }
        
        return opportunityToSearch
    }
    
    static func filterOpportunityByFilterByStatus(opportunityToBeFiltered : [Opportunity])-> (Bool, [Opportunity]){
        
        var filteredOpportunityArray = [Opportunity]()
        var enteredAnyFilterCase = false
        
        if (OpportunitiesFilterMenuModel.statusOpen == "YES" || OpportunitiesFilterMenuModel.statusPlanned == "YES" || OpportunitiesFilterMenuModel.statusClosedWon == "YES" || OpportunitiesFilterMenuModel.statusClosed == "YES") {
            
            var filteredStatusOpenOpportunityArray = [Opportunity]()
            
            enteredAnyFilterCase = true
            filteredStatusOpenOpportunityArray = opportunityToBeFiltered.filter( { return
                (OpportunitiesFilterMenuModel.statusOpen == "YES" && $0.status == "Open") ||
                (OpportunitiesFilterMenuModel.statusPlanned == "YES" && $0.status == "Planned") ||
                (OpportunitiesFilterMenuModel.statusClosedWon == "YES" && $0.status == "Closed Won") ||
                (OpportunitiesFilterMenuModel.statusClosed == "YES" && $0.status == "Closed") } )
            
            if filteredStatusOpenOpportunityArray.count > 0 {
                filteredOpportunityArray += filteredStatusOpenOpportunityArray
            }

        }
        
        return (enteredAnyFilterCase, filteredOpportunityArray)
    }
    
    static func filterOpportunityByFilterBySource(opportunityToBeFiltered : [Opportunity])-> (Bool, [Opportunity]){
        
        var filteredOpportunityArray = [Opportunity]()
        var enteredAnyFilterCase = false
        
        if (OpportunitiesFilterMenuModel.sourceOverview == "YES" || OpportunitiesFilterMenuModel.sourceTopSellers == "YES" || OpportunitiesFilterMenuModel.sourceUndersold == "YES" || OpportunitiesFilterMenuModel.sourceHotNot == "YES" || OpportunitiesFilterMenuModel.sourceUnsold == "YES") {
            
            var filteredStatusOpenOpportunityArray = [Opportunity]()
            
            enteredAnyFilterCase = true
            filteredStatusOpenOpportunityArray = opportunityToBeFiltered.filter( { return
                (OpportunitiesFilterMenuModel.sourceOverview == "YES" && $0.source == "Book Of Business") ||
                    (OpportunitiesFilterMenuModel.sourceTopSellers == "YES" && $0.source == "Top Sellers") ||
                    (OpportunitiesFilterMenuModel.sourceUndersold == "YES" && $0.source == "Undersold") ||
                    (OpportunitiesFilterMenuModel.sourceHotNot == "YES" && $0.source == "What's Hot/What's Not") ||
                    (OpportunitiesFilterMenuModel.sourceUnsold == "YES" && $0.source == "Unsold") } )
            
            if filteredStatusOpenOpportunityArray.count > 0 {
                filteredOpportunityArray += filteredStatusOpenOpportunityArray
            }
            
        }
        
        return (enteredAnyFilterCase, filteredOpportunityArray)
    }
    
    static func filterOpportunityByFilterByObjective(opportunityToBeFiltered : [Opportunity])-> (Bool, [Opportunity]){
        
        var filteredOpportunityArray = [Opportunity]()
        var enteredAnyFilterCase = false
        
        if (OpportunitiesFilterMenuModel.objective9L == "YES" || OpportunitiesFilterMenuModel.objectiveDecimal == "YES" || OpportunitiesFilterMenuModel.objectiveRevenue == "YES" || OpportunitiesFilterMenuModel.objectiveACS == "YES" || OpportunitiesFilterMenuModel.objectivePOD == "YES") {
            
            var filteredStatusOpenOpportunityArray = [Opportunity]()
            
            enteredAnyFilterCase = true
            filteredStatusOpenOpportunityArray = opportunityToBeFiltered.filter( { return
                (OpportunitiesFilterMenuModel.objective9L == "YES" && $0.objectiveTypes.self.range(of: "9L", options: .caseInsensitive) != nil) ||
                    (OpportunitiesFilterMenuModel.objectiveDecimal == "YES" && $0.objectiveTypes.self.range(of: "Decimal", options: .caseInsensitive) != nil) ||
                    (OpportunitiesFilterMenuModel.objectiveRevenue == "YES" && $0.objectiveTypes.self.range(of: "Revenue", options: .caseInsensitive) != nil) ||
                    (OpportunitiesFilterMenuModel.objectiveACS == "YES" && $0.objectiveTypes.self.range(of: "ACS", options: .caseInsensitive) != nil) ||
                    (OpportunitiesFilterMenuModel.objectivePOD == "YES" && $0.objectiveTypes.self.range(of: "POD", options: .caseInsensitive) != nil) } )
            
            if filteredStatusOpenOpportunityArray.count > 0 {
                filteredOpportunityArray += filteredStatusOpenOpportunityArray
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
    
    func opportunityRemoveDuplicates(_ opportunityToSort: [Opportunity]) -> [Opportunity] {
        
        var opportunitySorted = [Opportunity]()
        
        if opportunityToSort.count > 0 {
            let filteredNoDuplicateOpportunityArray = opportunityToSort.reduce([]) { (r, p) -> [Opportunity] in
                var r2 = r
                if !r.contains (where: { $0.id == p.id }) {
                    r2.append(p)
                }
                return r2
            }
            opportunitySorted = filteredNoDuplicateOpportunityArray
        }

        return opportunitySorted
    }
    

}

