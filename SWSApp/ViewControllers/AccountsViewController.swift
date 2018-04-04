//
//  AccountsViewController.swift
//  SWSApp
//
//  Created by shilpa.a.kulkarni on 26/03/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class AccountsViewController: UIViewController , DetailsScreenDelegate{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("Accounts VC will appear")
        
        let count =  self.view.subviews
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("Accounts VC will disappear")
    }
    
    func pushTheScreenToDetailsScreen(accountData: Account) {
         let accountDetails = self.storyboard?.instantiateViewController(withIdentifier: "AccountDetailsViewControllerID") as! AccountDetailsViewController
        accountDetails.accountsForLoggedInUser = accountData
        
        //self.present(accountDetails, animated: true, completion: nil)
        self.view.addSubview(accountDetails.view)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "mySegue") {
            let vc = segue.destination as! AccountsListViewController
            vc.delegate = self
        }
    }
    
    
}
