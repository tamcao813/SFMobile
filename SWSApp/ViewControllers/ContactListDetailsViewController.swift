//
//  ContactListDetailsViewController.swift
//  SWSApp
//
//  Created by shubham.e.shukla on 4/21/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class ContactListDetailsViewController: UIViewController {

    var contactDetail: Contact?
    let countHeaderFooter: Int = 3
    var accountLinked: [AccountContactRelation]!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        accountLinked = AccountContactRelationUtility.getAccountByFilterByContactId(contactId: (contactDetail?.contactId)!)
        print("accountLinked: " + String(accountLinked.count))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

//MARK:- TableView DataSource Methods
extension ContactListDetailsViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard contactDetail != nil else {
            return 0
        }
        
        return countHeaderFooter + accountLinked.count
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
        else if ((indexPath.row + 1) == countHeaderFooter + accountLinked.count) {
            let cell:ContactListAccountFooterDetails = tableView.dequeueReusableCell(withIdentifier: "ContactListAccountFooterDetails", for: indexPath) as! ContactListAccountFooterDetails
            return cell
        }
        
        let cell:ContactListAccountLinkDetails = tableView.dequeueReusableCell(withIdentifier: "ContactListAccountLinkDetails", for: indexPath) as! ContactListAccountLinkDetails
        return cell
        
    }
    
}

//MARK:- TableView Delegate Methods
extension ContactListDetailsViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 580
        }
        else if indexPath.row == 1 {
            return 110
        }
        else if ((indexPath.row + 1) == countHeaderFooter + accountLinked.count) {
            return 200
        }
        return 240
    }
    
}


