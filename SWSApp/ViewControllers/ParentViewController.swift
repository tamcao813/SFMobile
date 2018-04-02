//
//  ParentViewController.swift
//  SWSApp
//
//  Created by shilpa.a.kulkarni on 26/03/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit
import DropDown

class ParentViewController: UIViewController, XMSegmentedControlDelegate {
    // drop down on tapping more
    let moreDropDown = DropDown()
    // persistent menu
    var topMenuBar:XMSegmentedControl? = nil
    @IBOutlet weak var contentView: UIView!
    // current view controller
    var currentViewController: UIViewController?
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
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // set up persistent menu
        setUpMenuBar()
        // select the home tab after login
        topMenuBar?.selectedSegment = 0
        // show the relevant tab
        displayCurrentTab(0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // # MARK: setUpMenuBar
    private func setUpMenuBar()
    {
        // right side buttons
        let wifiIconButton = UIBarButtonItem(image: UIImage(named: "wifiImage"), style:UIBarButtonItemStyle.plain, target: nil, action: nil)
        wifiIconButton.isEnabled = false
        
        let numberButton = UIBarButtonItem(image: UIImage(named: "blueCircle-Small"), style:UIBarButtonItemStyle.plain, target: nil, action: nil)
        
        self.navigationItem.rightBarButtonItems = [numberButton, wifiIconButton]
        
        // left buttons
        let fpoButton = UIBarButtonItem(image: UIImage(named: "redCircle"), style:UIBarButtonItemStyle.plain, target: nil, action: nil)
        
        self.navigationItem.leftBarButtonItems = [fpoButton]
        // get the menu items from localized strings
        let menuItem1 = NSLocalizedString("Home", comment: "Home")
        let menuItem2 = NSLocalizedString("Accounts", comment: "Accounts")
        let menuItem3 = NSLocalizedString("Contacts", comment: "Contacts")
        let menuItem4 = NSLocalizedString("Calendar", comment: "Calendar")
        let menuItem5 = NSLocalizedString("More", comment: "More")
        
        let menuTitles = [menuItem1, menuItem2, menuItem3, menuItem4, menuItem5]
        let menuIcons = [UIImage(), UIImage(), UIImage(), UIImage(), UIImage(named: "moreArrow")!]
        
        let frame = CGRect(x: 0, y: 114, width: self.view.frame.width/1.5, height: 44)
        
        topMenuBar = XMSegmentedControl(frame: frame, segmentContent: (menuTitles, menuIcons), selectedItemHighlightStyle: XMSelectedItemHighlightStyle.bottomEdge)
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
        // more tapped
        if(selectedSegment == GlobalConstants.persistenMenuTabVCIndex.MoreVCIndex.rawValue)
        {
            //show more drop down()
            showMoreDropDown()
        }
        else
        {
            // display other tabs
            displayCurrentTab(selectedSegment)
        }
    }
    
    // # MARK: show more dropdown
    private func showMoreDropDown()
    {
        moreDropDown.anchorView = topMenuBar
        // number of menus in persisten menubar
        //let numberOfMenuTabsInPersistentMenu = 5
        moreDropDown.bottomOffset = CGPoint(x: ((topMenuBar?.frame.size.width)!-((topMenuBar?.frame.size.width)!/5)), y:(moreDropDown.anchorView?.plainView.bounds.height)!)
        // get the dropdown items from localized strings
        let dropDownItem1 = NSLocalizedString("Objectives", comment: "Objectives")
        let dropDownItem2 = NSLocalizedString("Account Visits", comment: "Account Visits")
        let dropDownItem3 = NSLocalizedString("Insights", comment: "Insights")
        let dropDownItem4 = NSLocalizedString("Reports", comment: "Reports")
        let dropDownItem5 = NSLocalizedString("Chatter", comment: "Chatter")
        let dropDownItem6 = NSLocalizedString("Transactions (Topaz)", comment: "Transactions (Topaz)")
        let dropDownItem7 = NSLocalizedString("Load Deposit (IDD)", comment: "Load Deposit (IDD)")
        let dropDownItem8 = NSLocalizedString("GoSpotCheck", comment: "GoSpotCheck")
        // set the data source for the dropdown
        moreDropDown.dataSource = [dropDownItem1, dropDownItem2, dropDownItem3, dropDownItem4, dropDownItem5, dropDownItem6, dropDownItem7, dropDownItem8]
        // just print for now
        moreDropDown.selectionAction = { (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
        }
        // display the dropdown
        moreDropDown.show()
    }
    
    // # MARK: displayCurrentTab
    private func displayCurrentTab(_ tabIndex: Int){
        if let vc = viewControllerForSelectedSegmentIndex(tabIndex) {
            
            self.addChildViewController(vc)
            vc.didMove(toParentViewController: self)
            
            vc.view.frame = self.contentView.bounds
            self.contentView.addSubview(vc.view)
            self.currentViewController = vc
        }
    }
    
    // # MARK: viewControllerForSelectedSegmentIndex
    // get the respective view controller as per the selected index of menu from menubar
    private func viewControllerForSelectedSegmentIndex(_ index: Int) -> UIViewController? {
        let selectedVC:GlobalConstants.persistenMenuTabVCIndex = GlobalConstants.persistenMenuTabVCIndex(rawValue: index)!
        var vc: UIViewController?
        switch selectedVC {
        case .HomeVCIndex:
            vc = homeVC
        case .AccountVCIndex:
            vc = accountsVC
        case .ContactsVCIndex:
            vc = contactsVC
        case .CalendarVCIndex:
            vc = calendarVC
        
        // have to cover all cases from defined enum, else compiler wont be happy :D
        /*default:
            return nil*/
        case .MoreVCIndex:
            return nil // for now 30/03/18
        }
        
        return vc
    }
    
    
}
