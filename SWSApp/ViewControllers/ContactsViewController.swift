//
//  ContactsViewController.swift
//  SWSApp
//
//  Created by shilpa.a.kulkarni on 26/03/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class ContactsViewController: UITableViewController {
    
    let contactData = Contact()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contactData.gettingSouthernIntials()
        contactData.gettingCrownsIntials()
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
            return contactData.crownNameArray.count
        }
        else if
            section == 1 {
            return contactData.contactNameArray.count
            
        }
        
        
        return 0
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ContactTableViewCell
        cell.layer.cornerRadius = 5
        cell.layer.borderWidth = 0.5
        if indexPath.section == 0 {
            cell.emailLabel.text = contactData.crownEmailArray[indexPath.row]
            cell.nameLabel.text = contactData.crownNameArray[indexPath.row]
            cell.phoneNumberLabel.text = contactData.crownContactArray[indexPath.row]
            cell.initialsLabel.text = contactData.crownInitialArray[indexPath.row]
            return cell
        }
        else if indexPath.section == 1 {
            cell.emailLabel.text = contactData.contactEmailArray[indexPath.row]
            cell.nameLabel.text = contactData.contactNameArray[indexPath.row]
            cell.phoneNumberLabel.text = contactData.contactArray[indexPath.row]
            cell.initialsLabel.text = contactData.southernInitialArray[indexPath.row]
            return cell
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return GlobalConstants.contactTableViewConstants.cellHeight
    }
    //    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    //
    //        switch section {
    //        case 0:
    //            return NSLocalizedString("Crown_Liquor_Contacts", comment: "crown liquor contacts section name")
    //        case 1:
    //            return NSLocalizedString("Southern_Glazer's_Contacts", comment: "southern glazers contacts section name")
    //        default:
    //            return  "Default"
    //        }
    //    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return GlobalConstants.contactTableViewConstants.heightForHeaderInSection
    }
    
    //    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
    //
    //        guard let header = view as? UITableViewHeaderFooterView else { return }
    //        header.textLabel?.textColor = UIColor.black
    //        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 25)
    //        header.textLabel?.frame = header.frame
    //        header.textLabel?.textAlignment = .left
    //    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let  headerCell = tableView.dequeueReusableCell(withIdentifier: "customerHeaderCell") as! CustomerHeaderTableViewCell
        if section == 0{
            
        }
        else if
            section == 1{
            
        }
        
        return headerCell
        
    }
    
    
    
    
}

