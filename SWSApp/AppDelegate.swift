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

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var RemoteAccessConsumerKey = ""
    var OAuthRedirectURI = ""
    
    var loggedInUser: User?
    
    let isMockUser = true //set it to true to use mock data or set it to false if testing with real data
    
    override
    init()
    {
        
        super.init()
        
        if let  path  = Bundle.main.path(forResource: "SFProperty", ofType: "plist") {
            if let dict = NSDictionary(contentsOfFile: path) as? Dictionary<String, String> {
                RemoteAccessConsumerKey = dict["RemoteAccessConsumerKey"]!
                OAuthRedirectURI = dict["OAuthRedirectURI"]!
            }
        }
        
        SalesforceSwiftSDKManager.initSDK()
            .Builder.configure { (appconfig: SFSDKAppConfig) -> Void in
                appconfig.oauthScopes = ["web", "api"]
                appconfig.remoteAccessConsumerKey = self.RemoteAccessConsumerKey
                appconfig.oauthRedirectURI = self.OAuthRedirectURI
            }.postInit {
                
            }
            .postLaunch {  [unowned self] (launchActionList: SFSDKLaunchAction) in
                let launchActionString = SalesforceSDKManager.launchActionsStringRepresentation(launchActionList)
                SalesforceSwiftLogger.log(type(of:self), level:.info, message:"Post-launch: launch actions taken: \(launchActionString)")
                
                //setup StoreDispatcher by registering soups
                StoreDispatcher.shared.registerSoups()
                
                self.setupRootViewController()
                
            }.postLogout {  [unowned self] in
                self.handleSdkManagerLogout()
            }.switchUser{ [unowned self] (fromUser: SFUserAccount?, toUser: SFUserAccount?) -> () in
                self.handleUserSwitch(fromUser, toUser: toUser)
            }.launchError {  [unowned self] (error: Error, launchActionList: SFSDKLaunchAction) in
                SFSDKLogger.log(type(of:self), level:.error, message:"Error during SDK launch: \(error.localizedDescription)")
                self.initializeAppViewState()
                SalesforceSDKManager.shared().launch()
            }
            .done()
                
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        initializeAppViewState()
        SalesforceSDKManager.shared().launch()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
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
    }

    func initializeAppViewState() {
        if let window = window {
            let storyboard = UIStoryboard(name: "LaunchScreen", bundle: nil)
            window.rootViewController = storyboard.instantiateViewController(withIdentifier: "LaunchScreen")
            window.makeKeyAndVisible()
        }
    }
    
    func handleSdkManagerLogout()
    {
        SFSDKLogger.log(type(of:self), level:.debug, message: "SFUserAccountManager logged out.  Resetting app.")
    }
    
    func handleUserSwitch(_ fromUser: SFUserAccount?, toUser: SFUserAccount?)
    {
        let fromUserName = (fromUser != nil) ? fromUser?.userName : "<none>"
        let toUserName = (toUser != nil) ? toUser?.userName : "<none>"
        SFSDKLogger.log(type(of:self), level:.debug, message:"SFUserAccountManager changed from user \(String(describing: fromUserName)) to \(String(describing: toUserName)).  Resetting app.")
    }
    
    
    func setupRootViewController() {
        guard let window = window else { return }
        
        //Do this in the main thread to make sure the HUB gets added to the view properly and to show progresses
        DispatchQueue.main.async(execute: {
            //to do: show Hub and progress
            
            StoreDispatcher.shared.syncDownUser({ (error) in
                if error != nil {
                    print("error in syncDownUser")
                    return
                }
                
                StoreDispatcher.shared.fetchLoggedInUser ({ (user, error) in
                    guard let user = user else {
                        print("No logged in user retrieved")
                        return
                    }
                    
                    self.loggedInUser =  user
                    
                    StoreDispatcher.shared.downloadAllSoups({ (error) in
                        if error != nil {
                            print("error in downloadAllSoups")
                            return
                        }
                        
                        
                        DispatchQueue.main.async(execute: {
                            //to do: show progress 100% completed and dismiss Hub
                            
                            print("DispatchQueue.main.async rootViewController")
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let viewController = storyboard.instantiateInitialViewController() as! UINavigationController
                            window.rootViewController = viewController
                            window.makeKeyAndVisible()
                        })
                    })
                })
            })
        })
    }
}
