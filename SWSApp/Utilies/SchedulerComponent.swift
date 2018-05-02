//
//  SchedulerComponent.swift
//  SWSApp
//
//  Created by vipin.vijay on 19/04/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class SchedulerComponent: UIView, UITextFieldDelegate {
    
    var dateTextField = DesignableUITextField()
    var startTimeTextField = DesignableUITextField()
    var endTimeTextField = DesignableUITextField()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Set UILabel size and position
        
        let dateLabel = UILabel(frame: CGRect(x: 0, y: 5, width: 100, height: 21))
        dateLabel.text = "Date of Visit"
        dateLabel.textColor = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1.0)
        dateLabel.font = UIFont(name:"Ubuntu", size: 12.0)
        self.addSubview(dateLabel)
        
        let startTimeLabel = UILabel(frame: CGRect(x: 150, y: 5, width: 100, height: 21))
        startTimeLabel.text = "Start Time"
        startTimeLabel.textColor = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1.0)
        startTimeLabel.font = UIFont(name:"Ubuntu", size: 12.0)
        self.addSubview(startTimeLabel)
        
        let endTimeLabel = UILabel(frame: CGRect(x: 270, y: 5, width: 100, height: 21))
        endTimeLabel.text = "End Time"
        endTimeLabel.textColor = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1.0)
        endTimeLabel.font = UIFont(name:"Ubuntu", size: 12.0)
        self.addSubview(endTimeLabel)
        
        // Set DesignableUITextField size and position
        
        dateTextField =  DesignableUITextField(frame: CGRect(x: 0, y: 30, width: 110, height: 30))
        dateTextField.rightImage = UIImage(named:"Calender_Icon")!
        dateTextField.rightPadding = 8
        dateTextField.placeholder = "dd-mm-yyyy"
        dateTextField.font = UIFont(name:"Ubuntu", size: 12.0)
        dateTextField.layer.borderColor = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1.0).cgColor
        dateTextField.layer.borderWidth = 1.0
        dateTextField.tag = 200
        dateTextField.borderStyle = UITextBorderStyle.roundedRect
        dateTextField.delegate = self
        self.addSubview(dateTextField)
        
        startTimeTextField =  DesignableUITextField(frame: CGRect(x: 150, y: 30, width: 100, height: 30))
        startTimeTextField.rightImage = UIImage(named:"dropDownLight")!
        startTimeTextField.rightPadding = 8
        startTimeTextField.backgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1.0)
        startTimeTextField.placeholder = "hh:mm"
        startTimeTextField.font = UIFont(name:"Ubuntu", size: 12.0)
        startTimeTextField.layer.borderColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1.0).cgColor
        startTimeTextField.tag = 201
        startTimeTextField.layer.borderWidth = 1.0
        startTimeTextField.borderStyle = UITextBorderStyle.roundedRect
        startTimeTextField.delegate = self
        self.addSubview(startTimeTextField)
        
        endTimeTextField =  DesignableUITextField(frame: CGRect(x: 270, y: 30, width: 100, height: 30))
        endTimeTextField.rightImage = UIImage(named:"dropDownLight")!
        endTimeTextField.rightPadding = 8
        endTimeTextField.backgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1.0)
        endTimeTextField.placeholder = "hh:mm"
        endTimeTextField.tag = 202
        endTimeTextField.font = UIFont(name:"Ubuntu", size: 12.0)
        endTimeTextField.layer.borderColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1.0).cgColor
        endTimeTextField.layer.borderWidth = 1.0
        endTimeTextField.borderStyle = UITextBorderStyle.roundedRect
        endTimeTextField.delegate = self
        self.addSubview(endTimeTextField)
        
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField.tag {
        case 200:
            self.dateView(textField: textField)
        case 201:
            self.timeView(textField: textField)
        case 202:
            self.timeView(textField: textField)
        default:
            print("default")
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("qweqwe")
    }
    
    // MARK - Custom Methods
    
    @objc func handleDatePicker(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM yyyy"
        dateTextField.text = dateFormatter.string(from: sender.date)
    }
    
    @objc func handleTimePicker(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        if (sender.tag == 201) {
            startTimeTextField.text = dateFormatter.string(from: sender.date)
        } else {
            endTimeTextField.text = dateFormatter.string(from: sender.date)
        }
        
    }
    
    @objc func doneButton(sender:UIButton)
    {
        self.endEditing(true)// To resign the inputView on clicking done.
    }
    
    func dateView(textField: UITextField) {
        
        let inputView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 240))
        let datePickerView = UIDatePicker()
        datePickerView.frame.origin = CGPoint(x: self.frame.width/1.2, y: 20)
        datePickerView.datePickerMode = .date
        datePickerView.addTarget(self, action: #selector(handleDatePicker(sender:)), for: .valueChanged)
        inputView.addSubview(datePickerView) // add date picker to UIView
        
        let doneButton = UIButton(frame: CGRect(x: (self.frame.size.width), y: 0, width: 100, height: 50))
        doneButton.setTitle("Done", for: UIControlState.normal)
        doneButton.setTitle("Done", for: UIControlState.highlighted)
        doneButton.setTitleColor(UIColor.black, for: UIControlState.normal)
        doneButton.setTitleColor(UIColor.gray, for: UIControlState.highlighted)
        
        inputView.addSubview(doneButton) // add Button to UIView
        
        doneButton.addTarget(self, action: #selector(doneButton(sender:)), for: UIControlEvents.touchUpInside) // set button click event
        textField.inputView = inputView
    }
    
    func timeView(textField: UITextField) {
        
        let inputView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 240))
        let datePickerView = UIDatePicker()
        datePickerView.frame.origin = CGPoint(x: self.frame.width/1.2, y: 20)
        datePickerView.datePickerMode = .time
        datePickerView.tag = textField.tag
        datePickerView.addTarget(self, action: #selector(handleTimePicker(sender:)), for: .valueChanged)
        inputView.addSubview(datePickerView) // add date picker to UIView
        
        let doneButton = UIButton(frame: CGRect(x: (self.frame.size.width), y: 0, width: 100, height: 50))
        doneButton.setTitle("Done", for: UIControlState.normal)
        doneButton.setTitle("Done", for: UIControlState.highlighted)
        doneButton.setTitleColor(UIColor.black, for: UIControlState.normal)
        doneButton.setTitleColor(UIColor.gray, for: UIControlState.highlighted)
        
        inputView.addSubview(doneButton) // add Button to UIView
        
        doneButton.addTarget(self, action: #selector(doneButton(sender:)), for: UIControlEvents.touchUpInside) // set button click event
        textField.inputView = inputView
    }
    
}
