//
//  SyncInfoViewController.swift
//  SWSApp
//
//  Created by manu.a.gupta on 28/05/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit
import SmartSync
import Reachability

protocol SyncInfoViewControllerDelegate: NSObjectProtocol {
    func startSyncUp()
}

class SyncInfoViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var lastSyncStatusLabel: UILabel!
    @IBOutlet weak var lastSyncDateLabel: UILabel!
    weak var delegate: SyncInfoViewControllerDelegate?
    @IBOutlet weak var syncNowViewHeightConstraint: NSLayoutConstraint!

    @IBOutlet weak var syncNowBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizedUI()
        setProgress(progress: 0.0)
        setLastSyncValues()
        checkReachability()
    }
    
    func checkReachability(){
        let reachability = Reachability.init()
        
        reachability?.whenReachable = { reachability in
            self.syncNowViewHeightConstraint.constant = 0
        }
        
        reachability?.whenUnreachable = { _ in
            self.syncNowViewHeightConstraint.constant = 0
        }
        
        do {
            try reachability?.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    func customizedUI(){
        containerView.dropShadow(color: .lightGray, opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
    }
    
    func setProgress(progress: Float,progressComplete: Bool = false,syncUpFailed: Bool = false){
        DispatchQueue.main.async {
            self.progressView.progress = progress/100
            if progressComplete {
                self.updateDailog(syncUpFailed: syncUpFailed)
            }
        }
    }
    
    func updateDailog(syncUpFailed: Bool){
        let date = Date()
        let lastSyncDate = "\(DateTimeUtility().getCurrentTime(date: date)) / \(DateTimeUtility().getCurrentDate(date: date))"
        UserDefaults.standard.set(lastSyncDate, forKey: "lastSyncDate")
        if syncUpFailed {
            UserDefaults.standard.set("Last Sync Failed", forKey: "lastSyncStatus")
        }else{
            UserDefaults.standard.set("Last Sync Successful", forKey: "lastSyncStatus")
        }
        self.setLastSyncValues()
    }
    
    
    @IBAction func syncNowButtonTapped(_ sender: UIButton){
        if !SyncUpDailogGlobal.isSyncing {
            self.delegate?.startSyncUp()
            SyncUpDailogGlobal.isSyncing = true
        }
    }
    
    func setLastSyncValues(){        
        if let status = UserDefaults.standard.object(forKey: "lastSyncStatus") as? String {
            self.lastSyncStatusLabel.text = status
        }else{
            self.lastSyncStatusLabel.text = "Last Sync"
        }
        
        if let date = UserDefaults.standard.object(forKey: "lastSyncDate") as? String {
            self.lastSyncDateLabel.text = date
        }else{
            self.lastSyncDateLabel.text = ""
        }
        self.setProgress(progress: Float(0))
        SyncUpDailogGlobal.isSyncing = false
    }
    
    @IBAction func closeDialogue(sender : UIButton) {
       self.dismiss(animated: true, completion: nil)
    }
}
