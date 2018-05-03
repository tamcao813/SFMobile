//
//  PrimaryFunctionTableViewCell.swift
//  SWSApp
//
//  Created by manu.a.gupta on 26/04/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class PrimaryFunctionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var primaryFunctionTextField: CustomUITextField!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var departmentTextField: UITextField!
    var pickerOption = [PlistOption]()
    var selectedPrimaryFunctionOption : PlistOption!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customizedUI()
    }
    
    func customizedUI(){
        let opts = PlistMap.sharedInstance.getPicklist(fieldname: "ContactRoles")
        pickerOption = opts
        primaryFunctionTextField.addPaddingLeft(10)
        titleTextField.addPaddingLeft(10)
        departmentTextField.addPaddingLeft(10)
        let dropdownButton : UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 30))
        dropdownButton.setImage(#imageLiteral(resourceName: "dropDownLight"), for: .normal)
        primaryFunctionTextField.rightView = dropdownButton
        primaryFunctionTextField.rightViewMode = .always
        addPickerView(textField: primaryFunctionTextField)
    }
    
    func displayCellContent(contactDetail: Contact?){
        if let title = contactDetail?.title, title != "" {
            titleTextField.text =  title
        }
        
        if let department = contactDetail?.department, department != "" {
            departmentTextField.text = department
        }
        
        if let role = contactDetail?.functionRole, role != "" {
            primaryFunctionTextField.text = role
        }
    }
    
    func addPickerView(textField: UITextField){
        let pickerView = UIPickerView()
        pickerView.backgroundColor = .white
        pickerView.delegate = self
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.cancelPicker))
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        textField.inputView = pickerView
        textField.inputAccessoryView = toolBar
    }
    
    @objc func donePicker(){
        if let selectedValue = selectedPrimaryFunctionOption {
            primaryFunctionTextField.text = selectedValue.value
        }
        primaryFunctionTextField.resignFirstResponder()
    }
    
    @objc func cancelPicker(){
        primaryFunctionTextField.resignFirstResponder()
    }
}

extension PrimaryFunctionTableViewCell: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerOption.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerOption[row].value
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedPrimaryFunctionOption = pickerOption[row]
    }
}

extension PrimaryFunctionTableViewCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}
