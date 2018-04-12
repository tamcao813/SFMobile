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
        case KSingleLocation = ""
        case KMultiLocation = "A"
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
            alphabeticallySortedAccountList = accountsListToBeSorted.sorted { $0.accountName < $1.accountName }
        }
        else
        {
            alphabeticallySortedAccountList = accountsListToBeSorted.sorted { $1.accountName < $0.accountName }
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
            balanceSortedAccountList = accountsListToBeSorted.sorted { $0.totalARBalance < $1.totalARBalance }
        }
        else
        {
            balanceSortedAccountList = accountsListToBeSorted.sorted { $1.totalARBalance < $0.totalARBalance }
        }
        
        return balanceSortedAccountList
    }
    
    // considering date format as MM-DD-YYYY for now.. 9April
    static func sortAccountsByNextDeliveryDate(accountsListToBeSorted:[Account], ascending:Bool)->[Account]
    {
        var dateSortedAccountList = [Account]()
        
        if(ascending == true)
        {
            
            dateSortedAccountList = accountsListToBeSorted.sorted(by: { $0.nextDeliveryDate.compare($1.nextDeliveryDate) == .orderedAscending })
        }
        else
        {
            dateSortedAccountList = accountsListToBeSorted.sorted(by: { $0.nextDeliveryDate.compare($1.nextDeliveryDate) == .orderedDescending })
        }
        
        return dateSortedAccountList
    }
    
    static func filterAccountByAppliedFilter(accountsListToBeSorted : [Account], searchBarText:String?)-> [Account]{
        
        var filteredSearchedArray = [Account]()
        var filteredByPastDue_PremiseCode_LicenseTypeAccountArray = [Account]()
        
        // filter by past due
        if FilterMenuModel.pastDueNo != "" || FilterMenuModel.pastDueYes != ""{
            if FilterMenuModel.pastDueYes == "YES"{
                
                filteredByPastDue_PremiseCode_LicenseTypeAccountArray = accountsListToBeSorted.filter( { return $0.pastDueAmount > 0 } )
                
            }else if FilterMenuModel.pastDueNo == "YES" {
                
                filteredByPastDue_PremiseCode_LicenseTypeAccountArray = accountsListToBeSorted.filter( { return $0.pastDueAmount <= 0 } )
                
            }
        }
        
        if(filteredByPastDue_PremiseCode_LicenseTypeAccountArray.count == 0)
        {
            // filter by  premise code
            if FilterMenuModel.premiseOn != "" || FilterMenuModel.premiseOff != ""{
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
                if FilterMenuModel.premiseOn == "YES"{
                    
                    filteredByPastDue_PremiseCode_LicenseTypeAccountArray = filteredByPastDue_PremiseCode_LicenseTypeAccountArray.filter( { return $0.premiseCode == "ON" } )
                    
                }else if FilterMenuModel.premiseOff == "YES" {
                    
                    filteredByPastDue_PremiseCode_LicenseTypeAccountArray = filteredByPastDue_PremiseCode_LicenseTypeAccountArray.filter( { return $0.premiseCode == "OFF" } )
                    
                }
            }
        }
        
        
        // filter by license type
        if(filteredByPastDue_PremiseCode_LicenseTypeAccountArray.count == 0)
        {
            if FilterMenuModel.licenseB != "" || FilterMenuModel.licenseL != "" || FilterMenuModel.licenseN != "" || FilterMenuModel.licenseW != ""{
                
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
        if(filteredByPastDue_PremiseCode_LicenseTypeAccountArray.count == 0)
        {
            // filter by  single or multilocation
            if FilterMenuModel.singleSelected != "" || FilterMenuModel.multiSelected != ""{
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
                if FilterMenuModel.singleSelected == "YES"{
                    
                    filteredByPastDue_PremiseCode_LicenseTypeAccountArray = filteredByPastDue_PremiseCode_LicenseTypeAccountArray.filter( { return $0.singleMultiLocationFilter == SingleMultiLocationEnum.KSingleLocation.rawValue } )
                    
                }else if FilterMenuModel.multiSelected == "YES" {
                    
                    filteredByPastDue_PremiseCode_LicenseTypeAccountArray = filteredByPastDue_PremiseCode_LicenseTypeAccountArray.filter( { return $0.singleMultiLocationFilter == SingleMultiLocationEnum.KMultiLocation.rawValue } )
                    
                }
            }
        }
        
        
        // now search filtered list by search text
        if(searchBarText != "")
        {
            if(filteredByPastDue_PremiseCode_LicenseTypeAccountArray.count == 0)
            {
                filteredSearchedArray = searchAccountBySearchBarQuery(accountsForLoggedUser: accountsListToBeSorted, searchText: searchBarText!)
            }
            else
            {
                filteredSearchedArray = searchAccountBySearchBarQuery(accountsForLoggedUser: filteredByPastDue_PremiseCode_LicenseTypeAccountArray, searchText: searchBarText!)
            }
        }
        else
        {
            filteredSearchedArray = filteredByPastDue_PremiseCode_LicenseTypeAccountArray
        }
        
        return filteredSearchedArray
    }
    
}

