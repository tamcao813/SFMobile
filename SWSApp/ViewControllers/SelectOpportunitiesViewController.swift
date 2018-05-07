//
//  SelectOpportunitiesViewController.swift
//  SWSApp
//
//  Created by vipin.vijay on 26/04/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation

class SelectOpportunitiesViewController: UIViewController {
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("Plan VC will disappear")
        PlanVistManager.sharedInstance.editPlanVisit = false
    }
    
    
    // MARK:- IBAction
    
    @IBAction func closeVC(sender: UIButton) {
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func backVC(sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func saveAndClose(sender: UIButton) {
        
        
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
}
