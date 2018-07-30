//
//  AccountVisitEmbedViewController.swift
//  SWSApp
//
//  Created by r.a.jantakal on 18/05/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation
import UIKit

class AccountVisitEmbedViewController : UIViewController{
    
    var accountVisitListVC : AccountVisitListViewController?
    var accountVisitFilterVC : AccountVisitListFilterViewController?
    
    //MARK:- View LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        accountVisitFilterVC?.delegate = accountVisitListVC
        accountVisitListVC?.delegate = accountVisitFilterVC
    }
    
    //MARK:- Segue Methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "listSegue") {
            accountVisitListVC = segue.destination as? AccountVisitListViewController
            //accountVisitFilterVC?.delegate = self
            
        }else if (segue.identifier == "filterSegue") {
            accountVisitFilterVC = segue.destination as? AccountVisitListFilterViewController
        }
    }
}
