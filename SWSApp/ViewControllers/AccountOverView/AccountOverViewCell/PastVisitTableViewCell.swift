//
//  AccountOverView_PastActivitiesTableViewCell.swift
//  SWSApp
//
//  Created by shubham.e.shukla on 5/11/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class PastVisitTableViewCell: UITableViewCell {

    @IBOutlet weak var PastActivities_TitleLabel: UILabel!
    
    @IBOutlet weak var PastActivities_DetailLabel: UILabel!
    
    @IBOutlet weak var PastActivities_ImageView: UIImageView!
    
    @IBOutlet weak var PastActivities_TimeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
