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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // set up persistent menu
        setUpMenuBar()
        // select the home tab after login
        topMenuBar?.selectedSegment = 0
        // show the relevant tab
        displayCurrentTab(0)
        
        let reachability = Reachability.init()
        
        reachability?.whenReachable = { reachability in
            if reachability.connection == .wifi {
                print("Reachable via WiFi")
            } else {
                print("Reachable via Cellular")
            }
            self.wifiIconButton?.image = UIImage(named: "Online")
            
        }
        reachability?.whenUnreachable = { _ in
            print("Not reachable")
            self.wifiIconButton?.image = UIImage(named: "Offline")
        }
        
        do {
            try reachability?.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
        let userInitialLabel:UILabel = UILabel(frame: CGRect(x: 3, y:5, width: 35, height: 35))
        userInitialLabel.font  = UIFont.boldSystemFont(ofSize: 13)
        userInitialLabel.text = ""//"DB"
        userInitialLabel.textAlignment = .center
        userInitialLabel.textColor = UIColor.white
        userInitialLabel.backgroundColor = UIColor(named: "Data New")
        userInitialLabel.layer.cornerRadius = 35/2
        userInitialLabel.clipsToBounds = true
        let userInitialLabelButton = UIBarButtonItem.init(customView: userInitialLabel)
        
        
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
        
        
        // get the menu items from localized strings
        let menuItem1 = NSLocalizedString("Home", comment: "Home")
        let menuItem2 = NSLocalizedString("Accounts", comment: "Accounts")
        let menuItem3 = NSLocalizedString("Contacts", comment: "Contacts")
        let menuItem4 = NSLocalizedString("Calendar", comment: "Calendar")
        let menuItem5 = NSLocalizedString("Objectives", comment: "Objectives")
        //let menuItem6 = NSLocalizedString("More", comment: "More")
        //let menuItem6 = "More   v" // time being 6April
        let menuItem6 = "More ..."
        
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
        
        moreDropDown.selectionAction = { (index: Int, item: String) in
            let moreVC1:MoreViewController = self.moreVC as! MoreViewController
            let moreMenuStoryboard = UIStoryboard.init(name: "MoreMenu", bundle: nil)
            let currentViewController = self.displayCurrentTab(selectedIndex)
            
            for view in self.view.subviews{
                
                // Set the identifier for globalNotification view
                if(view.restorationIdentifier == "globalNotification"){
                    view.removeFromSuperview()
                }
            }
            currentViewController?.view.addSubview(moreVC1.view)
            
            SelectedMoreButton.selectedItem = index
            //  self.moreDropDown.selectionBackgroundColor = UIColor.gray
            switch index {
            case 0:
                let actionItemsVC = moreMenuStoryboard.instantiateViewController(withIdentifier: "ActionItemsViewControllerID")
                moreVC1.view.addSubview((actionItemsVC.view)!)
               
                self.moreDropDownSelectionIndex = index
            case 1:
                let accountVisitsVC = moreMenuStoryboard.instantiateViewController(withIdentifier: "AccountVisitsControllerID")
                moreVC1.view.addSubview((accountVisitsVC.view)!)
                self.moreDropDownSelectionIndex = index
            case 2:
                let insightsVC = moreMenuStoryboard.instantiateViewController(withIdentifier: "InsightsViewControllerID")
                moreVC1.view.addSubview((insightsVC.view)!)
                self.moreDropDownSelectionIndex = index
            case 3:
                let reportsVC = moreMenuStoryboard.instantiateViewController(withIdentifier: "ReportsViewControllerID")
                moreVC1.view.addSubview((reportsVC.view)!)
                self.moreDropDownSelectionIndex = index
            case 4:
                let notificationsVC = moreMenuStoryboard.instantiateViewController(withIdentifier: "NotificationsControllerID")
                moreVC1.view.addSubview((notificationsVC.view)!)
                notificationsVC.view.frame.origin.y = -63.5
                self.moreDropDownSelectionIndex = index
            case 5:
                let chatterVC = moreMenuStoryboard.instantiateViewController(withIdentifier: "ChatterViewControllerID")
                moreVC1.view.addSubview((chatterVC.view)!)
                self.moreDropDownSelectionIndex = index
            case 6:
                let topazVC = moreMenuStoryboard.instantiateViewController(withIdentifier: "TopazViewControllerID")
                moreVC1.view.addSubview((topazVC.view)!)
                self.moreDropDownSelectionIndex = index
            case 7:
                let loadDepositVC = moreMenuStoryboard.instantiateViewController(withIdentifier: "IDDViewControllerID")
                moreVC1.view.addSubview((loadDepositVC.view)!)
                self.moreDropDownSelectionIndex = index
            case 8:
                let goSpotCheckVC = moreMenuStoryboard.instantiateViewController(withIdentifier: "GoSpotViewControllerID")
                moreVC1.view.addSubview((goSpotCheckVC.view)!)
                self.moreDropDownSelectionIndex = index
            default:
                break
                
                
            }
            
            //just print for now
            //            print("Selected item: \(item) at index: \(index)")
            //            let moreVC1:MoreViewController = self.moreVC as! MoreViewController
            //            moreVC1.moreLabel.text = item
            
        }
        // display the dropdown
        moreDropDown.show()
        
        // Dictionary to maitian the last selection
        if(self.moreDropDownSelectionIndex != -1){
            if let selection = moreDropDownSelectionIndex{
                moreDropDown.selectRow(selection)
            }
        }
        
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
    
    // # MARK: viewControllerForSelectedSegmentIndex
    // get the respective view controller as per the selected index of menu from menubar
    private func viewControllerForSelectedSegmentIndex(_ index: Int) -> UIViewController? {
        
        self.view.endEditing(true)
        
        filterMenuModel.clearFilterModelData()
        
        if(previouslySelectedVCIndex == 1)// account list view
        {
            // clear filter, reset data, hide keyboard
            print("previous is account list")
            let accVC = accountsVC as? AccountsViewController
            accVC?.filterMenuVC?.resetEnteredDataAndAccountList()
        }
        
        self.notificationButton?.isEnabled = true
        self.numberLabel?.isUserInteractionEnabled = true
        
        var ifMoreVC = false
        let selectedVC:GlobalConstants.persistenMenuTabVCIndex = GlobalConstants.persistenMenuTabVCIndex(rawValue: index)!
        
        if(GlobalConstants.persistenMenuTabVCIndex.MoreVCIndex != selectedVC) {
            self.moreDropDownSelectionIndex = -1
        }
        
        var vc: UIViewController?
        switch selectedVC {
            
        case .HomeVCIndex:
            vc = homeVC
        case .AccountVCIndex:
            let accVC = accountsVC as? AccountsViewController
            accVC?.accountDetails?.view.removeFromSuperview()
            
            vc = accountsVC
        case .ContactsVCIndex:
            vc = contactsVC
        case .CalendarVCIndex:
            vc = calendarVC
        case .ObjectivesVCIndex:
            vc = objectivesVC
            
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
        return vc
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

