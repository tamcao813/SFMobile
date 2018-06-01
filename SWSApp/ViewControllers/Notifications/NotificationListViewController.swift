//
//  NotificationListViewController.swift
//  SWSApp
//
//  Created by manu.a.gupta on 31/05/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class NotificationListViewController: UIViewController {

    var notificationArray = [String]()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        customizedUI()
        getNotifications()
    }
    
    func getNotifications(){
        notificationArray = NotificationsViewModel().notificationsForUser()
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
        
    }
    
    func clearFilter() {
    
    }
    
    
//    func performFilterOperation(searchText: UISearchBar) {
//        NotificationFilterModel.filterApplied = true
        //Perform Search Operation First then do Filtering
//        applyFilter(searchText: searchText.text!)
//    }
    
//    func applyFilter(searchText: String){
//        if searchText != ""{
//            searchStr = searchText
//            filteredActionItemsArray =  ActionItemSortUtility().searchAndFilter(searchStr: searchText, actionItems: actionItemsArray)
//        }else{
//            filteredActionItemsArray = ActionItemSortUtility().filterOnly(actionItems: actionItemsArray)
//        }
//        reloadTableView()
//    }
    
//    func clearFilter(){
//        NotificationFilterModel.filterApplied = false
//        reloadTableView()
//    }
}

extension NotificationListViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notificationArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationListTableViewCell") as? NotificationListTableViewCell
        
        return cell!
    }
    
}
