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
        
        let startTimeLabel = UILabel(frame: CGRect(x: 140, y: 5, width: 100, height: 21))
        startTimeLabel.text = "Start Time"
        startTimeLabel.textColor = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1.0)
        startTimeLabel.font = UIFont(name:"Ubuntu", size: 12.0)
        self.addSubview(startTimeLabel)
        
        let endTimeLabel = UILabel(frame: CGRect(x: 260, y: 5, width: 100, height: 21))
        endTimeLabel.text = "End Time"
        endTimeLabel.textColor = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1.0)
        endTimeLabel.font = UIFont(name:"Ubuntu", size: 12.0)
        self.addSubview(endTimeLabel)
        
        // Set DesignableUITextField size and position
        
        dateTextField =  DesignableUITextField(frame: CGRect(x: 0, y: 30, width: 100, height: 30))
        dateTextField.rightImage = UIImage(named:"dropDown")!
        dateTextField.rightPadding = 8
        dateTextField.text = "22-12-1967"
        dateTextField.font = UIFont(name:"Ubuntu", size: 12.0)
        dateTextField.layer.borderColor = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1.0).cgColor
        dateTextField.layer.borderWidth = 1.0
        dateTextField.tag = 200
        dateTextField.borderStyle = UITextBorderStyle.roundedRect
        dateTextField.delegate = self
        self.addSubview(dateTextField)
        
        startTimeTextField =  DesignableUITextField(frame: CGRect(x: 140, y: 30, width: 100, height: 30))
        startTimeTextField.rightImage = UIImage(named:"dropDown")!
        startTimeTextField.rightPadding = 8
        startTimeTextField.backgroundColor = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1.0)
        startTimeTextField.text = "9:30 AM"
        startTimeTextField.font = UIFont(name:"Ubuntu", size: 12.0)
        startTimeTextField.layer.borderColor = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1.0).cgColor
        startTimeTextField.tag = 201
        startTimeTextField.layer.borderWidth = 1.0
        startTimeTextField.borderStyle = UITextBorderStyle.roundedRect
        startTimeTextField.delegate = self
        self.addSubview(startTimeTextField)
        
        endTimeTextField =  DesignableUITextField(frame: CGRect(x: 260, y: 30, width: 100, height: 30))
        endTimeTextField.rightImage = UIImage(named:"dropDown")!
        endTimeTextField.rightPadding = 8
        endTimeTextField.backgroundColor = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1.0)
        endTimeTextField.text = "10:15 AM"
        startTimeTextField.tag = 202
        endTimeTextField.font = UIFont(name:"Ubuntu", size: 12.0)
        endTimeTextField.layer.borderColor = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1.0).cgColor
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
            let inputView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 240))
            let datePickerView = UIDatePicker()
            datePickerView.frame.origin = CGPoint(x: self.frame.width/1.2, y: 10)
            datePickerView.datePickerMode = .date
            datePickerView.addTarget(self, action: #selector(handleDatePicker(sender:)), for: .valueChanged)
            inputView.addSubview(datePickerView) // add date picker to UIView
            
            let doneButton = UIButton(frame: CGRect(x: (self.frame.size.width/2), y: 0, width: 100, height: 50))
            doneButton.setTitle("Done", for: UIControlState.normal)
            doneButton.setTitle("Done", for: UIControlState.highlighted)
            doneButton.setTitleColor(UIColor.black, for: UIControlState.normal)
            doneButton.setTitleColor(UIColor.gray, for: UIControlState.highlighted)
            
            inputView.addSubview(doneButton) // add Button to UIView
            
            doneButton.addTarget(self, action: #selector(doneButton(sender:)), for: UIControlEvents.touchUpInside) // set button click event
            textField.inputView = inputView
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
    
    @objc func doneButton(sender:UIButton)
    {
        self.endEditing(true)// To resign the inputView on clicking done.
    }
    
}
