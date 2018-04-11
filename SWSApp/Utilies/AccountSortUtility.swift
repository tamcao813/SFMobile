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
    
}

