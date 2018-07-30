//
//  MoreViewController.swift
//  SWSApp
//
//  Created by shilpa.a.kulkarni on 02/04/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class MoreViewController: UIViewController {
    
    @IBOutlet weak var moreLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("More VC will appear")
        //self.moreLabel.text = "More"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("More VC will disappear")
    }
}
