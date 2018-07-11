//
//  InsightsModalViewController.swift
//  SWSApp
//
//  Created by Jagadeeshwar Reddy on 12/06/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation
import UIKit
import SalesforceSDKCore

class InsightsModelViewController : UIViewController , WKNavigationDelegate{
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var lblNoNetworkConnection: UILabel!
    
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
    
    //MARK:- View LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set up activity indicator
        activityIndicator.center = CGPoint(x: self.view.bounds.size.width/2, y: self.view.bounds.size.height/2 - 100)
        activityIndicator.color = UIColor.lightGray
        webView?.addSubview(activityIndicator)        
        initializeReachability()
        self.loadWebView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        webView.reload()
        self.webView.isHidden = true
    }
    
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
    
    func loadWebView(){
        let instanceUrl: String = SFRestAPI.sharedInstance().user.credentials.instanceUrl!.description
        let accessToken: String = SFRestAPI.sharedInstance().user.credentials.accessToken!
        let authUrl: String = instanceUrl + StringConstants.secureUrl + accessToken + StringConstants.retUrl + StringConstants.insightsAccountUrl + AccountId.selectedAccountId
        
        let url  =  URL(string:authUrl)
        let requestObj = URLRequest(url: url!)
        webView?.navigationDelegate = self
        webView?.load(requestObj)        
    }
    
    //MARK:- IBActions
    //Close Button Clicked
    @IBAction func closeButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

//MARK:- UIWebView Delegate
extension InsightsModelViewController :UIWebViewDelegate{
    
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
}

