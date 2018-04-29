//
//  ToggleTableViewCell.swift
//  SWSApp
//
//  Created by manu.a.gupta on 26/04/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class ToggleTableViewCell: UITableViewCell {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        questionLabel.text = "Does this contact have buying power?"
    }
    
    @IBAction func yesButtonTapped(_ sender: UIButton){
    
    }
    
    @IBAction func noButtonTapped(_ sender: UIButton){
        
    }
}
