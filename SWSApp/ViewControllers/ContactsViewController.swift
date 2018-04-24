//
//  AccountsContactViewController.swift
//  SWSApp
//
//  Created by r.a.jantakal on 05/04/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation
import UIKit

class ContactsViewController : UIViewController {
    
    var contactListVC: ContactListViewController?
    var filterMenuVC: ContactMenuViewController?
    var accountId: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Account id is \(accountId)")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("Contact VC will appear")
        filterMenuVC?.searchByEnteredTextDelegate = contactListVC

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ContactSegue") {
            contactListVC = segue.destination as? ContactListViewController
            contactListVC?.contactListAccountID = accountId
//            contactListVC?.delegate = self
        }
        
        if(segue.identifier == "ContactQueryFilter")
        {
            filterMenuVC = segue.destination as? ContactMenuViewController
//            filterMenuVC?.searchByEnteredTextDelegate = contactListVC
        }
    }

}
