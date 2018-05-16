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
    var pickerOption = [[String:Any]]()
    var selectedPrimaryFunctionOption  = [String:Any]()
    var contactDetail: Contact?
    var buyingPower: Bool = true
    var pickerOptionBuyingPower = [[String:Any]]()
    var pickerOptionNoBuyingPower = [[String:Any]]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customizedUI()
    }
    
    func customizedUI(){
        primaryFunctionTextField.addPaddingLeft(10)
        titleTextField.addPaddingLeft(10)
        departmentTextField.addPaddingLeft(10)
        let dropdownButton : UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 30))
        dropdownButton.setImage(#imageLiteral(resourceName: "dropDownLight"), for: .normal)
        primaryFunctionTextField.rightView = dropdownButton
        primaryFunctionTextField.rightViewMode = .always
        addPickerView(textField: primaryFunctionTextField)
        
        let opts = PlistMap.sharedInstance.readPList(plist: "/ContactRoles.plist")
        
        //filter picker options with respect to buying power
        for opt in opts {
            let option = opt as! Dictionary<String, Any>
            if option["validFor"] as! Int == 1 {
                pickerOptionBuyingPower.append(option)
            }
            else if option["validFor"] as! Int == 0 {
                pickerOptionNoBuyingPower.append(option)
            }
        }
        
        if buyingPower {
            pickerOption = pickerOptionBuyingPower
        }
        else {
            pickerOption = pickerOptionNoBuyingPower
        }
    }
    
    func setBuyingPower(value: Bool) {
        if buyingPower != value { //if switching true/false, clear the textfield
            primaryFunctionTextField.text = ""
            selectedPrimaryFunctionOption  = [String:Any]()
        }
        
        buyingPower = value
        
        if buyingPower {
            pickerOption = pickerOptionBuyingPower
        }
        else {
            pickerOption = pickerOptionNoBuyingPower
        }
    }
    
    func displayCellContent(){
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
        if !selectedPrimaryFunctionOption.isEmpty {
            primaryFunctionTextField.text = selectedPrimaryFunctionOption["value"] as? String
        }else{
            if pickerOption.count > 0 {
                selectedPrimaryFunctionOption = pickerOption[0] as [String:Any]
                primaryFunctionTextField.text = selectedPrimaryFunctionOption["value"] as? String
            }
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
        let opt = pickerOption[row] as [String:Any]
        let value = opt["value"] as! String
        return value
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let opt = pickerOption[row] as [String:Any]
        selectedPrimaryFunctionOption = opt
    }
}

extension PrimaryFunctionTableViewCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        CreateNewContactViewController.createNewGlobals.userInput = true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        contactDetail?.functionRole = primaryFunctionTextField.text!
        contactDetail?.title = titleTextField.text!
        contactDetail?.department = departmentTextField.text!
    }
}
