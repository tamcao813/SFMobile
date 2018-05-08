//
//  ScheduleAppointmentTableViewCell.swift
//  SWSApp
//
//  Created by manu.a.gupta on 09/05/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class ScheduleAppointmentTableViewCell: UITableViewCell {
    
    @IBOutlet var schedulerComponentView: SchedulerComponent!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func validatefields() -> Array<Bool> {
        var validate: Bool = false
        var validateArray: [Bool] = []
        for subviews in schedulerComponentView.subviews{
            if let textField = subviews as? DesignableUITextField {
                if (textField.text?.isEmpty)! {
                    textField.layer.borderWidth = 2.0
                    textField.borderColor = UIColor.red
                    validate = false
                    validateArray.append(validate)
                } else {
                    textField.layer.borderWidth = 1.0
                    textField.borderColor = UIColor(red: 204/255.0, green: 204/255.0, blue: 204/255.0, alpha: 1.0)
                    validate = true
                    validateArray.append(validate)
                }
            }
        }
        return validateArray
    }

}

extension ScheduleAppointmentTableViewCell: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        CreateNewVisitViewController.createNewVisitViewControllerGlobals.userInput = true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}
