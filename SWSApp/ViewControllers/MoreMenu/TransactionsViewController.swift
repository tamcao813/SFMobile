//
//  TransactionsViewController.swift
//  SWSApp
//
//  Created by Krishna, Kamya on 4/4/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class TransactionsViewController: UIViewController {
    //MARK: View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("Transactions VC will appear")
        launchApp()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("Transactions VC will disappear")
    }
    
    //MARK:Calling Topaz URL
    func launchApp() {
        DispatchQueue.main.async {
            if let url = URL(string: StringConstants.topazUrl)
            {
                if UIApplication.shared.canOpenURL(url)
                {
                    UIApplication.shared.open(url, options: [:], completionHandler: {
                        (success) in
                        if (success)
                        {
                            print("OPENED \(url): \(success)")
                        }
                        else
                        {
                            print("FAILED to open \(url)")
                        }
                    })
                }
                else
                {
                    let alert = UIAlertController(title: "Alert!", message: "Topaz app is not installed", preferredStyle: .alert)
                    
                    let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    
                    alert.addAction(cancelAction)
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
        
    }
    
    
}
