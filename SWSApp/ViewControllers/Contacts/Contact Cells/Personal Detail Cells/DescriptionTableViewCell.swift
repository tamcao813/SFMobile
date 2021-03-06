//
//  DescriptionTableViewCell.swift
//  SWSApp
//
//  Created by manu.a.gupta on 26/04/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class DescriptionTableViewCell: UITableViewCell {

    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    var contactDetail: Contact?
    var actionItemObject: ActionItem?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func displayCellContent(){
        if descriptionTextView.tag == 1 {
            descriptionTextView.text! = (contactDetail?.likes)!
        }else if descriptionTextView.tag == 2 {
            descriptionTextView.text! = (contactDetail?.dislikes)!
        }else if descriptionTextView.tag == 3 {
            descriptionTextView.text! = (contactDetail?.favouriteActivities)!
        }else{
            descriptionTextView.text! = (contactDetail?.sgwsNotes)!
        }
    }
}

extension DescriptionTableViewCell: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        
        CreateNewEventViewControllerGlobals.isFirstTimeLoad = false
        
        if textView.tag == 500{
            
            CreateNewEventViewControllerGlobals.description = textView.text!
            
            
        }else if textView.tag == 1 {
            contactDetail?.likes = descriptionTextView.text!
        }else if textView.tag == 2 {
            contactDetail?.dislikes = descriptionTextView.text!
        }else if textView.tag == 3 {
            contactDetail?.favouriteActivities = descriptionTextView.text!
        }else{
            contactDetail?.sgwsNotes = descriptionTextView.text!
        }
        
        if let actionItem = actionItemObject {
            actionItemObject?.description = textView.text
        }
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        CreateNewContactViewController.createNewGlobals.userInput = true
        CreateNewActionItemViewController.createActionItemsGlobals.userInput = true
        return true
    }
}
