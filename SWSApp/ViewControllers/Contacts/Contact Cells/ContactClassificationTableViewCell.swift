//
//  ContactClassificationTableViewCell.swift
//  SWSApp
//
//  Created by manu.a.gupta on 26/04/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class ContactClassificationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var classificationTextField: CustomUITextField!
    @IBOutlet weak var otherTextField: UITextField!
    var pickerOption = [[String:Any]]()
    var selectedOption  = [String:Any]()
    var buyingPower: Bool = true
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customized()
    }
    
    func displayCellContents(){
        let classificationOpts = PlistMap.sharedInstance.readPList(plist: "/ContactClassification.plist")
        
        pickerOption = classificationOpts as! [[String : Any]]
    }
    
    func customized(){
        otherTextField.isHidden = true
        classificationTextField.addPaddingLeft(10)
        otherTextField.addPaddingLeft(10)
        let dropdownButton : UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 30))
        dropdownButton.setImage(#imageLiteral(resourceName: "dropDownLight"), for: .normal)
        classificationTextField.rightView = dropdownButton
        classificationTextField.rightViewMode = .always
        self.addPickerView(textField: classificationTextField)
    }
//    
//    func setBuyingPower(value: Bool) {
//        if buyingPower != value { //if switching to true, clear the textfield
//            classificationTextField.text = ""
//            otherTextField.text = ""
//        }
//        
//        buyingPower = value
//    }
    
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
        if selectedOption.isEmpty {
            if pickerOption.count > 0{
                selectedOption = pickerOption[0]
            }
        }
        let value = selectedOption["value"] as! String
        classificationTextField.text = value
        classificationTextField.resignFirstResponder()
        if value == "Other" {
            otherTextField.isHidden = false
        }else{
            otherTextField.isHidden = true
            otherTextField.text = ""
        }
        
    }
    
    @objc func cancelPicker(){
        classificationTextField.resignFirstResponder()
    }
}

extension ContactClassificationTableViewCell: UIPickerViewDelegate, UIPickerViewDataSource {
    
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
        if pickerOption.count > 0 {
            let opt = pickerOption[row] as [String:Any]
            selectedOption = opt
        }
    }
}

extension ContactClassificationTableViewCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        CreateNewContactViewController.createNewGlobals.userInput = true
    }
}
