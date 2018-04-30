//
//  AccountsContactViewController.swift
//  SWSApp
//
//  Created by r.a.jantakal on 05/04/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation
import UIKit

class ContactsViewController : UIViewController, ContactDetailsScreenDelegate {
    
    let contactViewModel = ContactsViewModel()

    var contactListVC: ContactListViewController?
    var filterMenuVC: ContactMenuViewController?
    var contactDetails : ContactListDetailsViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("Contact VC will appear")
        filterMenuVC?.searchByEnteredTextDelegate = contactListVC

        //testPlist()
        //testCreateNewContact()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ContactSegue") {
            contactListVC = segue.destination as? ContactListViewController
//            contactListVC?.delegate = self
        }
        
        if(segue.identifier == "ContactQueryFilter")
        {
            filterMenuVC = segue.destination as? ContactMenuViewController
        }
    }

    func testPlist() {
        //testContactRolePlist
        let opts = PlistMap.sharedInstance.getPicklist("Contact", fieldname: "Roles")
        print(opts)
        
        let preferredOpts = PlistMap.sharedInstance.getPicklist("Contact", fieldname: "PreferredCommunication")
        print(preferredOpts)
    }
    
    func testCreateNewContact() {
        let new_contact = Contact.mockNewContact1() //need to have "Id" field
        
        let success = contactViewModel.createNewContactToSoup(object: new_contact)
        
        //assuming online
        if success { //if upsert to local store is successful then upload to server
            contactViewModel.uploadContactACRToServer(object: new_contact, completion: { error in
                if error != nil {
                    print(error?.localizedDescription ?? "error")
                }
            })
        }
    }
    
    //Used to push the screen to Details ViewController
    func pushTheScreenToContactDetailsScreen(contactData: Contact) {
        contactDetails = self.storyboard?.instantiateViewController(withIdentifier: "ContactListDetailsViewControllerID") as? ContactListDetailsViewController
        
        self.view.endEditing(true)
        
        contactDetails?.contactDetail = contactData
        self.addChildViewController(contactDetails!)
        self.view.addSubview((contactDetails?.view)!)
    }

}
