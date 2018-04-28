//
//  ParentViewController.swift
//  SWSApp
//
//  Created by shilpa.a.kulkarni on 26/03/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit
import DropDown
import Reachability

struct SelectedMoreButton {
    static var selectedItem : Int = -1
}

struct ContactsGlobal {
    static var accountId: String = ""
}

class ParentViewController: UIViewController, XMSegmentedControlDelegate{
    // drop down on tapping more
    let moreDropDown = DropDown()
    // persistent menu
    var topMenuBar:XMSegmentedControl? = nil
    var wifiIconButton:UIBarButtonItem? = nil
    
    var moreDropDownSelectionIndex:Int?=0
    
    var notificationButton:UIBarButtonItem? = nil
    var numberLabel:UILabel? = nil
    
    @IBOutlet weak var contentView: UIView!
    // current view controller
    var currentViewController: UIViewController?
    var notificationsViewController:UIViewController?
    
    var notificationsView:UIView?
    var filterMenuModel = AccountsMenuViewController()
    //
    var previouslySelectedVCIndex = 0
    
    var ifMoreVC = false
    
    let moreMenuStoryboard = UIStoryboard.init(name: "MoreMenu", bundle: nil)
    
    // keep the views loaded
    //home VC
    lazy var homeVC: UIViewController? = {
        let homeTabVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewControllerID")
        return homeTabVC
    }()
    // accounts VC
    lazy var accountsVC : UIViewController? = {
        let accountsTabVC = self.storyboard?.instantiateViewController(withIdentifier: "AccountsViewControllerID")
        return accountsTabVC
    }()
    // contacts VC
    lazy var contactsVC : UIViewController? = {
        let contactsTabVC = self.storyboard?.instantiateViewController(withIdentifier: "ContactsViewControllerID")
        return contactsTabVC
    }()
    // calendar VC
    lazy var calendarVC : UIViewController? = {
        let calendarTabVC = self.storyboard?.instantiateViewController(withIdentifier: "CalendarViewControllerID")
        
        //let planVisitStoryboard: UIStoryboard = UIStoryboard(name: "PlanVisitEditableScreen", bundle: nil)
        //let calendarTabVC = planVisitStoryboard.instantiateViewController(withIdentifier: "PlanVisitViewControllerID")
        return calendarTabVC
    }()
    // objectives VC
    lazy var objectivesVC : UIViewController? = {
        let objectivesTabVC = self.storyboard?.instantiateViewController(withIdentifier: "ObjectivesControllerID")
        return objectivesTabVC
    }()
    // more VC
    lazy var moreVC : UIViewController? = {
        let moreStoryboard: UIStoryboard = UIStoryboard(name: "MoreMenu", bundle: nil)
        let moreTabVC = moreStoryboard.instantiateViewController(withIdentifier: "MoreViewControllerID") as UIViewController
        return moreTabVC
    }()
    
    lazy var accountVisit : UIViewController? = {
        let accountStoryboard: UIStoryboard = UIStoryboard(name: "AccountVisit", bundle: nil)
        let accountVisitListVC = accountStoryboard.instantiateViewController(withIdentifier: "AccountVisitListViewController") as UIViewController
        return accountVisitListVC
    }()
    
    
    
    var reachability = Reachability()!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // set up persistent menu
        setUpMenuBar()
        // select the home tab after login
        topMenuBar?.selectedSegment = 0
        // show the relevant tab
        displayCurrentTab(0)
        
        reachability.whenReachable = { reachability in
            if reachability.connection == .wifi {
                print("Reachable via WiFi")
            } else {
                print("Reachable via Cellular")
            }
            self.wifiIconButton?.image = UIImage(named: "Online")
        }
        
        reachability.whenUnreachable = { _ in
            print("Not reachable")
            self.wifiIconButton?.image = UIImage(named: "Offline")
        }
        
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
        NotificationCenter.default.addObserver(self, selector: #selector(self.showAllContacts), name: NSNotification.Name("showAllContacts"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func showAllContacts(notification: NSNotification){
        ContactsGlobal.accountId = notification.object as! String
        print(notification.object)
        topMenuBar?.selectedSegment = 2
        displayCurrentTab(2)
        
    }
    
    // # MARK: setUpMenuBar
    private func setUpMenuBar()
    {
        // color change
        navigationController?.navigationBar.barTintColor = UIColor.white
        // right side buttons
        wifiIconButton = UIBarButtonItem(image: UIImage(named: "Online"), style:UIBarButtonItemStyle.plain, target: nil, action: nil)
        wifiIconButton?.isEnabled = false
        //let numberButton = UIBarButtonItem(image: UIImage(named: "blueCircle-Small"), style:UIBarButtonItemStyle.plain, target: nil, action: nil)
        
        //Used to setup notification label and Logo
        self.setupTopMenuIcons()
        
        //Used to show the Persistant Menu items
        self.setupTopMenuItems()
        
    }
    
    
    private func setupTopMenuIcons(){
        
        let userInitialLabel:UILabel = UILabel(frame: CGRect(x: 3, y:5, width: 35, height: 35))
        userInitialLabel.font  = UIFont.boldSystemFont(ofSize: 13)
        userInitialLabel.text = ""//"DB"
        userInitialLabel.textAlignment = .center
        userInitialLabel.textColor = UIColor.white
        userInitialLabel.backgroundColor = UIColor(named: "Data New")
        userInitialLabel.layer.cornerRadius = 35/2
        userInitialLabel.clipsToBounds = true
        let userInitialLabelButton = UIBarButtonItem.init(customView: userInitialLabel)
        
        // adding TapGesture to userInitialLabel..
        let userInitialLabelTap  = UITapGestureRecognizer(target: self, action:#selector(handleTap))
        userInitialLabel.isUserInteractionEnabled = true
        userInitialLabel.addGestureRecognizer(userInitialLabelTap)
        
        
        self.numberLabel = UILabel(frame: CGRect(x: 30, y:5, width: 20, height: 20))
        self.numberLabel?.font  = UIFont.boldSystemFont(ofSize: 8)
        self.numberLabel?.text = "3"
        self.numberLabel?.textAlignment = .center
        self.numberLabel?.textColor = UIColor.white
        self.numberLabel?.backgroundColor = UIColor(named: "Data New")
        self.numberLabel?.layer.cornerRadius = 20/2
        self.numberLabel?.clipsToBounds = true
        self.notificationButton = UIBarButtonItem.init(customView: self.numberLabel!)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ParentViewController.notificationButtonPressed))
        self.numberLabel?.isUserInteractionEnabled = true
        self.numberLabel?.addGestureRecognizer(tap)
        
        self.navigationItem.rightBarButtonItems = [userInitialLabelButton, self.notificationButton!, wifiIconButton!]
        
        // left buttons
        
        // Logo Button with Label....
        //        let logoLabel:UIImageView = UIImageView(frame: CGRect(x: 0, y: 10, width: 10, height: 10))
        //        logoLabel.image = UIImage(named: "logo")
        //        logoLabel.layer.cornerRadius = 10/2
        //        logoLabel.clipsToBounds = true
        //        let logoBarButton = UIBarButtonItem.init(customView: logoLabel)
        
        let logoButton = UIBarButtonItem(image: UIImage(named: "logo"), style:UIBarButtonItemStyle.plain, target: nil, action: nil)
        logoButton.isEnabled = false
        self.navigationItem.leftBarButtonItem = logoButton
        
    }
    
    @objc func handleTap()  {
        print("Tap is identified")
    }
    
    private func setupTopMenuItems(){
        
        // get the menu items from localized strings
        let menuItem1 = NSLocalizedString("Home", comment: "Home")
        let menuItem2 = NSLocalizedString("Accounts", comment: "Accounts")
        let menuItem3 = NSLocalizedString("Contacts", comment: "Contacts")
        let menuItem4 = NSLocalizedString("Calendar", comment: "Calendar")
        let menuItem5 = NSLocalizedString("Objectives", comment: "Objectives")
        //let menuItem6 = NSLocalizedString("More", comment: "More")
        //let menuItem6 = "More   v" // time being 6April
        let menuItem6 = "More ⌵"
        
        let menuTitles = [menuItem1, menuItem2, menuItem3, menuItem4, menuItem5, menuItem6]
        //let menuIcons = [UIImage(), UIImage(), UIImage(), UIImage(),UIImage(), UIImage(named: "moreArrow")!]
        
        let frame = CGRect(x: 0, y: 114, width: self.view.frame.width/1.5, height: 44)
        
        //topMenuBar = XMSegmentedControl(frame: frame, segmentContent: (menuTitles, menuIcons), selectedItemHighlightStyle: XMSelectedItemHighlightStyle.bottomEdge)
        topMenuBar = XMSegmentedControl(frame: frame, segmentTitle: menuTitles, selectedItemHighlightStyle: XMSelectedItemHighlightStyle.bottomEdge) // 6 April
        topMenuBar?.font = UIFont(name: "Ubuntu-Medium", size: 17)!
        topMenuBar?.delegate = self
        topMenuBar?.backgroundColor = UIColor.clear
        topMenuBar?.highlightColor = UIColor.black
        topMenuBar?.tint = UIColor.gray
        topMenuBar?.highlightTint = UIColor.black
        
        self.navigationItem.titleView = topMenuBar
    }
    
    // # MARK: -XMSegmentedControlDelegate methods
    func xmSegmentedControl(_ xmSegmentedControl: XMSegmentedControl, selectedSegment: Int)
    {
        //print("Tab tapped" + String(selectedSegment))
        // display other tabs
        displayCurrentTab(selectedSegment)
        
        // more tapped
        if(selectedSegment == GlobalConstants.persistenMenuTabVCIndex.MoreVCIndex.rawValue)
        {
            //show more drop down()
            showMoreDropDown(selectedIndex: selectedSegment)
            filterMenuModel.clearFilterModelData()
        }
    }
    
    // # MARK: show more dropdown
    private func showMoreDropDown(selectedIndex: Int)
    {
        moreDropDown.anchorView = topMenuBar
        // number of menus in persisten menubar
        //let numberOfMenuTabsInPersistentMenu = 5
        moreDropDown.bottomOffset = CGPoint(x: ((topMenuBar?.frame.size.width)!-((topMenuBar?.frame.size.width)!/6.0)), y:(moreDropDown.anchorView?.plainView.bounds.height)!)
        moreDropDown.backgroundColor = UIColor.white
        // get the dropdown items from localized strings
        let dropDownItem1 = NSLocalizedString("  Action Items", comment: "Action Items")
        let dropDownItem2 = NSLocalizedString("  Account Visits", comment: "Account Visits")
        let dropDownItem3 = NSLocalizedString("  Insights", comment: "Insights")
        let dropDownItem4 = NSLocalizedString("  Reports", comment: "Reports")
        let dropDownItem5 = NSLocalizedString("  Notifications", comment: "Notifications")
        let dropDownItem6 = NSLocalizedString("  Chatter", comment: "Chatter")
        let dropDownItem7 = NSLocalizedString("  Transactions (Topaz)", comment: "Transactions (Topaz)")
        let dropDownItem8 = NSLocalizedString("  Load Deposit (IDD)", comment: "Load Deposit (IDD)")
        let dropDownItem9 = NSLocalizedString("  GoSpotCheck", comment: "GoSpotCheck")
        // set the data source for the dropdown
        moreDropDown.dataSource = [dropDownItem1, dropDownItem2, dropDownItem3, dropDownItem4, dropDownItem5, dropDownItem6, dropDownItem7, dropDownItem8, dropDownItem9]
        self.moreDropDown.textFont = UIFont(name: "Ubuntu", size: 13)!
        self.moreDropDown.textColor =  UIColor.gray
        
        self.selectedDropDownOption(selectedIndex : selectedIndex)
    }
    
    private func selectedDropDownOption(selectedIndex : Int){
        moreDropDown.selectionAction = { (index: Int, item: String) in
            
            let moreVC1:MoreViewController = self.moreVC as! MoreViewController
            let currentViewController = self.displayCurrentTab(selectedIndex)
            
            self.removeSubviews()
            
            currentViewController?.view.addSubview(moreVC1.view)
            
            SelectedMoreButton.selectedItem = index
            //  self.moreDropDown.selectionBackgroundColor = UIColor.gray
            switch index {
            case 0:
                self.instantiateViewController(identifier: "ActionItemsViewControllerID", moreOptionVC: moreVC1, index: index)
                
            case 1:
                moreVC1.view.addSubview((self.accountVisit?.view)!)
                self.moreDropDownSelectionIndex = index
            case 2:
                self.instantiateViewController(identifier: "InsightsViewControllerID", moreOptionVC: moreVC1, index: index)
                
            case 3:
                self.instantiateViewController(identifier: "AccountVisitsControllerID", moreOptionVC: moreVC1, index: index)
                
            case 4:
                self.instantiateViewController(identifier: "NotificationsControllerID", moreOptionVC: moreVC1, index: index)
                //notificationsVC.view.frame.origin.y = -63.5
                
            case 5:
                self.instantiateViewController(identifier: "ChatterViewControllerID", moreOptionVC: moreVC1, index: index)
                
            case 6:
                self.instantiateViewController(identifier: "TopazViewControllerID", moreOptionVC: moreVC1, index: index)
                
            case 7:
                self.instantiateViewController(identifier: "IDDViewControllerID", moreOptionVC: moreVC1, index: index)
                
            case 8:
                self.instantiateViewController(identifier: "GoSpotViewControllerID", moreOptionVC: moreVC1, index: index)
                
            default:
                break
            }
        }
        // display the dropdown
        moreDropDown.show()
        
        self.dropDownSelectedRow()
    }
    
    private func dropDownSelectedRow(){
        
        // Dictionary to maitian the last selection
        if(self.moreDropDownSelectionIndex != -1){
            if let selection = moreDropDownSelectionIndex{
                moreDropDown.selectRow(selection)
            }
        }
    }
    
    private func removeSubviews(){
        
        for view in self.view.subviews{
            
            // Set the identifier for globalNotification view
            if(view.restorationIdentifier == "globalNotification"){
                view.removeFromSuperview()
            }
        }
    }
    
    private func instantiateViewController(identifier : String , moreOptionVC : MoreViewController, index : Int){
        let loadController = moreMenuStoryboard.instantiateViewController(withIdentifier: identifier)
        moreOptionVC.view.addSubview((loadController.view)!)
        self.moreDropDownSelectionIndex = index
    }
    
    // # MARK: displayCurrentTab
    private func displayCurrentTab(_ tabIndex: Int) -> UIViewController?{
        
        if let vc = viewControllerForSelectedSegmentIndex(tabIndex) {
            
            self.addChildViewController(vc)
            vc.didMove(toParentViewController: self)
            
            vc.view.frame = self.contentView.bounds
            self.contentView.addSubview(vc.view)
            self.currentViewController = vc
        }
        return currentViewController
    }
    
    
    private func clearAccountFilterModel(){
        //account list view
        if(previouslySelectedVCIndex == 1) {
            // clear filter, reset data, hide keyboard
            print("previous is account list")
            let accVC = accountsVC as? AccountsViewController
            accVC?.filterMenuVC?.resetEnteredDataAndAccountList()
        }
    }
    
    private func clearContactsFilterModel(){
        if(previouslySelectedVCIndex == 2)// contact list view
        {
            // clear filter, reset data, hide keyboard
            print("previous is contact list")
            let conVC = contactsVC as? ContactsViewController
            conVC?.filterMenuVC?.resetEnteredDataAndContactList()
        }
        
    }
    
    // # MARK: viewControllerForSelectedSegmentIndex
    // get the respective view controller as per the selected index of menu from menubar
    private func viewControllerForSelectedSegmentIndex(_ index: Int) -> UIViewController? {
        
        self.view.endEditing(true)
        
        if index != 1{
            filterMenuModel.clearFilterModelData()
        }
        
        if index != 2{
            
            let accVC = contactsVC as? ContactsViewController
            accVC?.filterMenuVC?.clearFilterModelData()
        }
        
        self.clearAccountFilterModel()
        
        self.clearContactsFilterModel()
    
        
        self.notificationButton?.isEnabled = true
        self.numberLabel?.isUserInteractionEnabled = true
        
        let selectedVC:GlobalConstants.persistenMenuTabVCIndex = GlobalConstants.persistenMenuTabVCIndex(rawValue: index)!
        
        if(GlobalConstants.persistenMenuTabVCIndex.MoreVCIndex != selectedVC) {
            self.moreDropDownSelectionIndex = -1
        }
        
        ifMoreVC = false
        var vc: UIViewController?
        switch selectedVC {
            
        case .HomeVCIndex:
            vc = homeVC
             ContactsGlobal.accountId = ""
        case .AccountVCIndex:
            let accVC = accountsVC as? AccountsViewController
            accVC?.accountDetails?.view.removeFromSuperview()
            vc = accountsVC
            ContactsGlobal.accountId = ""
        case .ContactsVCIndex:
            let contactVC = contactsVC as! ContactsViewController
            vc = contactVC
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadAllContacts"), object:nil)
        case .CalendarVCIndex:
            vc = calendarVC
             ContactsGlobal.accountId = ""
        case .ObjectivesVCIndex:
            vc = objectivesVC
             ContactsGlobal.accountId = ""
            
            // have to cover all cases from defined enum, else compiler wont be happy :D
            /*default:
             return nil*/
            //       case .MoreVCIndex:
        //            vc = moreVC
        default:
            ifMoreVC = true
            break
        }
        
        previouslySelectedVCIndex = index
        self.removePresentedViewControllers()
        
        return vc
    }
    
    private func removePresentedViewControllers(){
        
        if(!ifMoreVC){
            if let mVC = self.moreVC {
                mVC.view.removeFromSuperview()
            }
        }
        
        if(!ifMoreVC){
            for view in self.view.subviews{
                if(view.restorationIdentifier == "globalNotification"){
                    view.removeFromSuperview()
                }
            }
        }
    }
    
    @objc func notificationButtonPressed(sender: UIBarButtonItem){
        
        self.moreDropDownSelectionIndex = -1
        let moreStoryboard = UIStoryboard.init(name: "MoreMenu", bundle: nil)
        notificationsViewController = moreStoryboard.instantiateViewController(withIdentifier: "NotificationsControllerID") as UIViewController
        if let notifVC = notificationsViewController{
            self.notificationsView = notifVC.view
            notifVC.view.restorationIdentifier = "globalNotification"
            self.view.endEditing(true)
            self.view.addSubview(notifVC.view)
            self.notificationButton?.isEnabled = false
            self.numberLabel?.isUserInteractionEnabled = false
        }
    }
}

