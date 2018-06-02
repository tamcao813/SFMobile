//
//  OpportunitiesViewController.swift
//  SWSApp
//
//  Created by Thillaiganesh, C. on 31/05/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class OpportunitiesViewController: UIViewController {

    var opportunitiesListVC: OpportunitiesListViewController?
    var filterMenuVC: OpportunitiesMenuViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        filterMenuVC?.searchByEnteredTextDelegate = opportunitiesListVC
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "OpportunitiesSegue") {
            opportunitiesListVC = segue.destination as? OpportunitiesListViewController
        }
        
        if(segue.identifier == "OpportunitiesQueryFilter")
        {
            filterMenuVC = segue.destination as? OpportunitiesMenuViewController
        }
    }

}
