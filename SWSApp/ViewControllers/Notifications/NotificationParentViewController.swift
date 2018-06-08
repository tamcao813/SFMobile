//
//  NotificationParentViewController.swift
//  SWSApp
//
//  Created by manu.a.gupta on 31/05/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit
protocol NotificationParentViewControllerDelegate: NSObjectProtocol {
    func updateParent()
}

class NotificationParentViewController: UIViewController {

    var notificationFilterVC : NotificationFilterViewController?
    var notificationListVC : NotificationListViewController?
    weak var delegate:NotificationParentViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        notificationFilterVC?.delegate = notificationListVC
        notificationFilterVC?.clearActionItemFilterModel()
    }
    
    func resetFilters(){
        notificationFilterVC?.clearActionItemFilterModel()
        notificationListVC?.getNotifications()
        notificationListVC?.tableView.setContentOffset(.zero, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "listSegue") {
            notificationListVC = segue.destination as? NotificationListViewController
            notificationListVC?.delegate = self
        }else if (segue.identifier == "filterSegue") {
            notificationFilterVC = segue.destination as? NotificationFilterViewController
        }
    }
}

extension NotificationParentViewController: NotificationListViewControllerDelegate {
    func updateCount() {
        self.delegate?.updateParent()
    }
}
