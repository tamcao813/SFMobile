//
//  NotificationParentViewController.swift
//  SWSApp
//
//  Created by manu.a.gupta on 31/05/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class NotificationParentViewController: UIViewController {

    var notificationFilterVC : NotificationFilterViewController?
    var notificationListVC : NotificationListViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notificationFilterVC?.delegate = notificationListVC
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "listSegue") {
            notificationListVC = segue.destination as? NotificationListViewController
        }else if (segue.identifier == "filterSegue") {
            notificationFilterVC = segue.destination as? NotificationFilterViewController
            
        }
    }
}
