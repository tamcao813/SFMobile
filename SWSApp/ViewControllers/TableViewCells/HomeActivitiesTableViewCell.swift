//
//  HomeActivitiesTableViewCell.swift
//  SWSApp
//
//  Created by shubham.e.shukla on 6/4/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class HomeActivitiesTableViewCell: UITableViewCell {
    @IBOutlet weak var homeActivitiesTitle: UILabel!
    @IBOutlet weak var homeActivitiesImage: UIImageView!
    @IBOutlet weak var homeActivitiesTimeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
