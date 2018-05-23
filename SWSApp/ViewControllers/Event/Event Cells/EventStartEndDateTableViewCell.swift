//
//  EventStartEndDateTableViewCell.swift
//  SWSApp
//
//  Created by r.a.jantakal on 21/05/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class EventStartEndDateTableViewCell: UITableViewCell , UITextFieldDelegate {

    @IBOutlet weak var eventStartDateTextField: UITextField!
    @IBOutlet weak var eventStartTimeTextField: UITextField!
    @IBOutlet weak var eventEndDateTextField: UITextField!
    @IBOutlet weak var eventEndTimeTextField: UITextField!
    
    @IBOutlet weak var btnAllDayEvent : UIButton?
    
    let datePickerView = UIDatePicker()
    
    var isSelectedFlag = false

    override func awakeFromNib() {
        super.awakeFromNib()
        customizedUI()
    }
    
    func customizedUI(){
        eventStartDateTextField.addPaddingLeft(10)
        eventStartTimeTextField.addPaddingLeft(10)
        eventEndDateTextField.addPaddingLeft(10)
        eventEndTimeTextField.addPaddingLeft(10)
    }
    
    @IBAction func allDayEventButtonAction(sender: UIButton){
        if isSelectedFlag == false {
            isSelectedFlag = true
            btnAllDayEvent?.setImage(UIImage(named:"Checkbox Selected"), for: .normal)
            
            CreateNewEventViewControllerGlobals.isFirstTimeLoad = false
            
            eventEndDateTextField.text = eventStartDateTextField.text
            eventStartTimeTextField.text = "00:00 AM"
            eventEndTimeTextField.text = "11:59 PM"
            
             //Assign the model data also for saving
            CreateNewEventViewControllerGlobals.endDate = eventStartDateTextField.text!
            CreateNewEventViewControllerGlobals.startTime = "00:00 AM"
            CreateNewEventViewControllerGlobals.endTime = "11:59 PM"
            
            eventEndDateTextField.isUserInteractionEnabled = false
            eventStartTimeTextField.isUserInteractionEnabled = false
            eventEndTimeTextField.isUserInteractionEnabled = false
            
            CreateNewEventViewControllerGlobals.allDayEventSelected = true
        }else{
            isSelectedFlag = false
            btnAllDayEvent?.setImage(UIImage(named:"Checkbox"), for: .normal)
            
            eventStartTimeTextField.text = ""
            eventEndDateTextField.text = ""
            eventEndTimeTextField.text = ""
            
            //Assign the model data also for saving
            CreateNewEventViewControllerGlobals.endDate = ""
            CreateNewEventViewControllerGlobals.startTime = ""
            CreateNewEventViewControllerGlobals.endTime = ""
            
            eventEndDateTextField.isUserInteractionEnabled = true
            eventStartTimeTextField.isUserInteractionEnabled = true
            eventEndTimeTextField.isUserInteractionEnabled = true
            
            CreateNewEventViewControllerGlobals.allDayEventSelected = false
        }
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        CreateNewEventViewControllerGlobals.isFirstTimeLoad = false
        
        if textField.tag == 300{
             self.dateView(textField: textField)
            
        }else if textField.tag == 301{
            self.timeView(textField: textField)
            
        }else if textField.tag == 302{
            self.dateView(textField: textField)
            
        }else if textField.tag == 303{
            self.timeView(textField: textField)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.tag == 300{
            CreateNewEventViewControllerGlobals.startDate = textField.text!
            
        }else if textField.tag == 301{
            CreateNewEventViewControllerGlobals.startTime = textField.text!
            
        }else if textField.tag == 302{
            CreateNewEventViewControllerGlobals.endDate = textField.text!
            
        }else if textField.tag == 303{
            CreateNewEventViewControllerGlobals.endTime = textField.text!
        }
    }
    
    func dateView(textField: UITextField) {
        
        let inputView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 240))
        inputView.backgroundColor = UIColor.white
        datePickerView.frame.origin = CGPoint(x: 350, y: 20)
        datePickerView.datePickerMode = .date
        datePickerView.minuteInterval = 15
        datePickerView.minimumDate = NSDate() as Date
        inputView.addSubview(datePickerView) // add date picker to UIView
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(handleDatePicker(sender:)))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(doneButton(sender:)))
        doneButton.tag = textField.tag
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        textField.inputView = inputView
        textField.inputAccessoryView = toolBar
    }
    
    func timeView(textField: UITextField) {
        
        let inputView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 240))
        inputView.backgroundColor = UIColor.white
        datePickerView.frame.origin = CGPoint(x: 350, y: 20)
        datePickerView.datePickerMode = .time
        datePickerView.minuteInterval = 15
        datePickerView.minimumDate = NSDate() as Date
        inputView.addSubview(datePickerView) // add date picker to UIView
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(handleTimePicker(sender:)))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(doneButton(sender:)))
        doneButton.tag = textField.tag
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        textField.inputView = inputView
        textField.inputAccessoryView = toolBar
    }
    
    @objc func handleDatePicker(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if sender.tag == 300{
            eventStartDateTextField.text = dateFormatter.string(from: datePickerView.date)
        }else{
            eventEndDateTextField.text = dateFormatter.string(from: datePickerView.date)
        }
        
        resignTextField()
        self.endEditing(true)// To resign the inputView on clicking done.
        //        NotificationCenter.default.post(name: Notification.Name("VALIDATEFIELDS"), object: nil, userInfo:nil)
        //
    }
    
    func resignTextField(){
        eventStartDateTextField.resignFirstResponder()
        eventStartTimeTextField.resignFirstResponder()
        eventEndDateTextField.resignFirstResponder()
        eventEndTimeTextField.resignFirstResponder()
    }
    
    @objc func doneButton(sender:UIButton)
    {
        resignTextField()
        self.endEditing(true)// To resign the inputView on clicking done.
    }
    
    @objc func handleTimePicker(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        if (sender.tag == 301) {
            eventStartTimeTextField.text = dateFormatter.string(from: datePickerView.date)
        } else {
            eventEndTimeTextField.text = dateFormatter.string(from: datePickerView.date)
        }
        if (!eventStartTimeTextField.text!.isEmpty && !eventEndTimeTextField.text!.isEmpty) {
            if convertToDate(dateString: eventStartTimeTextField.text!) == convertToDate(dateString: eventEndTimeTextField.text!)  {
                eventEndTimeTextField.text! = ""
                
                let alert = UIAlertView()
                alert.title = "Alert"
                alert.message = "Start Time should be lesser than End Time"
                alert.addButton(withTitle: "OK")
                alert.show()
                
            } else if convertToDate(dateString: eventStartTimeTextField.text!).compare(convertToDate(dateString: eventEndTimeTextField.text!)) == .orderedDescending  {
                eventEndTimeTextField.text! = ""
                
                let alert = UIAlertView()
                alert.title = "Alert"
                alert.message = "Start Time should be lesser than End Time"
                alert.addButton(withTitle: "OK")
                alert.show()
            }
        }
        
        resignTextField()
        self.endEditing(true)// To resign the inputView on clicking done.
        //        NotificationCenter.default.post(name: Notification.Name("VALIDATEFIELDS"), object: nil, userInfo:nil)
    }
    
    func convertToDate(dateString: String) -> Date {
        let dateformatter = DateFormatter()
        dateformatter.timeStyle = .medium
        dateformatter.dateFormat = "hh:mm a"
        var dateFromString = Date()
        if dateformatter.date(from:(dateString)) != nil {
            dateFromString = dateformatter.date(from: dateString)!
        } else {
            dateformatter.timeStyle = .medium
            dateformatter.dateFormat = "HH:mm a"
            dateFromString = dateformatter.date(from: dateString)!
        }
        
        return dateFromString
    }
}
