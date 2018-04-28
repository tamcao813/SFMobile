//
//  CreateNoteViewController.swift
//  SWSApp
//
//  Created by Jagadeeshwar Reddy on 22/04/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation
import UIKit

struct sendDataToTable {
    static var addDataToArray = -1
    static var dataDictionary = NSMutableDictionary()
}

class CreateNoteViewController : UIViewController{
    
    let textFieldLimit = 250 // limit for TextField
    let textViewLimit = 30000 // limit for TextView
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var notesTitleTextField: UITextField!
    
    var dataDictionary:[String: Any] = [:]
    var notesToEdit: AccountNotes!
    
    var isAddingNewNote: Bool = true
    
    //MARK:- View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        textView?.layer.borderColor = UIColor.init(red: 204/255.0, green: 204/255.0, blue: 204/255.0, alpha: 1).cgColor
        notesTitleTextField?.layer.borderColor = UIColor.init(red: 204/255.0, green: 204/255.0, blue: 204/255.0, alpha: 1).cgColor
        notesTitleTextField.delegate = self
        textView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if(!isAddingNewNote) {
            self.textView?.text = notesToEdit.accountNotesDesc
            self.notesTitleTextField?.text = notesToEdit.name
        }
    }
    
    //MARK:- IB Button actions
    @IBAction func closeButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveAndCloseButtonClicked(_ sender: Any) {
        
        if ((notesTitleTextField?.text)!.isEmpty){
            // create the alert
            let alert = UIAlertController(title: "Notes", message: "Please enter required fields", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd yyyy"
        let datetime = formatter.string(from: date)
        let timeformat = DateFormatter ()
        timeformat.dateFormat = "h:mm a"
        let timeresult = timeformat.string(from: date)
        
        let dataDictionary = NSMutableDictionary()
        dataDictionary.setValue(notesTitleTextField?.text, forKey: "title")
        dataDictionary.setValue(textView?.text, forKey: "description")
        dataDictionary.setValue(datetime, forKey: "date")
        dataDictionary.setValue(timeresult, forKey: "time")
        sendDataToTable.dataDictionary = dataDictionary
        sendDataToTable.addDataToArray = 1
        self.dismiss(animated: true, completion: nil)
    }
    
}

//MARK:- UI Delegates
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


