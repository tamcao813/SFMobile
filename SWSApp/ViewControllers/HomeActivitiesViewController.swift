//
//  HomeActivitiesViewController.swift
//  SWSApp
//
//  Created by r.a.jantakal on 01/06/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation
import UIKit

class HomeActivitiesViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var tableView : UITableView?
    let actionItemModel = AccountsActionItemViewModel()
    let notificationModel = NotificationsViewModel()
    var actionItem = [ActionItem]()
    var notifications = [Notifications]()
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        actionItem = actionItemModel.getAcctionItemForUser()
        notifications = notificationModel.notificationsForUser()
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return notifications.count
        }else if section == 2{
            
        return actionItem.count
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell1") as! TableViewCell
        cell.textLabel?.text = "HEllpor"
        return cell
    }
    
    
    

    
    
}






class TableViewCell : UITableViewCell{
    
    
}
