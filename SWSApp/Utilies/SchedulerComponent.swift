//
//  SchedulerComponent.swift
//  SWSApp
//
//  Created by vipin.vijay on 19/04/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class SchedulerComponent: UIView {
    
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
        dateTextField.borderStyle = UITextBorderStyle.roundedRect
        dateTextField.delegate = self as? UITextFieldDelegate
        self.addSubview(dateTextField)
        
        startTimeTextField =  DesignableUITextField(frame: CGRect(x: 140, y: 30, width: 100, height: 30))
        startTimeTextField.rightImage = UIImage(named:"dropDown")!
        startTimeTextField.rightPadding = 8
        startTimeTextField.backgroundColor = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1.0)
        startTimeTextField.text = "9:30 AM"
        startTimeTextField.font = UIFont(name:"Ubuntu", size: 12.0)
        startTimeTextField.layer.borderColor = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1.0).cgColor
        startTimeTextField.layer.borderWidth = 1.0
        startTimeTextField.borderStyle = UITextBorderStyle.roundedRect
        startTimeTextField.delegate = self as? UITextFieldDelegate
        self.addSubview(startTimeTextField)
        
        endTimeTextField =  DesignableUITextField(frame: CGRect(x: 260, y: 30, width: 100, height: 30))
        endTimeTextField.rightImage = UIImage(named:"dropDown")!
        endTimeTextField.rightPadding = 8
        endTimeTextField.backgroundColor = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1.0)
        endTimeTextField.text = "10:15 AM"
        endTimeTextField.font = UIFont(name:"Ubuntu", size: 12.0)
        endTimeTextField.layer.borderColor = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1.0).cgColor
        endTimeTextField.layer.borderWidth = 1.0
        endTimeTextField.borderStyle = UITextBorderStyle.roundedRect
        endTimeTextField.delegate = self as? UITextFieldDelegate
        self.addSubview(endTimeTextField)

    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
