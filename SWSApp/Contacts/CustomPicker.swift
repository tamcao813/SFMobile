//
//  CustomPicker.swift
//  SWSApp
//
//  Created by manu.a.gupta on 27/04/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation
import UIKit

class CustomPicker {
    
    func customPickerView(textField: UITextField) -> UIPickerView{
        let pickerView = UIPickerView()
        pickerView.backgroundColor = .white
        textField.inputView = pickerView
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.donePicker(_:)))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.donePicker(_:)))
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
        
        return pickerView
    }
    
    @objc func donePicker(_ sender: UITextField){
        
    }
    
    @objc func cancelPicker(_ sender: UITextField){
        
    }
    
    
}
