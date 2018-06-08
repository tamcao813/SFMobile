//
//  NotificationListTableViewCell.swift
//  SWSApp
//
//  Created by manu.a.gupta on 31/05/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class NotificationListTableViewCell: UITableViewCell {

    @IBOutlet weak var notificationTitle: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var notificationImage: UIImageView!
    @IBOutlet weak var isReadView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func displayCellContent(notificationObject: Notifications){
        dateLabel.text = DateTimeUtility.convertUtcDatetoReadableDateString(dateString:notificationObject.createdDate)
        // dateLabel.text =  notificationObject.createdDate
        if notificationObject.isRead {
            isReadView.backgroundColor = .clear
        }else{
            isReadView.backgroundColor = UIColor(named: "Data New")
        }
        
        if notificationObject.sgwsType == "Birthday" {
            let image = #imageLiteral(resourceName: "Calender").withRenderingMode(.alwaysTemplate)
            notificationImage.image = image
            notificationImage.tintColor = UIColor(named: "Data New")
            notificationTitle.text = notificationObject.sgwsContactBirthdayNotification
        }else{
            notificationImage.image = #imageLiteral(resourceName: "Small Status Critical")
            notificationTitle.text = notificationObject.sgwsAccLicenseNotification
        }
    }

}
