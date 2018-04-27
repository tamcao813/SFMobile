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


    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("AccountVisits VC will disappear")
    }
    
    @IBAction func planVisitClick(sender: UIButton) {
        let storyboard = UIStoryboard(name: "PlanVisitEditableScreen", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier :"PlanVisitViewControllerID")
//        viewController.view.frame = CGRect(x:0, y:0, width: self.view.frame.size.width, height: self.view.frame.size.height)
//        self.view.addSubview((viewController.view)!)
        self.present(viewController, animated: true)
    }
}
