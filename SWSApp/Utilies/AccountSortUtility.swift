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
        var enteredAnyFilterCase = false
        
        // filter by past due
        if FilterMenuModel.pastDueNo != "" || FilterMenuModel.pastDueYes != ""{
            enteredAnyFilterCase = true
            if FilterMenuModel.pastDueYes == "YES"{
                
                filteredByPastDue_PremiseCode_LicenseTypeAccountArray = accountsListToBeSorted.filter( { return $0.pastDueAmountDouble > 0 } )
                
            }else if FilterMenuModel.pastDueNo == "YES" {
                
                filteredByPastDue_PremiseCode_LicenseTypeAccountArray = accountsListToBeSorted.filter( { return $0.pastDueAmountDouble <= 0 } )
                
            }
        }
        
        if(enteredAnyFilterCase == false)
        {
            // filter by  premise code
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
        }
        else
        {
            // filter by  premise code
            if FilterMenuModel.premiseOn != "" || FilterMenuModel.premiseOff != ""{
                enteredAnyFilterCase = true
                if FilterMenuModel.premiseOn == "YES"{
                    
                    filteredByPastDue_PremiseCode_LicenseTypeAccountArray = filteredByPastDue_PremiseCode_LicenseTypeAccountArray.filter( { return $0.premiseCode == "ON" } )
                    
                }else if FilterMenuModel.premiseOff == "YES" {
                    
                    filteredByPastDue_PremiseCode_LicenseTypeAccountArray = filteredByPastDue_PremiseCode_LicenseTypeAccountArray.filter( { return $0.premiseCode == "OFF" } )
                    
                }
            }
        }
        
        
        // filter by license type
        if(enteredAnyFilterCase == false)
        {
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
        }
        else
        {
            if FilterMenuModel.licenseB != "" || FilterMenuModel.licenseL != "" || FilterMenuModel.licenseN != "" || FilterMenuModel.licenseW != ""{
                enteredAnyFilterCase = true
                
                if FilterMenuModel.licenseB == "YES"{
                    
                    filteredByPastDue_PremiseCode_LicenseTypeAccountArray = filteredByPastDue_PremiseCode_LicenseTypeAccountArray.filter( { return $0.licenseType == "B" } )
                    
                }else if FilterMenuModel.licenseL == "YES" {
                    
                    filteredByPastDue_PremiseCode_LicenseTypeAccountArray = filteredByPastDue_PremiseCode_LicenseTypeAccountArray.filter( { return $0.licenseType == "L" } )
                    
                }
                else if FilterMenuModel.licenseN == "YES" {
                    
                    filteredByPastDue_PremiseCode_LicenseTypeAccountArray = filteredByPastDue_PremiseCode_LicenseTypeAccountArray.filter( { return $0.licenseType == "N" } )
                    
                }
                else if FilterMenuModel.licenseW == "YES" {
                    
                    filteredByPastDue_PremiseCode_LicenseTypeAccountArray = filteredByPastDue_PremiseCode_LicenseTypeAccountArray.filter( { return $0.licenseType == "W" } )
                    
                }
            }
        }
        
        // filter by single or multilocation
        if(enteredAnyFilterCase == false)
        {
            // filter by  single or multilocation
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
        }
        else
        {
            // filter by  single or multilocation
            if FilterMenuModel.singleSelected != "" || FilterMenuModel.multiSelected != ""{
                enteredAnyFilterCase = true
                if FilterMenuModel.singleSelected == "YES"{
                    
                    filteredByPastDue_PremiseCode_LicenseTypeAccountArray = filteredByPastDue_PremiseCode_LicenseTypeAccountArray.filter( { return $0.singleMultiLocationFilter == SingleMultiLocationEnum.KSingleLocation.rawValue } )
                    
                }else if FilterMenuModel.multiSelected == "YES" {
                    
                    filteredByPastDue_PremiseCode_LicenseTypeAccountArray = filteredByPastDue_PremiseCode_LicenseTypeAccountArray.filter( { return $0.singleMultiLocationFilter == SingleMultiLocationEnum.KMultiLocation.rawValue } )
                    
                }
            }
        }
        
        //For Channel Filtering
        if(enteredAnyFilterCase == false){
            
            if FilterMenuModel.channel != ""{
                enteredAnyFilterCase = true
                filteredByPastDue_PremiseCode_LicenseTypeAccountArray = accountsListToBeSorted.filter( { return $0.channelTD == FilterMenuModel.channel } )
            }
            
        }else{
            
            if FilterMenuModel.channel != ""{
                enteredAnyFilterCase = true
                filteredByPastDue_PremiseCode_LicenseTypeAccountArray = filteredByPastDue_PremiseCode_LicenseTypeAccountArray.filter( { return $0.channelTD == FilterMenuModel.channel } )
            }
            
        }
        
        
        //For SubChannel Filtering
        if(enteredAnyFilterCase == false){
            
            if FilterMenuModel.subChannel != ""{
                enteredAnyFilterCase = true
                filteredByPastDue_PremiseCode_LicenseTypeAccountArray = accountsListToBeSorted.filter( { return $0.subChannelTD == FilterMenuModel.subChannel } )
            }
            
        }else{
            
            if FilterMenuModel.subChannel != ""{
                enteredAnyFilterCase = true
                filteredByPastDue_PremiseCode_LicenseTypeAccountArray = filteredByPastDue_PremiseCode_LicenseTypeAccountArray.filter( { return $0.subChannelTD == FilterMenuModel.subChannel } )
            }
            
        }
        
        
        //For Active
        if(enteredAnyFilterCase == false){
            
            if FilterMenuModel.statusIsActive != ""{
                enteredAnyFilterCase = true
                filteredByPastDue_PremiseCode_LicenseTypeAccountArray = accountsListToBeSorted.filter( { return $0.acctDescStatus == "A" } )
            }
            
        }else{
            
            if FilterMenuModel.statusIsActive != ""{
                enteredAnyFilterCase = true
                filteredByPastDue_PremiseCode_LicenseTypeAccountArray = filteredByPastDue_PremiseCode_LicenseTypeAccountArray.filter( { return $0.acctDescStatus == "A" } )
            }
            
        }
        
        
        //For Inactive
        if(enteredAnyFilterCase == false){
            
            if FilterMenuModel.statusIsInActive != ""{
                enteredAnyFilterCase = true
                filteredByPastDue_PremiseCode_LicenseTypeAccountArray = accountsListToBeSorted.filter( { return $0.acctDescStatus == "I" } )
            }
            
        }else{
            
            if FilterMenuModel.statusIsInActive != ""{
                enteredAnyFilterCase = true
                filteredByPastDue_PremiseCode_LicenseTypeAccountArray = filteredByPastDue_PremiseCode_LicenseTypeAccountArray.filter( { return $0.acctDescStatus == "I" } )
            }
            
        }
        
        //For Suspended
        if(enteredAnyFilterCase == false){
            
            if FilterMenuModel.statusIsSuspended != ""{
                enteredAnyFilterCase = true
                filteredByPastDue_PremiseCode_LicenseTypeAccountArray = accountsListToBeSorted.filter( { return $0.acctDescStatus == "S" } )
            }
            
        }else{
            
            if FilterMenuModel.statusIsSuspended != ""{
                enteredAnyFilterCase = true
                filteredByPastDue_PremiseCode_LicenseTypeAccountArray = filteredByPastDue_PremiseCode_LicenseTypeAccountArray.filter( { return $0.acctDescStatus == "S" } )
            }
            
        }
        
        
        // now search filtered list by search text
        if(searchBarText != "" && enteredAnyFilterCase == true) // user filtered list fot search
        {
            filteredSearchedArray = searchAccountBySearchBarQuery(accountsForLoggedUser: filteredByPastDue_PremiseCode_LicenseTypeAccountArray, searchText: searchBarText!)
        }
        else if(searchBarText != "" && enteredAnyFilterCase == false) // use main list for search
        {
            filteredSearchedArray = searchAccountBySearchBarQuery(accountsForLoggedUser: accountsListToBeSorted, searchText: searchBarText!)
        }
        else
        {
            filteredSearchedArray =  filteredByPastDue_PremiseCode_LicenseTypeAccountArray
        }
        
        
        return filteredSearchedArray
    }
    
}

