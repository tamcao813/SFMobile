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
    
    let dropDown = DropDown()
    var topMenuBar:XMSegmentedControl? = nil
    // keep the views loaded
    @IBOutlet weak var contentView: UIView!
    // current view C
    var currentViewController: UIViewController?
    //home
    lazy var homeVC: UIViewController? = {
        let homeTabVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewControllerID")
        return homeTabVC
    }()
    // accounts
    lazy var accountsVC : UIViewController? = {
        let accountsTabVC = self.storyboard?.instantiateViewController(withIdentifier: "AccountsViewControllerID")
        return accountsTabVC
    }()
    // contacts
    lazy var contactsVC : UIViewController? = {
        let contactsTabVC = self.storyboard?.instantiateViewController(withIdentifier: "ContactsViewControllerID")
        return contactsTabVC
    }()
    // calendar
    lazy var calendarVC : UIViewController? = {
        let calendarTabVC = self.storyboard?.instantiateViewController(withIdentifier: "CalendarViewControllerID")
        return calendarTabVC
    }()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setUpNavigationBar()
        // select the home tab after login
        topMenuBar?.selectedSegment = 0
        // show the relevant tab
        displayCurrentTab(0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setUpNavigationBar()
    {
        // right side buttons
        let wifiIconButton = UIBarButtonItem(image: UIImage(named: "wifiImage"), style:UIBarButtonItemStyle.plain, target: nil, action: nil)
        wifiIconButton.isEnabled = false
        
        let numberButton = UIBarButtonItem(image: UIImage(named: "blueCircle-Small"), style:UIBarButtonItemStyle.plain, target: nil, action: nil)
        
        //let dbButton = UIBarButtonItem(image: UIImage(named: "blueCircle"), style:UIBarButtonItemStyle.plain, target: nil, action: nil)
        
        self.navigationItem.rightBarButtonItems = [numberButton, wifiIconButton]
        
        // left buttons
        let fpoButton = UIBarButtonItem(image: UIImage(named: "redCircle"), style:UIBarButtonItemStyle.plain, target: nil, action: nil)
        
        //let logoButton = UIBarButtonItem(title: "Logo", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        self.navigationItem.leftBarButtonItems = [fpoButton]
        //TODO: SHILPA Use Global Let or Enum and use it insted of consatant.
        let titles8 = ["Home", "Accounts", "Contacts", "Calendar", "More"]
        let icons = [UIImage(), UIImage(), UIImage(), UIImage(), UIImage(named: "moreArrow")!]
        
        let frame = CGRect(x: 0, y: 114, width: self.view.frame.width/1.5, height: 44)
        
        topMenuBar = XMSegmentedControl(frame: frame, segmentContent: (titles8, icons), selectedItemHighlightStyle: XMSelectedItemHighlightStyle.bottomEdge)
        topMenuBar?.delegate = self
        topMenuBar?.backgroundColor = UIColor.clear
        topMenuBar?.highlightColor = UIColor.black
        topMenuBar?.tint = UIColor.gray
        topMenuBar?.highlightTint = UIColor.black
        
        self.navigationItem.titleView = topMenuBar
    }
    //TODO: SHILPA Use Global Let or Enum and use it insted of consatant.
    // XMSegmentedControlDelegate methods
    func xmSegmentedControl(_ xmSegmentedControl: XMSegmentedControl, selectedSegment: Int)
    {
        //print("Tab tapped" + String(selectedSegment))
        // more tapped
        if(selectedSegment == 4)
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
    //TODO: SHILPA Move all the Lables and Constant in Common file so it can be reused.
    // show dropdown
    private func showMoreDropDown()
    {
        dropDown.anchorView = topMenuBar
        dropDown.bottomOffset = CGPoint(x: ((topMenuBar?.frame.size.width)!*3.2/4.0), y:(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.dataSource = ["Objectives", "Account Visits", "Insights", "Reports", "Chatter", "Transactions (Topaz)", "Load Deposit (IDD)", "GoSpotCheck"]
        // just print for now
        dropDown.selectionAction = { (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
        }
        
        dropDown.show()
    }
    
    private func displayCurrentTab(_ tabIndex: Int){
        if let vc = viewControllerForSelectedSegmentIndex(tabIndex) {
            
            self.addChildViewController(vc)
            vc.didMove(toParentViewController: self)
            
            vc.view.frame = self.contentView.bounds
            self.contentView.addSubview(vc.view)
            self.currentViewController = vc
        }
    }
    //TODO: SHILPA Use Global Let or Enum and use it insted of consatant.
    private func viewControllerForSelectedSegmentIndex(_ index: Int) -> UIViewController? {
        var vc: UIViewController?
        switch index {
        case 0 :
            vc = homeVC
        case 1 :
            vc = accountsVC
        case 2 :
            vc = contactsVC
        case 3:
            vc = calendarVC
        default:
            return nil
        }
        
        return vc
    }
    
    
}
