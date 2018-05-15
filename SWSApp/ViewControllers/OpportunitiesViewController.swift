//
//  OpportunitiesViewController.swift
//  SWSApp
//
//  Created by r.a.jantakal on 28/04/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation
import UIKit
import SalesforceSDKCore

class OpportunitiesViewController : UIViewController{
    
    @IBOutlet weak var webView : UIWebView?
    
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
    
    let endUrl = "/one/one.app?source=alohaHeader#/sObject/Event/home"
    
    //MARK:- View LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set up activity indicator
        activityIndicator.center = CGPoint(x: self.view.bounds.size.width/2, y: self.view.bounds.size.height/2 - 200)
        activityIndicator.color = UIColor.lightGray
        webView?.addSubview(activityIndicator)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        let instanceUrl: String = SFRestAPI.sharedInstance().user.credentials.instanceUrl!.description
//        let accessToken: String = SFRestAPI.sharedInstance().user.credentials.accessToken!
//
//        let authUrl: String = instanceUrl + "/secur/frontdoor.jsp?sid=" + accessToken + "&retURL="
//        let accountUrl: String = authUrl +  endUrl
//
//        //let url = URL (string: "https://sgws-de--dedev1.lightning.force.com/one/one.app?source=alohaHeader#/sObject/Event/home")
        
//        let url  =  URL(string:authUrl+accountUrl)
//        let requestObj = URLRequest(url: url!)
//        webView?.loadRequest(requestObj)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
    override  func viewWillDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
}

//MARK:- UIWebView Delegate
extension OpportunitiesViewController :UIWebViewDelegate{
    
    func webViewDidStartLoad(_ webView: UIWebView){
        activityIndicator.startAnimating()
        
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView){
        activityIndicator.stopAnimating()
        
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error){
        activityIndicator.stopAnimating()
        
    }
}





