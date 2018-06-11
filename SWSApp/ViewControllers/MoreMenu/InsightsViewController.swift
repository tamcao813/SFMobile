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
        activityIndicator.center = CGPoint(x: self.view.bounds.size.width/2, y: self.view.bounds.size.height/2 - 100)
        activityIndicator.color = UIColor.lightGray
        webView?.addSubview(activityIndicator)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //let authUrl: String = instanceUrl + StringConstants.secureUrl + accessToken + StringConstants.retUrl
        let authUrl = StringConstants.insightsUrl
        //let accountUrl: String = authUrl +  StringConstants.endUrl
        
        let url  =  URL(string:authUrl)//+accountUrl)
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
extension InsightsViewController : UIWebViewDelegate{
    
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
       // activityIndicator.stopAnimating()
    }
}
