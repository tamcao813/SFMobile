//
//  UpComingActionTableViewCell.swift
//  SWSApp
//
//  Created by shubham.e.shukla on 5/23/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class UpComingActionTableViewCell: UITableViewCell {

    @IBOutlet weak var upcomingActionTimeLabel: UILabel!
    @IBOutlet weak var upcomingActionImage: UIImageView!
    @IBOutlet weak var upcomingActionTitle: UILabel!
    @IBOutlet weak var upcomingActionDescription: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
