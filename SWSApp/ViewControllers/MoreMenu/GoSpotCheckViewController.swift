//
//  GoSpotCheckViewController.swift
//  SWSApp
//
//  Created by Krishna, Kamya on 4/4/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class GoSpotCheckViewController: UIViewController {
    //MARK:View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("GoSpotCheck VC will appear")
        launchApp()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("GoSpotCheck VC will disappear")
    }
    
    //MARK: calling GospotCheck
    func launchApp() {
        DispatchQueue.main.async {
            if let url = URL(string: StringConstants.gospotcheckUrl)
            {
                if UIApplication.shared.canOpenURL(url)
                {
                    UIApplication.shared.open(url)
                }
                else
                {
                    let url  = URL(string: StringConstants.gospotItuneUrl)
                    
                    if UIApplication.shared.canOpenURL(url!) {
                        UIApplication.shared.open(url!)
                    }
                }
            }
        }
        
    }
}
