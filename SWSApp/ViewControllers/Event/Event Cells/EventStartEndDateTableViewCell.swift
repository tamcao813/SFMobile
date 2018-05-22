//
//  EventStartEndDateTableViewCell.swift
//  SWSApp
//
//  Created by r.a.jantakal on 21/05/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class EventStartEndDateTableViewCell: UITableViewCell {

    @IBOutlet weak var eventStartDateTextField: UITextField!
    @IBOutlet weak var eventStartTimeTextField: UITextField!
    @IBOutlet weak var eventEndDateTextField: UITextField!
    @IBOutlet weak var eventEndTimeTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customizedUI()
    }
    
    func customizedUI(){
        eventStartDateTextField.addPaddingLeft(10)
        eventStartTimeTextField.addPaddingLeft(10)
        eventEndDateTextField.addPaddingLeft(10)
        eventEndTimeTextField.addPaddingLeft(10)
    }
}
