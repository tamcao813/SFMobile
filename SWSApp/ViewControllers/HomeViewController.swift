//
//  HomeViewController.swift
//  SWSApp
//
//  Created by shilpa.a.kulkarni on 26/03/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    let userViewModel = UserViewModel()
    var loggerInUser: User?
    
    override func viewDidLoad() {
        loggerInUser = userViewModel.loggedInUser
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("Home VC will appear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("Home VC will disappear")
    }
}
