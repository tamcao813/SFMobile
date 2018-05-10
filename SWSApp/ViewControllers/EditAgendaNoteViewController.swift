//
//  EditAgendaNote.swift
//  SWSApp
//
//  Created by vipin.vijay on 07/05/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation

class EditAgendaNoteViewController: UIViewController {
    
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var bgView: UIView!
    
    var editNotesText:String = ""
    
    override func viewDidLoad() {
        bgView.dropShadow(color: .lightGray, opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
        descriptionTextView.text = editNotesText
        
    }
    
    //MARK:- IBAction
    
    @IBAction func closeVC(sender: UIButton) {
        
        self.dismiss(animated: true)
    }
    
    @IBAction func saveAndClose(sender: UIButton) {
        
        PlanVistManager.sharedInstance.visit?.description = descriptionTextView.text
        
        let status = PlanVistManager.sharedInstance.editAndSaveVisit()
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshAccountList"), object:nil)
        
        self.dismiss(animated: true)
    }
}
