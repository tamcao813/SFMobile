//
//  ParentViewController.swift
//  SWSApp
//
//  Created by shilpa.a.kulkarni on 26/03/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit
import Reachability
import CoreLocation
import SmartStore

struct SelectedMoreButton {
    static var selectedItem : Int = -1
    static var isBlackLineActive:Bool = false
}

struct ContactsGlobal {
    static var accountId: String = ""
}

struct SyncUpDailogGlobal {
    static var isSyncing    = false
    static var syncType     = "automtic"
    static var isSyncError      = false
    static var isSyncWarning    = false
}

struct ActionItemsGlobal {
    static var accountId: String = ""
}

protocol ParentViewControllerDelegate {
    func reloadOpportunityDataFromDB()
}
class ParentViewController: UIViewController, XMSegmentedControlDelegate,SFSafariViewControllerDelegate {
    
    //autoSync automtic/manual and Status of network wifi/cell
    var status:String = ""
    
    var networkType:String = ""
    // drop down on tapping more
    let moreDropDown = DropDown()
    // persistent menu
    var topMenuBar:XMSegmentedControl? = nil
    var onlineSyncStatus:UIBarButtonItem? = nil
    var userInitialLabel:UILabel? = nil
    var onlineStatusView = UIView()
    var statusLabel = UILabel()
    
    var moreDropDownSelectionIndex:Int?=0
    
    var notificationButton:UIBarButtonItem? = nil
    var unreadNotificationCountLabel = UILabel()
    static var delegate:ParentViewControllerDelegate?
    @IBOutlet weak var contentView: UIView!
    // current view controller
    var currentViewController: UIViewController?
    var notificationsViewController:UIViewController?
    
    var notificationsView:UIView?
    
    lazy var filterMenuModel = AccountsMenuViewController()
    
    //
    var previouslySelectedVCIndex = 0
    
    var ifMoreVC = false
    var isVisitSynDownComplete = false
    var isAccountSyncDownComplete =  false
    let contact = Contact.init(for: "loggedInUser")
    
    let moreMenuStoryboard = UIStoryboard.init(name: "MoreMenu", bundle: nil)
    
    let defaults:UserDefaults = UserDefaults.standard
    var syncProgress:Float = 0
    var syncViewControllerSyncBtn:UIButton?
    let opportunityViewModel = OpportunityViewModel()
    //Sync Object Count - To be updated if more objects added here
    let syncObjectCount:Int = 10
    
    
    var isPresentingNotificationVc = false
    
    // keep the views loaded
    //home VC
    lazy var homeVC: UIViewController? = {
        let homeStoryboard = UIStoryboard.init(name: "Home", bundle: nil)
        let homeTabVC = homeStoryboard.instantiateViewController(withIdentifier: "HomeViewControllerID")
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
    lazy var objectivesVC : ObjectivesViewController? = {
        let objectivesTabVC = self.storyboard?.instantiateViewController(withIdentifier: "ObjectivesControllerID") as? ObjectivesViewController
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
        let accountVisitListVC = accountStoryboard.instantiateViewController(withIdentifier: "AccountVisitEmbedViewController") as UIViewController
        return accountVisitListVC
    }()
    
    lazy var actionItemParent : ActionItemsContainerViewController? = {
        let actionItemStoryboard: UIStoryboard = UIStoryboard(name: "ActionItem", bundle: nil)
        let actionItemParentVC = actionItemStoryboard.instantiateViewController(withIdentifier: "ActionItemsContainerViewController") as! ActionItemsContainerViewController
        return actionItemParentVC
    }()
    
    lazy var syncUpInfoVC : SyncInfoViewController? = {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let syncUpVC = mainStoryboard.instantiateViewController(withIdentifier: "SyncInfoViewController") as! SyncInfoViewController
        return syncUpVC
    }()
    
    lazy var notificationParent : NotificationParentViewController? = {
        let notificationStoryboard: UIStoryboard = UIStoryboard(name: "Notification", bundle: nil)
        let notificationParentVC = notificationStoryboard.instantiateViewController(withIdentifier: "NotificationParentViewController") as! NotificationParentViewController
        return notificationParentVC
    }()
    
    lazy var insightsViewController : UIViewController? = {
        let insightsVC = moreMenuStoryboard.instantiateViewController(withIdentifier: "InsightsViewControllerID") as UIViewController
        return insightsVC
    }()
    
    lazy var chatterViewController : UIViewController? = {
        let chatterVC = moreMenuStoryboard.instantiateViewController(withIdentifier: "ChatterViewControllerID") as UIViewController
        return chatterVC
    }()
    
    lazy var gospotcheckViewController : UIViewController? = {
        let gospotcheckVC = moreMenuStoryboard.instantiateViewController(withIdentifier: "GoSpotViewControllerID") as UIViewController
        return gospotcheckVC
    }()
    
    lazy var reportsViewController : UIViewController? = {
        let reportsVC = moreMenuStoryboard.instantiateViewController(withIdentifier: "ReportsViewControllerID") as UIViewController
        return reportsVC
    }()
    
    var reachability = Reachability()!
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.startUpdatingLocationAlerts()
        
        // Do any additional setup after loading the view, typically from a nib.
        // set up persistent menu
        setUpMenuBar()
        // select the home tab after login
        topMenuBar?.selectedSegment = 0
        // show the relevant tab
        _ = displayCurrentTab(0)
        
        reachability.whenReachable = { reachability in
            self.statusLabel.text = "Online"
            self.onlineStatusView.backgroundColor = UIColor(named: "Good")
            DispatchQueue.main.async {
                self.syncViewControllerSyncBtn?.isEnabled = true
                self.syncUpInfoVC?.hideSyncButton(hide: false)
            }
        }
        
        reachability.whenUnreachable = { _ in
            MBProgressHUD.hide(forWindow: true)
            self.onlineStatusView.backgroundColor = UIColor.lightGray
            self.statusLabel.text = "Offline"
            self.userInitialLabel?.isUserInteractionEnabled = false
            DispatchQueue.main.async {
                self.syncViewControllerSyncBtn?.isEnabled = false
                self.syncUpInfoVC?.hideSyncButton(hide: true)
            }
        }
        
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
        //Delegate notification from during visit
        NotificationCenter.default.addObserver(self, selector: #selector(self.showActionItems), name: NSNotification.Name("showActionItems"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.showAllAccounts), name: NSNotification.Name("showAllAccounts"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.showAllContacts), name: NSNotification.Name("showAllContacts"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.loadMoreScreens), name: NSNotification.Name("loadMoreScreens"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.showCalendar), name: NSNotification.Name(rawValue: "SwitchToCalendar"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.showContact), name: NSNotification.Name(rawValue: "SwitchToContact"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.showActionItemOrNotification), name: NSNotification.Name(rawValue: "goToAllActionItem/Notification"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.showInsightBob(notification:)), name: NSNotification.Name(rawValue: "goTOInsightBob/Notification"), object: nil)
        
        
        //NotificationCenter.default.addObserver(self, selector: #selector(self.showAllAccounts), name: NSNotification.Name("showAllAccounts"), object: nil)
        
        let accountVc = accountsVC as! AccountsViewController
        self.addChildViewController(accountVc)
        accountVc.view.frame = self.contentView.bounds
        
        let contactVc = contactsVC as! ContactsViewController
        self.addChildViewController(contactVc)
        contactVc.view.frame = self.contentView.bounds
        //Initial delay for 1 min so that there is no conflict
        DispatchQueue.main.asyncAfter(deadline: .now() + 60) {
            var autoSyncTimer: Timer!   //Set timer to 30min sync
            autoSyncTimer = Timer.scheduledTimer(timeInterval: 60*30, target: self, selector: #selector(self.automticResync), userInfo: nil, repeats: true)
        }
    }
    
    
    
    func startUpdatingLocationAlerts() {
        // 1. status is not determined
        if CLLocationManager.authorizationStatus() == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        }
            // 2. authorization were denied
        else if CLLocationManager.authorizationStatus() == .denied {
            print("Location services were previously denied. Please enable location services for this app in Settings.")
        }
            // 3. we do have authorization
        else if CLLocationManager.authorizationStatus() == .authorizedAlways {
            print("Authorized always")
            
        }
        
    }
    @objc func automticResync()
    {
        let state: UIApplicationState = UIApplication.shared.applicationState
        if state == .active {
            print("$$$$$$$$$$$$$$$$$$$$ Autosync called")
            if !SyncUpDailogGlobal.isSyncing {
                self.startSyncUp()
                SyncUpDailogGlobal.isSyncing = true
                SyncUpDailogGlobal.syncType = "Automatic"
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func showAllAccounts(notification: NSNotification){
        topMenuBar?.selectedSegment = 1
        _ = displayCurrentTab(1)
        
        ScreenLoadFromParent.loadedFromParent = "YES"
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "loadDetailsScreen"), object:nil)
    }
    
    @objc func showAllContacts(notification: NSNotification){
        if notification.object != nil{
            ContactsGlobal.accountId = notification.object as! String
        }
        topMenuBar?.selectedSegment = 2
        _ = displayCurrentTab(2)
        
    }
    
    @objc func loadMoreScreens(notification: NSNotification) {
        
        let data : Int = notification.object.unsafelyUnwrapped as! Int
        
        if  data == LoadThePersistantMenuScreen.notifications.rawValue {
            isPresentingNotificationVc = true
            topMenuBar?.selectedSegment = 5
            self.navigateToMoreOptionsViewControllers(index: 4, selectedIndex: 4)
            
        }else{
            
            isPresentingNotificationVc = false
            let moreVC1:MoreViewController = self.moreVC as! MoreViewController
            let currentViewController = self.displayCurrentTab(data)
            self.removeSubviews()
            currentViewController?.view.addSubview(moreVC1.view)
            
            if data == LoadThePersistantMenuScreen.chatter.rawValue {
                self.instantiateViewController(identifier: "ChatterViewControllerID", moreOptionVC: moreVC1, index: 5)
                
            }else if data == LoadThePersistantMenuScreen.actionItems.rawValue {
                self.instantiateViewController(identifier: "ActionItemsViewControllerID", moreOptionVC: moreVC1, index: 0)
                
            }
        }
    }
    
    @objc func showCalendar(notification: NSNotification){
        
        defaults.set(false, forKey: "FromHomeVC")
        topMenuBar?.selectedSegment = 3
        _ = displayCurrentTab(3)
        
    }
    
    @objc func showContact(notification: NSNotification){
        
        topMenuBar?.selectedSegment = 2
        _ = displayCurrentTab(2)
        
        if let contact = notification.userInfo?["contact"] as? Contact {
            
            let contactDict:[String: Contact] = ["contact": contact]
            // do something with your image
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SelectedContact"), object:nil, userInfo: contactDict)
        }
    }
    
    @objc func showInsightBob(notification: NSNotification){
        //        topMenuBar?.selectedSegment = 5
        //        self.navigateToMoreOptionsViewControllers(index: 2, selectedIndex: 2)
        openSFSafariVC()
    }
    
    @objc func showActionItemOrNotification(notification: NSNotification){
        isPresentingNotificationVc = true
        let data : Int = notification.object.unsafelyUnwrapped as! Int
        let moreVC1:MoreViewController = self.moreVC as! MoreViewController
        let currentViewController = self.displayCurrentTab(data)
        self.removeSubviews()
        currentViewController?.view.addSubview(moreVC1.view)
        if data == 4 {
            //notificcation
            self.notificationParent?.resetFilters()
            self.notificationParent?.delegate = self
            moreVC1.view.addSubview((self.notificationParent?.view)!)
            self.moreDropDownSelectionIndex = 4
            topMenuBar?.selectedSegment = 5
            
        }
            
        else if data == 0{
            // action Item
            moreVC1.view.addSubview((self.actionItemParent?.view)!)
            ActionItemFilterModel.fromAccount = false
            ActionItemFilterModel.accountId = nil
            self.actionItemParent?.fromPersistentMenu = true
            self.moreDropDownSelectionIndex = 0
            topMenuBar?.selectedSegment = 5
            // self.instantiateViewController(identifier: "ActionItemsContainerViewController", moreOptionVC: moreVC1, index: 0)
            
        }
        
        
    }
    
    @objc func showActionItems(notification: NSNotification){
        if notification.object != nil{
            ActionItemsGlobal.accountId = notification.object as! String
        }
        topMenuBar?.selectedSegment = 5
        //_ = selectedDropDownOption(selectedIndex: 0)
        navigateToMoreOptionsViewControllers(index: 0, selectedIndex: 0)
        
    }
    
    
    // # MARK: setUpMenuBar
    private func setUpMenuBar()
    {
        // color change
        navigationController?.navigationBar.barTintColor = UIColor.white
        // right side buttons
        onlineSyncStatus = UIBarButtonItem(image: UIImage(named: "Online"), style:UIBarButtonItemStyle.plain, target: nil, action: nil)
        onlineSyncStatus?.isEnabled = false
        //let numberButton = UIBarButtonItem(image: UIImage(named: "blueCircle-Small"), style:UIBarButtonItemStyle.plain, target: nil, action: nil)
        
        //Used to setup notification label and Logo
        self.setupTopMenuIcons()
        
        //Used to show the Persistant Menu items
        self.setupTopMenuItems()
        
    }
    
    
    private func setupTopMenuIcons(){
        var loggedInUserInitials = ""
        if let userId = SFUserAccountManager.sharedInstance().currentUser?.fullName{
            loggedInUserInitials = Validations().getIntials(name: userId)
        }
        
        print("Name is ----\(loggedInUserInitials)")
        self.userInitialLabel = UILabel(frame: CGRect(x: 3, y:5, width: 35, height: 35))
        self.userInitialLabel?.font  = UIFont(name: "Ubuntu-Medium", size: 14)
        self.userInitialLabel?.text = loggedInUserInitials
        self.userInitialLabel?.textAlignment = .center
        self.userInitialLabel?.textColor = UIColor.white
        self.userInitialLabel?.backgroundColor = UIColor(named: "InitialsBackground")
        self.userInitialLabel?.layer.cornerRadius = 35/2
        self.userInitialLabel?.clipsToBounds = true
        let userInitialLabelButton = UIBarButtonItem.init(customView: userInitialLabel!)
        
        // adding TapGesture to userInitialLabel..
        //        let userInitialLabelTap  = UITapGestureRecognizer(target: self, action:#selector(SyncUpData))
        //        self.userInitialLabel?.isUserInteractionEnabled = true
        //        self.userInitialLabel?.addGestureRecognizer(userInitialLabelTap)
        
        
        self.unreadNotificationCountLabel = UILabel(frame: CGRect(x: 30, y:5, width: 20, height: 20))
        self.unreadNotificationCountLabel.font  = UIFont.boldSystemFont(ofSize: 8)
        self.unreadNotificationCountLabel.textAlignment = .center
        self.unreadNotificationCountLabel.textColor = UIColor.white
        self.unreadNotificationCountLabel.backgroundColor = UIColor(named: "Data New")
        self.unreadNotificationCountLabel.layer.cornerRadius = 10
        self.unreadNotificationCountLabel.clipsToBounds = true
        getUnreadNotificationsCount()
        self.notificationButton = UIBarButtonItem.init(customView: self.unreadNotificationCountLabel)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ParentViewController.notificationButtonPressed))
        self.unreadNotificationCountLabel.isUserInteractionEnabled = true
        self.unreadNotificationCountLabel.addGestureRecognizer(tap)
        
        onlineStatusView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
        onlineStatusView.backgroundColor = UIColor(named: "Good")
        
        statusLabel = UILabel(frame: CGRect(x: 15, y: 5, width: 60, height: 20))
        statusLabel.font  = UIFont.boldSystemFont(ofSize: 12)
        statusLabel.text = "Online"
        statusLabel.textColor = UIColor.white
        onlineStatusView.addSubview(statusLabel)
        
        let image = #imageLiteral(resourceName: "refreshBlue").withRenderingMode(.alwaysTemplate)
        let resyncImage = UIImageView(frame: CGRect(x: 70, y: 5, width: 18, height: 18))
        resyncImage.image = image
        resyncImage.tintColor = .white
        resyncImage.contentMode = .scaleAspectFit
        
        onlineStatusView.addSubview(resyncImage)
        self.onlineSyncStatus = UIBarButtonItem.init(customView: onlineStatusView)
        
        
        let tapOnline = UITapGestureRecognizer(target: self, action: #selector(ParentViewController.syncButtonPressed))
        onlineStatusView.isUserInteractionEnabled = true
        onlineStatusView.addGestureRecognizer(tapOnline)
        
        self.navigationItem.rightBarButtonItems = [userInitialLabelButton, self.notificationButton!, onlineSyncStatus!]
        let logoButton = UIBarButtonItem(image: UIImage(named: "AppLogo"), style:UIBarButtonItemStyle.plain, target: self, action: #selector(addTapped))
        if let instanceUrl: String = SFRestAPI.sharedInstance().user.credentials.instanceUrl?.description {
            if instanceUrl == StringConstants.detestServerUrl {
                logoButton.isEnabled = true
            }else{
                logoButton.isEnabled = false
            }
        }
        //logoButton.tintColor = UIColor.red
        logoButton.tintColor = UIColor.clear
        logoButton.setBackgroundImage(UIImage(named: "AppLogo"), for: .normal, barMetrics: .default)
        self.navigationItem.leftBarButtonItem = logoButton
        
        
    }
    
    @objc func addTapped(){
        let SmartStoreViewController = SFSmartStoreInspectorViewController.init(store:  SFSmartStore.sharedStore(withName: StoreDispatcher.SFADB) as! SFSmartStore)
        present(SmartStoreViewController, animated: true, completion: nil)
    }
    
    // MARK: SyncUp Data and resync down
    
    @objc func syncButtonPressed(){
        
        if AppDelegate.isConnectedToNetwork(){
            self.syncUpInfoVC?.hideSyncButton(hide: false)
        }else{
            self.syncUpInfoVC?.hideSyncButton(hide: true)
        }
        syncUpInfoVC?.delegate = self
        self.present(syncUpInfoVC!, animated: true, completion: {
            self.syncViewControllerSyncBtn = self.syncUpInfoVC?.syncNowBtn
            
        })
    }
    // MARK: SyncUp Data
    @objc func SyncUpData(){
        
        SyncUpDailogGlobal.isSyncError      = false
        SyncUpDailogGlobal.isSyncWarning    = false
        
        DispatchQueue.main.async { //do this in group.notify
            MBProgressHUD.show(onWindow: true)
        }
        var syncFailed = false
        let syncObjectProgressIncrement:Float = (Float(100/syncObjectCount))
        
        // Start sync progress
        SyncUpDailogGlobal.isSyncing = true
        func network()->String{
            if reachability.connection == .wifi {
                self.status = "WIFI"
            } else {
                self.status = "Cellular"
            }
            return status
        }
        
        networkType = network()
        print(networkType)
        // Start sync progress
        StoreDispatcher.shared.createSyncLogOnSyncStart(networkType: networkType)
        
        self.syncProgress = 0
        
        let queue = DispatchQueue(label: "concurrent")
        let group = DispatchGroup()
        
        // Sync Up Notes
        group.enter()
        AccountsNotesViewModel().syncNotesWithServer { error in
            if error != nil {
                syncFailed = true
                StoreDispatcher.shared.createSyncLogOnSyncError(networkType: self.networkType)
                print(error?.localizedDescription ?? "error")
            }
            print("syncNotesWithServer")
            self.syncProgress +=  syncObjectProgressIncrement
            self.syncUpInfoVC?.setProgress(progress: Float(self.syncProgress), progressComplete: false, syncUpFailed: false)
            group.leave()
        }
        
        // Contacts and ACRs Sync
        group.enter()
        ContactsViewModel().syncContactWithServer { error in
            if error == nil {
                print("syncContactWithServer")
                self.syncProgress += syncObjectProgressIncrement
                self.syncUpInfoVC?.setProgress(progress: Float(self.syncProgress), progressComplete: false, syncUpFailed: false)
                
                let acrArray = ContactsViewModel().accountsForContacts() //need all because some ACRs may be changed to unlinked
                
                var updatedACRs = [AccountContactRelation]()
                
                var meg = ""
                for acr in acrArray {
                    if acr.contactId.starts(with: "NEW") {
                        let sfContactId = ContactsViewModel().contactIdForACR(with: acr.contactId)
                        if sfContactId != "" {
                            acr.contactId = sfContactId
                            updatedACRs.append(acr)
                        }
                        else {
                            meg = meg + "sfContactId is empty for tempId: " + acr.contactId + " "
                            print(meg)
                        }
                    }
                }
                
                if updatedACRs.count > 0 {
                    let successAcrSoup = ContactsViewModel().updateACRToSoup(objects: updatedACRs)
                    if !successAcrSoup {
                        print("updateACRToSoup failed")
                    }
                }
                
                //                onemore enter {
                //                    one more leage
                //                }
                //
                //                wati for leae {
                //                    group.leave
                //                    }
                //    groupACR.enter()
                ContactsViewModel().syncACRwithServer{ error in
                    if error == nil {
                        print("syncACRwithServer completed successfully")
                    }
                    else {
                        print("syncACRwithServer failed")
                        StoreDispatcher.shared.createSyncLogOnSyncError(networkType: self.networkType)
                    }
                    //   groupACR.leave()
                }
                
                //                groupACR.notify(queue: queueACR) {
                //                    group.leave()
                //                }
                
            } else {
                syncFailed = true
                StoreDispatcher.shared.createSyncLogOnSyncError(networkType: self.networkType)
                print("syncContactWithServer error " + (error?.localizedDescription)!)
            }
            group.leave()
        }
        
        // Visits (WorkOrder) Sync Up
        group.enter()
        VisitSchedulerViewModel().syncVisitsWithServer{ error in
            if error != nil {
                syncFailed = true
                StoreDispatcher.shared.createSyncLogOnSyncError(networkType: self.networkType)
                print(error?.localizedDescription ?? "error")
            }
            
            print("syncVisitsWithServer")
            self.syncProgress +=  syncObjectProgressIncrement
            self.syncUpInfoVC?.setProgress(progress: Float(self.syncProgress), progressComplete: false, syncUpFailed: false)
            self.isVisitSynDownComplete = true
            
            
            if self.isVisitSynDownComplete {
                group.enter()
                DispatchQueue.global(qos: .background).async {
                    GlobalWorkOrderArray.workOrderArray = StoreDispatcher.shared.fetchVisits()
                    DispatchQueue.main.async {
                        print("Visit Download Complete")
                    }
                    group.leave()
                }
            }
            group.leave()
        }
        
        // Oppurtunity Sync Up
        group.enter()
        OpportunityViewModel().syncOpportunitysWithServer(){ error in
            if error != nil {
                syncFailed = true
                StoreDispatcher.shared.createSyncLogOnSyncError(networkType: self.networkType)
                print(error?.localizedDescription ?? "error")
            }
            print("syncOpportunitysWithServer")
            self.syncProgress +=  syncObjectProgressIncrement
            self.syncUpInfoVC?.setProgress(progress: Float(self.syncProgress), progressComplete: false, syncUpFailed: false)
            group.leave()
        }
        
        
        // Action Item  Sync with server
        group.enter()
        AccountsActionItemViewModel().syncAccountsActionItemWithServer{ error in
            if error != nil {
                syncFailed = true
                StoreDispatcher.shared.createSyncLogOnSyncError(networkType: self.networkType)
                print(error?.localizedDescription ?? "error")
            }
            print("syncAccountsActionItemWithServer")
            self.syncProgress +=  syncObjectProgressIncrement
            self.syncUpInfoVC?.setProgress(progress: Float(self.syncProgress), progressComplete: false, syncUpFailed: false)
            group.leave()
        }
        
        // StrategyQA  Sync with server
        group.enter()
        StrategyQAViewModel().syncStrategyWithServer{ error in
            if error != nil {
                syncFailed = true
                //DispatchQueue.main.async { //do this in group.notify
                //    MBProgressHUD.hide(forWindow: true)
                //}
                StoreDispatcher.shared.createSyncLogOnSyncError(networkType: self.networkType)
                print("Upload StrategyQA to Server " + (error?.localizedDescription)!)
            }
            print("syncStrategyWithServer")
            self.syncProgress +=  syncObjectProgressIncrement
            self.syncUpInfoVC?.setProgress(progress: Float(self.syncProgress), progressComplete: false, syncUpFailed: false)
            group.leave()
        }
        
        // Strategy Questions  Sync with server
        group.enter()
        StrategyQAViewModel().syncStrategyQuestionsWithServer{ error in
            if error != nil {
                syncFailed = true
                StoreDispatcher.shared.createSyncLogOnSyncError(networkType: self.networkType)
                print(error?.localizedDescription ?? "error")
            }
            print("syncStrategyQuestionsWithServer")
            self.syncProgress +=  syncObjectProgressIncrement
            self.syncUpInfoVC?.setProgress(progress: Float(self.syncProgress), progressComplete: false, syncUpFailed: false)
            group.leave()
        }
        
        // Strategy Answers  Sync with server
        group.enter()
        StrategyQAViewModel().syncStrategyAnswersWithServer{ error in
            if error != nil {
                syncFailed = true
                StoreDispatcher.shared.createSyncLogOnSyncError(networkType: self.networkType)
                print(error?.localizedDescription ?? "error")
            }
            print("syncStrategyAnswersWithServer")
            self.syncProgress +=  syncObjectProgressIncrement
            self.syncUpInfoVC?.setProgress(progress: Float(self.syncProgress), progressComplete: false, syncUpFailed: false)
            group.leave()
        }
        
        group.enter()
        AccountsViewModel().syncAccountWithServer{ error in
            if error != nil {
                syncFailed = true
                StoreDispatcher.shared.createSyncLogOnSyncError(networkType: self.networkType)
                print(error?.localizedDescription ?? "error")
            }
            print("syncAccountWithServer")
            self.syncProgress +=  syncObjectProgressIncrement
            self.syncUpInfoVC?.setProgress(progress: Float(self.syncProgress), progressComplete: false, syncUpFailed: false)
            if self.isAccountSyncDownComplete {
                group.enter()
                DispatchQueue.global(qos: .background).async {
                    GlobalWorkOrderArray.accountArray = StoreDispatcher.shared.fetchAccountsForLoggedUser()
                    DispatchQueue.main.async {
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadAccountsData"), object:nil)
                    }
                    group.leave()
                }
            }
            group.leave()
        }
        
        // Notification Sync
        group.enter()
        NotificationsViewModel().syncNotificationWithServer{ error in
            if error != nil {
                syncFailed = true
                StoreDispatcher.shared.createSyncLogOnSyncError(networkType: self.networkType)
                print(error?.localizedDescription ?? "error")
            }
            print("syncNotificationWithServer")
            self.syncProgress +=  syncObjectProgressIncrement
            self.syncUpInfoVC?.setProgress(progress: Float(self.syncProgress), progressComplete: false, syncUpFailed: false)
            group.leave()
        }
        
        //        // Configuration reSync
        //        group.enter()
        //        ConfigurationAndPickListModel().syncConfigurationWithServer{ error in
        //            if error != nil {
        //                StoreDispatcher.shared.createSyncLogOnSyncError(errorType: "SyncConfig")
        //                print(error?.localizedDescription ?? "error")
        //            }
        //            print("syncConfigurationWithServer")
        //            self.syncProgress +=  7
        //            self.syncUpInfoVC?.setProgress(progress: Float(self.syncProgress), progressComplete: false, syncUpFailed: false)
        //            group.leave()
        //        }
        //
        // Picklist reSync
        group.enter()
        ConfigurationAndPickListModel().syncPickListWithServer{ error in
            if error != nil {
                syncFailed = true
                StoreDispatcher.shared.createSyncLogOnSyncError(networkType: self.networkType)
                print(error?.localizedDescription ?? "error")
            }
            print("syncPickListWithServer")
            self.syncProgress +=  syncObjectProgressIncrement
            self.syncUpInfoVC?.setProgress(progress: Float(self.syncProgress), progressComplete: false, syncUpFailed: false)
            group.leave()
        }
        
        group.notify(queue: queue) {
            //If Error is there and no callback than push the error to DB so that it can be sync
            if UserDefaults.standard.object(forKey: "errorSDKUserDefaultSyncWarningMessage") != nil {
                StoreDispatcher.shared.createSyncLogOnSyncError(networkType: self.networkType)
                syncFailed = true
            }
            else if SyncUpDailogGlobal.isSyncWarning == true {
                //Check if ther is error register without callback in userdefaults if so force enter in DB
                syncFailed = true
                // Login the error in error case.
            }else if UserDefaults.standard.object(forKey: "errorSDKUserDefaultError") != nil{
                StoreDispatcher.shared.createSyncLogOnSyncError(networkType: self.networkType)
                syncFailed = true
            }
            
            /* if Duplicate entry detected errorSDKUserDefaultDuplicateEntryError */
            if let duplicateEntryDict = UserDefaults.standard.object(forKey: "errorSDKUserDefaultDuplicateEntryError") as? [String:AnyObject]{
                if let errocode = duplicateEntryDict["errorCode"] as? String{
                    if errocode == "MALFORMED_ID" {
                        if let msg = duplicateEntryDict["message"] as? String{
                            //duplicate value found: SGWS_Contact_Phone__c duplicates value on record with id: 0030t00000RostZ
                            let idarry = msg.components(separatedBy: ": ")
                            if idarry.count >= 3 {
                                if(idarry[0] == "Contact") {
                                    let id2Del = idarry[2]
                                    if !id2Del.isEmpty {
                                        let status = StoreDispatcher.shared.delDuplicateContactLocally(id: id2Del)
                                        if(status == true) {
                                            UserDefaults.standard.removeObject(forKey: "errorSDKUserDefaultDuplicateEntryError")
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            
            //Write to persistence for Resync to default
            UserDefaults.standard.set(StoreDispatcher.shared.syncIdDictionary, forKey: "resyncDictionary")
            StoreDispatcher.shared.createSyncLogOnSyncStop(networkType: self.networkType)
            self.syncProgress = 100
            
            if SyncUpDailogGlobal.isSyncError == true {
                syncFailed = true
            }
            
            self.syncUpInfoVC?.setProgress(progress: Float(self.syncProgress), progressComplete: true,syncUpFailed: syncFailed)
            
            SyncUpDailogGlobal.isSyncing = false
            
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadAllContacts"), object:nil)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshAccountOverView"), object:nil)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshCalendar"), object:nil)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshAccountVisitList"), object:nil)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "REFRESH_MONTH_CALENDAR"), object:nil)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshHomeActivities"), object:nil)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadAccountsData"), object:nil)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshNotification"), object:nil)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshNotesList"), object:nil)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshVisitEventList"), object:nil)
                
                ParentViewController.delegate?.reloadOpportunityDataFromDB()
                
                self.getUnreadNotificationsCount()
                if ActionItemFilterModel.fromAccount{
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshActionItemList"), object:nil)
                }else{
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "actionItemSyncDownComplete"), object:nil)
                }
                MBProgressHUD.hide(forWindow: true)
            }
        }
        // Start sync progress
    }
    
    
    //MARK: calling GospotCheck
    func launchGospotCheckApp() {
        DispatchQueue.main.async {
            if let url = URL(string: StringConstants.gospotcheckUrl)
            {
                if UIApplication.shared.canOpenURL(url)
                {
                    UIApplication.shared.open(url)
                }
                else
                {
                    let url  = URL(string: StringConstants.gospotItuneUrl)
                    
                    if UIApplication.shared.canOpenURL(url!) {
                        UIApplication.shared.open(url!)
                    }
                }
            }
        }
        
    }
    
    //MARK:Calling Topaz URL
    func launchTopazApp() {
        DispatchQueue.main.async {
            if let url = URL(string: StringConstants.topazUrl)
            {
                if UIApplication.shared.canOpenURL(url)
                {
                    UIApplication.shared.open(url)
                }
                else
                {
                    let alert = UIAlertController(title: "Alert", message: StringConstants.topazAlertMessage, preferredStyle: .alert)
                    
                    let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    
                    alert.addAction(cancelAction)
                    self.present(alert, animated: true, completion: nil)
                    
                }
            }
        }
        
    }
    
    //Insights Global
    
    func openSFSafariVC() {
        DispatchQueue.main.async {
            guard let instanceUrl = SFRestAPI.sharedInstance().user.credentials.instanceUrl else {
                return
            }
            
            guard let accessToken = SFRestAPI.sharedInstance().user.credentials.accessToken else {
                return
            }
            
            var authUrl: String = ""
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            
            if(appDelegate.insightLaunchIdentifier == "BoB"){
                
                authUrl = instanceUrl.description + StringConstants.secureUrl + accessToken + StringConstants.retUrl + StringConstants.homeScreenBoBURL
            }else if(appDelegate.insightLaunchIdentifier == "WHWN"){
                
                authUrl = instanceUrl.description + StringConstants.secureUrl + accessToken + StringConstants.retUrl + StringConstants.homeScreenWHWNURL
            }
            else if(appDelegate.insightLaunchIdentifier == "obj"){
                
                authUrl = instanceUrl.description + StringConstants.secureUrl + accessToken + StringConstants.retUrl + StringConstants.objectivesUrl
            }
            else {
                
                authUrl = instanceUrl.description + StringConstants.secureUrl + accessToken + StringConstants.retUrl + StringConstants.homeScreenBoBURL
            }
            
            
            
            let safariVC = SFSafariViewController(url: NSURL(string:authUrl )! as URL)
            self.present(safariVC, animated: true, completion: nil)
            //safariVC.
            safariVC.delegate = self
        }
    }
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        GlobalConstants.chatterfromMoreOption = true
        controller.dismiss(animated: true, completion: nil)
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
        isPresentingNotificationVc = false
        _ = displayCurrentTab(selectedSegment)
        if(selectedSegment == 0) {
            defaults.set(true, forKey: "FromHomeVC")
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "REFRESH_MONTH_CALENDAR"), object:nil)
        } else if (selectedSegment == 3) {
            defaults.set(false, forKey: "FromHomeVC")
        } else {
            print("Done !!")
        }
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
        ActionItemFilterModel.fromAccount = false
        UserDefaults.standard.set(true, forKey: "isBlackLineActive")
        SelectedMoreButton.isBlackLineActive = true
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
        //        let dropDownItem8 = NSLocalizedString("  Load Deposit (IDD)", comment: "Load Deposit (IDD)")
        let dropDownItem8 = NSLocalizedString("  GoSpotCheck", comment: "GoSpotCheck")
        // set the data source for the dropdown
        moreDropDown.dataSource = [dropDownItem1, dropDownItem2, dropDownItem3, dropDownItem4, dropDownItem5, dropDownItem6, dropDownItem7, dropDownItem8]
        self.moreDropDown.textFont = UIFont(name: "Ubuntu", size: 13)!
        self.moreDropDown.textColor =  UIColor.gray
        
        FilterMenuModel.isFromAccountVisitSummary = ""
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        appDelegate.insightLaunchIdentifier = ""
        self.selectedDropDownOption(selectedIndex : selectedIndex)
    }
    
    func navigateToMoreOptionsViewControllers(index : Int , selectedIndex : Int){
        
        let moreVC1:MoreViewController = self.moreVC as! MoreViewController
        let currentViewController = self.displayCurrentTab(selectedIndex)
        
        if index == 6{
            launchTopazApp()
            return
        }else if index == 7{
            launchGospotCheckApp()
            return
        }
        else if index == 2{
            openSFSafariVC()
            return
        }
        
        self.removeSubviews()
        removePresentedOldMoreControllers()
        currentViewController?.view.addSubview(moreVC1.view)
        SelectedMoreButton.selectedItem = index
        
        if index != 1{
            let accountsVisits = self.accountVisit as? AccountVisitEmbedViewController
            accountsVisits?.accountVisitFilterVC?.clearAccountVisitFilterModel()
        }
        
        self.clearAccountsVisitFilterModel()
        
        self.removePresentedMoreControllers()
        
        //  self.moreDropDown.selectionBackgroundColor = UIColor.gray
        switch index {
        case 0:
            moreVC1.view.addSubview((self.actionItemParent?.view)!)
            ActionItemFilterModel.fromAccount = false
            ActionItemFilterModel.accountId = nil
            self.actionItemParent?.fromPersistentMenu = true
            self.moreDropDownSelectionIndex = index
        case 1:
            moreVC1.view.addSubview((self.accountVisit?.view)!)
            self.moreDropDownSelectionIndex = index
        case 2:
            //            moreVC1.view.addSubview((self.insightsViewController?.view)!)
            //            self.moreDropDownSelectionIndex = index
            openSFSafariVC()
        case 3:
            moreVC1.view.addSubview((self.reportsViewController?.view)!)
            self.moreDropDownSelectionIndex = index
        case 4:
            self.notificationParent?.resetFilters()
            self.notificationParent?.delegate = self
            moreVC1.view.addSubview((self.notificationParent?.view)!)
            self.moreDropDownSelectionIndex = index
        case 5:
            GlobalConstants.chatterfromMoreOption = true
            moreVC1.view.addSubview((self.chatterViewController?.view)!)
            (chatterViewController as? ChatterViewController)?.loadWebView()
            self.moreDropDownSelectionIndex = index
        case 6:
            launchTopazApp()
            //self.instantiateViewController(identifier: "TopazViewControllerID", moreOptionVC: moreVC1, index: index)
            //        case 7:
        //            self.instantiateViewController(identifier: "IDDViewControllerID", moreOptionVC: moreVC1, index: index)
        case 7:
            launchGospotCheckApp()
            //moreVC1.view.addSubview((self.gospotcheckViewController?.view)!)
            // self.moreDropDownSelectionIndex = index
            
        default:
            break
        }
        
        
    }
    
    func removePresentedOldMoreControllers(){
        if SelectedMoreButton.selectedItem == 5 {
            chatterViewController?.willMove(toParentViewController: nil)
            chatterViewController?.view.removeFromSuperview()
            chatterViewController?.removeFromParentViewController()
        }
    }
    
    func removePresentedMoreControllers(){
        if SelectedMoreButton.selectedItem == 3{
            reportsViewController?.willMove(toParentViewController: nil)
            reportsViewController?.view.removeFromSuperview()
            reportsViewController?.removeFromParentViewController()
            (reportsViewController as? ReportsViewController)?.loadWebView()
            
        }else if SelectedMoreButton.selectedItem == 5{
//            chatterViewController?.willMove(toParentViewController: nil)
//            chatterViewController?.view.removeFromSuperview()
//            chatterViewController?.removeFromParentViewController()
//            (chatterViewController as? ChatterViewController)?.loadWebView()
            
        }
    }
    
    private func selectedDropDownOption(selectedIndex : Int){
        moreDropDown.selectionAction = { (index: Int, item: String) in
            
            self.navigateToMoreOptionsViewControllers(index: index , selectedIndex : selectedIndex)
            
        }
        // display the dropdown
        moreDropDown.show()
        
        self.dropDownSelectedRow()
    }
    
    //    private func selectedDropDownOption(selectedIndex : Int){
    //        moreDropDown.selectionAction = { (index: Int, item: String) in
    //
    //            let moreVC1:MoreViewController = self.moreVC as! MoreViewController
    //            let currentViewController = self.displayCurrentTab(selectedIndex)
    //            currentViewController?.view.addSubview(moreVC1.view)
    //            for view in moreVC1.view.subviews{
    //                view.removeFromSuperview()
    //            }
    //            if index != 1{
    //                let accountsVisits = self.accountVisit as? AccountVisitEmbedViewController
    //                accountsVisits?.accountVisitFilterVC?.clearAccountVisitFilterModel()
    //            }
    //
    //            self.clearAccountsVisitFilterModel()
    //            SelectedMoreButton.selectedItem = index
    //            switch index {
    //            case 0:
    //                moreVC1.view.addSubview((self.actionItemParent?.view)!)
    //                ActionItemFilterModel.fromAccount = false
    //                ActionItemFilterModel.accountId = nil
    //                self.actionItemParent?.fromPersistentMenu = true
    //                self.moreDropDownSelectionIndex = index
    //            case 1:
    //                moreVC1.view.addSubview((self.accountVisit?.view)!)
    //                self.moreDropDownSelectionIndex = index
    //            case 2:
    //                self.instantiateViewController(identifier: "InsightsViewControllerID", moreOptionVC: moreVC1, index: index)
    //            case 3:
    //                self.instantiateViewController(identifier: "ReportsViewControllerID", moreOptionVC: moreVC1, index: index)
    //            case 4:
    //                self.notificationParent?.resetFilters()
    //                self.notificationParent?.delegate = self
    //                moreVC1.view.addSubview((self.notificationParent?.view)!)
    //                self.moreDropDownSelectionIndex = index
    //            case 5:
    //                self.instantiateViewController(identifier: "ChatterViewControllerID", moreOptionVC: moreVC1, index: index)
    //
    //            case 6:
    //                self.instantiateViewController(identifier: "TopazViewControllerID", moreOptionVC: moreVC1, index: index)
    //
    //            case 7:
    //                self.instantiateViewController(identifier: "IDDViewControllerID", moreOptionVC: moreVC1, index: index)
    //
    //            case 8:
    //                self.instantiateViewController(identifier: "GoSpotViewControllerID", moreOptionVC: moreVC1, index: index)
    //
    //            default:
    //                break
    //            }
    //        }
    //        // display the dropdown
    //        moreDropDown.show()
    //
    //        self.dropDownSelectedRow()
    //    }
    
    private func dropDownSelectedRow(){
        
        // Dictionary to maitian the last selection
        if(self.moreDropDownSelectionIndex != -1){
            if let selection = moreDropDownSelectionIndex{
                moreDropDown.selectRow(selection)
            }
        }
    }
    
    private func removeSubviews(){
        
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
    
    private func clearAccountsVisitFilterModel(){
        if SelectedMoreButton.selectedItem == 1{
            let accountsVisits = self.accountVisit as? AccountVisitEmbedViewController
            accountsVisits?.accountVisitFilterVC?.clearAccountVisitFilterModel()
        }
        if SelectedMoreButton.selectedItem == 0{
            let accountsActionItem = self.actionItemParent
            accountsActionItem?.actionItemListVC?.fetchActionItemsFromDB()
        }
    }
    
    private func homeScreenScrollToTop(){
        if previouslySelectedVCIndex == 0{
            //            let homeScreen = self.homeVC as? HomeViewController
            //            homeScreen?.scrollToTop()
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "scrollToTopHomeActivities"), object:nil)
        }
    }
    
    // # MARK: viewControllerForSelectedSegmentIndex
    // get the respective view controller as per the selected index of menu from menubar
    private func viewControllerForSelectedSegmentIndex(_ index: Int) -> UIViewController? {
        
        self.view.endEditing(true)
        FilterMenuModel.isFromAccountListView = ""
        
        if index != 1{
            filterMenuModel.clearFilterModelData()
        }
        
        if index != 2{
            
            let accVC = contactsVC as? ContactsViewController
            accVC?.filterMenuVC?.clearFilterModelData(clearcontactsOnMyRoute: false)
        }
        
        self.clearAccountFilterModel()
        
        self.clearContactsFilterModel()
        
        self.homeScreenScrollToTop()
        
        self.notificationButton?.isEnabled = true
        self.unreadNotificationCountLabel.isUserInteractionEnabled = true
        
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
            contactVC.contactDetails?.willMove(toParentViewController: nil)
            contactVC.contactDetails?.view.removeFromSuperview()
            contactVC.contactDetails?.removeFromParentViewController()
            vc = contactVC
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadAllContacts"), object:nil)
        case .CalendarVCIndex:
            vc = calendarVC
            ContactsGlobal.accountId = ""
        case .ObjectivesVCIndex:
            // vc = objectivesVC
            if !isPresentingNotificationVc{
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.insightLaunchIdentifier = "obj"
                openSFSafariVC()
                topMenuBar?.selectedSegment = previouslySelectedVCIndex
            }
            
            ContactsGlobal.accountId = ""
        default:
            ifMoreVC = true
            ContactsGlobal.accountId = ""
            break
        }
        
        //        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadAllContacts"), object:nil)
        previouslySelectedVCIndex = index
        self.removePresentedViewControllers()
        
        return vc
    }
    
    private func removePresentedViewControllers(){
        
        if previouslySelectedVCIndex == 3 {
            calendarVC?.willMove(toParentViewController: nil)
            calendarVC?.view.removeFromSuperview()
            calendarVC?.removeFromParentViewController()
        }
        
        if previouslySelectedVCIndex == 0 {
            homeVC?.willMove(toParentViewController: nil)
            homeVC?.view.removeFromSuperview()
            homeVC?.removeFromParentViewController()
            (homeVC as! HomeViewController).scrollToTop()
        }
        
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
        let moreVC1:MoreViewController = self.moreVC as! MoreViewController
        let currentViewController = self.displayCurrentTab(LoadThePersistantMenuScreen.notifications.rawValue)
        self.removeSubviews()
        currentViewController?.view.addSubview(moreVC1.view)
        notificationParent?.resetFilters()
        notificationParent?.delegate = self
        moreVC1.view.addSubview((notificationParent?.view)!)
        self.moreDropDownSelectionIndex = 4
        topMenuBar?.selectedSegment = 5
    }
    
    func getUnreadNotificationsCount(){
        var notificationsArray = [Notifications]()
        var unreadNotificationsArray = [Notifications]()
        notificationsArray = NotificationsViewModel().notificationsForUser()
        for notification in notificationsArray {
            if !notification.isRead {
                unreadNotificationsArray.append(notification)
            }
        }
        let count : String = String(unreadNotificationsArray.count)
        DispatchQueue.main.async {
            self.unreadNotificationCountLabel.text = count
        }
    }
}

extension ParentViewController: NotificationParentViewControllerDelegate {
    func updateParent() {
        getUnreadNotificationsCount()
    }
}

extension ParentViewController: SyncInfoViewControllerDelegate {
    func startSyncUp(){
        return SyncUpData()
    }
}
