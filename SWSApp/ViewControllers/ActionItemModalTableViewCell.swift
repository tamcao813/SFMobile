//
//  ActionItemModalTableViewCell.swift
//  SWSApp
//
//  Created by Jagadeeshwar Reddy on 22/06/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation


class ActionItemModalTableViewCell:UITableViewCell{
    
    //MARK:IBOutlets
    @IBOutlet weak var statusLbl : UILabel?
    @IBOutlet weak var dueDateLbl: UILabel!
    @IBOutlet weak var actionItemTitleLbl: UILabel!
    
   override func awakeFromNib() {
        super.awakeFromNib()
    }
}
