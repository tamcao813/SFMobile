//
//  DuringVisitNotificationModalviewController.swift
//  SWSApp
//
//  Created by Jagadeeshwar Reddy on 22/06/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation
import SmartSync

protocol NavigateToDuringVisitViewController {
    func navigateNotificationToDuringVisitVC()
}

class DuringVisitNotificationModalviewController:UIViewController{
    
    //outlets
    @IBOutlet weak var bgView: UIView!
    var notificationsArray = [Notifications]()
    var notificationArrayToDisplay = [Notifications]()
    
    //MARK:- View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        bgView.backgroundColor = UIColor.white
        bgView.layer.shadowColor = UIColor.lightGray.cgColor
        bgView.layer.shadowOpacity = 1
        bgView.layer.shadowOffset = CGSize.zero
        bgView.layer.shadowRadius = 5
        getNotifications()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    func getNotifications(){
        //creating notifications array according to accountId
        let accountId = PlanVisitManager.sharedInstance.visit?.accountId
        notificationsArray = [Notifications]()
        notificationsArray = NotificationsViewModel().notificationsForUser()
        notificationArrayToDisplay = notificationsArray.filter( { return $0.account == accountId } )
    }
    
    var delegate : NavigateToDuringVisitViewController?
    
    //MARK:- IBActions
    //close button
    @IBAction func closeButtonClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    //View All notifications button
    @IBAction func viewAllNotificationButtonClicked(_ sender: UIButton) {
        DispatchQueue.main.async {
            AlertUtilities.showAlertMessageWithTwoActionsAndHandler("Any changes will not be saved", errorMessage: "Are you sure you want to close?", errorAlertActionTitle: "Yes", errorAlertActionTitle2: "No", viewControllerUsed: self, action1: {
                
                // NotificationCenter.default.post(name: NSNotification.Name(rawValue: "goToAllActionItem/Notification"), object:4)
                
                self.dismiss(animated: false, completion: {
                    self.delegate?.navigateNotificationToDuringVisitVC()
                })
               
                //LoadThePersistantMenuScreenItem.loadItemScreen = 2
                //self.performSegue(withIdentifier: "unwindToNotificationSegue", sender: nil)
                
            }) {
                
            }
        }
    }
}

//MARK:- Delegate and DataSource methods
extension DuringVisitNotificationModalviewController:UITableViewDataSource,UITableViewDelegate{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notificationArrayToDisplay.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notificationModalID", for: indexPath) as! NotificationModalTableViewCell
        cell.selectionStyle = .none
        let notification = notificationArrayToDisplay[indexPath.row]
        cell.notificationLbl?.text = notification.sgwsContactBirthdayNotification

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
}
