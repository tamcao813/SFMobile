//
//  ContactsViewController.swift
//  SWSApp
//
//  Created by shilpa.a.kulkarni on 26/03/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class ContactsViewController: UITableViewController {
   
    
    // Static data for Southern Glazer's Contact TableView
    let contactNameArray = ["Devin Miller","Alice Stewert","Ciera Morales","Tasha Howell","Keaton Mckinney","Tiffany Mccarthy"]
    let contactArray    =   ["1236432465","5565789036","3412456677","67673876277","1237645672","58754234456"]
    let contactEmailArray  = ["Devin@abc.com","Alice@bbc.com","Ciera@ccd.com","Tasha@eec.com","Keaton@ffc.com","Tiffany@ggc.com"]
    var southernInitialArray:[String] = []
    
    // Static data for Crown Liquor Contacts TableView
    
    let crownNameArray = ["Daniel Brown","Cory Gutierrez","Lawrence Sherman"]
    let crownContactArray    =   ["67673876277","1237645672","58754234456"]
    let crownEmailArray  = ["daniel@eec.com","cory@ffc.com","lawrence@ggc.com"]
    var crownInitialArray:[String] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.gettingSouthernIntials()
        self.gettingCrownsIntials()
      
        
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
            return  crownNameArray.count
        }
        else{
            
            return contactNameArray.count
        }
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ContactTableViewCell
        if indexPath.section == 0 {
            cell.emailLabel.text = crownEmailArray[indexPath.row]
            cell.nameLabel.text = crownNameArray[indexPath.row]
            cell.phoneNumberLabel.text = crownContactArray[indexPath.row]
            cell.initialsLabel.text = crownInitialArray[indexPath.row]
            return cell
        }
        else if indexPath.section == 1 {
            
            
            cell.emailLabel.text = contactEmailArray[indexPath.row]
            cell.nameLabel.text = contactNameArray[indexPath.row]
            cell.phoneNumberLabel.text = contactArray[indexPath.row]
            cell.initialsLabel.text = southernInitialArray[indexPath.row]
            return cell
            
            
        }
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 120
        
        
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch section {
        case 0:
            return "Crown Liquor Contacts"
        case 1:
            return "Southern Glazer's Contacts"
        default:
            return  "Default"
        }
        
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.textColor = UIColor.black
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        header.textLabel?.frame = header.frame
        header.textLabel?.textAlignment = .left
        
    }
    
    func gettingSouthernIntials(){
        
        
        for  var i in 0...(contactNameArray.count)-1 {
            
            var initials = contactNameArray[i].components(separatedBy: " ").reduce("") { ($0 == "" ? "" : "\($0.first!)") + "\($1.first!)" }
            southernInitialArray.append(initials)
            print("My Initials are\(initials)")
            
        }
        
    }
    
    func gettingCrownsIntials(){
        
        
        for  var i in 0...(crownNameArray.count)-1 {
            
            var initials = crownNameArray[i].components(separatedBy: " ").reduce("") { ($0 == "" ? "" : "\($0.first!)") + "\($1.first!)" }
            crownInitialArray.append(initials)
            print("My Initials are\(initials)")
            
        }
        
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

