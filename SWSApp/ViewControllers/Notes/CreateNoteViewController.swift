//
//  CreateNoteViewController.swift
//  SWSApp
//
//  Created by Jagadeeshwar Reddy on 22/04/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation
import UIKit
import SmartStore
import SmartSync

protocol sendNotesDataToNotesDelegate{
    func displayAccountNotes()
    func dismissEditNote()
    func noteCreated()
    func navigateToNotesSection()
}

class CreateNoteViewController : UIViewController{
    
    let textFieldLimit = 80 // limit for TextField
    let textViewLimit = 30000 // limit for TextView
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var notesTitleTextField: UITextField!
    @IBOutlet weak var editNotel_Label: UILabel!
    
    var dataDictionary:[String: Any] = [:]
    var notesToEdit: AccountNotes!
    var isAddingNewNote: Bool = true
    var accNotesViewModel = AccountsNotesViewModel()
    var sendNoteDelegate : sendNotesDataToNotesDelegate?
    var notesAccountId:String!
    var notesOwnerId:String!
    var comingFromNotesVC:Bool?
    var comingFromAccountDetails:Bool?
    
    
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
    
    //MARK:- View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        textView?.layer.borderColor = UIColor.init(red: 204/255.0, green: 204/255.0, blue: 204/255.0, alpha: 1).cgColor
        notesTitleTextField?.layer.borderColor = UIColor.init(red: 204/255.0, green: 204/255.0, blue: 204/255.0, alpha: 1).cgColor
        //  notesTitleTextField.layer.cornerRadius =
        notesTitleTextField.delegate = self
        textView.delegate = self
        activityIndicator.center =  CGPoint(x: self.view.frame.width/2, y: self.view.frame.height/2-200)
        activityIndicator.color = UIColor.darkGray
        self.view.addSubview(activityIndicator)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if(!isAddingNewNote) {
            self.textView?.text = notesToEdit.accountNotesDesc
            self.notesTitleTextField?.text = notesToEdit.name
        }
        if comingFromNotesVC == true{
            self.editNotel_Label.text = "Edit Note"
        }
        else {
            self.editNotel_Label.text = "Add Note"
        }
    }
    
    func generateRandomIDForNotes()->String  {
        //  Make a variable equal to a random number....
        let randomNum:UInt32 = arc4random_uniform(99999999) // range is 0 to 99
        // convert the UInt32 to some other  types
        let someString:String = String(randomNum)
        print("number in notes is \(someString)")
        return someString
    }
    
    func createNewNotes() {
        let new_notes = AccountNotes(for: "newNotes")
        new_notes.Id = self.generateRandomIDForNotes()
        new_notes.lastModifiedDate = DateTimeUtility.getCurrentTimeStampInUTCAsString()
        new_notes.name = self.notesTitleTextField.text!
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        new_notes.ownerId = (appDelegate.loggedInUser?.userId)!
        new_notes.accountId = notesAccountId
        new_notes.accountNotesDesc = self.textView.text!
        let attributeDict = ["type":"SGWS_Account_Notes__c"]
        
        let addNewDict: [String:Any] = [
            
            AccountNotes.AccountNotesFields[0]: new_notes.Id,
            AccountNotes.AccountNotesFields[1]: new_notes.lastModifiedDate,
            AccountNotes.AccountNotesFields[2]: new_notes.name,
            AccountNotes.AccountNotesFields[3]: new_notes.ownerId,
            AccountNotes.AccountNotesFields[4]: new_notes.accountId,
            AccountNotes.AccountNotesFields[5]: new_notes.accountNotesDesc,
            kSyncTargetLocal:true,
            kSyncTargetLocallyCreated:true,
            kSyncTargetLocallyUpdated:false,
            kSyncTargetLocallyDeleted:false,
            "attributes":attributeDict]
        let success = accNotesViewModel.createNewNotesLocally(fields: addNewDict)
        print("Success is here \(success)")
    }

    //Show Alert Message
    func showAlert(){
        AlertUtilities.showAlertMessageWithTwoActionsAndHandler(StringConstants.changesWillNotBeSavedMessage, errorMessage: StringConstants.closingMessage, errorAlertActionTitle: "Yes", errorAlertActionTitle2: "No", viewControllerUsed: self, action1: {
            self.dismiss(animated: true, completion: nil)
        }){
            
        }
    }
    
    //MARK:- IB Button actions
    @IBAction func closeButtonClicked(_ sender: Any) {
        if(!isAddingNewNote) {
            if self.textView?.text != notesToEdit.accountNotesDesc || self.notesTitleTextField?.text != notesToEdit.name {
                self.showAlert()
            }else{
                self.dismiss(animated: true, completion: nil)
            }
        }else if notesTitleTextField.text != "" || textView.text != ""{
            self.showAlert()
        }else{
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func saveAndCloseButtonClicked(_ sender: Any) {
        
        if(isAddingNewNote){
            if (notesTitleTextField.text?.trimmingCharacters(in: .whitespaces).isEmpty)!{
                notesTitleTextField.borderColor = UIColor.red
                errorLabel.text = StringConstants.emptyFieldError
                return
            }
            self.createNewNotes()
            self.dismiss(animated: true, completion: {
                 //MBProgressHUD.show(onWindow: true)
                self.activityIndicator.startAnimating()
                self.sendNoteDelegate?.displayAccountNotes()
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshNotesList"), object:nil)
                if self.comingFromAccountDetails == true{
                    self.sendNoteDelegate?.navigateToNotesSection()
                }
            })
        } else {
            if (notesTitleTextField.text?.trimmingCharacters(in: .whitespaces).isEmpty)!{
                // create the alert
                notesTitleTextField.borderColor = UIColor.red
                errorLabel.text = StringConstants.emptyFieldError
                return
            }
            
            activityIndicator.startAnimating()
                        self.editNote()
                        self.dismiss(animated: true, completion: {
                        //MBProgressHUD.show(onWindow: true)
                        DispatchQueue.global(qos: .userInitiated).async {
                            self.sendNoteDelegate?.dismissEditNote()
                            self.sendNoteDelegate?.displayAccountNotes()
                            DispatchQueue.main.async {
                                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshNotesList"), object:nil)
                                 self.activityIndicator.stopAnimating()
                            }
                            
                        }
                        
                    })
            
            }
        }
    
    @IBAction func editNote(_ sender: Any) {
        // self.performSegue(withIdentifier: "editToCreate", sender: nil)
    }
    
    
    func editNote() {
        notesToEdit.lastModifiedDate = DateTimeUtility.getCurrentTimeStampInUTCAsString()
        let attributeDict = ["type":"SGWS_Account_Notes__c"]
        
        if(notesToEdit.accountNotesDesc != self.textView.text){
            notesToEdit.accountNotesDesc = self.textView.text
        }
        if(notesToEdit.name != self.notesTitleTextField.text){
            if let noteTitle = self.notesTitleTextField.text{
                notesToEdit.name = noteTitle
            }
        }
        
        
        
        let editNoteDict: [String:Any] = [
            AccountNotes.AccountNotesFields[0]: notesToEdit.Id,
            AccountNotes.AccountNotesFields[1]: notesToEdit.lastModifiedDate,
            AccountNotes.AccountNotesFields[2]: notesToEdit.name,
            AccountNotes.AccountNotesFields[5]: notesToEdit.accountNotesDesc,
            kSyncTargetLocal:true,
            kSyncTargetLocallyCreated:false,
            kSyncTargetLocallyUpdated:true,
            kSyncTargetLocallyDeleted:false,
            "attributes":attributeDict]
        
        let success = AccountsNotesViewModel().editNotesLocally(fields: editNoteDict)
        print("Success is here \(success)")
        
        // Show the alert if not saved
        
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


