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
    var notesEditTitleText: String!
    var notesEditDescriptionText: String!
    var notesEditDate: String!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UITextView!
    @IBOutlet weak var titleLabel: UILabel!
    
    //MARK:- View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.dateLabel?.text = notesEditDate
        self.descriptionLabel?.text = notesEditDescriptionText
        self.titleLabel?.text = notesEditTitleText
        
    }
    
    //MARK:- segue connection
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editToCreate" {
            let createNoteScreen = segue.destination as! CreateNoteViewController
            createNoteScreen.noteTitleText = notesEditTitleText
            createNoteScreen.noteDescriptionText = notesEditDescriptionText
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
