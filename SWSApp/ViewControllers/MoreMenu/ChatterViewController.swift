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
    
    @IBOutlet var webView : WKWebView?
    @IBOutlet weak var lblNoNetworkConnection : UILabel?
    
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
    

    //MARK:- View LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set up activity indicator
        activityIndicator.center = CGPoint(x: self.view.bounds.size.width/2, y: self.view.bounds.size.height/2 - 100)
        activityIndicator.color = UIColor.lightGray
        webView?.addSubview(activityIndicator)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let webViewCfg = WKWebViewConfiguration()
        webViewCfg.preferences.javaScriptEnabled = true;
        webViewCfg.preferences.javaScriptCanOpenWindowsAutomatically = true
        webViewCfg.isAccessibilityElement = true
        //webView = WKWebView(frame:(webView?.bounds)!, configuration: webViewCfg)
        
        let instanceUrl: String = SFRestAPI.sharedInstance().user.credentials.instanceUrl!.description
        let accessToken: String = SFRestAPI.sharedInstance().user.credentials.accessToken!
        
        let authUrl: String = instanceUrl + StringConstants.secureUrl + accessToken + StringConstants.retUrl
        let accountUrl: String = authUrl +  StringConstants.endUrl
        
        let url  =  URL(string:authUrl+accountUrl)
        let requestObj = URLRequest(url: url!)
        webView?.navigationDelegate = self
        
        webView?.load(requestObj)
        
        if AppDelegate.isConnectedToNetwork(){
            lblNoNetworkConnection?.isHidden = true
        }else{
            lblNoNetworkConnection?.isHidden = false
        }
    }
    
}

////MARK:- UIWebView Delegate
extension ChatterViewController : UIWebViewDelegate , WKUIDelegate , WKScriptMessageHandler{
    
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
    // MARK: WKUIDelegate methods
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (() -> Void)) {
        print("webView:\(webView) runJavaScriptAlertPanelWithMessage:\(message) initiatedByFrame:\(frame) completionHandler:\(completionHandler)")
        
        let alertController = UIAlertController(title: frame.request.url?.host, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            completionHandler()
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "loginAction" {
            print("JavaScript is sending a message \(message.body)")
        }
    }
}
