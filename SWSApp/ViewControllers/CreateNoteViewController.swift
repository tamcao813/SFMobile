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
    
    var accNotesViewModel = AccountsNotesViewModel()
   
    
    //MARK:- View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        textView?.layer.borderColor = UIColor.init(red: 204/255.0, green: 204/255.0, blue: 204/255.0, alpha: 1).cgColor
        notesTitleTextField?.layer.borderColor = UIColor.init(red: 204/255.0, green: 204/255.0, blue: 204/255.0, alpha: 1).cgColor
        notesTitleTextField.delegate = self
        textView.delegate = self
       
       self.getDateForNotes()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.textView?.text = noteDescriptionText
        self.notesTitleTextField?.text = noteTitleText
       
        
    }
    
    func generateRandomIDForNotes()->String  {
        //  Make a variable equal to a random number....
        let randomNum:UInt32 = arc4random_uniform(99999999) // range is 0 to 99
        // convert the UInt32 to some other  types
        let someString:String = String(randomNum)
        print("number in notes is \(someString)")
        return someString
    }
    
    
    
    func getDateForNotes()  {
        
        let currentdate = Date()
        print("Current date is \(currentdate)")
        
    }
    
    func createNewNotes() {
            let new_notes = AccountNotes(for: "newNotes")
            new_notes.Id = self.generateRandomIDForNotes()
            new_notes.lastModifiedDate = ""
            new_notes.name = self.notesTitleTextField.text!
            new_notes.ownerId = ""
            new_notes.accountId = ""
            new_notes.accountNotesDesc = self.textView.text!
            let addNewDict: [String:Any] = [
                
                                             AccountNotes.AccountNotesFields[0]: new_notes.Id,
                                             AccountNotes.AccountNotesFields[1]: new_notes.lastModifiedDate,
                                             AccountNotes.AccountNotesFields[2]: new_notes.name,
                                             AccountNotes.AccountNotesFields[3]: new_notes.ownerId,
                                             AccountNotes.AccountNotesFields[4]: new_notes.accountId,
                                             AccountNotes.AccountNotesFields[5]: new_notes.accountNotesDesc,
            ]
        
        let success = accNotesViewModel.createNewNotesLocally(fields: addNewDict)
        print("Success is here \(success)")
        
        //assuming online
        if success { //upsert to local store is successful then upload to server
            accNotesViewModel.uploadNotesToServer(fields: addNewDict, completion: { error in
                if error != nil {
                    print(error?.localizedDescription ?? "error")
                }
            })
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
        
        self.createNewNotes()
        
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


