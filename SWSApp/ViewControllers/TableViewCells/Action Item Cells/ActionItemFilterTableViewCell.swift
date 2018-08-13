//
//  ActionItemFilterTableViewCell.swift
//  SWSApp
//
//  Created by manu.a.gupta on 21/05/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class ActionItemFilterTableViewCell: UITableViewCell {

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
        
        if indexPath.section == 3 { //Manager section
            let consult = titleContent![indexPath.row] as? Consultant
            self.titleLabel.text = consult?.name
        }
        else {
            self.titleLabel.text = titleContent![indexPath.row] as? String
        }

        switch indexPath.section{
        case 0:
            self.showActionStatusCell(indexPath: indexPath)
        case 1:
            self.showActionTypeCell(indexPath: indexPath)
        case 2:
            self.showDueDateCell(indexPath: indexPath)
        case 3:
            self.showManagerCell(indexPath: indexPath, rowContent: titleContent as! [Consultant])
        default:
            break
        }
    }
    
    func showActionStatusCell(indexPath : IndexPath){
        switch indexPath.row{
        case 0:
            if ActionItemFilterModel.isComplete == "YES"{
                self.dropDownImageView.image = UIImage.init(named: "Checkbox Selected")
            }else{
                self.dropDownImageView.image = UIImage.init(named: "Checkbox")
            }
            
        case 1:
            if ActionItemFilterModel.isOpen == "YES"{
                self.dropDownImageView.image = UIImage.init(named: "Checkbox Selected")
            }else{
                self.dropDownImageView.image = UIImage.init(named: "Checkbox")
            }
            
        case 2:
            if ActionItemFilterModel.isOverdue == "YES"{
                self.dropDownImageView.image = UIImage.init(named: "Checkbox Selected")
            }else{
                self.dropDownImageView.image = UIImage.init(named: "Checkbox")
            }
            
        default:
            break
        }
    }
    
    func showActionTypeCell(indexPath : IndexPath){
        switch indexPath.row{
        case 0:
            if ActionItemFilterModel.isUrgent == "YES"{
                self.dropDownImageView.image = UIImage.init(named: "Checkbox Selected")
            }else{
                self.dropDownImageView.image = UIImage.init(named: "Checkbox")
            }
            
        case 1:
            if ActionItemFilterModel.isNotUrgent == "YES"{
                self.dropDownImageView.image = UIImage.init(named: "Checkbox Selected")
            }else{
                self.dropDownImageView.image = UIImage.init(named: "Checkbox")
            }
    
            default:
            break
        }
    }
    
    func showDueDateCell(indexPath : IndexPath){
        switch indexPath.row{
        case 0:
            if ActionItemFilterModel.dueYes == "YES"{
                self.dropDownImageView.image = UIImage.init(named: "Checkbox Selected")
            }else{
                self.dropDownImageView.image = UIImage.init(named: "Checkbox")
            }
            
        case 1:
            if ActionItemFilterModel.dueNo == "YES"{
                self.dropDownImageView.image = UIImage.init(named: "Checkbox Selected")
            }else{
                self.dropDownImageView.image = UIImage.init(named: "Checkbox")
            }
            
        default:
            break
        }
    }
    
    //Show Manager Cell
    func showManagerCell(indexPath : IndexPath, rowContent: [Consultant]){
        self.dropDownImageView.image = UIImage.init(named: "radioUnselected")
        
        if let consult = ActionItemFilterModel.selectedConsultant {
            if consult.name == rowContent[indexPath.row].name && consult.id == rowContent[indexPath.row].id {
                self.dropDownImageView.image = UIImage.init(named: "radioSelected")
            }
        }
    }
}





