//
//  ContactsViewController.swift
//  SWSApp
//
//  Created by shilpa.a.kulkarni on 26/03/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class AccountsContactsViewController: UITableViewController {
    
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
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0{
            return  0
        }
        else if section == 1{
              return contactsWithBuyingPower.count
        }
        else if section == 2{
            return contactsForSG.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ContactTableViewCell
        
        
        var ary: [Contact] = []
        
        if indexPath.section == 1 {
            ary = contactsWithBuyingPower
        }
        else if indexPath.section == 2 {
            ary = contactsForSG
            
        }
        let contact = ary[indexPath.row]
        cell.emailLabel.text = contact.email
        cell.nameLabel.text = contact.name
        cell.phoneNumberLabel.text = contact.phoneuNmber
        cell.function_RoleLabel.text = contact.functionRole
        cell.initialsLabel.text = contact.getIntials(name: contact.name)
        return cell
    }
    
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        if section == 1{
            return "Crown Liquor Store"
        }
        else if section == 2{
            return "Souther Glazers Contact "
        }
        return nil
    }

    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 280
        }
        else if section == 1{
            return 100
        }
        else if section == 2{
            return 150
        }
        return 0
    }
   
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0.1
        }
        else if section == 1{
             return 0.1
        }else if section == 2{
             return 0.1
        }
        return 0.1
    }
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let  headerCell = tableView.dequeueReusableCell(withIdentifier: "customerHeaderCell") as! CustomerHeaderTableViewCell
       
        if section == 0{
            return headerCell
            
        }
        else if section == 1{
            let frame = tableView.frame
            let sectionLabel = UILabel.init(frame: CGRect(x: 40, y: 25, width: 400, height: 50))
            sectionLabel.text = "Crown Liquor Store"
            sectionLabel.textColor = UIColor.black
            sectionLabel.font = UIFont.boldSystemFont(ofSize: 25)
            
            
            let headerView = UIView.init(frame: CGRect(x: 0, y: 0, width:frame.width , height:frame.height ))
            headerView.backgroundColor = UIColor.white
            headerView.addSubview(sectionLabel)
            return headerView;
            
            
        }
            
        else if section == 2 {
          
            let frame = tableView.frame
            // ViewAllContacts Button...
            let viewAllAccountContactsButton = UIButton.init(frame: CGRect(x: 815, y: 25, width: 200, height: 35))
            viewAllAccountContactsButton.setTitle("ViewAllAccountsContact", for: .normal)
            viewAllAccountContactsButton.backgroundColor = UIColor(named: "LightGrey")
            viewAllAccountContactsButton.setTitleColor(UIColor.black, for: .normal)
            viewAllAccountContactsButton.titleLabel?.font = UIFont.init(name: "Ubuntu-Medium", size: 10)
            
            let sectionLabel = UILabel.init(frame: CGRect(x: 40, y: 90, width: 400, height: 50))
            sectionLabel.text = "Souther Glazers Contact"
            sectionLabel.textColor = UIColor.black
            sectionLabel.font = UIFont.boldSystemFont(ofSize: 25)
            
            
            
            let headerView = UIView.init(frame: CGRect(x: 0, y: 0, width:frame.width , height:frame.height ))
            headerView.backgroundColor = UIColor.white
            headerView.addSubview(viewAllAccountContactsButton)
            headerView.addSubview(sectionLabel)
            return headerView;
        }
        
        return nil
    }
    
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
      guard  let tableViewHeaderFooterView = view as? UITableViewHeaderFooterView else { return }
        
        if  section == 1{
            tableViewHeaderFooterView.contentView.backgroundColor = UIColor.white
            tableViewHeaderFooterView.textLabel?.text = "Crown Liquor Store"
            tableViewHeaderFooterView.textLabel?.textColor = UIColor.black
            tableViewHeaderFooterView.textLabel?.font = UIFont.boldSystemFont(ofSize:25)
            tableViewHeaderFooterView.textLabel?.frame = tableViewHeaderFooterView.frame
            tableViewHeaderFooterView.textLabel?.textAlignment = .left
            
        }
        else if section == 2
        {
            tableViewHeaderFooterView.contentView.backgroundColor = UIColor.white
            tableViewHeaderFooterView.textLabel?.text = "Souther Glazers Contact "
            tableViewHeaderFooterView.textLabel?.textColor = UIColor.black
            tableViewHeaderFooterView.textLabel?.font = UIFont.boldSystemFont(ofSize:25)
            tableViewHeaderFooterView.textLabel?.frame = tableViewHeaderFooterView.frame
            tableViewHeaderFooterView.textLabel?.textAlignment = .left
            
        }
        
    }
    
}

