//
//  AccountsDetailsViewController.swift
//  SWSApp
//
//  Created by r.a.jantakal on 04/04/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation
import UIKit
import DropDown

protocol SendDataToContainerDelegate {
    func passTheViewControllerToBeLoadedInContainerView(index : Int)
}

class AccountDetailsViewController : UIViewController , sendNotesDataToNotesDelegate{
    func displayAccountNotes() {
        
    }
    
    func dismissEditNote() {
        
    }
    
    func noteCreated() {
        
    }
    
    
    var accountDetailForLoggedInUser : Account?
    var goingFromAccountDetails = true
    
    
    
    
    @IBOutlet weak var centerLabel : UILabel?
    @IBOutlet weak var lblAccountTitle : UILabel?
    @IBOutlet weak var lblAddress1 : UILabel?
    @IBOutlet weak var lblAddress2 : UILabel?
    @IBOutlet weak var lblPastDue : UILabel?
    @IBOutlet weak var lblCYR12Sales : UILabel?
    @IBOutlet weak var lblLicenseStatus : UILabel?
    @IBOutlet weak var lblActionItem : UILabel?
    @IBOutlet weak var lblPhoneNumber : UILabel?
    @IBOutlet weak var btnPercentage : UIButton?
    
    @IBOutlet weak var containerView : UIView?
    
    @IBOutlet weak var btnOverview : UIButton?
    @IBOutlet weak var btnDetails : UIButton?
    @IBOutlet weak var btnInsights : UIButton?
    @IBOutlet weak var btnOpportunities : UIButton?
    @IBOutlet weak var btnStrategy : UIButton?
    @IBOutlet weak var btnActionItems : UIButton?
    @IBOutlet weak var btnNotes : UIButton?
    @IBOutlet weak var imgStatus : UIImageView?
    
    @IBOutlet weak var addNewButton: UIButton!
    
    var selectedIndex : Int = 0
    
    var firstViewController: NotesViewController?
    var detailsViewController : AccountDetailsViewController?
    
    var secondViewController: UIViewController?
    
    var delegate : SendDataToContainerDelegate?
    
    var addNewDropDown = DropDown()
    
    let contactsStoryboard = UIStoryboard.init(name: "AccountsContactsVC", bundle: nil)
    let notesStoryboard = UIStoryboard.init(name: "Notes", bundle: nil)
    let strategyStoryboard = UIStoryboard.init(name: "Strategy", bundle: nil)
    let mainStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
    
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
            
            let rectNewFrame: CGRect = CGRect(x: (containerView?.bounds.origin.x)!, y: (containerView?.bounds.origin.y)!, width: (containerView?.bounds.size.width)!, height: ((containerView?.bounds.size.height)!-65))
            
            activeVC.view.frame = rectNewFrame
            containerView?.addSubview(activeVC.view)
            
            // call before adding child view controller's view as subview
            activeVC.didMove(toParentViewController: self)
        }
    }
    
    @IBAction func addNewButtonClicked(_ sender: Any) {
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Notes", bundle: nil)
        let vc: CreateNoteViewController = storyboard.instantiateViewController(withIdentifier: "NotesID") as! CreateNoteViewController
        vc.notesAccountId = accountDetailForLoggedInUser?.account_Id
        vc.comingFromAccountDetails = goingFromAccountDetails
        vc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
       
        self.present(vc, animated: true, completion: nil)
        vc.sendNoteDelegate = self
        
    }
    
    func navigateToNotesSection() {
        
        let button = UIButton()
        button.tag = 6
        self.itemsClicked(sender: button)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Account details Screen is loaded")
        lblActionItem?.layer.borderColor = UIColor.init(named: "Data New")?.cgColor
        containerView?.isHidden = true
        
       
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setupDetailsScreenUI()
        self.setupPastDueUI()
        self.setupAccountHealthGrade()
        self.setupPercentageValue()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        
    }
   
    
    func setupDetailsScreenUI(){
        
        lblAccountTitle?.text = accountDetailForLoggedInUser?.accountName
        lblActionItem?.text = String(describing: accountDetailForLoggedInUser!.actionItem)
        lblPastDue?.text = CurrencyFormatter.convertToCurrencyFormat(amountToConvert: (accountDetailForLoggedInUser?.pastDueAmountDouble)!) //String(format: "$%.2f",(accountDetailForLoggedInUser?.pastDueAmountDouble)!)
        lblCYR12Sales?.text = CurrencyFormatter.convertToCurrencyFormat(amountToConvert: (accountDetailForLoggedInUser?.totalCYR12NetSales)!)
        lblLicenseStatus?.text = accountDetailForLoggedInUser?.licenseStatus
        lblPhoneNumber?.text = accountDetailForLoggedInUser?.phone
        
        if let acc = accountDetailForLoggedInUser{
            
            var fullAddress = ""
            if acc.shippingStreet == "" && acc.shippingCity == "" && acc.shippingState == "" && acc.shippingPostalCode == "" {
                fullAddress = acc.shippingStreet + " " + acc.shippingCity + " " + acc.shippingState +  " " + acc.shippingPostalCode
                
            }else{
                if (acc.shippingStreet != "" || acc.shippingCity != "") {
                    if (acc.shippingState != "" || acc.shippingPostalCode != "") {
                        fullAddress = acc.shippingStreet + " " + acc.shippingCity + "," + " " + acc.shippingState +  " " + acc.shippingPostalCode
                    }else{
                        fullAddress = acc.shippingStreet + " " + acc.shippingCity + " " + acc.shippingState +  " " + acc.shippingPostalCode
                    }
                }else{
                    fullAddress = acc.shippingStreet + " " + acc.shippingCity + " " + acc.shippingState +  " " + acc.shippingPostalCode
                }
            }
            lblAddress1?.text = fullAddress
        }
    }
    
    func setupPastDueUI(){
        
        if accountDetailForLoggedInUser!.pastDueAmountDouble <= 0.0 {
            imgStatus?.isHidden = true
        }else {
            imgStatus?.isHidden = false
        }
    }
    
    func setupAccountHealthGrade(){
        if accountDetailForLoggedInUser?.acctHealthGrade == "A"{
            centerLabel?.text = accountDetailForLoggedInUser?.acctHealthGrade
            centerLabel?.layer.backgroundColor = UIColor(named: "Good")?.cgColor//green.cgColor
        }else if accountDetailForLoggedInUser?.acctHealthGrade == "B"{
            centerLabel?.text = accountDetailForLoggedInUser?.acctHealthGrade
            centerLabel?.layer.backgroundColor = UIColor(named: "Medium Alert")?.cgColor//yellow.cgColor
        }else if accountDetailForLoggedInUser?.acctHealthGrade == "C"{
            centerLabel?.text = accountDetailForLoggedInUser?.acctHealthGrade
            centerLabel?.layer.backgroundColor = UIColor.orange.cgColor
            
        }else if accountDetailForLoggedInUser?.acctHealthGrade == "D"{
            centerLabel?.text = accountDetailForLoggedInUser?.acctHealthGrade
            centerLabel?.layer.backgroundColor = UIColor(named: "Bad")?.cgColor//.red.cgColor
        } else {
            centerLabel?.layer.backgroundColor = UIColor.clear.cgColor
        }
    }
    
    
    func setupPercentageValue(){
        
        let percLastYearR12DivideBy100:Double = ((accountDetailForLoggedInUser?.percentageLastYearR12NetSales)!as NSString).doubleValue / 100
        let percentYearR12Double:Double =  ((accountDetailForLoggedInUser?.percentageLastYearR12NetSales)!as NSString).doubleValue
        
        //        var strVal = String(percLastYearR12DivideBy100)
        //        var fullPerR12NetSaleValue = strVal.components(separatedBy: ".")
        //        var strNew = fullPerR12NetSaleValue[0] + "." + String(fullPerR12NetSaleValue[1].prefix(2)) + "%"
        
        let titleForButton = String(format: "%.02f",percentYearR12Double) + "%"
        
        print("the button text is \(titleForButton)")
        
        if percLastYearR12DivideBy100 < 0.80 {
            btnPercentage?.setTitle(titleForButton, for: .normal)
            btnPercentage?.backgroundColor = UIColor(named: "Bad")
        }else if percLastYearR12DivideBy100 >= 0.80 && percLastYearR12DivideBy100 <= 0.99 {
            btnPercentage?.setTitle(titleForButton, for: .normal)
            btnPercentage?.backgroundColor = UIColor(named: "Medium Alert")
        }
        else if percLastYearR12DivideBy100 > 0.99 {
            btnPercentage?.setTitle(titleForButton, for: .normal)
            btnPercentage?.backgroundColor = UIColor(named: "Good")
        }
    }
    
   
    @IBAction func itemsClicked(sender : UIButton){
        
        containerView?.isHidden = true
        
        btnOverview?.backgroundColor = UIColor(named: "LightGrey")
        btnDetails?.backgroundColor = UIColor(named: "LightGrey")
        btnInsights?.backgroundColor = UIColor(named: "LightGrey")
        btnOpportunities?.backgroundColor = UIColor(named: "LightGrey")
        btnStrategy?.backgroundColor = UIColor(named: "LightGrey")
        btnActionItems?.backgroundColor = UIColor(named: "LightGrey")
        btnNotes?.backgroundColor = UIColor(named: "LightGrey")
        
        btnOverview?.setTitleColor(UIColor.gray, for: .normal)
        btnDetails?.setTitleColor(UIColor.gray, for: .normal)
        btnInsights?.setTitleColor(UIColor.gray, for: .normal)
        btnOpportunities?.setTitleColor(UIColor.gray, for: .normal)
        btnStrategy?.setTitleColor(UIColor.gray, for: .normal)
        btnActionItems?.setTitleColor(UIColor.gray, for: .normal)
        btnNotes?.setTitleColor(UIColor.gray, for: .normal)
        
        switch sender.tag {
        case 0:
            btnOverview?.backgroundColor = UIColor.white
            btnOverview?.setTitleColor(UIColor.black, for: .normal)
        case 1:
            containerView?.isHidden = false
            btnDetails?.backgroundColor = UIColor.white
            btnDetails?.setTitleColor(UIColor.black, for: .normal)
            
            let detailsViewController: AccountDetailTabViewController = contactsStoryboard.instantiateViewController(withIdentifier: "AccountDetailTabViewControllerID") as! AccountDetailTabViewController
            
            detailsViewController.account = accountDetailForLoggedInUser
            activeViewController = detailsViewController
            
        case 2:
            btnInsights?.backgroundColor = UIColor.white
            btnInsights?.setTitleColor(UIColor.black, for: .normal)
            
        case 3:
            containerView?.isHidden = false
            btnOpportunities?.backgroundColor = UIColor.white
            btnOpportunities?.setTitleColor(UIColor.black, for: .normal)
            
            let opportunitiesViewController: OpportunitiesViewController = mainStoryboard.instantiateViewController(withIdentifier: "OpportunitiesViewControllerID") as! OpportunitiesViewController
            activeViewController = opportunitiesViewController
        case 4:
            containerView?.isHidden = false
            btnStrategy?.backgroundColor = UIColor.white
            btnStrategy?.setTitleColor(UIColor.black, for: .normal)
            
            let strategyViewController: AccountStrategyViewController = strategyStoryboard.instantiateViewController(withIdentifier: "AccountStrategyViewControllerID") as! AccountStrategyViewController
            activeViewController = strategyViewController
            
        case 5:
            
            btnActionItems?.backgroundColor = UIColor.white
            btnActionItems?.setTitleColor(UIColor.black, for: .normal)
            
        case 6:
            btnNotes?.backgroundColor = UIColor.white
            btnNotes?.setTitleColor(UIColor.black, for: .normal)
            containerView?.isHidden = false
            
            let notesViewController: NotesViewController = notesStoryboard.instantiateViewController(withIdentifier: "AccountNotesID") as! NotesViewController
            notesViewController.accountId = accountDetailForLoggedInUser?.account_Id
            activeViewController = notesViewController
            
        default:
            break
        }
    }
    
}


