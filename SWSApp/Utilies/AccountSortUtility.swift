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
    
    static func sortAccountByFilterSearchBarQuery(accountsForLoggedUser:[Account], searchText:String)->[Account]
    {
        print("sortAccountByFilterSearchBarQuery: " + searchText)
        var accountsForLoggedUserFiltered = [Account]()
        // trim leading trailing white spaces
        let trimmedSearchString = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        for account in accountsForLoggedUser
        {
            if account.name.self.range(of: trimmedSearchString, options: .caseInsensitive) != nil
            {
                accountsForLoggedUserFiltered.append(account)
            }
        }
        return accountsForLoggedUserFiltered
    }
    
    static func sortAlphabetsByAscendingOrder(accountsListToBeSorted:[Account])->[Account]
    {
        var alphabeticallySortedAccountList = [Account]()
        alphabeticallySortedAccountList = accountsListToBeSorted.sorted { $0.name < $1.name }
        
        return alphabeticallySortedAccountList
    }
    
    static func sortAlphabetsByDescendingOrder(accountsListToBeSorted:[Account])->[Account]
    {
        var alphabeticallySortedAccountList = [Account]()
        alphabeticallySortedAccountList = accountsListToBeSorted.sorted { $0.name > $1.name }
        
        return alphabeticallySortedAccountList
    }
    
}
