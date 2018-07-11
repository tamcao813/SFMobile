//
//  ReportsViewController.swift
//  SWSApp
//
//  Created by Krishna, Kamya on 4/3/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation
import UIKit
import SalesforceSDKCore

class ReportsViewController: UIViewController , WKNavigationDelegate {
    
    @IBOutlet weak var webView : WKWebView?
    @IBOutlet weak var lblNoNetworkConnection : UILabel?
    
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
    
    //MARK:- View LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        //Set up activity indicator
        activityIndicator.center = CGPoint(x: self.view.bounds.size.width/2, y: self.view.bounds.size.height/2 - 100)
        activityIndicator.color = UIColor.lightGray
        webView?.addSubview(activityIndicator)
        initializeReachability()
        loadWebView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        webView?.reload()
        webView?.isHidden = true
        print("Reports VC will appear")
    }
    
    //MARK:-
    //Initialize reachability Check
    func initializeReachability(){
        ReachabilitySingleton.sharedInstance().whenReachable = { reachability in
            self.webView?.reload()
            DispatchQueue.main.async {
                self.lblNoNetworkConnection?.isHidden = true
                self.webView?.isHidden = false
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
        let instanceUrl: String = SFRestAPI.sharedInstance().user.credentials.instanceUrl!.description
        let accessToken: String = SFRestAPI.sharedInstance().user.credentials.accessToken!
        let authUrl: String = instanceUrl + StringConstants.secureUrl + accessToken + StringConstants.retUrl + StringConstants.reportsUrl
        
        let url  =  URL(string:authUrl)//+accountUrl)
        let requestObj = URLRequest(url: url!)
        webView?.navigationDelegate = self
        webView?.uiDelegate = self
        webView?.load(requestObj)
    }
}

//MARK:- UIWebView Delegate
extension ReportsViewController :UIWebViewDelegate , WKUIDelegate{
    
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
        webView.isHidden = false
        //activityIndicator.stopAnimating()
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
