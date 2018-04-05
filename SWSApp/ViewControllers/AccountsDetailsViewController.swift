//
//  AccountsDetailsViewController.swift
//  SWSApp
//
//  Created by r.a.jantakal on 04/04/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation
import UIKit

class AccountDetailsViewController : UIViewController{
    
    var accountsForLoggedInUser : Account?
    
    @IBOutlet weak var centerLabel : UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Account details Screen is loaded")
        
        centerLabel?.layer.cornerRadius = 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print(accountsForLoggedInUser!)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        
    }
    
    
}
