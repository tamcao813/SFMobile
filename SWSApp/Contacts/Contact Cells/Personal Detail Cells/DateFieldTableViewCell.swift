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
    @IBOutlet weak var dateTextfield: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customUI()
    }

    func customUI() {
        dateTextfield.addPaddingLeft(10)
        dateTextfield.delegate = self
//        let dropdownButton : UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
//        dropdownButton.setImage(#imageLiteral(resourceName: "calendar"), for: .normal)
//        dateTextfield.rightView = dropdownButton
//        dateTextfield.rightViewMode = .always
//        customizePicker()
    }
    
    @objc func datePickerValueChanged(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateTextfield.text = dateFormatter.string(from: sender.date)
    }
}

extension DateFieldTableViewCell: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.date
        textField.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(self.datePickerValueChanged), for: UIControlEvents.valueChanged)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}
