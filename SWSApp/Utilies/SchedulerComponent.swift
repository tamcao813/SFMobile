//
//  SchedulerComponent.swift
//  SWSApp
//
//  Created by vipin.vijay on 19/04/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit
 //LOCATION
import CoreLocation
//protocol LocationDelegate {
//    func onTimeTap(latitude:String, longitude:String, startTime:String)
//}

class SchedulerComponent: UIView, UITextFieldDelegate, CLLocationManagerDelegate {
    
    var dateTextField = DesignableUITextField()
    var startTimeTextField = DesignableUITextField()
    var endTimeTextField = DesignableUITextField()
    let datePickerView = UIDatePicker()
    
    //LOCATION
   // var locationManager = CLLocationManager()
    
//    func setLocationManager(){
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.delegate = self
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.startUpdatingLocation()
//    }
    
//    func startUpdatingLocation() {
//        // 1. status is not determined
//        if CLLocationManager.authorizationStatus() == .NotDetermined {
//            locationManager.requestAlwaysAuthorization()
//        }
//            // 2. authorization were denied
//        else if CLLocationManager.authorizationStatus() == .Denied {
//            showAlert("Location services were previously denied. Please enable location services for this app in Settings.")
//        }
//            // 3. we do have authorization
//        else if CLLocationManager.authorizationStatus() == .AuthorizedAlways {
//            locationManager.startUpdatingLocation()
//        }
//    }
//
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        
//        setLocationManager()
//        startUpdatingLocation()
        
        // Set UILabel size and position
        let dateLabel = UILabel(frame: CGRect(x: 0, y: 5, width: 100, height: 21))
        dateLabel.text = "Date of Visit"
        dateLabel.textColor = UIColor(fromHexValue: "#9A9A9A")
        dateLabel.font = UIFont(name:"Ubuntu", size: 14.0)
        self.addSubview(dateLabel)
        
        let startTimeLabel = UILabel(frame: CGRect(x: 230, y: 5, width: 100, height: 21))
        startTimeLabel.text = "Start Time"
        startTimeLabel.textColor = UIColor(fromHexValue: "#9A9A9A")
        startTimeLabel.font = UIFont(name:"Ubuntu", size: 14.0)
        self.addSubview(startTimeLabel)
        
        let endTimeLabel = UILabel(frame: CGRect(x: 380, y: 5, width: 100, height: 21))
        endTimeLabel.text = "End Time"
        endTimeLabel.textColor = UIColor(fromHexValue: "#9A9A9A")
        endTimeLabel.font = UIFont(name:"Ubuntu", size: 14.0)
        self.addSubview(endTimeLabel)
        
        // Set DesignableUITextField size and position
        
        dateTextField =  DesignableUITextField(frame: CGRect(x: 0, y: 30, width: 180, height: 40))
        dateTextField.rightImage = UIImage(named:"Calender_Icon")!
        dateTextField.rightPadding = 8
        dateTextField.placeholder = "MM/DD/YYYY"
        dateTextField.accessibilityIdentifier = "dateTextFieldID"
        dateTextField.font = UIFont(name:"Ubuntu", size: 14.0)
        dateTextField.layer.borderColor = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1.0).cgColor
        dateTextField.layer.borderWidth = 1.0
        dateTextField.layer.cornerRadius = 2.0
        dateTextField.tag = 200
        dateTextField.borderStyle = UITextBorderStyle.roundedRect
        dateTextField.delegate = self
        self.addSubview(dateTextField)
        
        startTimeTextField =  DesignableUITextField(frame: CGRect(x: 230, y: 30, width: 100, height: 40))
        startTimeTextField.rightImage = UIImage(named:"dropDownLight")!
        startTimeTextField.rightPadding = 8
        startTimeTextField.backgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1.0)
        startTimeTextField.placeholder = "HH:MM"
        startTimeTextField.accessibilityIdentifier = "startTimeTextFieldID"
        startTimeTextField.font = UIFont(name:"Ubuntu", size: 14.0)
        startTimeTextField.layer.borderColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1.0).cgColor
        startTimeTextField.tag = 201
        startTimeTextField.layer.borderWidth = 1.0
        startTimeTextField.layer.cornerRadius = 2.0
        startTimeTextField.borderStyle = UITextBorderStyle.roundedRect
        startTimeTextField.delegate = self
        self.addSubview(startTimeTextField)
        
        endTimeTextField =  DesignableUITextField(frame: CGRect(x: 380, y: 30, width: 100, height: 40))
        endTimeTextField.rightImage = UIImage(named:"dropDownLight")!
        endTimeTextField.rightPadding = 8
        endTimeTextField.backgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1.0)
        endTimeTextField.placeholder = "HH:MM"
        endTimeTextField.accessibilityIdentifier = "endTimeTextFieldID"
        endTimeTextField.tag = 202
        endTimeTextField.font = UIFont(name:"Ubuntu", size: 14.0)
        endTimeTextField.layer.borderColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1.0).cgColor
        endTimeTextField.layer.borderWidth = 1.0
        endTimeTextField.layer.cornerRadius = 2.0
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
    
    func checkVisitStates(textField : UITextField){
        
        if((PlanVisitManager.sharedInstance.visit?.Id) != nil && ((PlanVisitManager.sharedInstance.visit?.Id)?.count)! > 0){
            
            if StoreDispatcher.shared.isWorkOrderCreatedLocally(id: (PlanVisitManager.sharedInstance.visit?.Id)!){
                
                //Its a local created entry
                if textField.tag == 200{
                    self.dateView(textField: textField)
                }else{
                    self.timeView(textField: textField)
                }
            }else{
                
                //Its already Synced UP
                if AppDelegate.isConnectedToNetwork(){
                    textField.isUserInteractionEnabled = true
                    if textField.tag == 200{
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
            if textField.tag == 200{
                self.dateView(textField: textField)
            }else{
                self.timeView(textField: textField)
            }
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        textField.isUserInteractionEnabled = true
        
        switch textField.tag {
        case 200:
         
            self.checkVisitStates(textField: textField)

        case 201:
            
            self.checkVisitStates(textField: textField)
            
        case 202:
           
            self.checkVisitStates(textField: textField)
            
        default:
            print("default")
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField.tag {
        case 200:
            CreateNewVisitViewController.createNewVisitViewControllerGlobals.startTimeField = dateTextField.text!
        case 201:
            CreateNewVisitViewController.createNewVisitViewControllerGlobals.startTimeField = startTimeTextField.text!
        case 202:
            CreateNewVisitViewController.createNewVisitViewControllerGlobals.startTimeField = endTimeTextField.text!
        default:
            print("default")
        }
    }
    
    // MARK - Custom Methods
    
    @objc func handleDatePicker(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        dateTextField.text = dateFormatter.string(from: datePickerView.date)
        resignTextField()
        self.endEditing(true)// To resign the inputView on clicking done.
//        NotificationCenter.default.post(name: Notification.Name("VALIDATEFIELDS"), object: nil, userInfo:nil)
//
    }
    
    @objc func handleTimePicker(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        if (sender.tag == 201) {
            startTimeTextField.text = dateFormatter.string(from: datePickerView.date)
        } else {
            endTimeTextField.text = dateFormatter.string(from: datePickerView.date)
        }
        if (!startTimeTextField.text!.isEmpty && !endTimeTextField.text!.isEmpty) {
            if DateTimeUtility.getTimeFromDateString(dateString: startTimeTextField.text!) == DateTimeUtility.getTimeFromDateString(dateString: endTimeTextField.text!)  {
                endTimeTextField.text! = ""
                 showAlert(message: "Start Time should be lesser than End Time")
                
            } else if DateTimeUtility.getTimeFromDateString(dateString: startTimeTextField.text!).compare(DateTimeUtility.getTimeFromDateString(dateString: endTimeTextField.text!)) == .orderedDescending  {
                endTimeTextField.text! = ""
                showAlert(message: "Start Time should be lesser than End Time")
              
            }
        }
        
        resignTextField()
        self.endEditing(true)// To resign the inputView on clicking done.
//        NotificationCenter.default.post(name: Notification.Name("VALIDATEFIELDS"), object: nil, userInfo:nil)
    }
    
    func showAlert(message:String) {
        let alert = UIAlertView()
        alert.title = "Alert"
        alert.message = message
        alert.addButton(withTitle: "OK")
        alert.show()
    }
    
    @objc func doneButton(sender:UIButton)
    {
        resignTextField()
        self.endEditing(true)// To resign the inputView on clicking done.
    }
    
    func dateView(textField: UITextField) {
        
        let inputView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 240))
        inputView.backgroundColor = UIColor.white
        datePickerView.frame.origin = CGPoint(x: self.frame.width/1.2, y: 20)
        datePickerView.datePickerMode = .date
        
        if((PlanVisitManager.sharedInstance.visit?.Id) != nil){
            
            let startDate = DateTimeUtility.covertUTCtoLocalTimeZone(dateString: (PlanVisitManager.sharedInstance.visit?.startDate)!)
            
            datePickerView.date = startDate!
            
        }
        
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
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        textField.inputView = inputView
        textField.inputAccessoryView = toolBar
    }
    
    func timeView(textField: UITextField) {
        
        let inputView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 240))
        inputView.backgroundColor = UIColor.white
        datePickerView.frame.origin = CGPoint(x: self.frame.width/1.2, y: 20)
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
//
//
    
    
    func resignTextField(){
        dateTextField.resignFirstResponder()
        startTimeTextField.resignFirstResponder()
        endTimeTextField.resignFirstResponder()
    }
}
