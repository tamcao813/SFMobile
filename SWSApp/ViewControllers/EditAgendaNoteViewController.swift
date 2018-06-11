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
        bgView.backgroundColor = UIColor.white
        bgView.layer.shadowColor = UIColor.lightGray.cgColor
        bgView.layer.shadowOpacity = 1
        bgView.layer.shadowOffset = CGSize.zero
        bgView.layer.shadowRadius = 5
        descriptionTextView.text = editNotesText
    }
    
    //MARK:- IBAction
    
    @IBAction func closeVC(sender: UIButton) {
        
        if editNotesText != descriptionTextView.text{
            AlertUtilities.showAlertMessageWithTwoActionsAndHandler("Any changes will not be saved", errorMessage: "Are you sure you want to close?", errorAlertActionTitle: "Yes", errorAlertActionTitle2: "No", viewControllerUsed: self, action1: {
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                }
            }){
                
            }
        }else{
            DispatchQueue.main.async {
                self.dismiss(animated: true)
            }
        }
    }
    
    @IBAction func saveAndClose(sender: UIButton) {
        PlanVisitManager.sharedInstance.visit?.description = descriptionTextView.text
        _ = PlanVisitManager.sharedInstance.editAndSaveVisit()
        DispatchQueue.main.async {
            self.dismiss(animated: true)
        }        
    }
}
