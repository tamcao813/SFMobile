//
//  EventLocationTableViewCell.swift
//  SWSApp
//
//  Created by vipin.vijay on 22/05/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class EventLocationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        label.sizeToFit()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        
    }
    
}
