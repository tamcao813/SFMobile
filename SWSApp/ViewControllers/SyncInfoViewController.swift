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
    @IBOutlet weak var containerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var progressContainerView: UIView!

    @IBOutlet weak var syncNowBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizedUI()
        setProgress(progress: 0.0)
        setLastSyncValues()
    }
    
    func hideSyncButton(hide: Bool){
        DispatchQueue.main.async {
            if self.containerViewHeightConstraint != nil {
                if hide {
                    self.containerViewHeightConstraint.constant = 65
                    self.progressContainerView.isHidden = true
                }else{
                    self.containerViewHeightConstraint.constant = 130
                    self.progressContainerView.isHidden = false
                }
                self.containerView.layoutIfNeeded()
                self.customizedUI()
            }
        }
    }
    
    func customizedUI(){
        containerView.dropShadow(color: .lightGray, opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
    }
    
    func setProgress(progress: Float,progressComplete: Bool = false,syncUpFailed: Bool = false){
        DispatchQueue.main.async {
            if let _ = self.progressView { //Check if progressview is instantited, if not than dont disply in Autosync
                self.progressView.progress = progress/100
                
                if(SyncUpDailogGlobal.isSyncError == true) {
                    self.updateDailog(syncUpFailed: true)
                    return  //If error return without incrementing progress
                }
                
                if progressComplete {
                    self.updateDailog(syncUpFailed: syncUpFailed)
                }
            }
        }
    }
    
    
    func updateDailog(syncUpFailed: Bool){
        let date = Date()
        UserDefaults.standard.set(date, forKey: "lastSyncDateInDateFormat")
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
            SyncUpDailogGlobal.isSyncing    = true
            SyncUpDailogGlobal.syncType     = "Manual"
            SyncUpDailogGlobal.isSyncError  = false //Error Flag to reset on synccall
            SyncUpDailogGlobal.isSyncErrorNoCallBack = true
        }
    }
    
    func setLastSyncValues(){
        if let status = UserDefaults.standard.object(forKey: "lastSyncStatus") as? String {
            DispatchQueue.main.async {
                self.lastSyncStatusLabel.text = status
            }
        }else{
            DispatchQueue.main.async {
                self.lastSyncStatusLabel.text = "Last Sync"
            }
        }
        
        if let date = UserDefaults.standard.object(forKey: "lastSyncDate") as? String {
            DispatchQueue.main.async {
                self.lastSyncDateLabel.text = date
            }
        }else{
            DispatchQueue.main.async {
                self.lastSyncDateLabel.text = ""
            }
        }
        self.setProgress(progress: Float(0))
        SyncUpDailogGlobal.isSyncing = false
    }
    
    @IBAction func closeDialogue(sender : UIButton) {
       self.dismiss(animated: true, completion: nil)
    }
}
