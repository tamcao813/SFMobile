//
//  AccountsDetailsViewController.swift
//  SWSApp
//
//  Created by r.a.jantakal on 04/04/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation
import UIKit
//import DropDown

//DropDown menu optrions when AddNew is clicked
enum DropDownMenuOptionsInDetails : Int{
    case visit = 0
    case event = 1
    case actionItems = 2
    case notes = 3
}

//Detail screen Options
enum DetailsScreenEnumOptions : Int {
    case overview = 0
    case details = 1
    case opportunities = 3
    case strategy = 4
    case actionItems = 5
    case notes = 6
}

struct AccountId {
    static var selectedAccountId = ""
}

protocol SendDataToContainerDelegate {
    func passTheViewControllerToBeLoadedInContainerView(index : Int)
}

class AccountDetailsViewController : UIViewController , sendNotesDataToNotesDelegate,DetailsScreenDelegate{
    
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
    @IBOutlet weak var scrollView: UIScrollView!
    var accountDetailForLoggedInUser : Account?
    var goingFromAccountDetails = true
    var selectedIndex : Int = 0
    var firstViewController: NotesViewController?
    var detailsViewController : AccountDetailsViewController?
    var secondViewController: UIViewController?
    var delegate : SendDataToContainerDelegate?
    var detailDelegate : DetailsScreenDelegate?
    let accountViewModel = AccountsViewModel()
    var addNewDropDown = DropDown()
    let contactsStoryboard = UIStoryboard.init(name: "AccountsContactsVC", bundle: nil)
    let accountOverViewStoryboard = UIStoryboard.init(name: "AccountOverView", bundle: nil)
    let notesStoryboard = UIStoryboard.init(name: "Notes", bundle: nil)
    let strategyStoryboard = UIStoryboard.init(name: "Strategy", bundle: nil)
    let opportunitiesStoryboard = UIStoryboard.init(name: "Opportunities", bundle: nil)
    let mainStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
    let actionItemStoryboard = UIStoryboard.init(name: "ActionItem", bundle: nil)
    lazy var actionItemContainerVC : ActionItemsContainerViewController? = {
        let actionItemStoryboard: UIStoryboard = UIStoryboard(name: "ActionItem", bundle: nil)
        let actionItemVC = actionItemStoryboard.instantiateViewController(withIdentifier: "ActionItemsContainerViewController") as? ActionItemsContainerViewController
        return actionItemVC
    }()
    
    func dismissKeyBoard() {
        
    }
    func pushTheScreenToDetailsScreen(accountData: Account) {
        accountDetailForLoggedInUser = accountData
    }
    
    //Present Active ViewController
    private var activeViewController: UIViewController? {
        didSet {
            removeInactiveViewController(inactiveViewController: oldValue)
            updateActiveViewController()
        }
    }
    
    //Remove Inactive ViewController
    private func removeInactiveViewController(inactiveViewController: UIViewController?) {
        if let inActiveVC = inactiveViewController {
            // call before removing child view controller's view from hierarchy
            inActiveVC.willMove(toParentViewController: nil)
            
            inActiveVC.view.removeFromSuperview()
            
            // call after removing child view controller's view from hierarchy
            inActiveVC.removeFromParentViewController()
        }
    }
    
    //Update Active ViewController
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
    
    //MARK:- View LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Account details Screen is loaded")
        lblActionItem?.layer.borderColor = UIColor.init(named: "Data New")?.cgColor
        //containerView?.isHidden = true
        AccountsListViewController.accountListDelegate = self
        let button = UIButton()
        button.tag = 0
        self.itemsClicked(sender: button)
        
        //containerView?.isHidden = true
        NotificationCenter.default.addObserver(self, selector: #selector(self.refreshActionItemList), name: NSNotification.Name("refreshActionItemList"), object: nil)
        addNewButton.setAttributedTitle(AttributedStringUtil.formatAttributedText(smallString: "Add New ", bigString: "+"), for: .normal)
        
        StrategyScreenLoadFrom.isLoadFromStrategy = "0"
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
    }

    @objc func keyboardWillShow(notification:NSNotification){
        guard let keyboardFrameValue = notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue else {
            return
        }
        let keyboardFrame = view.convert(keyboardFrameValue.cgRectValue, from: nil)
        scrollView.contentOffset = CGPoint(x:0, y:keyboardFrame.size.height - 100)
    }
    
    @objc func keyboardWillHide(notification:NSNotification){
        scrollView.contentOffset = .zero
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupDetailsScreenUI()
        self.setupPastDueUI()
      //  self.setupAccountHealthGrade()
        self.setupPercentageValue()
    }
    
    //MARK:-
    //Navigate to Notes Section after adding Notes
    func navigateToNotesSection() {
        let button = UIButton()
        button.tag = 6
        self.itemsClicked(sender: button)
    }
    
    @objc func refreshActionItemList(){
        if selectedIndex == 5{
            let button = UIButton()
            button.tag = 5
            self.itemsClicked(sender: button)
        }
    }
    
    //Initial setup for Deatils Screen UI
    func setupDetailsScreenUI(){
        
        AccountId.selectedAccountId = (accountDetailForLoggedInUser?.account_Id)!
        
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
    
    //Setup Past Due UI
    func setupPastDueUI(){
        
        if accountDetailForLoggedInUser!.pastDueAmountDouble <= 0.0 {
            imgStatus?.isHidden = true
        }else {
            imgStatus?.isHidden = false
        }
    }
    
//    //Setup Health Grade value wheather its Good, Medium or Bad
//    func setupAccountHealthGrade(){
//        if accountDetailForLoggedInUser?.acctHealthGrade == "A"{
//            centerLabel?.text = accountDetailForLoggedInUser?.acctHealthGrade
//            centerLabel?.layer.backgroundColor = UIColor(named: "Good")?.cgColor//green.cgColor
//        }else if accountDetailForLoggedInUser?.acctHealthGrade == "B"{
//            centerLabel?.text = accountDetailForLoggedInUser?.acctHealthGrade
//            centerLabel?.layer.backgroundColor = UIColor(named: "Medium Alert")?.cgColor//yellow.cgColor
//        }else if accountDetailForLoggedInUser?.acctHealthGrade == "C"{
//            centerLabel?.text = accountDetailForLoggedInUser?.acctHealthGrade
//            centerLabel?.layer.backgroundColor = UIColor.orange.cgColor
//
//        }else if accountDetailForLoggedInUser?.acctHealthGrade == "D"{
//            centerLabel?.text = accountDetailForLoggedInUser?.acctHealthGrade
//            centerLabel?.layer.backgroundColor = UIColor(named: "Bad")?.cgColor//.red.cgColor
//        } else {
//            centerLabel?.layer.backgroundColor = UIColor.clear.cgColor
//        }
//    }
    
    //Based on Percentage values images Bad, Medium and Good are shown
    func setupPercentageValue(){
        
        let percLastYearR12DivideBy100:Double = ((accountDetailForLoggedInUser?.percentageLastYearR12NetSales)!as NSString).doubleValue / 100
        let percentYearR12Double:Double =  ((accountDetailForLoggedInUser?.percentageLastYearR12NetSales)!as NSString).doubleValue
        
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
    
    //MARK:- IBAction Methods
    @IBAction func addNewButtonClicked(_ sender: Any) {
        addNewDropDown.anchorView = addNewButton
        
        addNewDropDown.bottomOffset = CGPoint(x: 0, y:(addNewDropDown.anchorView?.plainView.bounds.height)!)
        addNewDropDown.backgroundColor = UIColor.white
        addNewDropDown.dataSource = ["Visit", "Event", "Action Item", "Note"]
        self.addNewDropDown.textFont = UIFont(name: "Ubuntu", size: 14)!
        self.addNewDropDown.textColor = UIColor.black
        
        addNewDropDown.show()
        
        addNewDropDown.selectionAction = {(index: Int, item: String) in
            switch index {
            case DropDownMenuOptionsInDetails.visit.rawValue :
                print(index)
                
                let storyboard: UIStoryboard = UIStoryboard(name: "AccountVisit", bundle: nil)
                let vc: CreateNewVisitViewController = storyboard.instantiateViewController(withIdentifier: "CreateNewVisitViewController") as! CreateNewVisitViewController
                vc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                vc.selectedAccount = self.accountDetailForLoggedInUser
                
                //As we are creating a new Visit Make the Shared instance Nil
                PlanVisitManager.sharedInstance.visit = nil
                
                self.present(vc, animated: false, completion: nil)
                
            case DropDownMenuOptionsInDetails.event.rawValue :
                print(index)
                
                let createEventViewController = UIStoryboard(name: "CreateEvent", bundle: nil).instantiateViewController(withIdentifier :"CreateNewEventViewController") as! CreateNewEventViewController
                createEventViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                createEventViewController.selectedAccount = self.accountDetailForLoggedInUser
                //As we are creating a new Visit Make the Shared instance Nil
                PlanVisitManager.sharedInstance.visit = nil
                
                self.present(createEventViewController, animated: false, completion: nil)
                
            case DropDownMenuOptionsInDetails.actionItems.rawValue:
                DispatchQueue.main.async {
                    let createActionItemViewController = UIStoryboard(name: "ActionItem", bundle: nil).instantiateViewController(withIdentifier :"CreateNewActionItemViewController") as! CreateNewActionItemViewController
                    createActionItemViewController.isEditingMode = false
                    createActionItemViewController.selectedAccount = self.accountDetailForLoggedInUser
                    //                    createActionItemViewController.delegate = self
                    self.present(createActionItemViewController, animated: false)
                }
            case DropDownMenuOptionsInDetails.notes.rawValue :
                let storyboard: UIStoryboard = UIStoryboard(name: "Notes", bundle: nil)
                let vc: CreateNoteViewController = storyboard.instantiateViewController(withIdentifier: "NotesID") as! CreateNoteViewController
                vc.notesAccountId = self.accountDetailForLoggedInUser?.account_Id
                vc.comingFromAccountDetails = self.goingFromAccountDetails
                vc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                
                self.present(vc, animated: false, completion: nil)
                vc.sendNoteDelegate = self
            default:
                break
            }
        }
    }
    
    //Back Button Clicked
    @IBAction func backButtonAction(sender : UIButton){
        FilterMenuModel.comingFromDetailsScreen = "NO"
        self.view.removeFromSuperview()
    }
    
    //Details header Section Clicked
    @IBAction func itemsClicked(sender : UIButton){
        containerView?.isHidden = true
        
        btnOverview?.backgroundColor = UIColor(named: "VeryLightGrey")
        btnDetails?.backgroundColor = UIColor(named: "VeryLightGrey")
        btnInsights?.backgroundColor = UIColor(named: "VeryLightGrey")
        btnOpportunities?.backgroundColor = UIColor(named: "VeryLightGrey")
        btnStrategy?.backgroundColor = UIColor(named: "VeryLightGrey")
        btnActionItems?.backgroundColor = UIColor(named: "VeryLightGrey")
        btnNotes?.backgroundColor = UIColor(named: "VeryLightGrey")
        
        btnOverview?.setTitleColor(UIColor.gray, for: .normal)
        btnDetails?.setTitleColor(UIColor.gray, for: .normal)
        btnInsights?.setTitleColor(UIColor.gray, for: .normal)
        btnOpportunities?.setTitleColor(UIColor.gray, for: .normal)
        btnStrategy?.setTitleColor(UIColor.gray, for: .normal)
        btnActionItems?.setTitleColor(UIColor.gray, for: .normal)
        btnNotes?.setTitleColor(UIColor.gray, for: .normal)
        
        switch sender.tag {
        case DetailsScreenEnumOptions.overview.rawValue :
            containerView?.isHidden = false
            btnOverview?.backgroundColor = UIColor.white
            btnOverview?.setTitleColor(UIColor.black, for: .normal)
            let accountOverView: AccountOverViewViewController = accountOverViewStoryboard.instantiateViewController(withIdentifier: "AccountOverViewID")  as! AccountOverViewViewController
            accountOverView.account = accountDetailForLoggedInUser
            activeViewController = accountOverView
            selectedIndex = 0
            
        case DetailsScreenEnumOptions.details.rawValue :
            containerView?.isHidden = false
            btnDetails?.backgroundColor = UIColor.white
            btnDetails?.setTitleColor(UIColor.black, for: .normal)
            
            let detailsViewController: AccountDetailTabViewController = contactsStoryboard.instantiateViewController(withIdentifier: "AccountDetailTabViewControllerID") as! AccountDetailTabViewController
            
            detailsViewController.account = accountDetailForLoggedInUser
            activeViewController = detailsViewController
            selectedIndex = 1
            
        case DetailsScreenEnumOptions.opportunities.rawValue :
            containerView?.isHidden = false
            btnOpportunities?.backgroundColor = UIColor.white
            btnOpportunities?.setTitleColor(UIColor.black, for: .normal)

            let opportunitiesViewController: OpportunitiesViewController = opportunitiesStoryboard.instantiateViewController(withIdentifier: "OpportunitiesViewControllerID") as! OpportunitiesViewController
            OpportunitiesFilterMenuModel.accountId = accountDetailForLoggedInUser?.account_Id

            activeViewController = opportunitiesViewController
            selectedIndex = 3
            
        case DetailsScreenEnumOptions.strategy.rawValue :
            containerView?.isHidden = false
            btnStrategy?.backgroundColor = UIColor.white
            btnStrategy?.setTitleColor(UIColor.black, for: .normal)
            
            let strategyViewController: AccountStrategyViewController = strategyStoryboard.instantiateViewController(withIdentifier: "AccountStrategyViewControllerID") as! AccountStrategyViewController
            activeViewController = strategyViewController
            selectedIndex = 4
            
        case DetailsScreenEnumOptions.actionItems.rawValue :
            btnActionItems?.backgroundColor = UIColor.white
            btnActionItems?.setTitleColor(UIColor.black, for: .normal)
            containerView?.isHidden = false
            ActionItemFilterModel.accountId = accountDetailForLoggedInUser?.account_Id
            ActionItemFilterModel.fromAccount = true
            activeViewController = actionItemContainerVC
            actionItemContainerVC?.fromPersistentMenu = false
            selectedIndex = 5
            
        case DetailsScreenEnumOptions.notes.rawValue :
            btnNotes?.backgroundColor = UIColor.white
            btnNotes?.setTitleColor(UIColor.black, for: .normal)
            containerView?.isHidden = false
            
            let notesViewController: NotesViewController = notesStoryboard.instantiateViewController(withIdentifier: "AccountNotesID") as! NotesViewController
            notesViewController.accountId = accountDetailForLoggedInUser?.account_Id
            activeViewController = notesViewController
            selectedIndex = 6
        default:
            break
        }
    }
    
    func displayAccountNotes() {
        
    }
    
    func dismissEditNote() {
        
    }
    
    func noteCreated() {
        
    }
}

