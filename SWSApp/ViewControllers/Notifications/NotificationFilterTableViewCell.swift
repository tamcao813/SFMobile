//
//  NotificationFilterTableViewCell.swift
//  SWSApp
//
//  Created by manu.a.gupta on 01/06/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class NotificationFilterTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dropDownImageView : UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //Used to display cell content
    func displayCellContent(sectionContent : NSArray , indexPath : IndexPath){
        let titleContent = sectionContent[indexPath.section] as? NSArray
        self.titleLabel.text = titleContent![indexPath.row] as? String
        
        switch indexPath.section{
        case 0:
            self.showNotificationTypeCell(indexPath: indexPath)
        case 1:
            self.showNotificationHeadCell(indexPath: indexPath)
        default:
            break
        }
    }
    
    func showNotificationTypeCell(indexPath : IndexPath){
        switch indexPath.row{
        case 0:
            if NotificationFilterModel.isLicenseExpiration == "YES"{
                self.dropDownImageView.image = UIImage.init(named: "Checkbox Selected")
            }else{
                self.dropDownImageView.image = UIImage.init(named: "Checkbox")
            }
            
        case 1:
            if NotificationFilterModel.isContactBirthday == "YES"{
                self.dropDownImageView.image = UIImage.init(named: "Checkbox Selected")
            }else{
                self.dropDownImageView.image = UIImage.init(named: "Checkbox")
            }
        default:
            break
        }
    }
    
    func showNotificationHeadCell(indexPath : IndexPath){
        switch indexPath.row{
        case 0:
            if NotificationFilterModel.isRead == "YES"{
                self.dropDownImageView.image = UIImage.init(named: "Checkbox Selected")
            }else{
                self.dropDownImageView.image = UIImage.init(named: "Checkbox")
            }
            
        case 1:
            if NotificationFilterModel.isUnread == "YES"{
                self.dropDownImageView.image = UIImage.init(named: "Checkbox Selected")
            }else{
                self.dropDownImageView.image = UIImage.init(named: "Checkbox")
            }
            
        default:
            break
        }
    }
}
