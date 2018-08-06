//
//  ContactListDetailsViewController.swift
//  SWSApp
//
//  Created by shubham.e.shukla on 4/21/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class ContactListDetailsViewController: UIViewController,ContactDetailsScreenDelegate {

    @IBOutlet weak var contactDetailsTableView: UITableView!

    var contactDetail: Contact?
    let countHeaderFooter: Int = 2
    let countLinkHeader: Int = 1
    var accountLinked: [AccountContactRelation]!

    override func viewDidLoad() {
        super.viewDidLoad()
        if(ContactFilterMenuModel.selectedContactIdFromDetailScreen != ""){
            if let selectedContact = contactDetail?.contactId{
                ContactFilterMenuModel.selectedContactIdFromDetailScreen = selectedContact
            }
        }

        ContactListViewController.refreshContactDetailDelegate = self
        // Do any additional setup after loading the view.
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        ContactFilterMenuModel.selectedContactIdFromDetailScreen = ""
    }
    
    func reloadAllMenu() {

    }
    func clearAllMenu() {
        
    }
    func pushTheScreenToContactDetailsScreen(contactData: Contact) {
        contactDetail = contactData
        self.contactDetailsTableView.reloadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        accountLinked = ContactsViewModel().linkedAccountsForContact(with: (contactDetail?.contactId)!)
            //AccountContactRelationUtility.getAccountByFilterByContactId(contactId: (contactDetail?.contactId)!)
    }
}

//MARK:- TableView DataSource Methods
extension ContactListDetailsViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard contactDetail != nil else {
            return 0
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
        else if indexPath.row == 1 {
            let cell:ContactListAccountHeaderDetails = tableView.dequeueReusableCell(withIdentifier: "ContactListAccountHeaderDetails", for: indexPath) as! ContactListAccountHeaderDetails
            if accountLinked.count == 0 {
                cell.displayEmptyCellContent()
            }
            else {
                cell.displayCellContent(contactDetail!)
            }

            cell.selectionStyle = .none
            return cell
        }
        else if (indexPath.row + 1) == countHeaderFooter + accountLinked.count + countLinkHeader {
            let cell:ContactListAccountFooterDetails = tableView.dequeueReusableCell(withIdentifier: "ContactListAccountFooterDetails", for: indexPath) as! ContactListAccountFooterDetails
            cell.displayCellContent(contactDetail!)
            cell.linkNewAccountContactButton.addTarget(self, action: #selector(actionLinkNewAccountContactDetails), for: .touchUpInside)

            cell.selectionStyle = .none
            return cell
        }
        
        let cell:ContactListAccountLinkDetails = tableView.dequeueReusableCell(withIdentifier: "ContactListAccountLinkDetails", for: indexPath) as! ContactListAccountLinkDetails
//        let acrDetail = ContactsViewModel().linkedAccountsForContact(with: (contactDetail?.contactId)!)
            //AccountContactRelationUtility.getAccountByFilterByContactId(contactId: (contactDetail?.contactId)!)
        
        
        cell.contactId = (contactDetail?.contactId)!
        
        var acrArray = ContactsViewModel().accountsForContacts()
        acrArray = acrArray.filter( {(contactDetail?.contactId == $0.contactId) && (accountLinked[(indexPath.row-2)].accountId == $0.accountId)} )
        
        var classification = ""
        if acrArray.count > 0 {
            if acrArray[0].buyingPower == 1 {
                classification = "Buyer"
            }
            else {
                classification = acrArray[0].contactClassification
                if classification == "Other" {
                    classification = acrArray[0].otherSpecification
                }
            }
        }

//        cell.displayCellContent(accountLinked[(indexPath.row-2)].accountId, withRoles: accountLinked[(indexPath.row-2)].roles, forClassification: ContactSortUtility.formatContactClassification(contactToBeFormatted: contactDetail!))
        cell.displayCellContent(accountLinked[(indexPath.row-2)].accountId, withRoles: accountLinked[(indexPath.row-2)].roles, forClassification: classification)

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
        
        if accountLinked.count == 1 {
            
            let alert = UIAlertController(title: nil, message: "Each Contact must be linked to at least one Account.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self.present(alert, animated: true)
            
            return
        }
        
        //update ACR soup
        let aCR = accountLinked[sender.tag]
        aCR.isActive = 0
        var ary = [AccountContactRelation]()
        ary.append(aCR)
        let success = ContactsViewModel().updateACRToSoup(objects:ary)
        
        if !success {
            return
        }
        
        UIView.performWithoutAnimation({() -> Void in
            contactDetailsTableView.beginUpdates()
    
            accountLinked.remove(at: sender.tag)
            
            contactDetailsTableView.deleteRows(at: [IndexPath(row: (sender.tag + countHeaderFooter), section: 0)], with: .fade)

            if accountLinked.count == 0 {
                contactDetailsTableView.reloadRows(at: [IndexPath(row: 1, section: 0)], with: .none)
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
        let newContactStoryboard: UIStoryboard = UIStoryboard(name: "NewContact", bundle: nil)
        let linkAccountToContactVC = newContactStoryboard.instantiateViewController(withIdentifier: "LinkAccountToContactViewController") as? LinkAccountToContactViewController
        linkAccountToContactVC?.isInEditMode = true
        linkAccountToContactVC?.contactName = contactDetail?.firstName
        linkAccountToContactVC?.contactObject = contactDetail
        linkAccountToContactVC?.delegate = self
        
        let aCR = accountLinked[sender.tag]
        linkAccountToContactVC?.accContactRelation = aCR
        
        self.present(linkAccountToContactVC!, animated: true, completion: nil)
    }

    @objc func actionLinkNewAccountContactDetails(sender:UIButton!) {
        let newContactStoryboard: UIStoryboard = UIStoryboard(name: "NewContact", bundle: nil)
        let linkAccountToContactVC = newContactStoryboard.instantiateViewController(withIdentifier: "LinkAccountToContactViewController") as? LinkAccountToContactViewController
        linkAccountToContactVC?.isInEditMode = false
        linkAccountToContactVC?.contactName = contactDetail?.firstName
        linkAccountToContactVC?.contactObject = contactDetail
        linkAccountToContactVC?.delegate = self
        self.present(linkAccountToContactVC!, animated: true, completion: nil)
    }
    
}

//MARK:- TableView Delegate Methods
extension ContactListDetailsViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 650
        }
        else if indexPath.row == 1 {
            return 100
        }
        else if (indexPath.row + 1) == countHeaderFooter + accountLinked.count + countLinkHeader {
            return 200
        }
        return 240
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: true)
        self.view.endEditing(true)

        if indexPath.row == 0 {
            return
        }
        else if indexPath.row == 1 {
            return
        }
        else if (indexPath.row + 1) == countHeaderFooter + accountLinked.count + countLinkHeader {
            return
        }
        
        FilterMenuModel.comingFromDetailsScreen = "YES"
//        let acrDetail = ContactsViewModel().linkedAccountsForContact(with: (contactDetail?.contactId)!)
            //AccountContactRelationUtility.getAccountByFilterByContactId(contactId: (contactDetail?.contactId)!)
        FilterMenuModel.selectedAccountId = accountLinked[(indexPath.row-2)].accountId
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showAllAccounts"), object:nil)

    }
    
}

extension ContactListDetailsViewController : ContactListDetailsTableViewCellDelegate {
    func editContactButtonTapped() {
        let newContactStoryboard: UIStoryboard = UIStoryboard(name: "NewContact", bundle: nil)
        let newContactVC = newContactStoryboard.instantiateViewController(withIdentifier: "CreateNewContactViewController") as? CreateNewContactViewController
        newContactVC?.isNewContact = false
        newContactVC?.contactId = contactDetail?.contactId
        newContactVC?.delegate = self
        self.present(newContactVC!, animated: true, completion: nil)
    }
}

extension ContactListDetailsViewController : CreateNewContactViewControllerDelegate {
    func updateContactList() {
        
        let contact = ContactSortUtility.searchContactByContactId((contactDetail?.contactId)!)
        if contact != nil {
            
            accountLinked = ContactsViewModel().linkedAccountsForContact(with: (contact?.contactId)!)
                //AccountContactRelationUtility.getAccountByFilterByContactId(contactId: (contact?.contactId)!)
            
            contactDetail = contact
            DispatchQueue.main.async {
                UIView.performWithoutAnimation({() -> Void in
                    self.contactDetailsTableView.reloadData()
                    self.contactDetailsTableView.beginUpdates()
                    self.contactDetailsTableView.endUpdates()
                })
            }

        }
    }
}

extension ContactListDetailsViewController : LinkAccountToContactViewControllerDelegate{
    func updateContact() {
        
        let contact = ContactSortUtility.searchContactByContactId((contactDetail?.contactId)!)
        if contact != nil {
            
            accountLinked = ContactsViewModel().linkedAccountsForContact(with: (contact?.contactId)!)
                //AccountContactRelationUtility.getAccountByFilterByContactId(contactId: (contact?.contactId)!)
            
            contactDetail = contact
            DispatchQueue.main.async {
                UIView.performWithoutAnimation({() -> Void in
                    self.contactDetailsTableView.reloadData()
                    self.contactDetailsTableView.beginUpdates()
                    self.contactDetailsTableView.endUpdates()
                })
            }
            
        }
    }
}


