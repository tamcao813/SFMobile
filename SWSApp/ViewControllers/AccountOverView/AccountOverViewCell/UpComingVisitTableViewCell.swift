//
//  AccountOverView_UpComingTableViewCell.swift
//  SWSApp
//
//  Created by shubham.e.shukla on 5/11/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class UpComingVisitTableViewCell: UITableViewCell {
    
    @IBOutlet weak var UpComingActivities_TitleLabel: UILabel!
    @IBOutlet weak var UpComingActivities_DetailsLabel: UILabel!
    @IBOutlet weak var UpComingActivities_TimeLabel: UILabel!
    @IBOutlet weak var UpComingActivities_Image: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
