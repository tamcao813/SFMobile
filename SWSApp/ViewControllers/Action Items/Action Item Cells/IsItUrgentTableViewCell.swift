//
//  IsItUrgentTableViewCell.swift
//  SWSApp
//
//  Created by manu.a.gupta on 11/05/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit


class IsItUrgentTableViewCell: UITableViewCell {

    @IBOutlet weak var isUrgentSwitch: UISwitch!
    @IBOutlet weak var  switchValueLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func switchValueChanged(_ sender: Any) {
        CreateNewActionItemViewController.createActionItemsGlobals.userInput = true
        if isUrgentSwitch.isOn {
            switchValueLabel.text = "Yes"
        }else{
            switchValueLabel.text = "No"
        }
    }
}
