//
//  ActionItemDetailsViewController.swift
//  SWSApp
//
//  Created by manu.a.gupta on 14/05/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class ActionItemDetailsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var actionItemStatusLabel: UILabel!
    @IBOutlet weak var footerView: UIView!
    var actionItemObject: ActionItem!
    var accountSelected: Account!

    override func viewDidLoad() {
        super.viewDidLoad()
        customizedUI()
    }
    
    func customizedUI(){
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        self.tableView.estimatedRowHeight = 100
        initializeXibs()
        footerView.dropShadow()
    }
    
    func initializeXibs(){
        self.tableView.register(UINib(nibName: "AccountContactLinkTableViewCell", bundle: nil), forCellReuseIdentifier: "DropDownCell")
    }
    
    @IBAction func closeButtonTapped(_ sender: UIButton){
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
    }
}

extension ActionItemDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ActionItemTitleDetailTableViewCell") as? ActionItemTitleDetailTableViewCell
            cell?.displayCellContent(actionItem: actionItemObject)
            return cell!
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ActionItemDescriptionTableViewCell") as? ActionItemDescriptionTableViewCell
            cell?.headerLabel.text = "Linked Account"
            return cell!
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DropDownCell") as? AccountContactLinkTableViewCell
            cell?.containerTrailingConstraint.constant = 40
            cell?.containerLeadingConstraint.constant = 20
            cell?.deleteButton.isHidden = true
            if let account = accountSelected{
                cell?.displayCellContent(account: account)
            }
            return cell!
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ActionItemDescriptionTableViewCell") as? ActionItemDescriptionTableViewCell
            cell?.headerLabel.text = "Action Item Description"
            cell?.subheaderLabel.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged."
            return cell!
        default:
            return UITableViewCell()
        }
    }
}
