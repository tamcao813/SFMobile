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
        }
    }
    
//    func displayDictdata(name:[Dictionary<String, String>], index: Int){
//        dictname = name
//        dictIndex = index
//    }
    
    //MARK:- IB  button actions
    @IBAction func close(_sender: Any){
        
        if ((titleLabel?.text)!.isEmpty){
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
        dataDictionary.setValue(titleLabel?.text, forKey: "title")
        dataDictionary.setValue(descriptionLabel?.text, forKey: "description")
        dataDictionary.setValue(datetime, forKey: "date")
        dataDictionary.setValue(timeresult, forKey: "time")
        sendDataToTable.dataDictionary = dataDictionary
        sendDataToTable.addDataToArray = 1
        self.editNote()
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
        //let dt = dateFormatter.date(from: date)
        // dateFormatter.timeZone = TimeZone
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000+0000"
        let timeStamp = dateFormatter.string(from: date)
        print(timeStamp)
                
        notesToBeEdited.lastModifiedDate = timeStamp
        let attributeDict = ["type":"SGWS_Account_Notes__c"]
        
        let editNoteDict: [String:Any] = [
            
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
        
        // dictname.remove(at: dictIndex)
        self.dismiss(animated: true, completion: nil)
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
