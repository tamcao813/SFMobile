//
//  HomeGoalTypesViewController.swift
//  SWSApp
//
//  Created by r.a.jantakal on 01/06/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation
import UIKit
import SalesforceSDKCore
import Reachability

class HomeGoalTypesViewController : UIViewController , WKNavigationDelegate{
    
    @IBOutlet weak var webView : WKWebView?
    @IBOutlet weak var lblNoNetworkConnection : UILabel?
    @IBOutlet weak var btnViewPerformance : UIButton?
    
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
    
    var reachability = Reachability()!
    
    //MARK:- View LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set up activity indicator
        activityIndicator.center = CGPoint(x: self.view.bounds.size.width/2 - 275, y: self.view.bounds.size.height/2 - 200)
        activityIndicator.color = UIColor.lightGray
        webView?.addSubview(activityIndicator)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.loadUrlRequest()
    }
    
    //MARK:-
    //Used to load the Web Content Within the app Using WEBKIT VIEW
    func loadUrlRequest(){
        
        let instanceUrl: String = SFRestAPI.sharedInstance().user.credentials.instanceUrl!.description
        let accessToken: String = SFRestAPI.sharedInstance().user.credentials.accessToken!
                
        let authUrl: String = instanceUrl + StringConstants.secureUrl + accessToken + StringConstants.retUrl + StringConstants.goalsUrl
        
        //let accountUrl: String = authUrl +  endUrl
        //let url  =  URL(string:authUrl)//+accountUrl)
        
        reachability.whenReachable = { reachability in
            if reachability.connection == .wifi {
                print("Reachable via WiFi")
            } else {
                print("Reachable via Cellular")
            }
            let url = URL(string: authUrl)
            let requestObj = URLRequest(url: url!)
            self.webView?.navigationDelegate = self
            
            self.lblNoNetworkConnection?.isHidden = true
            self.btnViewPerformance?.isUserInteractionEnabled = true//isHidden = false
            self.webView?.isHidden = false
            self.webView?.load(requestObj)
        }
        
        reachability.whenUnreachable = { _ in
            self.lblNoNetworkConnection?.isHidden = false
            self.btnViewPerformance?.isUserInteractionEnabled = false//isHidden = true
            self.webView?.isHidden = true
        }
        
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    //MARK:- IBAction Methods
    //Close button Clicked
    @IBAction func closeButtonAction(sender : UIButton){
        self.dismiss(animated: true, completion: nil)
    }
}

//MARK:- UIWebView Delegate
extension HomeGoalTypesViewController :UIWebViewDelegate{
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print(error.localizedDescription)
        //activityIndicator.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("Start to load")
        //activityIndicator.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("finish to load")
        //activityIndicator.stopAnimating()
    }
}
