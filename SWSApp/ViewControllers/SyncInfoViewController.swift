//
//  SyncInfoViewController.swift
//  SWSApp
//
//  Created by manu.a.gupta on 28/05/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit
import SmartSync

protocol SyncInfoViewControllerDelegate: NSObjectProtocol {
    func startSyncUp()
}

class SyncInfoViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var lastSyncStatusLabel: UILabel!
    @IBOutlet weak var lastSyncDateLabel: UILabel!
    weak var delegate: SyncInfoViewControllerDelegate?

    @IBOutlet weak var syncNowBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizedUI()
        setProgress(progress: 0.0)
        setLastSyncValues()
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
        let lastSyncDate = "\(self.getCurrentTime(date: date)) / \(self.getCurrentDate(date: date))"
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
        DispatchQueue.main.async {
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
    }
    
    @IBAction func closeDialogue(sender : UIButton) {
       self.dismiss(animated: true, completion: nil)
    }
    
    func getCurrentDate(date: Date) -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yy"
        let dateString = formatter.string(from: date)
        return dateString
    }
    
    func getCurrentTime(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "H:mm a"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        let timeString = formatter.string(from: date)
        return timeString
    }
    
}
