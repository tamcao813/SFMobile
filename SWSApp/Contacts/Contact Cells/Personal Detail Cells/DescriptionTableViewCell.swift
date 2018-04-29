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
    override func awakeFromNib() {
        super.awakeFromNib()
        customUI()
    }
    
    func customUI() {
        
    }
}

