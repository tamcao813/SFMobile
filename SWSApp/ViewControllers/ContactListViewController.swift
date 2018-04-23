//
//  ContactListViewController.swift
//  SWSApp
//
//  Created by shubham.e.shukla on 4/20/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class ContactListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource, SearchContactByEnteredTextDelegate {
    func sortContactData(searchString: String) {
        print(sortContactData)
    }
    
    func filteringContact(filtering: Bool) {
        print(filteringContact)
    }
    
    func performContactFilterOperation(searchString: String) {
        print(performContactFilterOperation)
    }
    
    
    let contactViewModel = ContactsViewModel()
    var globalContactsForList = [Contact]()
    let linkedAccountArray = ["Crown Liquor Store One","Account Name Two"," Account Name Three"]
    var accountID:String = ""
    var accountContactsForList = [Contact]()
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 0
        }
        else if  section == 1{
            
            return globalContactsForList.count
        }
        return 1
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
        
        let globalContact:Contact = globalContactsForList[indexPath.row]
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
        
        globalContactsForList = contactViewModel.globalContacts()
       
        
        // Do any additional setup after loading the view.
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
    
    
    
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
