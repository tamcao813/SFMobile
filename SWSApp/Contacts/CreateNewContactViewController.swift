//
//  CreateNewContactViewController.swift
//  SWSApp
//
//  Created by Krishna, Kamya on 4/25/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class CreateNewContactViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var firstNameTextField: UITextField!
    var lastNameTextField: UITextField!
    var preferredNameTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizedUI()
        initializingXIBs()
    }
    
    func customizedUI(){
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        self.tableView.estimatedRowHeight = 100
    }
    
    func initializingXIBs(){
        self.tableView.register(UINib(nibName: "ToggleTableViewCell", bundle: nil), forCellReuseIdentifier: "ToggleTableViewCell")
        
        self.tableView.register(UINib(nibName: "ContactClassificationTableViewCell", bundle: nil), forCellReuseIdentifier: "ContactClassificationTableViewCell")
        
        self.tableView.register(UINib(nibName: "NameTableViewCell", bundle: nil), forCellReuseIdentifier: "NameTableViewCell")
        
        self.tableView.register(UINib(nibName: "PrimaryFunctionTableViewCell", bundle: nil), forCellReuseIdentifier: "PrimaryFunctionTableViewCell")
        
        self.tableView.register(UINib(nibName: "PhoneTableViewCell", bundle: nil), forCellReuseIdentifier: "PhoneTableViewCell")
        
        self.tableView.register(UINib(nibName: "EmailTableViewCell", bundle: nil), forCellReuseIdentifier: "EmailTableViewCell")
        
        self.tableView.register(UINib(nibName: "ContactHoursTableViewCell", bundle: nil), forCellReuseIdentifier: "ContactHoursTableViewCell")
        
        self.tableView.register(UINib(nibName: "DescriptionTableViewCell", bundle: nil), forCellReuseIdentifier: "DescriptionTableViewCell")
        
        self.tableView.register(UINib(nibName: "DropdownTableViewCell", bundle: nil), forCellReuseIdentifier: "DropdownTableViewCell")
        
        self.tableView.register(UINib(nibName: "DateFieldTableViewCell", bundle: nil), forCellReuseIdentifier: "DateFieldTableViewCell")
        
        self.tableView.register(UINib(nibName: "FamilyTableViewCell", bundle: nil), forCellReuseIdentifier: "FamilyTableViewCell")
    }
    
    @IBAction func closeButtonTapped(_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton){
//        var showAlert = false
        
        if (firstNameTextField.text?.isEmpty)! || (lastNameTextField.text?.isEmpty)! {
            firstNameTextField.borderColor = .red
            tableView.scrollToRow(at: IndexPath(row: 0, section: 1), at: .top, animated: true)
//            showAlert = true
            firstNameTextField.shake()
        }else{
//            showAlert = false
           firstNameTextField.borderColor = .lightGray
        }
        
//        if showAlert {
//            let alertController = UIAlertController(title: "Alert", message:
//                "Please enter required fields", preferredStyle: UIAlertControllerStyle.alert)
//            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default,handler: nil))
//            self.present(alertController, animated: true, completion: nil)
//        }
    }

}

extension CreateNewContactViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 3
        case 1:
            return 9
        case 2:
            return 8
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "ToggleTableViewCell") as? ToggleTableViewCell
                return cell!
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "ToggleTableViewCell") as? ToggleTableViewCell
                return cell!
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: "ContactClassificationTableViewCell") as? ContactClassificationTableViewCell
                return cell!
            default:
                return UITableViewCell()
            }
        case 1:
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "NameTableViewCell") as? NameTableViewCell
                firstNameTextField = cell?.firstNameTextField
                lastNameTextField = cell?.lastNameTextField
                return cell!
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "PrimaryFunctionTableViewCell") as? PrimaryFunctionTableViewCell
                return cell!
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: "PhoneTableViewCell") as? PhoneTableViewCell
                return cell!
            case 3:
                let cell = tableView.dequeueReusableCell(withIdentifier: "EmailTableViewCell") as? EmailTableViewCell
                return cell!
            case 4:
                let cell = tableView.dequeueReusableCell(withIdentifier: "ContactHoursTableViewCell") as? ContactHoursTableViewCell
                return cell!
            case 5:
                let cell = tableView.dequeueReusableCell(withIdentifier: "DropdownTableViewCell") as? DropdownTableViewCell
                return cell!
            case 6:
                let cell = tableView.dequeueReusableCell(withIdentifier: "DateFieldTableViewCell") as? DateFieldTableViewCell
                cell?.headerLabel.text = "Birthday"
                return cell!
            case 7:
                let cell = tableView.dequeueReusableCell(withIdentifier: "DateFieldTableViewCell") as? DateFieldTableViewCell
                cell?.headerLabel.text = "Anniversary"
                return cell!
            default:
                return UITableViewCell()
            }
        case 2:
            switch indexPath.row {
            case 0 ... 4:
                let cell = tableView.dequeueReusableCell(withIdentifier: "FamilyTableViewCell") as? FamilyTableViewCell
                if indexPath.row != 0{
                    cell?.familyLabelHeightConstraint.constant = 0
                    cell?.dateLabelHeightConstraint.constant = 0
                    cell?.nameLabelHeightConstraint.constant = 0
                }
                return cell!
            case 5:
                let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionTableViewCell") as? DescriptionTableViewCell
                cell?.headerLabel.text = "Likes"
                return cell!
            case 6:
                let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionTableViewCell") as? DescriptionTableViewCell
                cell?.headerLabel.text = "Dislikes"
                return cell!
            case 7:
                let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionTableViewCell") as? DescriptionTableViewCell
                cell?.headerLabel.text = "Notes"
                return cell!
            default:
                return UITableViewCell()
            }
        default:
            return UITableViewCell()
        }
    }
}
