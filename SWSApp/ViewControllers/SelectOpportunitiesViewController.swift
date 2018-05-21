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
        PlanVisitManager.sharedInstance.editPlanVisit = false
    }
    
    
    // MARK:- IBAction
    
    @IBAction func closeVC(sender: UIButton) {
        //STATEMACHINE:No State Change
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshAccountVisitList"), object:nil)
        DispatchQueue.main.async {
            self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func backVC(sender: UIButton) {
        //STATEMACHINE:No State Change
        DispatchQueue.main.async {
            self.dismiss(animated: true)
        }
    }
    
    @IBAction func saveAndClose(sender: UIButton) {
        //STATEMACHINE:If you com tho this Screen its in Planned state
        PlanVisitManager.sharedInstance.visit?.status = "Planned"
        PlanVisitManager.sharedInstance.editAndSaveVisit()
        DispatchQueue.main.async {
            self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func loadStrategyScreen(sender : UIButton){
        
        let accountId = PlanVisitManager.sharedInstance.visit?.accountId
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Strategy", bundle: nil)
        let vc: AccountStrategyViewController = storyboard.instantiateViewController(withIdentifier: "AccountStrategyViewControllerID") as! AccountStrategyViewController
        StrategyScreenLoadFrom.isLoadFromStrategy = "1"
        
        AccountId.selectedAccountId = accountId!
        
        (vc as AccountStrategyViewController).modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        DispatchQueue.main.async {
            self.present(vc, animated: true, completion: nil)
        }
        
    }
    
}
