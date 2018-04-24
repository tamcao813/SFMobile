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
    let linkedAccountArray = ["Crown Liquor Store One","Account Name Two"," Account Name Three"]
   
  
    //MARK: Table View Functions
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 0
        }
        else if  section == 1{
            
            if ContactsGlobal.accountId == "" {
                globalContactsForList = contactViewModel.globalContacts()
                print("globalContactsForList.count = \(globalContactsForList.count)")
                return globalContactsForList.count
                
            }else {
                accountContactsForList = contactViewModel.contacts(forAccount: ContactsGlobal.accountId)
                print("accountContactsForList.count = \(accountContactsForList.count)")
                return accountContactsForList.count
            }
            
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
            return headerCell
        }
        return nil
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var ary: [Contact] = []
        if ContactsGlobal.accountId == "" {
            ary = contactViewModel.globalContacts()
            print("globalContacts ary.count  = \(ary.count)")
            
        }else{
            ary = contactViewModel.contacts(forAccount: ContactsGlobal.accountId)
            print("contacts ary.count  = \(ary.count)")
        }
        
        //let globalContact:Contact = globalContactsForList[indexPath.row]
        
        let globalContact:Contact = ary[indexPath.row]
     
        let cell:ContactListTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ContactListTableViewCell
    
        let fullName = globalContact.firstName + " " + globalContact.lastName
        print("full name \(fullName)")
        cell.initialNameLabel.text = globalContact.getIntials(name: fullName)
        cell.nameValueLabel.text = fullName
        cell.phoneValueLabel.text = globalContact.phoneuNmber
        cell.emailValueLabel.text =  globalContact.email
        cell.linkedAccountWithContact.text = "\(linkedAccountArray)"
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
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
        
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
    
}

//MARK:- SearchContactByEnteredTextDelegate Methods
extension ContactListViewController : SearchContactByEnteredTextDelegate{

    func sortContactData(searchString: String) {
        print("sortContactData")
    }
    
    func filteringContact(filtering: Bool) {

        print("filteringContact")

        if !filtering {
            globalContactsForList = contactViewModel.globalContacts()
            self.tableView.reloadData()
        }

    }
    
    func performContactFilterOperation(searchString: String) {
        
        print("performContactFilterOperation")
        print(ContactFilterMenuModel.functionRoles)
        
        globalContactsForList = ContactSortUtility.filterContactByAppliedFilter(contactListToBeSorted: contactViewModel.globalContacts(), searchBarText: searchString)
        self.tableView.reloadData()
        
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
