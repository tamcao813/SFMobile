//
//  AccountsViewController.swift
//  SWSApp
//
//  Created by shilpa.a.kulkarni on 26/03/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class AccountsViewController: UIViewController , DetailsScreenDelegate{
    
    
    var accountDetails : AccountDetailsViewController?
    
    //MARK:- View LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("Accounts VC will appear")
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("Accounts VC will disappear")
        
        
        self.accountDetails?.view.removeFromSuperview()
    }
    
    //MARK:-
    
    //Used to push the screen to Details ViewController
    func pushTheScreenToDetailsScreen(accountData: Account) {
        accountDetails = self.storyboard?.instantiateViewController(withIdentifier: "AccountDetailsViewControllerID") as? AccountDetailsViewController
        accountDetails?.accountsForLoggedInUser = accountData
        self.addChildViewController(accountDetails!)
        //self.present(accountDetails, animated: true, completion: nil)
        self.view.addSubview((accountDetails?.view)!)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "mySegue") {
            let vc = segue.destination as! AccountsListViewController
            vc.delegate = self
        }
    }
    
    
}
