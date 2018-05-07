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
        if textView.tag == 1 {
            contactDetail?.likes = descriptionTextView.text!
        }else if textView.tag == 2 {
            contactDetail?.dislikes = descriptionTextView.text!
        }else if textView.tag == 3 {
            contactDetail?.favouriteActivities = descriptionTextView.text!
        }else{
            contactDetail?.sgwsNotes = descriptionTextView.text!
        }
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        CreateNewContactViewController.createNewGlobals.userInput = true
        return true
    }
}
