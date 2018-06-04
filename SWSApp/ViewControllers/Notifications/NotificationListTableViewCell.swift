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
    
    func getDateTimeFromNotification(dateToConvert:String)-> String  {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000+0000"
        let date = dateFormatter.date(from: dateToConvert)
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let timeStamp = dateFormatter.string(from: date!)
        return timeStamp
    }
    
    func displayCellContent(notificationObject: Notifications){
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000+0000"
//        let date = dateFormatter.date(from: notificationObject.createdDate)
//
//        if (date?.isInThisWeek)!{
//            dateLabel.text = DateTimeUtility().getDayFrom(dateToConvert: notificationObject.createdDate)
//        }

        dateLabel.text = getDateTimeFromNotification(dateToConvert: notificationObject.createdDate)
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
