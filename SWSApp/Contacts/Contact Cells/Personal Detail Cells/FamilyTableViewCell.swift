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
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var familyLabelHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var nameLabelHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var dateLabelHeightConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customizedUI()
    }
    
    func customizedUI(){
        dateTextField.addPaddingLeft(10)
        nameTextField.addPaddingLeft(10)
//        let dropdownButton : UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
//        dropdownButton.setImage(#imageLiteral(resourceName: "calendar"), for: .normal)
//        dateTextField.rightView = dropdownButton
//        dateTextField.rightViewMode = .always
        assignDatePicker()
    }
    
    func assignDatePicker(){
        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.date
        dateTextField.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(self.datePickerValueChanged), for: UIControlEvents.valueChanged)
    }
    
    @objc func datePickerValueChanged(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateTextField.text = dateFormatter.string(from: sender.date)
    }
}

extension FamilyTableViewCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}

