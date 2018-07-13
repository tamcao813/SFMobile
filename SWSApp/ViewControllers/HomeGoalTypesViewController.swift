//
//  HomeGoalTypesViewController.swift
//  SWSApp
//
//  Created by r.a.jantakal on 01/06/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation
import UIKit
import SalesforceSDKCore

class HomeGoalTypesViewController : UIViewController , WKNavigationDelegate{
    
    @IBOutlet weak var webView : WKWebView?
    @IBOutlet weak var lblNoNetworkConnection : UILabel?
    @IBOutlet weak var btnViewPerformance : UIButton?
    
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
    
    //MARK:- View LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set up activity indicator
        activityIndicator.center = CGPoint(x: self.view.bounds.size.width/2 - 275, y: self.view.bounds.size.height/2 - 200)
        activityIndicator.color = UIColor.lightGray
        webView?.addSubview(activityIndicator)
        //self.initializeReachability()
        //self.loadUrlRequest()
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
        self.loadUrlRequest()
        initializeReachability()
    }
    
    //MARK:-
    //Initialize reachability Check
    func loadUrlRequest(){
        guard let instanceUrl = SFRestAPI.sharedInstance().user.credentials.instanceUrl else {
            return
        }
        
        guard let accessToken = SFRestAPI.sharedInstance().user.credentials.accessToken else {
            return
        }
         
        let authUrl: String = instanceUrl.description + StringConstants.secureUrl + accessToken + StringConstants.retUrl + StringConstants.homeScreenUrl
        
        let url = URL(string: authUrl)
        let requestObj = URLRequest(url: url!)
        self.webView?.uiDelegate = self
        self.webView?.navigationDelegate = self
        self.webView?.load(requestObj)
        
    }
    
    //Load the webview with specified URL
    func initializeReachability(){
        
        ReachabilitySingleton.sharedInstance().whenReachable = { reachability in
            self.loadUrlRequest()
            DispatchQueue.main.async {
                self.lblNoNetworkConnection?.isHidden = true
                self.btnViewPerformance?.isUserInteractionEnabled = true
                self.webView?.isHidden = false
                self.webView?.reload()
            }
        }
        
        ReachabilitySingleton.sharedInstance().whenUnreachable = { _ in
            DispatchQueue.main.async {
                self.lblNoNetworkConnection?.isHidden = false
                self.btnViewPerformance?.isUserInteractionEnabled = false
                self.webView?.isHidden = true
            }
        }
        
        do {
            try ReachabilitySingleton.sharedInstance().startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    //MARK:- IBAction Methods
    //View Trends Button Clicked
    @IBAction func viewTrendsButtonClicked(sender : UIButton){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.insightLaunchIdentifier = "WHWN"
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "goTOInsightBob/Notification"), object:4)
        
    }
    
    //View Performance Button Clicked
    @IBAction func viewPerformanceButtonClicked(sender : UIButton){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.insightLaunchIdentifier = "BoB"
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "goTOInsightBob/Notification"), object:4)
        
    }
    
}

//MARK:- UIWebView Delegate
extension HomeGoalTypesViewController :UIWebViewDelegate, WKUIDelegate{
    
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
        self.webView?.isHidden = false
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
