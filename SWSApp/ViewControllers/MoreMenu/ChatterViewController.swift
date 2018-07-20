//
//  ChatterViewController.swift
//  SWSApp
//
//  Created by Krishna, Kamya on 4/3/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit
import Foundation
import SalesforceSDKCore
import WebKit

class ChatterViewController: UIViewController , WKNavigationDelegate {
    
    @IBOutlet weak var webView : WKWebView?
    @IBOutlet weak var lblNoNetworkConnection : UILabel?
    
    //var isWebViewLoaded = false
    //var isFirstTimeLoad = false
    
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
    
    //MARK:- View LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set up activity indicator
        activityIndicator.center = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height / 2)
        activityIndicator.color = UIColor.lightGray
        self.view.addSubview(activityIndicator)
        loadWebView()
        //isFirstTimeLoad = true
        //initializeReachability()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //webView?.isHidden = true
       
        if !(AppDelegate.isConnectedToNetwork()){
            DispatchQueue.main.async {
                self.lblNoNetworkConnection?.isHidden = false
                self.webView?.isHidden = true
            }
        }
        //loadWebView()
        initializeReachability()
        
//        if isFirstTimeLoad,isWebViewLoaded{
//            isFirstTimeLoad = false
//            DispatchQueue.main.async {
//                self.webView?.frame = CGRect(x: (self.webView?.frame.origin.x)!, y: (self.webView?.frame.origin.y)! + 64, width: (self.webView?.frame.size.width)!, height: ((self.webView?.frame.size.height)! + 5))
//            }
//        }
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
        DispatchQueue.main.async {
            self.webView?.isHidden = true
        }
        guard let instanceUrl = SFRestAPI.sharedInstance().user.credentials.instanceUrl else {
            return
        }
        guard let accessToken = SFRestAPI.sharedInstance().user.credentials.accessToken else {
            return
        }
        let authUrl: String = instanceUrl.description + StringConstants.secureUrl + accessToken + StringConstants.retUrl + StringConstants.globalChatter
        
        let url  =  URL(string:authUrl)
        let requestObj = URLRequest(url: url!)
        webView?.navigationDelegate = self
        webView?.uiDelegate = self
        webView?.load(requestObj)
    }
}

//MARK:- UIWebView Delegate
extension ChatterViewController : UIWebViewDelegate , WKUIDelegate {
    
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
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
        //isWebViewLoaded = true
    }
    
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if navigationAction.targetFrame == nil {
            webView.load(navigationAction.request)
        }
        return nil
    }
}
