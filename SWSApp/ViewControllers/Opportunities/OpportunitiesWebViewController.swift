//
//  OpportunitiesWebViewController.swift
//  SWSApp
//
//  Created by r.a.jantakal on 13/06/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation
import UIKit
import SalesforceSDKCore

class OpportunitiesWebViewController : UIViewController , WKNavigationDelegate{
    
    @IBOutlet weak var webView : WKWebView?
    @IBOutlet weak var lblNoNetworkConnection : UILabel?
    
    var opportunityWebViewId = ""
    
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
    
    //MARK:- View LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set up activity indicator
        activityIndicator.center = CGPoint(x: self.view.bounds.size.width/2, y: self.view.bounds.size.height/2 - 100)
        activityIndicator.color = UIColor.lightGray
        webView?.addSubview(activityIndicator)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let instanceUrl: String = SFRestAPI.sharedInstance().user.credentials.instanceUrl!.description
        let accessToken: String = SFRestAPI.sharedInstance().user.credentials.accessToken!
        let authUrl: String = instanceUrl + StringConstants.secureUrl + accessToken + StringConstants.retUrl + StringConstants.opportunitiesUrl + opportunityWebViewId + StringConstants.opportunityEndUrl
        
        
        let url  =  URL(string:authUrl)
        let requestObj = URLRequest(url: url!)
        webView?.navigationDelegate = self
        
        webView?.load(requestObj)
        
        if AppDelegate.isConnectedToNetwork(){
            lblNoNetworkConnection?.isHidden = true
        }else{
            lblNoNetworkConnection?.isHidden = false
        }
    }
    
    //MARK:- IBActions
    //Close Button Clicked
    @IBAction func closeButtonAction(sender : UIButton){
        self.dismiss(animated: true, completion: nil)
    }
}

////MARK:- UIWebView Delegate
extension OpportunitiesWebViewController :UIWebViewDelegate{
    
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

