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
    var selectedDate = NSDate()
    var contactDetail: Contact?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customUI()
    }

    func customUI() {
        dateTextfield.addPaddingLeft(10)
        dateTextfield.delegate = self
        addToolbar(textField: dateTextfield)
    }
    
    func displayCellContent(){
        if dateTextfield.tag == 1{
            dateTextfield.text = contactDetail?.birthDate
        }else{
            dateTextfield.text = contactDetail?.anniversary
        }
        
    }
    
    @objc func datePickerValueChanged(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM-dd-yyyy"
        let dateString = dateFormatter.string(from: sender.date)
        let date = dateFormatter.date(from: dateString)
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateTextfield.text = dateFormatter.string(from: date!)
    }
    
    func addToolbar(textField: UITextField){        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([spaceButton,doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        textField.inputAccessoryView = toolBar
    }
    
    @objc func donePicker(){
        dateTextfield.resignFirstResponder()
    }
}

extension DateFieldTableViewCell: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.date
        textField.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(self.datePickerValueChanged), for: UIControlEvents.valueChanged)
        if textField.tag == 1{
            contactDetail?.birthDate = textField.text!
        }else {
            contactDetail?.anniversary = textField.text!
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}
