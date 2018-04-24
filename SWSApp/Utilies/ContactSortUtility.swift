//
//  ContactSortUtility.swift
//  SWSApp
//
//  Created by Thillaiganesh, C. on 24/04/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class ContactSortUtility {

    static func searchContactBySearchBarQuery(contactsForLoggedUser:[Contact], searchText:String)->[Contact]
    {
        print("sortContactByFilterSearchBarQuery: " + searchText)
        var contactListWithSearchResults = [Contact]()
        // trim leading trailing white spaces
        let trimmedSearchString = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        for contact in contactsForLoggedUser
        {
            // search account name, account number, postal code and city
            if (contact.name.self.range(of: trimmedSearchString, options: .caseInsensitive) != nil
                || contact.firstName.self.range(of: trimmedSearchString, options: .caseInsensitive) != nil
                || contact.lastName.self.range(of: trimmedSearchString, options: .caseInsensitive) != nil)
            {
                contactListWithSearchResults.append(contact)
            }
        }
        return contactListWithSearchResults
    }
    
    static func filterContactByAppliedFilter(contactListToBeSorted : [Contact], searchBarText:String?)-> [Contact]{
        
        var filteredContactArray = contactListToBeSorted
        var filteredByReturnArray = [Contact]()
        var enteredAnyFilterCaseReturn = false
        
        // filter by contact association
        (enteredAnyFilterCaseReturn, filteredByReturnArray) = filterContactByFilterByAssociation(contactListToBeSorted: filteredContactArray)
        if enteredAnyFilterCaseReturn {
            filteredContactArray = filteredByReturnArray
        }

        // filter by role
        (enteredAnyFilterCaseReturn, filteredByReturnArray) = filterContactByFilterByRoles(contactListToBeSorted: filteredContactArray)
        if enteredAnyFilterCaseReturn {
            filteredContactArray = filteredByReturnArray
        }
        
        // filter by Buying Power
        (enteredAnyFilterCaseReturn, filteredByReturnArray) = filterContactByFilterByBuyingPower(contactListToBeSorted: filteredContactArray)
        if enteredAnyFilterCaseReturn {
            filteredContactArray = filteredByReturnArray
        }
        
        // now search filtered list by search text
        if(searchBarText != "")
        {
            filteredContactArray = searchContactBySearchBarQuery(contactsForLoggedUser: filteredContactArray, searchText: searchBarText!)
        }

        return filteredContactArray
    }
    
    static func filterContactByFilterByAssociation(contactListToBeSorted : [Contact])-> (Bool, [Contact]){
        
        var filteredContactArray = [Contact]()
        var enteredAnyFilterCase = false

        if ContactFilterMenuModel.allContacts == "YES" {
            enteredAnyFilterCase = true
            filteredContactArray = contactListToBeSorted
        }
        else if ContactFilterMenuModel.contactsOnMyRoute == "YES" {
            
            enteredAnyFilterCase = true
            let accountViewModel = AccountsViewModel()
            print(accountViewModel.accountsForLoggedUser)
            if accountViewModel.accountsForLoggedUser.count > 0 {
                
                var filteredAccountContactArray = [Contact]()
                for account in accountViewModel.accountsForLoggedUser {
                    filteredAccountContactArray += contactListToBeSorted.filter( { return account.account_Id == $0.accountId } )
                }

                if filteredContactArray.count > 0 {
                    let filteredNoDuplicateContactArray = filteredAccountContactArray.reduce([]) { (r, p) -> [Contact] in
                        var r2 = r
                        if !r.contains (where: { $0.contactId == p.contactId }) {
                            r2.append(p)
                        }
                        return r2
                    }
                    
                    filteredContactArray = filteredNoDuplicateContactArray
                }

            }
            
        }
        
        return (enteredAnyFilterCase, filteredContactArray)
    }

    static func filterContactByFilterByRoles(contactListToBeSorted : [Contact])-> (Bool, [Contact]){
        
        var filteredContactArray = [Contact]()
        var enteredAnyFilterCase = false
        
        if ContactFilterMenuModel.allRole == "YES"{
            enteredAnyFilterCase = true
            filteredContactArray = contactListToBeSorted
        }
        else if ContactFilterMenuModel.functionRoles.count > 0 {
            enteredAnyFilterCase = true
            filteredContactArray = contactListToBeSorted.filter( { return ContactFilterMenuModel.functionRoles.contains($0.functionRole) } )
        }

        return (enteredAnyFilterCase, filteredContactArray)
    }
    
    static func filterContactByFilterByBuyingPower(contactListToBeSorted : [Contact])-> (Bool, [Contact]){
        
        var filteredContactArray = [Contact]()
        var enteredAnyFilterCase = false

        // filter by All Buying Power
        if ContactFilterMenuModel.allBuyingPower == "YES"{
            if(enteredAnyFilterCase == false) {
                enteredAnyFilterCase = true
                filteredContactArray = contactListToBeSorted
            }
        }
        else {
            // filter by Buying Power
            var filteredBuyingPowerContactArray = [Contact]()
            var filteredNoBuyingPowerContactArray = [Contact]()

            if ContactFilterMenuModel.buyingPower == "YES"{
                filteredBuyingPowerContactArray = contactListToBeSorted.filter( { return $0.buyerFlag == "1" } )
            }
            
            // filter by NO Buying Power
            if ContactFilterMenuModel.nobuyingPower == "YES"{
                filteredNoBuyingPowerContactArray = contactListToBeSorted.filter( { return $0.buyerFlag == "0" } )
            }
            
            if filteredBuyingPowerContactArray.count > 0 {
                enteredAnyFilterCase = true
                filteredContactArray = filteredBuyingPowerContactArray
            }
            if filteredNoBuyingPowerContactArray.count > 0 {
                enteredAnyFilterCase = true
                filteredContactArray += filteredNoBuyingPowerContactArray
            }

        }
        
        return (enteredAnyFilterCase, filteredContactArray)
        
    }
    
}
