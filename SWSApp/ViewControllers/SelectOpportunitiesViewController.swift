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
        //STATEMACHINE:No State Change
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func backVC(sender: UIButton) {
        //STATEMACHINE:No State Change
        self.dismiss(animated: true)
    }
    
    @IBAction func saveAndClose(sender: UIButton) {
        //STATEMACHINE:If you com tho this Screen its in Planned state
        PlanVistManager.sharedInstance.status = "Scheduled"
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
}
