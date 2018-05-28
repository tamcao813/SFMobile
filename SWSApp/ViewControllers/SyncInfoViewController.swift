//
//  SyncInfoViewController.swift
//  SWSApp
//
//  Created by manu.a.gupta on 28/05/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class SyncInfoViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var lastSyncStatusLabel: UILabel!
    @IBOutlet weak var lastSyncDateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizedUI()
    }
    
    func customizedUI(){
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.checkAction))
        self.view.addGestureRecognizer(gesture)
        containerView.dropShadow(color: .lightGray, opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
        // Remove after actual implementation
        setProgress(progress: 0.0)
    }
    
    func setProgress(progress: Float){
        progressView.progress = progress
    }
    
    
    @IBAction func syncNowButtonTapped(_ sender: UIButton){
        
    }
    
    @objc func checkAction(sender : UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
