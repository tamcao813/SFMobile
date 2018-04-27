//
//  AccountVisitListViewController.swift
//  SWSApp
//
//  Created by Krishna, Kamya on 4/23/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class AccountVisitListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var accountVisitArray = [
        ["title" : "Visit: Crown Liquor Store One", "status" : "Scheduled"],
        ["title" : "Visit: Crown Liquor Store One", "status" : "In Progress"],
        ["title" : "Visit: Crown Liquor Store One", "status" : "Completed"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizedUI()
        initializingXIBs()
    }

    func customizedUI(){
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        self.tableView.estimatedRowHeight = 100
        self.tableView.tableFooterView = UIView()
    }
    
    func initializingXIBs(){
        self.tableView.register(UINib(nibName: "AccountVisitListTableViewCell", bundle: nil), forCellReuseIdentifier: "AccountVisitListTableViewCell")
    }
    
    @IBAction func newVisitButtonTapped(_ sender: UIButton){
        let storyboard = UIStoryboard(name: "PlanVisitEditableScreen", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier :"PlanVisitViewControllerID")
        viewController.modalPresentationStyle = .overCurrentContext
        self.present(viewController, animated: true)
    }

}

extension AccountVisitListViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accountVisitArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccountVisitListTableViewCell") as? AccountVisitListTableViewCell
        cell?.addressLabel.text = accountVisitArray[indexPath.row]["title"]
        cell?.visitStatusLabel.text = accountVisitArray[indexPath.row]["status"]
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let accountStoryboard = UIStoryboard.init(name: "AccountVisit", bundle: nil)
        let accountVisitsVC = accountStoryboard.instantiateViewController(withIdentifier: "AccountVisitSummaryViewController") as? AccountVisitSummaryViewController
        if accountVisitArray[indexPath.row]["status"] == "Scheduled"{
            accountVisitsVC?.visitStatus = .scheduled
        }else if accountVisitArray[indexPath.row]["status"] == "Completed"{
            accountVisitsVC?.visitStatus = .completed
        }else {
            accountVisitsVC?.visitStatus = .inProgress
        }
        accountVisitsVC?.modalPresentationStyle = .overCurrentContext
        present(accountVisitsVC!, animated: true, completion: nil)
    }
}

enum AccountVisitStatus : String {
    case scheduled
    case inProgress
    case completed
}
