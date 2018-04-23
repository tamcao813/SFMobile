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
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UITextView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    func displayEditNoteData(title:String,date:String,description:String){
        self.dateLabel?.text = date
        self.descriptionLabel?.text = description
        self.titleLabel?.text = title
    }
    
    @IBAction func close(_sender: Any){
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func editNote(_ sender: Any) {
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Notes", bundle: nil)
        let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: "NotesID") as! CreateNoteViewController
        self.present(vc, animated: true, completion: nil)
        (vc as! CreateNoteViewController).displayCreateNoteData(title: (self.titleLabel?.text)!, description: (self.descriptionLabel?.text)!)
    }
    
    @IBAction func deleteNote(_ sender: Any) {
        
        
    }
    
    
    
    
}
