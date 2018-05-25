//
//  TitleDepartmentTableViewCell.swift
//  SWSApp
//
//  Created by manu.a.gupta on 25/05/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class TitleDepartmentTableViewCell: UITableViewCell {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var departmentTextField: UITextField!
    var contactDetail: Contact?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customizedUI()
    }
    
    func customizedUI(){
        titleTextField.addPaddingLeft(10)
        departmentTextField.addPaddingLeft(10)
    }
    
    func displayCellContent(){
        if let title = contactDetail?.title, title != "" {
            titleTextField.text =  title
        }
        
        if let department = contactDetail?.department, department != "" {
            departmentTextField.text = department
        }
    }
}

extension TitleDepartmentTableViewCell: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        CreateNewContactViewController.createNewGlobals.userInput = true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        contactDetail?.title = titleTextField.text!
        contactDetail?.department = departmentTextField.text!
    }
}
