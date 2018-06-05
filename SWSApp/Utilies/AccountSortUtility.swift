//
//  AccountSortUtility.swift
//  SWSApp
//
//  Created by shilpa.a.kulkarni on 09/04/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation

class AccountSortUtility
{
    // TODO: have to modify later .. currently getting either A or empty string from backend
    enum SingleMultiLocationEnum:String
    {
        case KSingleLocation = "Single"
        case KMultiLocation = "Multi"
    }
    
    static func searchAccountByAccountId(accountsForLoggedUser:[Account], accountId:String)->[Account]
    {

        return accountsForLoggedUser.filter( { return $0.account_Id == accountId } )

    }

    static func searchAccountBySearchBarQuery(accountsForLoggedUser:[Account], searchText:String)->[Account]
    {
        print("sortAccountByFilterSearchBarQuery: " + searchText)
        var accountsListWithSearchResults = [Account]()
        // trim leading trailing white spaces
        let trimmedSearchString = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        for account in accountsForLoggedUser
        {
            // search account name, account number, postal code and city
            if (account.accountName.self.range(of: trimmedSearchString, options: .caseInsensitive) != nil
                || account.accountNumber.self.range(of: trimmedSearchString, options: .caseInsensitive) != nil
                || account.shippingPostalCode.self.range(of: trimmedSearchString, options: .caseInsensitive) != nil
                || account.shippingCity.self.range(of: trimmedSearchString, options: .caseInsensitive) != nil)
            {
                accountsListWithSearchResults.append(account)
            }
        }
        return accountsListWithSearchResults
    }
    
    static func sortByAccountNameAlphabetically(accountsListToBeSorted:[Account], ascending:Bool)->[Account]
    {
        
        var alphabeticallySortedAccountList = [Account]()
        if(ascending == true)
        {
            alphabeticallySortedAccountList = accountsListToBeSorted.sorted { $0.accountName.lowercased() < $1.accountName.lowercased() }
        }
        else
        {
            alphabeticallySortedAccountList = accountsListToBeSorted.sorted { $1.accountName.lowercased() < $0.accountName.lowercased() }
        }
        
        
        return alphabeticallySortedAccountList
    }
    
    static func sortAccountsByActionItems(accountsListToBeSorted:[Account], ascending:Bool)->[Account]
    {
        var actionItemSortedAccountList = [Account]()
        if(ascending == true)
        {
            actionItemSortedAccountList = accountsListToBeSorted.sorted { $0.actionItem < $1.actionItem }
        }
        else
        {
            actionItemSortedAccountList = accountsListToBeSorted.sorted { $1.actionItem < $0.actionItem }
        }
        
        return actionItemSortedAccountList
    }
    
    static func sortAccountsByTotalNetSales(accountsListToBeSorted:[Account], ascending:Bool)->[Account]
    {
        var netSalesSortedAccountList = [Account]()
        if(ascending == true)
        {
            netSalesSortedAccountList = accountsListToBeSorted.sorted { $0.totalCYR12NetSales < $1.totalCYR12NetSales }
        }
        else
        {
            netSalesSortedAccountList = accountsListToBeSorted.sorted { $1.totalCYR12NetSales < $0.totalCYR12NetSales }
        }
        
        return netSalesSortedAccountList
    }
    
    static func sortAccountsByBalance(accountsListToBeSorted:[Account], ascending:Bool)->[Account]
    {
        var balanceSortedAccountList = [Account]()
        if(ascending == true)
        {
            balanceSortedAccountList = accountsListToBeSorted.sorted { $0.pastDueAmountDouble < $1.pastDueAmountDouble }
        }
        else
        {
            balanceSortedAccountList = accountsListToBeSorted.sorted { $1.pastDueAmountDouble < $0.pastDueAmountDouble }
        }
        
        return balanceSortedAccountList
    }
    
    // considering date format as MM-DD-YYYY for now.. 9April
    static func sortAccountsByNextDeliveryDate(accountsListToBeSorted:[Account], ascending:Bool)->[Account]
    {
        // 13April Shilpa: Handling the empty date coming from backend for some of the accounts
        for accountObject in accountsListToBeSorted
        {
            if(accountObject.nextDeliveryDate.count == 0)
            {
                accountObject.nextDeliveryDate = "1969-12-31"// "yyyy-mm-dd"
            }
        }
        
        var dateSortedAccountList = [Account]()
        // 13April: Date coming into string format now. previously it was Date() object
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"// MM/DD/YYYY Account object has date format as yyyy-mm-dd
        
        if(ascending == true)
        {
            
            dateSortedAccountList = accountsListToBeSorted.sorted(by: { dateFormatter.date(from:$0.nextDeliveryDate)?.compare(dateFormatter.date(from:$1.nextDeliveryDate)!) == .orderedAscending })
        }
        else
        {
            dateSortedAccountList = accountsListToBeSorted.sorted(by: { dateFormatter.date(from:$0.nextDeliveryDate)?.compare(dateFormatter.date(from:$1.nextDeliveryDate)!) == .orderedDescending })
        }
        
        return dateSortedAccountList
    }
    
    static func filterAccountByAppliedFilter(accountsListToBeSorted : [Account], searchBarText:String?)-> [Account]{
        
        var filteredSearchedArray = [Account]()
        var filteredByPastDue_PremiseCode_LicenseTypeAccountArray = [Account]()
        var filteredByReturnArray = [Account]()
        var enteredAnyFilterCase = false
        var enteredAnyFilterCaseReturn = false
        
        var accountsToFilter = accountsListToBeSorted
        
        // if selected a consultant to filter
        if let _ = FilterMenuModel.selectedConsultant {
            accountsToFilter = AccountsViewModel().accountsForSelectedUser()
            accountsToFilter = accountsToFilter.sorted{ $0.accountName < $1.accountName}
        }
        
        // filter by past due
        (enteredAnyFilterCaseReturn, filteredByReturnArray) = filterAccountByFilterByPastDue(accountsListToBeSorted: accountsToFilter)
        if enteredAnyFilterCaseReturn {
            enteredAnyFilterCase = true
            filteredByPastDue_PremiseCode_LicenseTypeAccountArray = filteredByReturnArray
        }
        else {
            filteredByPastDue_PremiseCode_LicenseTypeAccountArray = accountsToFilter
        }
        
        // filter by  premise code
        // filter by license type
        // filter by single or multilocation
        if(enteredAnyFilterCase == false)
        {
            (enteredAnyFilterCaseReturn, filteredByReturnArray) = filterAccountByFilterPremiseCodeRelated(accountsListToBeSorted: accountsToFilter)
        }
        else
        {
            (enteredAnyFilterCaseReturn, filteredByReturnArray) = filterAccountByFilterPremiseCodeRelated(accountsListToBeSorted: filteredByPastDue_PremiseCode_LicenseTypeAccountArray)
        }
        if enteredAnyFilterCaseReturn {
            enteredAnyFilterCase = true
            filteredByPastDue_PremiseCode_LicenseTypeAccountArray = filteredByReturnArray
        }
        
        //For Channel Filtering
        //For SubChannel Filtering
        //For Active
        //For Inactive
        //For Suspended
        if(enteredAnyFilterCase == false)
        {
            (enteredAnyFilterCaseReturn, filteredByReturnArray) = filterAccountByFilterForChannelRelatedFiltering(accountsListToBeSorted: accountsToFilter)
        }
        else
        {
            (enteredAnyFilterCaseReturn, filteredByReturnArray) = filterAccountByFilterForChannelRelatedFiltering(accountsListToBeSorted: filteredByPastDue_PremiseCode_LicenseTypeAccountArray)
        }
        if enteredAnyFilterCaseReturn {
            enteredAnyFilterCase = true
            filteredByPastDue_PremiseCode_LicenseTypeAccountArray = filteredByReturnArray
        }
        
        // now search filtered list by search text
        if(searchBarText != "" && enteredAnyFilterCase == true) // user filtered list fot search
        {
            filteredSearchedArray = searchAccountBySearchBarQuery(accountsForLoggedUser: filteredByPastDue_PremiseCode_LicenseTypeAccountArray, searchText: searchBarText!)
        }
        else if(searchBarText != "" && enteredAnyFilterCase == false) // use main list for search
        {
            filteredSearchedArray = searchAccountBySearchBarQuery(accountsForLoggedUser: accountsToFilter, searchText: searchBarText!)
        }
        else
        {
            filteredSearchedArray =  filteredByPastDue_PremiseCode_LicenseTypeAccountArray
        }
        
        filteredSearchedArray = filteredSearchedArray.sorted{ $0.accountName.lowercased() < $1.accountName.lowercased()}
        
        return filteredSearchedArray
    }
    
    static func filterAccountByFilterByPastDue(accountsListToBeSorted : [Account])-> (Bool, [Account]){
        
        var filteredByPastDue_PremiseCode_LicenseTypeAccountArray = [Account]()
        var enteredAnyFilterCase = false
        
        if FilterMenuModel.pastDueNo != "" || FilterMenuModel.pastDueYes != ""{
            enteredAnyFilterCase = true
            if FilterMenuModel.pastDueYes == "YES"{
                
                filteredByPastDue_PremiseCode_LicenseTypeAccountArray = accountsListToBeSorted.filter( { return $0.pastDueAmountDouble > 0 } )
                
            }else if FilterMenuModel.pastDueNo == "YES" {
                
                filteredByPastDue_PremiseCode_LicenseTypeAccountArray = accountsListToBeSorted.filter( { return $0.pastDueAmountDouble <= 0 } )
                
            }
        }
        
        return (enteredAnyFilterCase, filteredByPastDue_PremiseCode_LicenseTypeAccountArray)
        
    }
    
    static func filterAccountByFilterPremiseCodeRelated(accountsListToBeSorted : [Account])-> (Bool, [Account]){
        
        var filteredByPastDue_PremiseCode_LicenseTypeAccountArray = [Account]()
        var filteredByReturnArray = [Account]()
        var enteredAnyFilterCase = false
        var enteredAnyFilterCaseReturn = false
        
        // filter by  premise code
        (enteredAnyFilterCaseReturn, filteredByReturnArray) = filterAccountByFilterByPremiseCode(accountsListToBeSorted: accountsListToBeSorted)
        if enteredAnyFilterCaseReturn {
            enteredAnyFilterCase = true
            filteredByPastDue_PremiseCode_LicenseTypeAccountArray = filteredByReturnArray
        }
        
        // filter by license type
        if(enteredAnyFilterCase == false)
        {
            (enteredAnyFilterCaseReturn, filteredByReturnArray) = filterAccountByFilterByLicenseType(accountsListToBeSorted: accountsListToBeSorted)
        }
        else
        {
            (enteredAnyFilterCaseReturn, filteredByReturnArray) = filterAccountByFilterByLicenseType(accountsListToBeSorted: filteredByPastDue_PremiseCode_LicenseTypeAccountArray)
        }
        if enteredAnyFilterCaseReturn {
            enteredAnyFilterCase = true
            filteredByPastDue_PremiseCode_LicenseTypeAccountArray = filteredByReturnArray
        }
        
        // filter by single or multilocation
        if(enteredAnyFilterCase == false)
        {
            (enteredAnyFilterCaseReturn, filteredByReturnArray) = filterAccountByFilterBySingleOrMultilocation(accountsListToBeSorted: accountsListToBeSorted)
        }
        else
        {
            (enteredAnyFilterCaseReturn, filteredByReturnArray) = filterAccountByFilterBySingleOrMultilocation(accountsListToBeSorted: filteredByPastDue_PremiseCode_LicenseTypeAccountArray)
        }
        if enteredAnyFilterCaseReturn {
            enteredAnyFilterCase = true
            filteredByPastDue_PremiseCode_LicenseTypeAccountArray = filteredByReturnArray
        }
        
        return (enteredAnyFilterCase, filteredByPastDue_PremiseCode_LicenseTypeAccountArray)
        
    }
    
    static func filterAccountByFilterByPremiseCode(accountsListToBeSorted : [Account])-> (Bool, [Account]){
        
        var filteredByPastDue_PremiseCode_LicenseTypeAccountArray = [Account]()
        var enteredAnyFilterCase = false
        
        if FilterMenuModel.premiseOn != "" || FilterMenuModel.premiseOff != ""{
            enteredAnyFilterCase = true
            if FilterMenuModel.premiseOn == "YES"{
                
                filteredByPastDue_PremiseCode_LicenseTypeAccountArray = accountsListToBeSorted.filter( { return $0.premiseCode == "ON" } )
                
            }
            else if FilterMenuModel.premiseOff == "YES"
            {
                
                filteredByPastDue_PremiseCode_LicenseTypeAccountArray = accountsListToBeSorted.filter( { return $0.premiseCode == "OFF" } )
                
            }
        }
        
        return (enteredAnyFilterCase, filteredByPastDue_PremiseCode_LicenseTypeAccountArray)
        
    }
    
    static func filterAccountByFilterByLicenseType(accountsListToBeSorted : [Account])-> (Bool, [Account]){
        
        var filteredByPastDue_PremiseCode_LicenseTypeAccountArray = [Account]()
        var enteredAnyFilterCase = false
        
        if FilterMenuModel.licenseB != "" || FilterMenuModel.licenseL != "" || FilterMenuModel.licenseN != "" || FilterMenuModel.licenseW != ""{
            enteredAnyFilterCase = true
            
            if FilterMenuModel.licenseB == "YES"{
                
                filteredByPastDue_PremiseCode_LicenseTypeAccountArray = accountsListToBeSorted.filter( { return $0.licenseType == "B" } )
                
            }else if FilterMenuModel.licenseL == "YES" {
                
                filteredByPastDue_PremiseCode_LicenseTypeAccountArray = accountsListToBeSorted.filter( { return $0.licenseType == "L" } )
                
            }
            else if FilterMenuModel.licenseN == "YES" {
                
                filteredByPastDue_PremiseCode_LicenseTypeAccountArray = accountsListToBeSorted.filter( { return $0.licenseType == "N" } )
                
            }
            else if FilterMenuModel.licenseW == "YES" {
                
                filteredByPastDue_PremiseCode_LicenseTypeAccountArray = accountsListToBeSorted.filter( { return $0.licenseType == "W" } )
                
            }
        }
        
        return (enteredAnyFilterCase, filteredByPastDue_PremiseCode_LicenseTypeAccountArray)
        
    }
    
    static func filterAccountByFilterBySingleOrMultilocation(accountsListToBeSorted : [Account])-> (Bool, [Account]){
        
        var filteredByPastDue_PremiseCode_LicenseTypeAccountArray = [Account]()
        var enteredAnyFilterCase = false
        
        if FilterMenuModel.singleSelected != "" || FilterMenuModel.multiSelected != ""{
            enteredAnyFilterCase = true
            if FilterMenuModel.singleSelected == "YES"
            {
                filteredByPastDue_PremiseCode_LicenseTypeAccountArray = accountsListToBeSorted.filter( { return $0.singleMultiLocationFilter == SingleMultiLocationEnum.KSingleLocation.rawValue } )
            }
            else if FilterMenuModel.multiSelected == "YES"
            {
                filteredByPastDue_PremiseCode_LicenseTypeAccountArray = accountsListToBeSorted.filter( { return $0.singleMultiLocationFilter == SingleMultiLocationEnum.KMultiLocation.rawValue } )
            }
        }
        
        return (enteredAnyFilterCase, filteredByPastDue_PremiseCode_LicenseTypeAccountArray)
        
    }
    
    
    static func filterAccountByFilterForChannelRelatedFiltering(accountsListToBeSorted : [Account])-> (Bool, [Account]){
        
        var filteredByPastDue_PremiseCode_LicenseTypeAccountArray = [Account]()
        var filteredByReturnArray = [Account]()
        var enteredAnyFilterCase = false
        var enteredAnyFilterCaseReturn = false
        
        //For Channel Filtering
        (enteredAnyFilterCaseReturn, filteredByReturnArray) = filterAccountByFilterForChannelFiltering(accountsListToBeSorted: accountsListToBeSorted)
        if enteredAnyFilterCaseReturn {
            enteredAnyFilterCase = true
            filteredByPastDue_PremiseCode_LicenseTypeAccountArray = filteredByReturnArray
        }
        
        //For SubChannel Filtering
        if(enteredAnyFilterCase == false)
        {
            (enteredAnyFilterCaseReturn, filteredByReturnArray) = filterAccountByFilterForSubChannelFiltering(accountsListToBeSorted: accountsListToBeSorted)
        }
        else
        {
            (enteredAnyFilterCaseReturn, filteredByReturnArray) = filterAccountByFilterForSubChannelFiltering(accountsListToBeSorted: filteredByPastDue_PremiseCode_LicenseTypeAccountArray)
        }
        if enteredAnyFilterCaseReturn {
            enteredAnyFilterCase = true
            filteredByPastDue_PremiseCode_LicenseTypeAccountArray = filteredByReturnArray
        }
        
        //For Active
        if(enteredAnyFilterCase == false)
        {
            (enteredAnyFilterCaseReturn, filteredByReturnArray) = filterAccountByFilterForActive(accountsListToBeSorted: accountsListToBeSorted)
        }
        else
        {
            (enteredAnyFilterCaseReturn, filteredByReturnArray) = filterAccountByFilterForActive(accountsListToBeSorted: filteredByPastDue_PremiseCode_LicenseTypeAccountArray)
        }
        if enteredAnyFilterCaseReturn {
            enteredAnyFilterCase = true
            filteredByPastDue_PremiseCode_LicenseTypeAccountArray = filteredByReturnArray
        }
        
        //For Inactive
        if(enteredAnyFilterCase == false)
        {
            (enteredAnyFilterCaseReturn, filteredByReturnArray) = filterAccountByFilterForInactive(accountsListToBeSorted: accountsListToBeSorted)
        }
        else
        {
            (enteredAnyFilterCaseReturn, filteredByReturnArray) = filterAccountByFilterForInactive(accountsListToBeSorted: filteredByPastDue_PremiseCode_LicenseTypeAccountArray)
        }
        if enteredAnyFilterCaseReturn {
            enteredAnyFilterCase = true
            filteredByPastDue_PremiseCode_LicenseTypeAccountArray = filteredByReturnArray
        }
        
        //For Suspended
        if(enteredAnyFilterCase == false)
        {
            (enteredAnyFilterCaseReturn, filteredByReturnArray) = filterAccountByFilterForSuspended(accountsListToBeSorted: accountsListToBeSorted)
        }
        else
        {
            (enteredAnyFilterCaseReturn, filteredByReturnArray) = filterAccountByFilterForSuspended(accountsListToBeSorted: filteredByPastDue_PremiseCode_LicenseTypeAccountArray)
        }
        if enteredAnyFilterCaseReturn {
            enteredAnyFilterCase = true
            filteredByPastDue_PremiseCode_LicenseTypeAccountArray = filteredByReturnArray
        }
        
        return (enteredAnyFilterCase, filteredByPastDue_PremiseCode_LicenseTypeAccountArray)
        
    }
    
    static func filterAccountByFilterForChannelFiltering(accountsListToBeSorted : [Account])-> (Bool, [Account]){
        
        var filteredByPastDue_PremiseCode_LicenseTypeAccountArray = [Account]()
        var enteredAnyFilterCase = false
        
        if FilterMenuModel.channel != ""{
            enteredAnyFilterCase = true
            filteredByPastDue_PremiseCode_LicenseTypeAccountArray = accountsListToBeSorted.filter( { return $0.channelTD == FilterMenuModel.channel } )
        }
        
        return (enteredAnyFilterCase, filteredByPastDue_PremiseCode_LicenseTypeAccountArray)
        
    }
    
    static func filterAccountByFilterForSubChannelFiltering(accountsListToBeSorted : [Account])-> (Bool, [Account]){
        
        var filteredByPastDue_PremiseCode_LicenseTypeAccountArray = [Account]()
        var enteredAnyFilterCase = false
        
        if FilterMenuModel.subChannel != ""{
            enteredAnyFilterCase = true
            filteredByPastDue_PremiseCode_LicenseTypeAccountArray = accountsListToBeSorted.filter( { return $0.subChannelTD == FilterMenuModel.subChannel } )
        }
        
        return (enteredAnyFilterCase, filteredByPastDue_PremiseCode_LicenseTypeAccountArray)
        
    }
    
    static func filterAccountByFilterForActive(accountsListToBeSorted : [Account])-> (Bool, [Account]){
        
        var filteredByPastDue_PremiseCode_LicenseTypeAccountArray = [Account]()
        var enteredAnyFilterCase = false
        
        if FilterMenuModel.statusIsActive != ""{
            enteredAnyFilterCase = true
            filteredByPastDue_PremiseCode_LicenseTypeAccountArray = accountsListToBeSorted.filter( { return $0.acctDescStatus == "A" } )
        }
        
        return (enteredAnyFilterCase, filteredByPastDue_PremiseCode_LicenseTypeAccountArray)
        
    }
    
    static func filterAccountByFilterForInactive(accountsListToBeSorted : [Account])-> (Bool, [Account]){
        
        var filteredByPastDue_PremiseCode_LicenseTypeAccountArray = [Account]()
        var enteredAnyFilterCase = false
        
        if FilterMenuModel.statusIsInActive != ""{
            enteredAnyFilterCase = true
            filteredByPastDue_PremiseCode_LicenseTypeAccountArray = accountsListToBeSorted.filter( { return $0.acctDescStatus == "I" } )
        }
        
        return (enteredAnyFilterCase, filteredByPastDue_PremiseCode_LicenseTypeAccountArray)
        
    }
    
    static func filterAccountByFilterForSuspended(accountsListToBeSorted : [Account])-> (Bool, [Account]){
        
        var filteredByPastDue_PremiseCode_LicenseTypeAccountArray = [Account]()
        var enteredAnyFilterCase = false
        
        if FilterMenuModel.statusIsSuspended != ""{
            enteredAnyFilterCase = true
            filteredByPastDue_PremiseCode_LicenseTypeAccountArray = accountsListToBeSorted.filter( { return $0.acctDescStatus == "S" } )
        }
        
        return (enteredAnyFilterCase, filteredByPastDue_PremiseCode_LicenseTypeAccountArray)
        
    }
    
    static func filterAccountByConsultant(accountsListToBeFiltered : [Account])-> [Account] {
        var filteredAccounts = [Account]()
        
        if let consultant = FilterMenuModel.selectedConsultant  {
            filteredAccounts = AccountsViewModel().accountsForSelectedUser()
        }
        
        return filteredAccounts
    }
    
}

