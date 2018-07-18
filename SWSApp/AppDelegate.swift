//
//  AppDelegate.swift
//  SWSApp
//
//  Created by maria.min-hui.yu on 3/21/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit
import SalesforceSDKCore
import SalesforceSwiftSDK
import PromiseKit
import Reachability
import Fabric
import Crashlytics

//import DropDown


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    var RemoteAccessConsumerKey = ""
    var OAuthRedirectURI = ""
    
    var loggedInUser: User?
    var currentSelectedUserId: String = ""
    var consultants = [Consultant]()
    var alertVisible = false
    var launchedBefore:Bool = false
    
    var insightLaunchIdentifier:String = ""
    
    override init(){
        
        super.init()
        var  plistpath:String? = ""
        //TODO: [SMK] Move the RemoteAccessConsumerKey in plist and put it in keychain
        #if DEINT
            plistpath  = Bundle.main.path(forResource: "SFPropertyDeInt", ofType: "plist")
        #elseif DETEST
            plistpath  = Bundle.main.path(forResource: "SFPropertyDeTest", ofType: "plist")
        #else // DEDEV
            plistpath  = Bundle.main.path(forResource: "SFPropertyDeDev", ofType: "plist")
        #endif
        
        let globalPlistUrl = Bundle.main.path(forResource: "GlobalURL", ofType: ".plist", inDirectory: nil)
        StringConstants.globalUrlDictionary = NSDictionary(contentsOfFile: globalPlistUrl!)
        
        if let  path = plistpath {
            if let dict = NSDictionary(contentsOfFile: path) as? Dictionary<String, String> {
                RemoteAccessConsumerKey = dict["RemoteAccessConsumerKey"]!
                OAuthRedirectURI = StringConstants.swsUri //dict["OAuthRedirectURI"]!
            }
        }
        
        SalesforceSwiftSDKManager.initSDK()
            .Builder.configure { (appconfig: SFSDKAppConfig) -> Void in
                appconfig.oauthScopes = ["web", "api"]
                appconfig.remoteAccessConsumerKey = self.RemoteAccessConsumerKey
                appconfig.oauthRedirectURI = self.OAuthRedirectURI
            }.postInit {
                SFUserAccountManager.sharedInstance().advancedAuthConfiguration = SFOAuthAdvancedAuthConfiguration.require;
            }
            .postLaunch {  [unowned self] (launchActionList: SFSDKLaunchAction) in
                let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
                let launchActionString = SalesforceSDKManager.launchActionsStringRepresentation(launchActionList)
                SalesforceSwiftLogger.log(type(of:self), level:.info, message:"Post-launch: launch actions taken: \(launchActionString)")
                //If launched first time Or Any soup is missing than treat it as first launch and call StoreDispatcher register soups
                let isAllSoupExist = StoreDispatcher.shared.checkIfAllSoupsExist()
                if((!launchedBefore && !isAllSoupExist)){
                        StoreDispatcher.shared.sfaStore.removeAllSoups()
                        StoreDispatcher.shared.registerSoups()
                        self.resetLaunchandResyncConfiguration()
                    }
                
                self.setupRootViewController()
                //For SDK error one can use .debug or .error to switch off .off
                SFSDKAnalyticsLogger.sharedInstance().logLevel  =    .error
                SFSDKCoreLogger.sharedInstance().logLevel       =    .error
                
            }.postLogout {  [unowned self] in
                self.handleSdkManagerLogout()
                print("postLogout")
                self.resetLaunchandResyncConfiguration()
                
            }.switchUser{ [unowned self] (fromUser: SFUserAccount?, toUser: SFUserAccount?) -> () in
                self.handleUserSwitch(fromUser, toUser: toUser)
                self.resetLaunchandResyncConfiguration()
            }.launchError {  [unowned self] (error: Error, launchActionList: SFSDKLaunchAction) in
                SFSDKLogger.log(type(of:self), level:.error, message:"Error during SDK launch: \(error.localizedDescription)")
                self.resetLaunchandResyncConfiguration()
                self.initializeAppViewState()
                SalesforceSDKManager.shared().launch()
            }
            .done()
    }
    
    class func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        
        /* Only Working for WIFI
         let isReachable = flags == .reachable
         let needsConnection = flags == .connectionRequired
         
         return isReachable && !needsConnection
         */
        
        // Working for Cellular and WIFI
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnection)
        
        return ret
        
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
//        Fabric.sharedSDK().debug = true
        Fabric.with([Crashlytics.self()])
        
        self.launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        
        if launchedBefore
        {
            print("Not first launch.")
        }
        else
        {
            print("First launch")
        }
        
        initializeAppViewState()
        SalesforceSDKManager.shared().launch()
        DropDown.startListeningToKeyboard()
        
        //Listen to kSFUserWillLogoutNotification
        NotificationCenter.default.addObserver(self, selector: #selector(self.resetLaunchandResyncConfiguration), name: NSNotification.Name("kSFUserWillLogoutNotification"), object: nil)
        
        return true
        
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        UserDefaults.standard.set(StoreDispatcher.shared.syncIdDictionary, forKey: "resyncDictionary")

    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        UserDefaults.standard.set(StoreDispatcher.shared.syncIdDictionary, forKey: "resyncDictionary")
        
    }
    
    func initializeAppViewState() {
        
        // Checking for the Network
        let reachability = Reachability.init()
        let alert = UIAlertController(title: "Alert", message: "The internet connection appears to be offline.", preferredStyle: UIAlertControllerStyle.alert)
        reachability?.whenReachable = { reachability in
            if self.alertVisible {
                alert.dismiss(animated: true, completion: nil)
                self.alertVisible = false
                if let window = self.window {
                    let storyboard = UIStoryboard(name: "LaunchScreen", bundle: nil)
                    window.rootViewController = storyboard.instantiateViewController(withIdentifier: "LaunchScreen")
                    window.makeKeyAndVisible()
                }
            }
        }
        
        reachability?.whenUnreachable = { _ in
            StoreDispatcher.shared.fetchLoggedInUser ({ (user, consults, error) in
                if user == nil {
                    if !self.alertVisible {
                        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                           // exit(0)
                        }))
                        self.window?.rootViewController?.present(alert, animated: true, completion: nil)
                        self.alertVisible = true
                    }
                }
            })
        }
        
        do {
            try reachability?.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
        
        if let window = window {
            if !self.alertVisible {
                let storyboard = UIStoryboard(name: "LaunchScreen", bundle: nil)
                window.rootViewController = storyboard.instantiateViewController(withIdentifier: "LaunchScreen")
                window.makeKeyAndVisible()
            }
        }
    }
    
    func handleSdkManagerLogout(){
        SFSDKLogger.log(type(of:self), level:.debug, message: "SFUserAccountManager logged out.  Resetting app.")
        if((self.window?.rootViewController?.presentedViewController) != nil){
            self.window?.rootViewController?.dismiss(animated: true, completion: {
                self.initializeAppViewState()
                SalesforceSDKManager.shared().launch()
            })
        }
    }
    
    func handleUserSwitch(_ fromUser: SFUserAccount?, toUser: SFUserAccount?){
        let fromUserName = (fromUser != nil) ? fromUser?.userName : "<none>"
        let toUserName = (toUser != nil) ? toUser?.userName : "<none>"
        SFSDKLogger.log(type(of:self), level:.debug, message:"SFUserAccountManager changed from user \(String(describing: fromUserName)) to \(String(describing: toUserName)).  Resetting app.")
    }
    
    
    func setupRootViewController() {
        guard let window = window else { return }
        
        let reachability = Reachability.init()
        
        reachability?.whenReachable = { reachability in
            if reachability.connection == .wifi {
                print("Reachable via WiFi")
            } else {
                print("Reachable via Cellular")
            }
           
            //Do this in the main thread to make sure the HUB gets added to the view properly and to show progresses
            DispatchQueue.main.async(execute: {
                //to do: show Hub and progress
                
                if(self.isKeyPresentInUserDefaults(key: "resyncDictionary")){
                    StoreDispatcher.shared.syncIdDictionary = UserDefaults.standard.dictionary(forKey: "resyncDictionary") as! [String : UInt]
                }
                
                StoreDispatcher.shared.syncDownUser({ (error) in
                    if error != nil {
                        print("error in syncDownUser")
                        //Don't return from here
                     //   return
                    }
                    
                    StoreDispatcher.shared.fetchLoggedInUser ({ (user, consults, error) in
                        guard let user = user else {
                            print("No logged in user retrieved")
                            self.resetLaunchandResyncConfiguration()
                            // Show Alert and exit the app
                            self.showAlertandExit()
                            return
                        }
                        
                        //Validate User Role
                        
                        //self.validateUserRole({ (user, error) in
                        
                        self.loggedInUser =  user
                        self.currentSelectedUserId = user.userId
                        self.consultants = consults
            print("appdelegate: currentSelectedUserId: " + self.currentSelectedUserId)
                        
                        //If first time download all soups
                        if(!self.launchedBefore){
                            StoreDispatcher.shared.downloadAllSoups({ (error) in
                                if error != nil {
                                    print("error in downloadAllSoups")
                                    self.resetLaunchandResyncConfiguration()
                                    return
                                }
                                DispatchQueue.main.async(){
                                let globalAccountsForLoggedUser = AccountsViewModel().accountsForLoggedUser()
                                if(globalAccountsForLoggedUser.count == 0){
                                    self.resetLaunchandResyncConfiguration()
                                    
                                    // Show Alert and exit the app
                                        self.showAlertandExit()
                                    }
                                }
                                // If both register and syncdownall is completed than only set the launched comeplete flag
                                UserDefaults.standard.set(true, forKey: "launchedBefore")
                                let date = Date()
                                UserDefaults.standard.set(date, forKey: "lastSyncDateInDateFormat")
                                let lastSyncDate = "\(DateTimeUtility().getCurrentTime(date: date)) / \(DateTimeUtility().getCurrentDate(date: date))"
                                UserDefaults.standard.set(lastSyncDate, forKey: "lastSyncDate")
                                UserDefaults.standard.set("Last Sync Successful", forKey: "lastSyncStatus")
                                //save the resyncdictionary to defaults
                                UserDefaults.standard.set(StoreDispatcher.shared.syncIdDictionary, forKey: "resyncDictionary")
                                
                                DispatchQueue.main.async(execute: {
                                    //to do: show progress 100% completed and dismiss Hub
                                    
                                    print("DispatchQueue.main.async rootViewController")
                                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                    let viewController = storyboard.instantiateInitialViewController() as! UINavigationController
                                    window.rootViewController = viewController
                                    window.makeKeyAndVisible()
                                })
                                
                            })
                        } else {
                            
                            StoreDispatcher.shared.resyncAllSoups({ (error) in
                                let date = Date()
                                UserDefaults.standard.set(date, forKey: "lastSyncDateInDateFormat")
                                let lastSyncDate = "\(DateTimeUtility().getCurrentTime(date: date)) / \(DateTimeUtility().getCurrentDate(date: date))"
                                UserDefaults.standard.set(lastSyncDate, forKey: "lastSyncDate")
                                if error != nil {
                                    
                                    print("error in resyncAllSoups")
                                 UserDefaults.standard.set("Last Sync Failed", forKey: "lastSyncStatus")
                                    return
                                }
                             
                                UserDefaults.standard.set("Last Sync Successful", forKey: "lastSyncStatus")
                                //save the resyncdictionary to defaults
                                UserDefaults.standard.set(StoreDispatcher.shared.syncIdDictionary, forKey: "resyncDictionary")
                                 print("resyncAllSoups resyncDictionary \(StoreDispatcher.shared.syncIdDictionary)")
                                DispatchQueue.main.async(execute: {
                                    //to do: show progress 100% completed and dismiss Hub
                                    
                                    print("DispatchQueue.main.async rootViewController")
                                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                    let viewController = storyboard.instantiateInitialViewController() as! UINavigationController
                                    window.rootViewController = viewController
                                    window.makeKeyAndVisible()
                                })
                            })
                        }
                        //} //else resync
                        
                        //})
                    })
                })
            })
        //})
        }
        reachability?.whenUnreachable = { _ in
            
            if(self.isKeyPresentInUserDefaults(key: "resyncDictionary")){
                StoreDispatcher.shared.syncIdDictionary = UserDefaults.standard.dictionary(forKey: "resyncDictionary") as! [String : UInt]
            }
            
            StoreDispatcher.shared.fetchLoggedInUser ({ (user, consults, error) in
                guard let user = user else {
                    print("No logged in user retrieved")
                    return
                }
                
                self.loggedInUser =  user
                self.currentSelectedUserId = user.userId
                self.consultants = consults
                
                print("Not reachable")
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let viewController = storyboard.instantiateInitialViewController() as! UINavigationController
                window.rootViewController = viewController
                window.makeKeyAndVisible()
                
            })
            
        }
        
        do {
            try reachability?.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
        
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
        // If you're using advanced authentication:
        // --Configure your app to handle incoming requests to your
        //   OAuth Redirect URI custom URL scheme.
        // --Uncomment the following line and delete the original return statement:
        
        return  SFUserAccountManager.sharedInstance().handleAdvancedAuthenticationResponse(url, options: options)
        //return false;
    }
    
//        func validateUserRole(user: User,completion: @escaping (Bool) -> ()) {
//    
//            let alert = UIAlertController(title: "Alert", message: "You do not have access to the SFA mobile application", preferredStyle: UIAlertControllerStyle.alert)
//    
//            // Check if this user is Sales Consultant OR Sales Manager or not
//            // If not show Alert and logout
//            if((user.userTeamMemberRole == StringConstants.salesConsultantTitle) || (user.userTeamMemberRole == StringConstants.salesManagerTitle)){
//                completion(true)
//            }
//            else {
//                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
//                    SFUserAccountManager.sharedInstance().logout()
//                    //       completion(true)
//
//                    exit(0)
//                }))
//                self.window?.rootViewController?.present(alert, animated: true, completion: nil)
//            }
//    
//        }
    
        func showAlertandExit() {
    
            let alert = UIAlertController(title: "Alert", message: "Logged in user don’t have any associated accounts, Please contact admin!", preferredStyle: UIAlertControllerStyle.alert)
    
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                    SFUserAccountManager.sharedInstance().logout()
                    exit(0)
                }))
                self.window?.rootViewController?.present(alert, animated: true, completion: nil)
            }
    
    
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
    
    @objc func resetLaunchandResyncConfiguration(){
        if(self.isKeyPresentInUserDefaults(key: "launchedBefore")){
            UserDefaults.standard.set(false,forKey: "launchedBefore")
        }
        StoreDispatcher.shared.syncIdDictionary.removeAll()
        UserDefaults.standard.set(StoreDispatcher.shared.syncIdDictionary, forKey: "resyncDictionary")
    }
    
}
