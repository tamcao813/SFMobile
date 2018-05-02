//
//  ContactListDetailsViewController.swift
//  SWSApp
//
//  Created by shubham.e.shukla on 4/21/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class ContactListDetailsViewController: UIViewController {

    @IBOutlet weak var contactDetailsTableView: UITableView!

    var contactDetail: Contact?
    let countHeaderFooter: Int = 2
    let countLinkHeader: Int = 1
    var accountLinked: [AccountContactRelation]!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        accountLinked = AccountContactRelationUtility.getAccountByFilterByContactId(contactId: (contactDetail?.contactId)!)
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
        
        if accountLinked.count == 0 {
            return countHeaderFooter
        }
        return countHeaderFooter + accountLinked.count + countLinkHeader
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell:ContactListDetailsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "contactDetailsCell", for: indexPath) as! ContactListDetailsTableViewCell
            cell.displayCellContent(contactDetail!)
            cell.editContactButton.addTarget(self, action: #selector(actionEditContactDetails), for: .touchUpInside)
            cell.delegate = self
            cell.selectionStyle = .none
            return cell
        }
        else if accountLinked.count > 0 , indexPath.row == 1 {
            let cell:ContactListAccountHeaderDetails = tableView.dequeueReusableCell(withIdentifier: "ContactListAccountHeaderDetails", for: indexPath) as! ContactListAccountHeaderDetails
            cell.displayCellContent(contactDetail!)

            cell.selectionStyle = .none
            return cell
        }
        else if (accountLinked.count > 0 && ((indexPath.row + 1) == countHeaderFooter + accountLinked.count + countLinkHeader)) ||
            (accountLinked.count == 0 && ((indexPath.row + 1) == countHeaderFooter)) {
            let cell:ContactListAccountFooterDetails = tableView.dequeueReusableCell(withIdentifier: "ContactListAccountFooterDetails", for: indexPath) as! ContactListAccountFooterDetails
            cell.displayCellContent(contactDetail!)
            cell.linkNewAccountContactButton.addTarget(self, action: #selector(actionLinkNewAccountContactDetails), for: .touchUpInside)

            cell.selectionStyle = .none
            return cell
        }
        
        let cell:ContactListAccountLinkDetails = tableView.dequeueReusableCell(withIdentifier: "ContactListAccountLinkDetails", for: indexPath) as! ContactListAccountLinkDetails
        let acrDetail = AccountContactRelationUtility.getAccountByFilterByContactId(contactId: (contactDetail?.contactId)!)
        cell.displayCellContent(acrDetail[(indexPath.row-2)].accountId,withRoles: acrDetail[(indexPath.row-2)].roles)

        cell.unlinkAccountContactButton.tag = indexPath.row - countHeaderFooter
        cell.unlinkAccountContactButton.addTarget(self, action: #selector(actionUnlinkAccountContactDetails), for: .touchUpInside)

        cell.editAccountContactButton.tag = indexPath.row - countHeaderFooter
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
        
        UIView.performWithoutAnimation({() -> Void in
            contactDetailsTableView.beginUpdates()
            accountLinked.remove(at: sender.tag)
            contactDetailsTableView.deleteRows(at: [IndexPath(row: (sender.tag + countHeaderFooter), section: 0)], with: .fade)
            if accountLinked.count == 0 {
                contactDetailsTableView.deleteRows(at: [IndexPath(row: 1, section: 0)], with: .fade)
            }
            contactDetailsTableView.endUpdates()
            if accountLinked.count != 0 {
                for n in 0...accountLinked.count {
                    contactDetailsTableView.reloadRows(at: [IndexPath(row: (n + countHeaderFooter), section: 0)], with: .none)
                }
            }
        })

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
        else if accountLinked.count > 0 , indexPath.row == 1 {
            return 100
        }
        else if (accountLinked.count > 0 && ((indexPath.row + 1) == countHeaderFooter + accountLinked.count + countLinkHeader)) ||
            (accountLinked.count == 0 && ((indexPath.row + 1) == countHeaderFooter)) {
            return 200
        }
        return 240
    }
    
}

extension ContactListDetailsViewController : ContactListDetailsTableViewCellDelegate {
    func editContactButtonTapped() {
        let newContactStoryboard: UIStoryboard = UIStoryboard(name: "NewContact", bundle: nil)
        let newContactVC = newContactStoryboard.instantiateViewController(withIdentifier: "CreateNewContactViewController") as? CreateNewContactViewController
//        newContactVC?.delegate = self
        newContactVC?.isinEditingMode = true
        newContactVC?.contactDetail = contactDetail
        
        self.present(newContactVC!, animated: true, completion: nil)
    }
}
