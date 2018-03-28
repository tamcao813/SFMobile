//
//  ContactsViewController.swift
//  SWSApp
//
//  Created by shilpa.a.kulkarni on 26/03/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class ContactsViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("Contacts VC will appear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("Contacts VC will disappear")
    }
}
