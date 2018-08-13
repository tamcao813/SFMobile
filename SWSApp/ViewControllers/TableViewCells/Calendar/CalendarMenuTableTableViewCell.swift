//
//  CalendarMenuTableTableViewCell.swift
//  SWSApp
//
//  Created by Thillaiganesh, C. on 18/05/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class CalendarMenuTableTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var filterLabel: UILabel!
    @IBOutlet weak var borderView : UIView!
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
        if indexPath.section == 1{//Manager section
            
            let consult = titleContent![indexPath.row] as? Consultant
            self.filterLabel.text = consult?.name
        }
        else {
            self.filterLabel.text = titleContent![indexPath.row] as? String
        }
        
        //self.borderView.layer.borderColor = UIColor.init(red: 158/255, green: 158/255, blue: 158/255, alpha: 1.0).cgColor
        
        //self.filterLabel.text = titleContent![indexPath.row] as? String
        self.titleLabel.text = ""
        
        switch indexPath.section{
        case 0:
            displayEventTypeCellContent(indexPath)
        case 1:
            self.showManagerCell(indexPath: indexPath, rowContent: titleContent as! [Consultant])
        default:
            break
            
        }
    }
    
    //Show Manager Cell
    func showManagerCell(indexPath : IndexPath, rowContent: [Consultant]){
        self.dropDownImageView.image = UIImage.init(named: "radioUnselected")
        
        if let consult = CalendarFilterMenuModel.selectedConsultant {
            if consult.name == rowContent[indexPath.row].name && consult.id == rowContent[indexPath.row].id {
                self.dropDownImageView.image = UIImage.init(named: "radioSelected")
            }
        }
    }
    
    func displayEventTypeCellContent(_ indexPath : IndexPath){
        
        switch indexPath.row{
        case 0:
            if CalendarFilterMenuModel.visitsType == "YES"{
                self.dropDownImageView.image = UIImage.init(named: "Checkbox Selected")
            }else{
                self.dropDownImageView.image = UIImage.init(named: "Checkbox")
            }

        case 1:
            if CalendarFilterMenuModel.eventsType == "YES"{
                self.dropDownImageView.image = UIImage.init(named: "Checkbox Selected")
            }else{
                self.dropDownImageView.image = UIImage.init(named: "Checkbox")
            }

        default:
            break
        }
        
    }
    
}
