//
//  AccountVisitsViewController.swift
//  SWSApp
//
//  Created by Krishna, Kamya on 4/3/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class AccountVisitsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Plan VC viewDidLoad")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("AccountVisits VC will appear")
        let storyboard = UIStoryboard(name: "PlanVisitEditableScreen", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier :"PlanVisitViewControllerID")
        self.view.addSubview((viewController.view)!)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("AccountVisits VC will disappear")
    }
    
    @IBAction func planVisitClick(sender: UIButton) {
        let storyboard = UIStoryboard(name: "PlanVisitEditableScreen", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier :"PlanVisitViewControllerID")
        self.view.addSubview((viewController.view)!)
//        self.present(viewController, animated: true)
    }
}
