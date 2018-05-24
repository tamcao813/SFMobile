//
//  PastActionTableViewCell.swift
//  SWSApp
//
//  Created by shubham.e.shukla on 5/23/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class PastActionTableViewCell: UITableViewCell {

    @IBOutlet weak var pastActionDescription: UILabel!
    @IBOutlet weak var pastActionTitle: UILabel!
    @IBOutlet weak var pastActionImage: UIImageView!
    @IBOutlet weak var pastActionTimeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
