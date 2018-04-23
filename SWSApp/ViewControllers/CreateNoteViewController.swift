//
//  CreateNoteViewController.swift
//  SWSApp
//
//  Created by Jagadeeshwar Reddy on 22/04/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation
import UIKit

class CreateNoteViewController : UIViewController{
    
    let textFieldLimit = 250
    let textViewLimit = 30000
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var notesTitleTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView?.layer.borderColor = UIColor.init(red: 204/255.0, green: 204/255.0, blue: 204/255.0, alpha: 1).cgColor
        notesTitleTextField.delegate = self
        textView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    func displayCreateNoteData(title:String,description:String){
        //self.dateLabel?.text = date
        self.textView?.text = description
        self.notesTitleTextField?.text = title
    }
    
    func getTime() -> (hour:Int, min:Int) {
        let currentDateTime = Date()
        let calender = Calendar.current
        let components = calender.dateComponents([.hour,.minute], from: currentDateTime)
        let hour = components.hour
        let min = components.minute
        return (hour!,min!)
    }
    
    
    @IBAction func closeButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func saveAndCloseButtonClicked(_ sender: Any) {
        
        if ((notesTitleTextField?.text)!.isEmpty){
            // create the alert
            let alert = UIAlertController(title: "Notes", message: "Title is empty.Please fill the title.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else if((textView?.text)!.isEmpty){
            // create the alert
            let alert = UIAlertController(title: "Notes", message: "Description is empty.Please fill the Description.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        //         var title = notesTitleLabel.text
        //         var description = textView.text
        //         var currentTime = self.getTime()
        //        let date = Date()
        //        let formatter = DateFormatter()
        //        formatter.dateFormat = "dd.MM.yyyy"
        //        let result = formatter.string(from: date)
        //        var datetime = result
        
    }
    
    
}

extension CreateNoteViewController : UITextFieldDelegate,UITextViewDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.count + string.count - range.length
        return newLength <= textFieldLimit // replace 250 for your max length value
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        //30000 chars restriction
        return textView.text.count + (text.count - range.length) <= textViewLimit
    }
    
}


