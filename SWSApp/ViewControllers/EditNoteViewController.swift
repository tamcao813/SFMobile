//
//  EditNoteViewController.swift
//  SWSApp
//
//  Created by Jagadeeshwar Reddy on 22/04/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation
import UIKit
import SmartSync


protocol  NavigateToNotesVCDelegate {
    func navigateToNotesViewController()
}

class EditNoteViewController : UIViewController,sendNotesDataToNotesDelegate{
    func navigateToNotesSection() {
        
    }
  
    var dictname = [Dictionary<String, String>]()
    var dictIndex: Int!
    var notesToBeEdited: AccountNotes!
   
   
    
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UITextView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var delegate : NavigateToNotesVCDelegate?
    
    //MARK:- View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let serverDate = notesToBeEdited.lastModifiedDate
        let getTime = DateTimeUtility.convertUtcDatetoReadableDate(dateStringfromAccountNotes: serverDate)
        var dateTime = getTime.components(separatedBy: " ")
        if(dateTime.count > 0){
            self.dateLabel?.text = dateTime[0]
        }
        self.descriptionLabel?.text = notesToBeEdited.accountNotesDesc
        self.titleLabel?.text = notesToBeEdited.name
        
        
        
    }
    
    //MARK:- segue connection
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editToCreate" {
            let createNoteScreen = segue.destination as! CreateNoteViewController
            createNoteScreen.notesToEdit = notesToBeEdited
            createNoteScreen.isAddingNewNote = false
            createNoteScreen.sendNoteDelegate = self
            createNoteScreen.comingFromNotesVC = true
        }
    }
    
    
    //MARK:- IB  button actions
    @IBAction func close(_sender: Any){
        
        if ((titleLabel?.text)!.isEmpty){
            // create the alert
            let alert = UIAlertController(title: "Notes", message: "Please enter required fields", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
      //  self.editNote()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func editNote(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let ownerId = appDelegate.loggedInUser?.userId
        //is allowed nonly for Note owner
        if(ownerId == notesToBeEdited.ownerId){
            
            self.performSegue(withIdentifier: "editToCreate", sender: nil)
        }
        else {
            
            return
        }
    }
    
    
    func editNote() {
        
        let date = Date()
        print(date)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000+0000"
        let timeStamp = dateFormatter.string(from: date)
        print(timeStamp)
                
        notesToBeEdited.lastModifiedDate = timeStamp
        let attributeDict = ["type":"SGWS_Account_Notes__c"]
        
        let editNoteDict: [String:Any] = [
            AccountNotes.AccountNotesFields[0]: notesToBeEdited.Id,
            AccountNotes.AccountNotesFields[1]: notesToBeEdited.lastModifiedDate,
            AccountNotes.AccountNotesFields[2]: notesToBeEdited.name,
            AccountNotes.AccountNotesFields[5]: notesToBeEdited.accountNotesDesc,
            kSyncTargetLocal:true,
            kSyncTargetLocallyCreated:false,
            kSyncTargetLocallyUpdated:true,
            kSyncTargetLocallyDeleted:false,
            "attributes":attributeDict]
        
        let success = AccountsNotesViewModel().editNotesLocally(fields: editNoteDict)
        print("Success is here \(success)")
        
        // Show the alert if not saved
        
    }
    
    @IBAction func deleteNote(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let ownerId = appDelegate.loggedInUser?.userId
        //Delete is allowed only for Note owner
        if(ownerId == self.notesToBeEdited.ownerId){
        let alert = UIAlertController(title: "Notes Delete", message: StringConstants.deleteConfirmation, preferredStyle: UIAlertControllerStyle.alert)
        let continueAction = UIAlertAction(title: "Delete", style: .default) {
            action in
            
        let date = Date()
        print(date)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000+0000"
        let timeStamp = dateFormatter.string(from: date)
        print(timeStamp)
        
            self.notesToBeEdited.lastModifiedDate = timeStamp
        let attributeDict = ["type":"SGWS_Account_Notes__c"]
        
        let editNoteDict: [String:Any] = [
            AccountNotes.AccountNotesFields[0]: self.notesToBeEdited.Id,
            kSyncTargetLocal:true,
            kSyncTargetLocallyCreated:false,
            kSyncTargetLocallyUpdated:false,
            kSyncTargetLocallyDeleted:true,
            "attributes":attributeDict]
        
        let success = AccountsNotesViewModel().deleteNotesLocally(fields: editNoteDict)
        print("Note is deleted \(success)")
        if(success){
        self.dismiss(animated: true, completion: {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshNotesListPostDelete"), object:nil)
        })
        } else {
            //Alert errors 
        }
            }
            alert.addAction(continueAction)
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
        }else{
            return
        }
    }
    
    
    func dismissEditNote(){
        
        self.dismiss(animated: true, completion: nil)
        delegate?.navigateToNotesViewController()
    }
    
    func displayAccountNotes() {
        
    }
    
    func noteCreated() {
        
    }
    
    
    
    
}
