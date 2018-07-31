//
//  ContactSortUtility.swift
//  SWSApp
//
//  Created by Thillaiganesh, C. on 24/04/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class ContactSortUtility {
    
    static func searchContactByContactId(_ contactId:String)->Contact?{
        let contactList = ContactsViewModel().globalContacts().filter( { return $0.contactId == contactId } )
        if contactList.count > 0 {
            return contactList[0]
        }else {
            return nil
        }
    }
    
    static func searchContactByContactId(contactList:[Contact], contactId:String)->Contact?{
        let contactList = contactList.filter( { return $0.contactId == contactId } )
        if contactList.count > 0 {
            return contactList[0]
        }else {
            return nil
        }
    }
    
    static func sortByContactNameAlphabetically(contactsListToBeSorted:[Contact], ascending:Bool)->[Contact]{
        var alphabeticallySortedContactList = [Contact]()
        if(ascending == true){
            alphabeticallySortedContactList = contactsListToBeSorted.sorted { $0.name.lowercased() < $1.name.lowercased() }
        }else{
            alphabeticallySortedContactList = contactsListToBeSorted.sorted { $1.name.lowercased() < $0.name.lowercased() }
        }
        return alphabeticallySortedContactList
    }
    
    static func searchContactBySearchBarQuery(contactsForLoggedUser:[Contact], searchText:String)->[Contact]{
        print("sortContactByFilterSearchBarQuery: " + searchText)
        var contactListWithSearchResults = [Contact]()
        // trim leading trailing white spaces
        let trimmedSearchString = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        
        for contact in contactsForLoggedUser{
            // search contace name and Account Id
            if (contact.name.self.range(of: trimmedSearchString, options: .caseInsensitive) != nil
                || contact.accountId.self.range(of: trimmedSearchString, options: .caseInsensitive) != nil){
                contactListWithSearchResults.append(contact)
            }
            
            // search account name
            let accountsListWithContactId = AccountContactRelationUtility.getAccountByFilterByContactId(contactId: contact.contactId)
            for acrObject in accountsListWithContactId {
                let accName = AccountsViewModel().accountNameFor(accountId: acrObject.accountId)
                if (accName.self.range(of: trimmedSearchString, options: .caseInsensitive) != nil){
                    contactListWithSearchResults.append(contact)
                    break
                }
                
                // search account number
                let accountsListByAccountId = AccountsViewModel().accountsForLoggedUser().filter( { return ($0.account_Id == acrObject.accountId && $0.accountNumber.self.range(of: trimmedSearchString, options: .caseInsensitive) != nil) } )
                if accountsListByAccountId.count > 0 {
                    contactListWithSearchResults.append(contact)
                    break
                }
            }
        }
        
        if contactListWithSearchResults.count > 0 {
            let filteredNoDuplicateContactArray = contactListWithSearchResults.reduce([]) { (r, p) -> [Contact] in
                var r2 = r
                if !r.contains (where: { $0.contactId == p.contactId }) {
                    r2.append(p)
                }
                return r2
            }
            
            contactListWithSearchResults = filteredNoDuplicateContactArray
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
        if(searchBarText != ""){
            filteredContactArray = searchContactBySearchBarQuery(contactsForLoggedUser: filteredContactArray, searchText: searchBarText!)
        }
        return filteredContactArray
    }
    
    static func filterContactByFilterByAssociationDetails(contactListToBeSorted : [Contact] , selectedAccountId : String)-> (Bool, [Contact]){
        var filteredContactArray = [Contact]()
        let enteredAnyFilterCase = true
        
        let acrArray = ContactsViewModel().accountsForContacts()
        
        var filteredAccountContactArray = [Contact]()

        filteredAccountContactArray = contactListToBeSorted.filter( {
            let thisContactId = $0.contactId
            let acrAccountId = acrArray.filter( {$0.isActive == 1 && thisContactId == $0.contactId && selectedAccountId == $0.accountId} )
            if acrAccountId.count > 0 {
                return true
            }

            return false
            
        } )

        if filteredAccountContactArray.count > 0 {
            let filteredNoDuplicateContactArray = filteredAccountContactArray.reduce([]) { (r, p) -> [Contact] in
                var r2 = r
                if !r.contains (where: { $0.contactId == p.contactId }) {
                    r2.append(p)
                }
                return r2
            }
            
            filteredContactArray = filteredNoDuplicateContactArray
        }
        
        return (enteredAnyFilterCase, filteredContactArray)
    }

    static func filterContactByFilterByAssociation(contactListToBeSorted : [Contact])-> (Bool, [Contact]){
        var filteredContactArray = [Contact]()
        let enteredAnyFilterCase = true
        
        let accountViewModel = AccountsViewModel()
        let accounts = accountViewModel.accountsForLoggedUser()

        let acrArray = ContactsViewModel().accountsForContacts()
        /*
        if accounts.count > 0 {
            
            var filteredAccountContactArray = [Contact]()
            for account in accounts {
                filteredAccountContactArray += contactListToBeSorted.filter( {
                    
                    let thisContactId = $0.contactId
                    let selectedAccountId = account.account_Id
                    let acrAccountId = acrArray.filter( {$0.isActive == 1 && thisContactId == $0.contactId && selectedAccountId == $0.accountId} )
                    if acrAccountId.count > 0 {
                        return true
                    }

                    return false
                } )
            }
            
            if filteredAccountContactArray.count > 0 {
                let filteredNoDuplicateContactArray = filteredAccountContactArray.reduce([]) { (r, p) -> [Contact] in
                    var r2 = r
                    if !r.contains (where: { $0.contactId == p.contactId }) {
                        r2.append(p)
                    }
                    return r2
                }
                filteredContactArray = filteredNoDuplicateContactArray
            }
        }*/
        
        if accounts.count > 0 {
            
            var filteredAccountContactArray = [Contact]()
            
            let acrFilteredArray = ContactsViewModel().accountsForSetOfAccounts(For: acrArray.map { $0.accountId })
            
            filteredAccountContactArray += contactListToBeSorted.filter( {
                
                let thisContactId = $0.contactId
                let acrAccountId = acrFilteredArray.filter( {thisContactId == $0.contactId} )
                if acrAccountId.count > 0 {
                    return true
                }
                
                return false
            } )

            if filteredAccountContactArray.count > 0 {
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
        
        
        return (enteredAnyFilterCase, filteredContactArray)
    }
    
    static func filterContactByFilterByRoles(contactListToBeSorted : [Contact])-> (Bool, [Contact]){
        var filteredContactArray = [Contact]()
        var enteredAnyFilterCase = false
        
        if ContactFilterMenuModel.allRole == "YES"{
            enteredAnyFilterCase = true
            filteredContactArray = contactListToBeSorted
        }else if ContactFilterMenuModel.functionRoles.count > 0 {
            
            enteredAnyFilterCase = true
            filteredContactArray = contactListToBeSorted.filter( {
                
                let accountsListWithContactId = AccountContactRelationUtility.getAccountByFilterByContactId(contactId: $0.contactId)
                for acrObject in accountsListWithContactId {
                    if ContactFilterMenuModel.functionRoles.contains(acrObject.roles) {
                        return true
                    }
                }
                return false } )
        }
        return (enteredAnyFilterCase, filteredContactArray)
    }
    
    static func filterContactByFilterByBuyingPower(contactListToBeSorted : [Contact])-> (Bool, [Contact]){
        
        var filteredContactArray = [Contact]()
        var enteredAnyFilterCase = false
        
        // filter by All Buying Power
        if ContactFilterMenuModel.allBuyingPower == "YES" {
            enteredAnyFilterCase = true
            filteredContactArray = contactListToBeSorted
        } else if ContactFilterMenuModel.buyingPower == "YES" && ContactFilterMenuModel.nobuyingPower == "YES" {
            enteredAnyFilterCase = true
            filteredContactArray = contactListToBeSorted
        } else {
            // filter by Buying Power
            var filteredBuyingPowerContactArray = [Contact]()
            var filteredNoBuyingPowerContactArray = [Contact]()
            
            if ContactFilterMenuModel.buyingPower == "YES"{
                enteredAnyFilterCase = true
                let acrArray = ContactsViewModel().accountsForContacts()
                filteredBuyingPowerContactArray = contactListToBeSorted.filter( {
                    let thisContactId = $0.contactId
                    let acrAccountId = acrArray.filter( {$0.isActive == 1 && $0.buyingPower == 1 && thisContactId == $0.contactId} )
                    if acrAccountId.count > 0 {
                        return true
                    }
                    
                    return false
                    
                } )
            }
            
            // filter by NO Buying Power
            if ContactFilterMenuModel.nobuyingPower == "YES"{
                enteredAnyFilterCase = true
                let acrArray = ContactsViewModel().accountsForContacts()
                
                filteredNoBuyingPowerContactArray = contactListToBeSorted.filter( {
                    let thisContactId = $0.contactId
                    let acrAccountId = acrArray.filter( {$0.isActive == 1 && $0.buyingPower != 1 && thisContactId == $0.contactId} )
                    if acrAccountId.count > 0 {
                        return true
                    }

                    return false
                } )
            }
            
            if filteredBuyingPowerContactArray.count > 0 {
                filteredContactArray = filteredBuyingPowerContactArray
            }
            if filteredNoBuyingPowerContactArray.count > 0 {
                filteredContactArray += filteredNoBuyingPowerContactArray
            }
        }
        return (enteredAnyFilterCase, filteredContactArray)
    }
    
    static func formatContactClassification(contactToBeFormatted : Contact)-> (String) {
        if contactToBeFormatted.buyerFlag {
            return "Buyer"
        }else {
            return contactToBeFormatted.contactClassification
        }
    }
    
//    func checkIfContactExistOnRoute(contact: Contact)-> Bool{
//        var filteredContactArray = [Contact]()
//        let contactListToBeSorted = ContactsViewModel().globalContacts()
//        let accountViewModel = AccountsViewModel()
//        let accounts = accountViewModel.accountsForLoggedUser()
//
//        if accounts.count > 0 {
//            var filteredAccountContactArray = [Contact]()
//            for account in accounts {
//                filteredAccountContactArray += contactListToBeSorted.filter( { return account.account_Id == $0.accountId } )
//            }
//
//            if filteredAccountContactArray.count > 0 {
//                let filteredNoDuplicateContactArray = filteredAccountContactArray.reduce([]) { (r, p) -> [Contact] in
//                    var r2 = r
//                    if !r.contains (where: { $0.contactId == p.contactId }) {
//                        r2.append(p)
//                    }
//                    return r2
//                }
//                filteredContactArray = filteredNoDuplicateContactArray
//            }
//        }
//        
//        filteredContactArray = filteredContactArray.filter( { return $0.contactId == contact.contactId } )
//
//        return filteredContactArray.count > 0
//    }
}
