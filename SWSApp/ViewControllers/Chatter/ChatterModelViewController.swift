//
//  ChatterModelViewController.swift
//  SWSApp
//
//  Created by r.a.jantakal on 15/05/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation
import UIKit
import SalesforceSDKCore

class ChatterModelViewController : UIViewController , WKNavigationDelegate{
    
    @IBOutlet weak var webView : WKWebView?
    @IBOutlet weak var lblNoNetworkConnection : UILabel?
    var isNewModelOpened = false
    
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
    
    //MARK:- View LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set up activity indicator
        activityIndicator.center = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height / 2)
        activityIndicator.color = UIColor.lightGray
        self.view.addSubview(activityIndicator)
        //initializeReachability()
        loadWebView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if AppDelegate.isConnectedToNetwork(){
            DispatchQueue.main.async {
                self.lblNoNetworkConnection?.isHidden = true
                self.webView?.isHidden = false
            }
        }else{
            DispatchQueue.main.async {
                self.lblNoNetworkConnection?.isHidden = false
                self.webView?.isHidden = true
            }
        }
        initializeReachability()
    }
    
    override func dismiss(animated flag: Bool, completion: (() -> Void)?) {
        if (self.presentedViewController != nil) {
            super.dismiss(animated: flag, completion: completion)
        }else if self.isNewModelOpened == true{
            super.dismiss(animated: flag, completion: completion)
        }
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
        guard let instanceUrl = SFRestAPI.sharedInstance().user.credentials.instanceUrl else {
            return
        }
        
        guard let accessToken = SFRestAPI.sharedInstance().user.credentials.accessToken else {
            return
        }
        let authUrl: String = instanceUrl.description + StringConstants.secureUrl + accessToken + StringConstants.apexChatterUrl + AccountId.selectedAccountId
        
        //let accountUrl: String = authUrl +  endUrl
        
        let url  =  URL(string:authUrl)//+accountUrl)
        let requestObj = URLRequest(url: url!)
        webView?.navigationDelegate = self
        webView?.uiDelegate = self
        webView?.load(requestObj)
    }
    
    //MARK:- IBActions
    //Close Button Clicked
    @IBAction func closeButtonAction(sender : UIButton){
        self.isNewModelOpened = true
        self.dismiss(animated: true, completion: nil)
    }
}

//MARK:- UIWebView Delegate
extension ChatterModelViewController :UIWebViewDelegate , WKUIDelegate{

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
        self.isNewModelOpened = false
    }
    
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if navigationAction.targetFrame == nil {
            webView.load(navigationAction.request)
        }
        return nil
    }
}

