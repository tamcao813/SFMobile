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
            return 50
        }else if section == 2{
            
        return 50
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! HomeActivitiesTableViewCell
        cell.textLabel?.text = "HEllpor"
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0{
        let frame = tableView.frame
        let sectionLabel = UILabel.init(frame: CGRect(x: 12, y: 5, width: 300, height: 50))
        sectionLabel.text = "Activities"
        sectionLabel.textColor = UIColor.black
        sectionLabel.font = UIFont(name: "Ubuntu-Medium", size: 25)
    
        let headerView = UIView.init(frame: CGRect(x: 0, y: 0, width:frame.width , height:frame.height ))
        headerView.backgroundColor = UIColor.white
        headerView.addSubview(sectionLabel)
        return headerView;
        }
        return nil
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            return 80
        }
        else {
            return 0
        }
    }
    
    
    

    
    
}

