//
//  DateFieldTableViewCell.swift
//  SWSApp
//
//  Created by manu.a.gupta on 26/04/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class DateFieldTableViewCell: UITableViewCell {

    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var dateTextfield: CustomUITextField!
    @IBOutlet weak var dateTextFieldContainerView: UIView!
    var selectedDate = NSDate()
    var contactDetail: Contact?
    let datePickerView:UIDatePicker = UIDatePicker()
    var actionItem: ActionItem?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customUI()
    }

    func customUI() {
        dateTextfield.addPaddingLeft(10)
        dateTextfield.delegate = self
        addToolbar(textField: dateTextfield)
        datePickerView.datePickerMode = UIDatePickerMode.date
        dateTextfield.inputView = datePickerView
    }
    
    func displayCellContent(){
        if dateTextfield.tag == 1{
            dateTextfield.text = DateTimeUtility.convertUtcDatetoReadableDateString(dateString:  contactDetail?.birthDate)
                //DateTimeUtility.convertUtcDatetoReadableDateOnlyDate(dateStringfromAccountNotes:  contactDetail?.birthDate)
        }else{
            dateTextfield.text = DateTimeUtility.convertUtcDatetoReadableDateString(dateString:  contactDetail?.anniversary)
                //DateTimeUtility.convertUtcDatetoReadableDateOnlyDate(dateStringfromAccountNotes: contactDetail?.anniversary)
        }
    }
    
    @objc func datePickerValueChanged(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let dateString = dateFormatter.string(from: sender.date)
        dateTextfield.text = dateString
    }
    
    func addToolbar(textField: UITextField){        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.cancelPicker))
        
        toolBar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        textField.inputAccessoryView = toolBar
    }
    
    @objc func donePicker(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let dateString = dateFormatter.string(from: datePickerView.date)
//        let date = dateFormatter.date(from: dateString)
//        dateFormatter.dateFormat = "yyyy-MM-dd"
//        dateTextfield.text = dateFormatter.string(from: dateString)
        dateTextfield.text = dateString
        dateTextfield.resignFirstResponder()
    }
    
    @objc func cancelPicker(){
        dateTextfield.resignFirstResponder()
    }
}

extension DateFieldTableViewCell: UITextFieldDelegate {    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        CreateNewContactViewController.createNewGlobals.userInput = true
        CreateNewActionItemViewController.createActionItemsGlobals.userInput = true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.tag == 1{
            contactDetail?.birthDate = textField.text!
        }else {
            contactDetail?.anniversary = textField.text!
        }
        
        if let item = actionItem {
            actionItem?.activityDate = textField.text!
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}
