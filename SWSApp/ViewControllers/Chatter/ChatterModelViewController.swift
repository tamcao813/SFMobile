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
    
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
    let endUrl = "/one/one.app?source=alohaHeader#/sObject/Event/home"

    
    //MARK:- View LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set up activity indicator
        activityIndicator.center = CGPoint(x: self.view.bounds.size.width/2, y: self.view.bounds.size.height/2 - 100)
        activityIndicator.color = UIColor.lightGray
        webView?.addSubview(activityIndicator)
        
        if AppDelegate.isConnectedToNetwork(){
            lblNoNetworkConnection?.isHidden = true
        }else{
            lblNoNetworkConnection?.isHidden = false
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let instanceUrl: String = SFRestAPI.sharedInstance().user.credentials.instanceUrl!.description
        let accessToken: String = SFRestAPI.sharedInstance().user.credentials.accessToken!
        
        let authUrl: String = instanceUrl + "/secur/frontdoor.jsp?sid=" + accessToken + "&retURL=" + "/c/sgwsChatterApp.app?acnid=" + AccountId.selectedAccountId
        
        let accountUrl: String = authUrl +  endUrl
        
        //let url = URL (string: "https://sgws-de--dedev1.lightning.force.com/one/one.app?source=alohaHeader#/sObject/Event/home")
        
        let url  =  URL(string:authUrl+accountUrl)
        let requestObj = URLRequest(url: url!)
        webView?.navigationDelegate = self
        
        webView?.load(requestObj)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
    override  func viewWillDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
    //MARK:- IBActions
    @IBAction func closeButtonAction(sender : UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    
}

////MARK:- UIWebView Delegate
extension ChatterModelViewController :UIWebViewDelegate{

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
        activityIndicator.stopAnimating()
    }
}

