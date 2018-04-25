//
//  ContactListViewController.swift
//  SWSApp
//
//  Created by shubham.e.shukla on 4/20/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class ContactListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    let contactViewModel = ContactsViewModel()
    
    var globalContactsForList = [Contact]()
    var accountContactsForList = [Contact]()
    var contactsAcc = [AccountContactRelation]()
    var globalContactCount:Int?
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 0
        }
        else if  section == 1{
            /*
            if ContactsGlobal.accountId == "" {
                globalContactsForList = contactViewModel.globalContacts()
                print("globalContactsForList.count = \(globalContactsForList.count)")
                return globalContactsForList.count
                
            }else {
                accountContactsForList = contactViewModel.contacts(forAccount: ContactsGlobal.accountId)
                print("accountContactsForList.count = \(accountContactsForList.count)")
                return accountContactsForList.count
            }*/

            return globalContactsForList.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            
            return 70
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 0{
            let  headerCell = tableView.dequeueReusableCell(withIdentifier: "buttonCell") as! ContactListTableViewButtonCell
                headerCell.noOfResultLabel.text = "Showing \(globalContactsForList.count) of \(globalContactCount!) results"
            return headerCell
        }
        return nil
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        /*
        var ary: [Contact] = []
        if ContactsGlobal.accountId == "" {
            ary = contactViewModel.globalContacts()
            print("globalContacts ary.count  = \(ary.count)")
            
        }else{
            ary = contactViewModel.contacts(forAccount: ContactsGlobal.accountId)
            print("contacts ary.count  = \(ary.count)")
        }*/
        
        let globalContact:Contact = globalContactsForList[indexPath.row]
        
//        let globalContact:Contact = ary[indexPath.row]

        let cell:ContactListTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ContactListTableViewCell
    
        let fullName = globalContact.firstName + " " + globalContact.lastName
        print("full name \(fullName)")
        cell.initialNameLabel.text = globalContact.getIntials(name: fullName)
        cell.nameValueLabel.text = fullName
        cell.phoneValueLabel.text = globalContact.phoneuNmber
        cell.emailValueLabel.text =  globalContact.email
        
        var accountsName = [String]()
        for acc in contactsAcc{
            
            if(globalContact.contactId == acc.contactId){
             accountsName.append(acc.accountName)
            }
        }
        
        let formattedaccountsName = accountsName.joined(separator: ", ")
        print(formattedaccountsName)
        cell.linkedAccountWithContact.text = "\(formattedaccountsName)"
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        else if  section == 1 {
            return 0
        }
        return 0
    }
    
    
    @IBOutlet  var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         NotificationCenter.default.addObserver(self, selector: #selector(self.reloadAllContacts), name: NSNotification.Name("reloadAllContacts"), object: nil)
            contactsAcc = contactViewModel.accountsForContacts()
            loadContactData()
        
        globalContactCount = contactViewModel.globalContacts().count

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "contactDetailsSegue" {
            let contactDetailsScreen = segue.destination as! ContactListDetailsViewController
            // accountDetailsScreen.accountDetailForLoggedInUser = selectedAccount
        }
    }
    
    //Mark load contact data
    func loadContactData() {
        
        print("loadContactData")
        if ContactsGlobal.accountId == "" {
            globalContactsForList = contactViewModel.globalContacts()
        }else{
            globalContactsForList = contactViewModel.contacts(forAccount: ContactsGlobal.accountId)
            print("globalContactsForList.count  = \(globalContactsForList.count)")
        }
        globalContactsForList = ContactSortUtility.sortByContactNameAlphabetically(contactsListToBeSorted: globalContactsForList, ascending: true)
        self.tableView.reloadData()

    }
    
}

//MARK:- SearchContactByEnteredTextDelegate Methods
extension ContactListViewController : SearchContactByEnteredTextDelegate{

    func sortContactData(searchString: String) {
        print("sortContactData")
    }
    
    func filteringContact(filtering: Bool) {

        print("filteringContact")

        if !filtering {
            loadContactData()
        }

    }
    
    func performContactFilterOperation(searchString: String) {
        
        print("performContactFilterOperation")
        print(ContactFilterMenuModel.functionRoles)
        
        globalContactsForList = ContactSortUtility.filterContactByAppliedFilter(contactListToBeSorted: contactViewModel.globalContacts(), searchBarText: searchString)
        globalContactsForList = ContactSortUtility.sortByContactNameAlphabetically(contactsListToBeSorted: globalContactsForList, ascending: true)
        self.tableView.reloadData()
        
    }
    
    @objc func reloadAllContacts(notification: NSNotification){

        loadContactData()
//        tableView.reloadData()
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
