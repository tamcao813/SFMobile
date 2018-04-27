//
//  ContactListDetailsViewController.swift
//  SWSApp
//
//  Created by shubham.e.shukla on 4/21/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class ContactListDetailsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell:ContactListDetailsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "contactDetailsCell", for: indexPath) as! ContactListDetailsTableViewCell
            return cell
        }
        else if indexPath.row == 1 {
            let cell:ContactListAccountHeaderDetails = tableView.dequeueReusableCell(withIdentifier: "ContactListAccountHeaderDetails", for: indexPath) as! ContactListAccountHeaderDetails
            return cell
        }
        else if (indexPath.row == 2 || indexPath.row == 3) {
            let cell:ContactListAccountLinkDetails = tableView.dequeueReusableCell(withIdentifier: "ContactListAccountLinkDetails", for: indexPath) as! ContactListAccountLinkDetails
            return cell
        }
        
        let cell:ContactListAccountFooterDetails = tableView.dequeueReusableCell(withIdentifier: "ContactListAccountFooterDetails", for: indexPath) as! ContactListAccountFooterDetails
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 580
        }
        else if indexPath.row == 1 {
            return 110
        }
        else if (indexPath.row == 2 || indexPath.row == 3) {
            return 240
        }
        return 200
    }
    
   
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
