//
//  DropdownTableViewCell.swift
//  SWSApp
//
//  Created by manu.a.gupta on 26/04/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class DropdownTableViewCell: UITableViewCell {

    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var dropdownTextfield: UITextField!
    var pickOption = ["one", "two", "three", "seven", "fifteen"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customUI()
    }
    
    func customUI() {
        dropdownTextfield.addPaddingLeft(10)
        let dropdownButton : UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 30))
        dropdownButton.setImage(#imageLiteral(resourceName: "dropDownLight"), for: .normal)
        dropdownTextfield.rightView = dropdownButton
        dropdownTextfield.rightViewMode = .always
        let pickerView = CustomPicker().customPickerView(textField: dropdownTextfield)
        pickerView.delegate = self
    }
    
}

extension DropdownTableViewCell: UIPickerViewDelegate, UIPickerViewDataSource {
    
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
        dropdownTextfield.text = pickOption[row]
    }
}

extension DropdownTableViewCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}


