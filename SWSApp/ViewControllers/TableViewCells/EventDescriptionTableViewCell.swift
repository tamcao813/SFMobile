//
//  EventDescriptionTableViewCell.swift
//  SWSApp
//
//  Created by vipin.vijay on 22/05/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class EventDescriptionTableViewCell: UITableViewCell {
    
     @IBOutlet weak var descLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        descLabel.sizeToFit()
        descLabel.font = UIFont(name:"Ubuntu", size: 17.0)
    }
    
     override func setSelected(_ selected: Bool, animated: Bool) {
        
    }
    
}
