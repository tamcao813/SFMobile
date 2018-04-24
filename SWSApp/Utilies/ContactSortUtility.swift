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
        
        var filteredContactArray = [Contact]()
        var filteredByReturnArray = [Contact]()
        var enteredAnyFilterCase = false
        var enteredAnyFilterCaseReturn = false
        
        // filter by role
        if ContactFilterMenuModel.allRole == "YES"{
            enteredAnyFilterCase = true
            filteredContactArray = contactListToBeSorted
        }
        else if ContactFilterMenuModel.functionRoles.count > 0 {
            enteredAnyFilterCase = true
            filteredContactArray = contactListToBeSorted.filter( { return ContactFilterMenuModel.functionRoles.contains($0.functionRole) } )
        }
        
        // filter by Buying Power
        if(enteredAnyFilterCase == false)
        {
            (enteredAnyFilterCaseReturn, filteredByReturnArray) = filterContactByFilterByBuyingPower(contactListToBeSorted: contactListToBeSorted)
        }
        else
        {
            (enteredAnyFilterCaseReturn, filteredByReturnArray) = filterContactByFilterByBuyingPower(contactListToBeSorted: filteredContactArray)
        }
        if enteredAnyFilterCaseReturn {
            enteredAnyFilterCase = true
            filteredContactArray = filteredByReturnArray
        }
        
        // now search filtered list by search text
        if(searchBarText != "" && enteredAnyFilterCase == true) // user filtered list fot search
        {
            filteredContactArray = searchContactBySearchBarQuery(contactsForLoggedUser: filteredContactArray, searchText: searchBarText!)
        }
        else if(searchBarText != "" && enteredAnyFilterCase == false) // use main list for search
        {
            filteredContactArray = searchContactBySearchBarQuery(contactsForLoggedUser: contactListToBeSorted, searchText: searchBarText!)
        }

        return filteredContactArray
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
            if ContactFilterMenuModel.buyingPower == "YES"{
                if(enteredAnyFilterCase == false)
                {
                    enteredAnyFilterCase = true
                    filteredContactArray = contactListToBeSorted.filter( { return $0.buyerFlag == "1" } )
                }
                else {
                    filteredContactArray = filteredContactArray.filter( { return $0.buyerFlag == "1" } )
                }
            }
            
            // filter by NO Buying Power
            if ContactFilterMenuModel.nobuyingPower == "YES"{
                if(enteredAnyFilterCase == false)
                {
                    enteredAnyFilterCase = true
                    filteredContactArray = contactListToBeSorted.filter( { return $0.buyerFlag == "0" } )
                }
                else {
                    filteredContactArray = filteredContactArray.filter( { return $0.buyerFlag == "0" } )
                }
            }
        }
        
        return (enteredAnyFilterCase, filteredContactArray)
        
    }
    
}
