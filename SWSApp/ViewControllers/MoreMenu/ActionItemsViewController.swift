//
//  ActionItemsViewController.swift
//  SWSApp
//
//  Created by Krishna, Kamya on 4/4/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class ActionItemsViewController: UIViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("Action Items VC will appear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("Action Items VC will disappear")
    }
}

