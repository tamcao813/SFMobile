//
//  NotificationListViewController.swift
//  SWSApp
//
//  Created by manu.a.gupta on 31/05/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit
import SmartSync

protocol NotificationListViewControllerDelegate : NSObjectProtocol {
    func updateCount()
}

class NotificationListViewController: UIViewController {

    var notificationsArray = [Notifications]()
    var filteredNotificationsArray = [Notifications]()
    @IBOutlet weak var tableView: UITableView!
    let parnentViewController = ParentViewController()
    weak var delegate : NotificationListViewControllerDelegate?
    
    override func viewDidLoad() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.refreshNotification), name: NSNotification.Name("refreshNotification"), object: nil)
        super.viewDidLoad()
        customizedUI()
        getNotifications()
    }
    
    
    @objc func refreshNotification()   {
        getNotifications()
    }
    
    
    func getNotifications(){
        notificationsArray = [Notifications]()
        notificationsArray = NotificationsViewModel().notificationsForUser()
        notificationsArray = notificationsArray.sorted(by: { $0.createdDate < $1.createdDate })
        reloadTableView()
    }
    
    func customizedUI(){
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        self.tableView.estimatedRowHeight = 100
        self.tableView.tableFooterView = UIView()
        initializeXib()
    }
    
    func initializeXib(){
        tableView.register(UINib(nibName: "NotificationListTableViewCell", bundle: nil), forCellReuseIdentifier: "NotificationListTableViewCell")
        
    }
    
    func reloadTableView(){
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

//MARK:- Notification Filter Delegate
extension NotificationListViewController :  NotificationSearchButtonTappedDelegate{
    
    func performFilterOperation(searchText: UISearchBar) {
        NotificationFilterModel.filterApplied = true
        if searchText.text != ""{
            filteredNotificationsArray =  NotificationsSortUtility().searchAndFilter(searchStr: searchText.text!, notifications: notificationsArray)
        }else{
            filteredNotificationsArray = NotificationsSortUtility().filterOnly(notifications: notificationsArray)
        }
        reloadTableView()
    }

    func clearFilter(){
        NotificationFilterModel.filterApplied = false
        reloadTableView()
    }
    
    func editNotification(notification: Notifications){
        var editNotification = Notifications(for: "notification")
        editNotification = notification
        if editNotification.isRead {
            editNotification.isRead = false
        }else{
            editNotification.isRead = true
        }
//        editNotification. = ActionItemSortUtility().getTimestamp()
        let attributeDict = ["type":"FS_Notification__c"]
        let notificationDict: [String:Any] = [
            
            Notifications.notificationsFields[0]: editNotification.Id,
            Notifications.notificationsFields[8]: editNotification.isRead,
//            ActionItem.AccountActionItemFields[7]: editNotification.lastModifiedDate,
            
            kSyncTargetLocal:true,
            kSyncTargetLocallyCreated:false,
            kSyncTargetLocallyUpdated:true,
            kSyncTargetLocallyDeleted:false,
            "attributes":attributeDict]
        
        let success = NotificationsViewModel().editNotificationsLocally(fields: notificationDict)
        if success {
            self.delegate?.updateCount()
            self.getNotifications()
        }
    }
}

extension NotificationListViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if NotificationFilterModel.filterApplied {
            return filteredNotificationsArray.count
        }else{
            return  notificationsArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationListTableViewCell") as? NotificationListTableViewCell
        if NotificationFilterModel.filterApplied {
            cell?.displayCellContent(notificationObject: filteredNotificationsArray[indexPath.row])
        }else{
            cell?.displayCellContent(notificationObject: notificationsArray[indexPath.row])
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if NotificationFilterModel.filterApplied {
            self.editNotification(notification: filteredNotificationsArray[indexPath.row])
        }else{
            self.editNotification(notification: notificationsArray[indexPath.row])
        }
    }
    
}
