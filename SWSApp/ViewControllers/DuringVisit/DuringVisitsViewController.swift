//
//  DuringVisitsViewController.swift
//  SWSApp
//
//  Created by r.a.jantakal on 27/04/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation
import UIKit
import IQKeyboardManagerSwift


enum LoadThePersistantMenuScreen : Int{
    case contacts = 0
    case chatter
    case actionItems
    case notifications
}

protocol NavigateToAccountVisitSummaryDelegate {
    func NavigateToAccountVisitSummary(data : LoadThePersistantMenuScreen)
    func navigateToAccountVisitingScreen()
}

class  DuringVisitsViewController : UIViewController {
    
    @IBOutlet weak var containerView : UIView?
    @IBOutlet weak var btnBack : UIButton?
    
    @IBOutlet weak var imgDiscussion : UIImageView?
    @IBOutlet weak var imgInsights : UIImageView?
    
    @IBOutlet weak var btnDiscussion : UIButton?
    @IBOutlet weak var btnInsights : UIButton?
    
    @IBOutlet weak var btnEditAccountStrategy : UIButton?
    @IBOutlet weak var btnSaveContinueComplete : UIButton?
    
    var visitObject: Visit?
    
    var delegate : NavigateToAccountVisitSummaryDelegate?
    
    
    private var activeViewController: UIViewController? {
        didSet {
            removeInactiveViewController(inactiveViewController: oldValue)
            updateActiveViewController()
        }
    }
    
    private func removeInactiveViewController(inactiveViewController: UIViewController?) {
        if let inActiveVC = inactiveViewController {
            // call before removing child view controller's view from hierarchy
            inActiveVC.willMove(toParentViewController: nil)
            
            inActiveVC.view.removeFromSuperview()
            
            // call after removing child view controller's view from hierarchy
            inActiveVC.removeFromParentViewController()
        }
    }
    
    private func updateActiveViewController() {
        if let activeVC = activeViewController {
            // call before adding child view controller's view as subview
            addChildViewController(activeVC)
            
            activeVC.view.frame = (containerView?.bounds)!
            containerView?.addSubview(activeVC.view)
            
            // call before adding child view controller's view as subview
            activeVC.didMove(toParentViewController: self)
        }
    }
    
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnInsights?.setTitle("", for: .normal)
        
        let storyboard = UIStoryboard.init(name: "DuringVisit", bundle: nil)
        let duringVisitVC: DuringVisitsTopicsViewController = storyboard.instantiateViewController(withIdentifier: "DuringVisitsTopicsViewControllerID") as! DuringVisitsTopicsViewController
        
        duringVisitVC.visitObject = visitObject
        
        activeViewController = duringVisitVC
        
        IQKeyboardManager.shared.enable = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        
    }
    
    
    //MARK:- IBAction Methods
    @IBAction func closeButtonClicked(sender : UIButton){
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func transactionClicked(sender : UIButton){
        UIApplication.shared.open(URL(string : "http://www.google.com")!, options: [:], completionHandler: { (status) in
            
        })
    }
    
    @IBAction func goSpotClicked(sender : UIButton){
        
        UIApplication.shared.open(URL(string : "http://www.google.com")!, options: [:], completionHandler: { (status) in
            
        })
    }
    
    @IBAction func backButtonClicked(sender : UIButton){
        
        btnBack?.isHidden = true
        imgDiscussion?.image = UIImage(named: "selectedButton")
        imgInsights?.image = UIImage(named: "selectedGrey")
        
        btnDiscussion?.setTitle("Discussion", for: .normal)
        btnInsights?.setTitle("", for: .normal)
        btnSaveContinueComplete?.setTitle("Save and Continue", for: .normal)
        
        
        let storyboard = UIStoryboard.init(name: "DuringVisit", bundle: nil)
        let duringVisitVC: DuringVisitsTopicsViewController = storyboard.instantiateViewController(withIdentifier: "DuringVisitsTopicsViewControllerID") as! DuringVisitsTopicsViewController
        duringVisitVC.visitObject = visitObject
        activeViewController = duringVisitVC
    }
    
    @IBAction func saveContinueAndComplete(sender : UIButton){
        
        if btnSaveContinueComplete?.titleLabel?.text == "Save and Continue"{
            PlanVistManager.sharedInstance.status = "In-Progress"
        }
        else if btnSaveContinueComplete?.titleLabel?.text == "Complete"{
            PlanVistManager.sharedInstance.status = "Completed"
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshAccountList"), object:nil)
            self.dismiss(animated: true, completion: nil)
            delegate?.navigateToAccountVisitingScreen()
            return
        }
        
        btnBack?.isHidden = false
        imgDiscussion?.image = UIImage(named: "Small Status Good")
        imgInsights?.image = UIImage(named: "selectedButton")
        
        btnDiscussion?.setTitle("", for: .normal)
        btnInsights?.setTitle("Insights", for: .normal)
        btnSaveContinueComplete?.setTitle("Complete", for: .normal)
        
        let storyboard = UIStoryboard.init(name: "DuringVisit", bundle: nil)
        let duringVisitVC: DuringVisitsInsightsViewController = storyboard.instantiateViewController(withIdentifier: "DuringVisitsInsightsViewControllerID") as! DuringVisitsInsightsViewController
        activeViewController = duringVisitVC
        
        
    }
    
    @IBAction func loadEditAccountStrategy(sender : UIButton){
        let storyboard: UIStoryboard = UIStoryboard(name: "Strategy", bundle: nil)
        let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: "EditAccountStrategyViewControllerID") as UIViewController
        vc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.present(vc, animated: true, completion: nil)
        
    }
    
    @IBAction func contactsClicked(sender : UIButton){
        DispatchQueue.main.async {
            AlertUtilities.showAlertMessageWithTwoActionsAndHandler("Any changes will not be saved", errorMessage: "Are you sure you want to close?", errorAlertActionTitle: "Yes", errorAlertActionTitle2: "No", viewControllerUsed: self, action1: {                
                self.dismiss(animated: false, completion: nil)
                self.delegate?.NavigateToAccountVisitSummary(data: .contacts)
            }) {
                print("No")
            }
        }
    }
    
    @IBAction func chatterClicked(sender : UIButton){
        AlertUtilities.showAlertMessageWithTwoActionsAndHandler("Any changes will not be saved", errorMessage: "Are you sure you want to close?", errorAlertActionTitle: "Yes", errorAlertActionTitle2: "No", viewControllerUsed: self, action1: {
            
            self.dismiss(animated: true, completion: nil)
            self.delegate?.NavigateToAccountVisitSummary(data: .chatter)
            
        }) {
            
        }
    }
    
    @IBAction func actionItemsClicked(sender : UIButton){
        AlertUtilities.showAlertMessageWithTwoActionsAndHandler("Any changes will not be saved", errorMessage: "Are you sure you want to close?", errorAlertActionTitle: "Yes", errorAlertActionTitle2: "No", viewControllerUsed: self, action1: {
            
            self.dismiss(animated: true, completion: nil)
            self.delegate?.NavigateToAccountVisitSummary(data: .actionItems)
            
        }) {
            
        }
    }
    
    @IBAction func notificationsClicked(sender : UIButton){
        AlertUtilities.showAlertMessageWithTwoActionsAndHandler("Any changes will not be saved", errorMessage: "Are you sure you want to close?", errorAlertActionTitle: "Yes", errorAlertActionTitle2: "No", viewControllerUsed: self, action1: {
            
            self.dismiss(animated: true, completion: nil)
            self.delegate?.NavigateToAccountVisitSummary(data: .notifications)
            
        }) {
            
        }
    }
}





