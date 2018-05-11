//
//  CreateNewActionItemViewController.swift
//  SWSApp
//
//  Created by manu.a.gupta on 11/05/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit
import DropDown

class CreateNewActionItemViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var screenHeaderLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    var accountDropDown: DropDown?
    var selectedAccount: Account?
    var actionItemId: String?
    var actionItemDescriptionTextView: UITextView!
    var actionTitleTextField: UITextField!
    var searchAccountTextField: UITextField!
    var dueDateTextField: UITextField!
    var isEditingMode = false
    struct createActionItemsGlobals {
        static var userInput = false
    }
    @IBOutlet weak var saveView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizedUI()
    }
    
    func customizedUI(){
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        self.tableView.estimatedRowHeight = 100
        self.tableView.tableFooterView = UIView()
        saveView.dropShadow()
        initializeNibs()
    }
    
    func initializeNibs(){
        self.tableView.register(UINib(nibName: "ActionItemTitleTableViewCell", bundle: nil), forCellReuseIdentifier: "ActionItemTitleTableViewCell")
        self.tableView.register(UINib(nibName: "SearchAccountTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchAccountTableViewCell")
        self.tableView.register(UINib(nibName: "AccountContactLinkTableViewCell", bundle: nil), forCellReuseIdentifier: "DropDownCell")
        self.tableView.register(UINib(nibName: "DescriptionTableViewCell", bundle: nil), forCellReuseIdentifier: "DescriptionTableViewCell")
        self.tableView.register(UINib(nibName: "IsItUrgentTableViewCell", bundle: nil), forCellReuseIdentifier: "IsItUrgentTableViewCell")
        self.tableView.register(UINib(nibName: "DateFieldTableViewCell", bundle: nil), forCellReuseIdentifier: "DateFieldTableViewCell")        
    }
    
    
    @IBAction func closeButtonTapped(_ sender: UIButton){
        self.view.endEditing(true)
        if let dropdown = accountDropDown{
            dropdown.hide()
        }
        DispatchQueue.main.async {
            if  createActionItemsGlobals.userInput {
                AlertUtilities.showAlertMessageWithTwoActionsAndHandler("Any changes will not be saved", errorMessage: "Are you sure you want to close?", errorAlertActionTitle: "Yes", errorAlertActionTitle2: "No", viewControllerUsed: self, action1: {
                    createActionItemsGlobals.userInput = false
                    self.dismiss(animated: true, completion: nil)
                }){}
            }else{
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func saveAndCloseButtonTapped(_ sender: UIButton){
        
        if (actionTitleTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)!  {
            actionTitleTextField.borderColor = .red
            actionTitleTextField.becomeFirstResponder()
            tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            errorLabel.text = StringConstants.emptyFieldError
            return
        }else if selectedAccount != nil {
            searchAccountTextField.borderColor = .red
            tableView.scrollToRow(at: IndexPath(row: 0, section: 1), at: .top, animated: true)
            errorLabel.text = StringConstants.emptyFieldError
            return
        }else if actionItemDescriptionTextView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty{
            actionItemDescriptionTextView.borderColor = .red
            tableView.scrollToRow(at: IndexPath(row: 0, section: 3), at: .top, animated: true)
            errorLabel.text = StringConstants.emptyFieldError
            return
        }else if (dueDateTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)! {
            dueDateTextField.borderColor = .red
            tableView.scrollToRow(at: IndexPath(row: 0, section: 4), at: .top, animated: true)
            errorLabel.text = StringConstants.emptyFieldError
            return
        }
        print("Creating Action Item")
    }

}

extension CreateNewActionItemViewController : UITableViewDelegate, UITableViewDataSource {    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 2{
            if selectedAccount != nil{
                return 1
            }else{
                return 0
            }
        }else{
            return 1
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ActionItemTitleTableViewCell") as? ActionItemTitleTableViewCell
            actionTitleTextField = cell?.actionTitleTextField
            return cell!
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SearchAccountTableViewCell") as? SearchAccountTableViewCell
            searchAccountTextField = cell?.searchContactTextField
            accountDropDown = cell?.accountsDropDown
            cell?.delegate = self
            return cell!
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DropDownCell") as? AccountContactLinkTableViewCell
            cell?.containerTrailingConstraint.constant = 40
            cell?.containerLeadingConstraint.constant = 40
            cell?.delegate = self
            if let account = selectedAccount {
                cell?.displayCellContent(account: account)
            }
            return cell!
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionTableViewCell") as? DescriptionTableViewCell
            cell?.headerLabel.text = "Action Item Description*"
            actionItemDescriptionTextView = cell?.descriptionTextView
//            cell?.displayCellContent()
            return cell!
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "IsItUrgentTableViewCell") as? IsItUrgentTableViewCell
            return cell!
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DateFieldTableViewCell") as? DateFieldTableViewCell
            dueDateTextField = cell?.dateTextfield
            cell?.headerLabel.text = "Due Date"
            return cell!
        default:
            return UITableViewCell()
        }
    }
}

extension CreateNewActionItemViewController: SearchAccountTableViewCellDelegate {
    func accountSelected(account : Account) {
        selectedAccount = account
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension CreateNewActionItemViewController: AccountContactLinkTableViewCellDelegate {
    func removeAccount() {
        selectedAccount = nil
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
