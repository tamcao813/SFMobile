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
            cell.displayCellContent(contactDetail!)
            cell.editContactButton.addTarget(self, action: #selector(actionEditContactDetails), for: .touchUpInside)
            
            cell.selectionStyle = .none
            return cell
        }
        else if indexPath.row == 1 {
            let cell:ContactListAccountHeaderDetails = tableView.dequeueReusableCell(withIdentifier: "ContactListAccountHeaderDetails", for: indexPath) as! ContactListAccountHeaderDetails

            cell.selectionStyle = .none
            return cell
        }
        else if ((indexPath.row + 1) == countHeaderFooter + accountLinked.count) {
            let cell:ContactListAccountFooterDetails = tableView.dequeueReusableCell(withIdentifier: "ContactListAccountFooterDetails", for: indexPath) as! ContactListAccountFooterDetails
            cell.linkNewAccountContactButton.addTarget(self, action: #selector(actionLinkNewAccountContactDetails), for: .touchUpInside)

            cell.selectionStyle = .none
            return cell
        }
        
        let cell:ContactListAccountLinkDetails = tableView.dequeueReusableCell(withIdentifier: "ContactListAccountLinkDetails", for: indexPath) as! ContactListAccountLinkDetails
        let acrDetail = AccountContactRelationUtility.getAccountByFilterByContactId(contactId: (contactDetail?.contactId)!)
        cell.displayCellContent(acrDetail[(indexPath.row-2)].accountId,withRoles: acrDetail[(indexPath.row-2)].roles)

        cell.unlinkAccountContactButton.tag = indexPath.row - (countHeaderFooter-1)
        cell.unlinkAccountContactButton.addTarget(self, action: #selector(actionUnlinkAccountContactDetails), for: .touchUpInside)

        cell.editAccountContactButton.tag = indexPath.row - (countHeaderFooter-1)
        cell.editAccountContactButton.addTarget(self, action: #selector(actionEditAccountContactDetails), for: .touchUpInside)

        cell.selectionStyle = .none
        return cell
        
    }
    
    //MARK:- TableView Cell Button Actions
    @objc func actionEditContactDetails(sender:UIButton!) {
        print("actionEditContactDetails Clicked")
    }

    @objc func actionUnlinkAccountContactDetails(sender:UIButton!) {
        print("actionUnlinkAccountContactDetails Clicked " + String(sender.tag))
    }

    @objc func actionEditAccountContactDetails(sender:UIButton!) {
        print("actionEditAccountContactDetails Clicked " + String(sender.tag))
    }

    @objc func actionLinkNewAccountContactDetails(sender:UIButton!) {
        print("actionLinkNewAccountContactDetails Clicked")
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


