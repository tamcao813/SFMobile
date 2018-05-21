//
//  ActionItemTitleTableViewCell.swift
//  SWSApp
//
//  Created by manu.a.gupta on 11/05/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class ActionItemTitleTableViewCell: UITableViewCell {

    @IBOutlet weak var actionTitleTextField: UITextField!
    @IBOutlet weak var actionHeaderLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        customizedUI()
    }
    
    func customizedUI(){
        actionTitleTextField.addPaddingLeft(10)
    }
}
