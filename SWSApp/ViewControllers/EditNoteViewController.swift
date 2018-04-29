//
//  EditNoteViewController.swift
//  SWSApp
//
//  Created by Jagadeeshwar Reddy on 22/04/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation
import UIKit

class EditNoteViewController : UIViewController{
    
    var dictname = [Dictionary<String, String>]()
    var dictIndex: Int!
    var notesToBeEdited: AccountNotes!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UITextView!
    @IBOutlet weak var titleLabel: UILabel!
    
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
        }
    }
    
//    func displayDictdata(name:[Dictionary<String, String>], index: Int){
//        dictname = name
//        dictIndex = index
//    }
    
    //MARK:- IB  button actions
    @IBAction func close(_sender: Any){
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func editNote(_ sender: Any) {
        self.performSegue(withIdentifier: "editToCreate", sender: nil)
    }
    
    @IBAction func deleteNote(_ sender: Any) {
        
        // dictname.remove(at: dictIndex)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
}
