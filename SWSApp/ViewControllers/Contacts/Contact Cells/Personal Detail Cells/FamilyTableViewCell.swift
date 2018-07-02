//
//  FamilyTableViewCell.swift
//  SWSApp
//
//  Created by manu.a.gupta on 26/04/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class FamilyTableViewCell: UITableViewCell {

    @IBOutlet weak var familyLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var dateTextField: CustomUITextField!
    @IBOutlet weak var familyLabelHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var nameLabelHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var dateLabelHeightConstraint: NSLayoutConstraint!
    var contactDetail: Contact?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customizedUI()
    }
    
    func customizedUI(){
        dateTextField.addPaddingLeft(10)
        nameTextField.addPaddingLeft(10)
        assignDatePicker()
        addToolbar(textField: dateTextField)
    }
    
    func displayCellContent(){
        if nameTextField.tag == 1 || dateTextField.tag == 1{
            nameTextField.text! = (contactDetail?.child1Name)!
            dateTextField.text! = (contactDetail?.child1Birthday)!
        }else if nameTextField.tag == 2 || dateTextField.tag == 2 {
            nameTextField.text! = (contactDetail?.child2Name)!
            dateTextField.text! = (contactDetail?.child2Birthday)!
        }else if nameTextField.tag == 3 || dateTextField.tag == 3{
            nameTextField.text! = (contactDetail?.child3Name)!
            dateTextField.text! = (contactDetail?.child3Birthday)!
        }else if nameTextField.tag == 4 || dateTextField.tag == 4{
            nameTextField.text! = (contactDetail?.child4Name)!
            dateTextField.text! = (contactDetail?.child4Birthday)!
        }else{
            nameTextField.text! = (contactDetail?.child5Name)!
            dateTextField.text! = (contactDetail?.child5Birthday)!
        }
    }
    
    func assignDatePicker(){
        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.date
        dateTextField.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(self.datePickerValueChanged), for: UIControlEvents.valueChanged)
    }
    
    @objc func datePickerValueChanged(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let dateString = dateFormatter.string(from: sender.date)
        let date = dateFormatter.date(from: dateString)
        dateTextField.text = dateFormatter.string(from: date!)
    }
    
    func addToolbar(textField: UITextField){
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([spaceButton,doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        textField.inputAccessoryView = toolBar
    }
    
    @objc func donePicker(){
        dateTextField.resignFirstResponder()
        if dateTextField.tag == 1 {
            contactDetail?.child1Birthday = dateTextField.text!
        }else if dateTextField.tag == 2 {
            contactDetail?.child3Birthday = dateTextField.text!
        }else if dateTextField.tag == 3 {
            contactDetail?.child3Birthday = dateTextField.text!
        }else if dateTextField.tag == 4{
            contactDetail?.child4Birthday = dateTextField.text!
        }else{
            contactDetail?.child5Birthday = dateTextField.text!
        }
    }
}

extension FamilyTableViewCell: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == dateTextField{
            let datePickerView:UIDatePicker = UIDatePicker()
            datePickerView.datePickerMode = UIDatePickerMode.date
            textField.inputView = datePickerView
            datePickerView.addTarget(self, action: #selector(self.datePickerValueChanged), for: UIControlEvents.valueChanged)
        }
        CreateNewContactViewController.createNewGlobals.userInput = true        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        if textField.tag == 1 {
            contactDetail?.child1Name = nameTextField.text!
            contactDetail?.child1Birthday = dateTextField.text!
        }else if textField.tag == 2 {
            contactDetail?.child2Name = nameTextField.text!
            contactDetail?.child2Birthday = dateTextField.text!
        }else if textField.tag == 3 {
            contactDetail?.child3Name = nameTextField.text!
            contactDetail?.child3Birthday = dateTextField.text!
        }else if textField.tag == 4{
            contactDetail?.child4Name = nameTextField.text!
            contactDetail?.child4Birthday = dateTextField.text!
        }else{
            contactDetail?.child5Name = nameTextField.text!
            contactDetail?.child5Birthday = dateTextField.text!
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return AlertUtilities.disableEmojis(text: string)
    }
}

