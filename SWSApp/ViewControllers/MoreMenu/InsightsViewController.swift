//
//  InsightsViewController.swift
//  SWSApp
//
//  Created by Krishna, Kamya on 4/3/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit
import Foundation
import SalesforceSDKCore
import WebKit

class InsightsViewController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var lblNoNetworkConnection: UILabel!
    
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
    
    //MARK:- View LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set up activity indicator
        activityIndicator.center = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height / 2)
        activityIndicator.color = UIColor.lightGray
        self.view.addSubview(activityIndicator)
        //initializeReachability()
        //self.loadWebView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.webView?.isHidden = true
        
        if !(AppDelegate.isConnectedToNetwork()){
            DispatchQueue.main.async {
                self.lblNoNetworkConnection?.isHidden = false
                self.webView?.isHidden = true
            }
        }
//        DispatchQueue.main.async{
//            self.loadWebView()
//        }
        self.initializeReachability()
    }
    
    //MARK:-
    //Initialize reachability Check
    func initializeReachability(){
        ReachabilitySingleton.sharedInstance().whenReachable = { reachability in
            self.loadWebView()
            DispatchQueue.main.async {
                self.lblNoNetworkConnection?.isHidden = true
                self.webView?.isHidden = false
                self.webView?.reload()
            }
        }
        
        ReachabilitySingleton.sharedInstance().whenUnreachable = { _ in
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.lblNoNetworkConnection?.isHidden = false
                self.webView?.isHidden = true
            }
        }
        
        do {
            try ReachabilitySingleton.sharedInstance().startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    //Load the webview with specified URL
    func loadWebView(){
        
        self.webView?.isHidden = true
        //DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
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
            else {
                
                authUrl = instanceUrl.description + StringConstants.secureUrl + accessToken + StringConstants.retUrl + StringConstants.insightsUrl
            }
            
            //let accountUrl: String = authUrl +  StringConstants.endUrl
            
            let url  =  URL(string:authUrl)//+accountUrl)
            let requestObj = URLRequest(url: url!)
            self.webView.uiDelegate = self
            self.webView?.navigationDelegate = self
            self.webView?.load(requestObj)
        //}
    }
}

//MARK:- UIWebView Delegate
extension InsightsViewController : UIWebViewDelegate, WKUIDelegate{
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print(error.localizedDescription)
        activityIndicator.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("Start to load")
        activityIndicator.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("finish to load")
        DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
            self.webView?.isHidden = false
        }
        activityIndicator.stopAnimating()
    }
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo,
                 completionHandler: @escaping () -> Void) {
        
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            completionHandler()
        }))
        
        present(alertController, animated: true, completion: nil)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if navigationAction.targetFrame == nil {
            webView.load(navigationAction.request)
        }
        return nil
    }
}
