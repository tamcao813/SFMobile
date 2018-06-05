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
    var actionItemToDisplay = [ActionItem]()
    var notifications = [Notifications]()
    var notificationsToDisplay = [Notifications]()
    var dateFormatter = DateFormatter()
    var dateToCheck = Date()
    var dateStringForActionItem:String?
    var dateStringForNotification:String?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateStringForActionItem = dateFormatter.string(from: dateToCheck)
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000+0000"
        dateStringForNotification = dateFormatter.string(from: dateToCheck)
        
        getDB()
        
        
    }
    
    func getDB() {
        
        actionItemToDisplay = [ActionItem]()
        notificationsToDisplay = [Notifications]()
        
        actionItem = actionItemModel.getAcctionItemForUser()
        actionItemToDisplay = actionItem.filter( { return $0.activityDate == dateStringForActionItem } )
        
     
        notifications = notificationModel.notificationsForUser()
        notificationsToDisplay = notifications.filter({ return $0.createdDate == dateStringForNotification })
        
    }
    
    
    
    
    //MARK:- Table View Functions
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return notificationsToDisplay.count
        }else if section == 1{
            
            return actionItemToDisplay.count
        }
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomeActivitiesTableViewCell
        
        if indexPath.section == 0 {
            let notificationObject:Notifications = notificationsToDisplay[indexPath.row]
            if notificationObject.sgwsType == "Birthday"{
                
                cell.homeActivitiesTitle.text = notificationObject.sgwsContactBirthdayNotification
                cell.homeActivitiesTimeLabel.text = notificationObject.createdDate
                cell.homeActivitiesImage.image = UIImage(named: "Bell")
                
            }
            else  {
                
                cell.homeActivitiesTitle.text = notificationObject.sgwsAccLicenseNotification
                cell.homeActivitiesTimeLabel.text = notificationObject.createdDate
                cell.homeActivitiesImage.image = UIImage(named: "Bell")
            }
            
        }
        else if indexPath.section == 1{
            
            let actionItemObject:ActionItem = actionItemToDisplay[indexPath.row]
            
            cell.homeActivitiesTitle.text = actionItemObject.subject
            cell.homeActivitiesTimeLabel.text = DateTimeUtility.convertUtcDatetoReadableDateOnlyDate(dateStringfromAccountNotes: actionItemObject.activityDate)
            cell.homeActivitiesImage.image = UIImage(named: "Small Status Critical")
        }
        
        
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
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1{
            DispatchQueue.main.async {
                let detailViewController = UIStoryboard(name: "ActionItem", bundle: nil).instantiateViewController(withIdentifier :"ActionItemDetailsViewController") as! ActionItemDetailsViewController
                detailViewController.actionItemId = self.actionItemToDisplay[indexPath.row].Id
                detailViewController.delegate = self as? ActionItemDetailsViewControllerDelegate
                self.present(detailViewController, animated: true)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            return 80
        }
        else {
            return 0
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
   
    @IBAction func viewAllNotifications(_ sender: Any) {
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "goToAllActionItem/Notification"), object:4)
    }
    @IBAction func viewAllActionItem(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "goToAllActionItem/Notification"), object:0)
        
        
    }
    
    
}

