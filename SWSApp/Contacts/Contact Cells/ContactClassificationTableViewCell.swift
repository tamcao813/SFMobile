//
//  ContactClassificationTableViewCell.swift
//  SWSApp
//
//  Created by manu.a.gupta on 26/04/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class ContactClassificationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var classificationTextField: UITextField!
    @IBOutlet weak var otherTextField: UITextField!
    var pickOption = ["one", "two", "three", "seven", "fifteen"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customized()
    }
    
    func customized(){
        classificationTextField.addPaddingLeft(10)
        otherTextField.addPaddingLeft(10)
        let dropdownButton : UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 30))
        dropdownButton.setImage(#imageLiteral(resourceName: "dropDownLight"), for: .normal)
        classificationTextField.rightView = dropdownButton
        classificationTextField.rightViewMode = .always
        customizePicker()
    }
    
    func customizePicker(){
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.backgroundColor = .white
        classificationTextField.inputView = pickerView
    }
    
}

extension ContactClassificationTableViewCell: UIPickerViewDelegate, UIPickerViewDataSource {
    
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
        classificationTextField.text = pickOption[row]
    }
}

extension ContactClassificationTableViewCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}
