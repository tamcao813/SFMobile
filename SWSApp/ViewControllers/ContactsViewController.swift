//
//  ContactsViewController.swift
//  SWSApp
//
//  Created by shilpa.a.kulkarni on 26/03/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class ContactsViewController: UITableViewController {
    
    //use view models to get contacts data
    let userViewModel = UserViewModel()
    let contactViewModel = ContactsViewModel()
    var contactsWithBuyingPower = [Contact]()
    var contactsForSG = [Contact]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loggerInUser = userViewModel.loggedInUser
        contactsWithBuyingPower = contactViewModel.contactsWithBuyingPower(forUser: (loggerInUser?.sfid)!)
        
        contactsForSG = contactViewModel.contactsForSG(forUser: (loggerInUser?.sfid)!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0{
            return  contactsWithBuyingPower.count
        }
        else{
            return contactsForSG.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ContactTableViewCell
        cell.layer.borderWidth = 0.5
        
        var ary: [Contact] = []
        
        if indexPath.section == 0 {
            ary = contactsWithBuyingPower
        }
        else if indexPath.section == 1 {
            ary = contactsForSG
        }
        
        let contact = ary[indexPath.row]
        cell.emailLabel.text = contact.email
        cell.nameLabel.text = contact.name
        cell.phoneNumberLabel.text = contact.phoneuNmber
        cell.initialsLabel.text = contact.getIntials(name: contact.name)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 0 {
            return 280
            
        }
        else{
            
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let  headerCell = tableView.dequeueReusableCell(withIdentifier: "customerHeaderCell") as! CustomerHeaderTableViewCell
        if section == 0{
            let  headerCell = tableView.dequeueReusableCell(withIdentifier: "customerHeaderCell") as! CustomerHeaderTableViewCell
            
            return headerCell
            
        }
        
        return headerCell
        
    }
    
    
    
    
}

