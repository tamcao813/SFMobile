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
        notificationTitle.text = notificationObject.name
        dateLabel.text = notificationObject.createdDate
        if notificationObject.isRead {
            isReadView.backgroundColor = .clear
        }else{
            isReadView.backgroundColor = UIColor(named: "Data New")
        }
        
        if notificationObject.sgwsAccLicenseNotification != ""{
            notificationImage.image = #imageLiteral(resourceName: "Small Status Critical")
        }
        
        if notificationObject.sgwsContactBirthdayNotification != "" {
            let image = #imageLiteral(resourceName: "Calender").withRenderingMode(.alwaysTemplate)
            notificationImage.image = image
            notificationImage.tintColor = UIColor(named: "Data New")
        }
    }

}
