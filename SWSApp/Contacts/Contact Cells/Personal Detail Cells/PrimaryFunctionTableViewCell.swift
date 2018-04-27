//
//  PrimaryFunctionTableViewCell.swift
//  SWSApp
//
//  Created by manu.a.gupta on 26/04/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class PrimaryFunctionTableViewCell: UITableViewCell {

    @IBOutlet weak var primaryFunctionTextField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var departmentTextField: UITextField!
    var pickOption = ["one", "two", "three", "seven", "fifteen"]
    
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
        let pickerView = CustomPicker().customPickerView(textField: primaryFunctionTextField)
        pickerView.delegate = self
    }
}

extension PrimaryFunctionTableViewCell: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickOption.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickOption[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        primaryFunctionTextField.text = pickOption[row]
    }
}

extension PrimaryFunctionTableViewCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}
