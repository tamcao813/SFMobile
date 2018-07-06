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
        
        if CreateNewEventViewControllerGlobals.startDate != ""{
            eventStartDateTextField.borderColor = .gray
            CreateNewEventViewControllerGlobals.isFirstTimeLoad = false
            
            if isSelectedFlag == false {
                isSelectedFlag = true
                btnAllDayEvent?.setImage(UIImage(named:"Checkbox Selected"), for: .normal)
                
                eventEndDateTextField.text = eventStartDateTextField.text
                
                CreateNewEventViewControllerGlobals.endDate = eventStartDateTextField.text!

                if DateTimeUtility.isDeviceIsin24hrFormat() {
                    eventStartTimeTextField.text = "00:00"
                    eventEndTimeTextField.text = "23:59"
                    
                    //Assign the model data also for saving
                    CreateNewEventViewControllerGlobals.startTime = "00:00"
                    CreateNewEventViewControllerGlobals.endTime = "23:59"
                }else {
                    eventStartTimeTextField.text = "00:00 AM"
                    eventEndTimeTextField.text = "11:59 PM"
                    
                    //Assign the model data also for saving
                    CreateNewEventViewControllerGlobals.startTime = "00:00 AM"
                    CreateNewEventViewControllerGlobals.endTime = "11:59 PM"
                }
                self.startAndEndDatesUserInteractionDisabled()
                CreateNewEventViewControllerGlobals.allDayEventSelected = true
            }else{
                isSelectedFlag = false
                btnAllDayEvent?.setImage(UIImage(named:"Checkbox"), for: .normal)
                
                eventStartDateTextField.text = ""
                eventStartTimeTextField.text = ""
                eventEndDateTextField.text = ""
                eventEndTimeTextField.text = ""
                
                //Assign the model data also for saving
                CreateNewEventViewControllerGlobals.startDate = ""
                CreateNewEventViewControllerGlobals.endDate = ""
                CreateNewEventViewControllerGlobals.startTime = ""
                CreateNewEventViewControllerGlobals.endTime = ""
                
                self.startAndEndDatesUserInteractionEnabled()
                CreateNewEventViewControllerGlobals.allDayEventSelected = false
            }
        }else{
            eventStartDateTextField.borderColor = .red
        }
    }
    
    func startAndEndDatesUserInteractionDisabled(){
        eventStartDateTextField.isUserInteractionEnabled = false
        eventEndDateTextField.isUserInteractionEnabled = false
        eventStartTimeTextField.isUserInteractionEnabled = false
        eventEndTimeTextField.isUserInteractionEnabled = false
    }
    
    func startAndEndDatesUserInteractionEnabled(){
        eventStartDateTextField.isUserInteractionEnabled = true
        eventEndDateTextField.isUserInteractionEnabled = true
        eventStartTimeTextField.isUserInteractionEnabled = true
        eventEndTimeTextField.isUserInteractionEnabled = true
    }
    
    func checkEventStates(textField : UITextField){
        
        if((PlanVisitManager.sharedInstance.visit?.Id) != nil){
            
            if StoreDispatcher.shared.isWorkOrderCreatedLocally(id: (PlanVisitManager.sharedInstance.visit?.Id)!){
                //Its a local created entry
                if textField.tag == 300 || textField.tag == 302{
                    self.dateView(textField: textField)
                }else{
                    self.timeView(textField: textField)
                }
                
            }else{
                //Its already Synced UP
                if AppDelegate.isConnectedToNetwork(){
                    textField.isUserInteractionEnabled = true
                    if textField.tag == 300 || textField.tag == 302{
                        self.dateView(textField: textField)
                    }else{
                        self.timeView(textField: textField)
                    }
                    
                }else{
                    textField.isUserInteractionEnabled = false
                }
            }
            
        }else{
            
            //Its a new local created entry
            if textField.tag == 300 || textField.tag == 302{
                self.dateView(textField: textField)
            }else{
                self.timeView(textField: textField)
            }
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        CreateNewEventViewControllerGlobals.isFirstTimeLoad = false
        textField.isUserInteractionEnabled = true
        
        if textField.tag == 300{
            self.checkEventStates(textField: textField)
            
        }else if textField.tag == 301{
            self.checkEventStates(textField: textField)
            
        }else if textField.tag == 302{
            self.checkEventStates(textField: textField)
            
        }else if textField.tag == 303{
            self.checkEventStates(textField: textField)
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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return AlertUtilities.disableEmojis(text: string)
    }
    
    func dateView(textField: UITextField) {
        
        let inputView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 240))
        inputView.backgroundColor = UIColor.white
        datePickerView.frame.origin = CGPoint(x: 350, y: 20)
        datePickerView.datePickerMode = .date
        datePickerView.minuteInterval = 15
        datePickerView.minimumDate = Date()
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
        datePickerView.minimumDate = Date()
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
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        if sender.tag == 300{
            eventStartDateTextField.text = dateFormatter.string(from: datePickerView.date)
        }else{
            eventEndDateTextField.text = dateFormatter.string(from: datePickerView.date)
            eventEndTimeTextField.text = ""
            CreateNewEventViewControllerGlobals.endTime = ""
        }
        
        if (!eventStartDateTextField.text!.isEmpty && !eventEndDateTextField.text!.isEmpty) {
            if DateTimeUtility.getMMDDYYYFormattedDateFromString(dateString: eventStartDateTextField.text!).compare(DateTimeUtility.getMMDDYYYFormattedDateFromString(dateString: eventEndDateTextField.text!)) == .orderedDescending  {
                eventEndDateTextField.text! = ""
                  showAlert(message: "Start Date should be lesser than End Date")
            }
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
        
        if eventStartDateTextField.text != eventEndDateTextField.text{
            //User
            
            
        }else if (!eventStartTimeTextField.text!.isEmpty && !eventEndTimeTextField.text!.isEmpty) {
            if DateTimeUtility.getTimeFromDateString(dateString: eventStartTimeTextField.text!) == DateTimeUtility.getTimeFromDateString(dateString: eventEndTimeTextField.text!)  {
                eventEndTimeTextField.text! = ""
                showAlert(message: "Start Time should be lesser than End Time")
                
            } else if DateTimeUtility.getTimeFromDateString(dateString: eventStartTimeTextField.text!).compare(DateTimeUtility.getTimeFromDateString(dateString: eventEndTimeTextField.text!)) == .orderedDescending  {
                eventEndTimeTextField.text! = ""
                showAlert(message: "Start Time should be lesser than End Time")
            }
        }
        
        resignTextField()
        self.endEditing(true)// To resign the inputView on clicking done.
        //        NotificationCenter.default.post(name: Notification.Name("VALIDATEFIELDS"), object: nil, userInfo:nil)
    }
    
    func showAlert(message:String){
        let alert = UIAlertView()
        alert.title = "Alert"
        alert.message = message
        alert.addButton(withTitle: "OK")
        alert.show()
        
    }
    
//    func convertToDate(dateString: String) -> Date {
//        let dateformatter = DateFormatter()
//        dateformatter.timeStyle = .medium
//        dateformatter.dateFormat = "hh:mm a"
//        var dateFromString = Date()
//        if dateformatter.date(from:(dateString)) != nil {
//            dateFromString = dateformatter.date(from: dateString)!
//        } else {
//            dateformatter.timeStyle = .medium
//            dateformatter.dateFormat = "HH:mm a"
//            dateFromString = dateformatter.date(from: dateString)!
//        }
//
//        return dateFromString
//    }
}
