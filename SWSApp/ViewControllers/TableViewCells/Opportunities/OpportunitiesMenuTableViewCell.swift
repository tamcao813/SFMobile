//
//  OpportunitiesMenuTableViewCell.swift
//  SWSApp
//
//  Created by Thillaiganesh, C. on 01/06/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class OpportunitiesMenuTableViewCell: UITableViewCell {

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
        
        //self.borderView.layer.borderColor = UIColor.init(red: 158/255, green: 158/255, blue: 158/255, alpha: 1.0).cgColor
        let titleContent = sectionContent[indexPath.section] as? NSArray
        self.filterLabel.text = titleContent![indexPath.row] as? String
        self.titleLabel.text = ""
        
        switch indexPath.section {
        case 0:
            displayViewByCellContent(indexPath)
            
        case 1:
            displayStatusCellContent(indexPath)
            
        case 2:
            displaySourceCellContent(indexPath)
            
        case 3:
            displayObjectiveCellContent(indexPath)
            
        default:
            break
            
        }
    }
    
    func displayViewByCellContent(_ indexPath : IndexPath){
        
        switch indexPath.row{
        case 0:
            if OpportunitiesFilterMenuModel.viewBy9L == "YES"{
                self.dropDownImageView.image = UIImage.init(named: "radioSelected")
            }else{
                self.dropDownImageView.image = UIImage.init(named: "radioUnselected")
            }
        case 1:
            if OpportunitiesFilterMenuModel.viewByCaseDecimal == "YES"{
                self.dropDownImageView.image = UIImage.init(named: "radioSelected")
            }else{
                self.dropDownImageView.image = UIImage.init(named: "radioUnselected")
            }
        default:
            break
        }
        
    }
    
    func displayStatusCellContent(_ indexPath : IndexPath){
        
        switch indexPath.row{
        case 0:
            if OpportunitiesFilterMenuModel.statusClosed == "YES"{
                self.dropDownImageView.image = UIImage.init(named: "Checkbox Selected")
            }else{
                self.dropDownImageView.image = UIImage.init(named: "Checkbox")
            }
            
        case 1:
            if OpportunitiesFilterMenuModel.statusClosedWon == "YES"{
                self.dropDownImageView.image = UIImage.init(named: "Checkbox Selected")
            }else{
                self.dropDownImageView.image = UIImage.init(named: "Checkbox")
            }
            
        case 2:
            if OpportunitiesFilterMenuModel.statusOpen == "YES"{
                self.dropDownImageView.image = UIImage.init(named: "Checkbox Selected")
            }else{
                self.dropDownImageView.image = UIImage.init(named: "Checkbox")
            }
            
        case 3:
            if OpportunitiesFilterMenuModel.statusPlanned == "YES"{
                self.dropDownImageView.image = UIImage.init(named: "Checkbox Selected")
            }else{
                self.dropDownImageView.image = UIImage.init(named: "Checkbox")
            }
            
        default:
            break
        }
        
    }
    
    func displaySourceCellContent(_ indexPath : IndexPath){
        
        switch indexPath.row{
        case 0:
            if OpportunitiesFilterMenuModel.sourceOverview == "YES"{
                self.dropDownImageView.image = UIImage.init(named: "Checkbox Selected")
            }else{
                self.dropDownImageView.image = UIImage.init(named: "Checkbox")
            }
            
        case 1:
            if OpportunitiesFilterMenuModel.sourceTopSellers == "YES"{
                self.dropDownImageView.image = UIImage.init(named: "Checkbox Selected")
            }else{
                self.dropDownImageView.image = UIImage.init(named: "Checkbox")
            }
            
        case 2:
            if OpportunitiesFilterMenuModel.sourceUndersold == "YES"{
                self.dropDownImageView.image = UIImage.init(named: "Checkbox Selected")
            }else{
                self.dropDownImageView.image = UIImage.init(named: "Checkbox")
            }
            
        case 3:
            if OpportunitiesFilterMenuModel.sourceHotNot == "YES"{
                self.dropDownImageView.image = UIImage.init(named: "Checkbox Selected")
            }else{
                self.dropDownImageView.image = UIImage.init(named: "Checkbox")
            }
            
        case 4:
            if OpportunitiesFilterMenuModel.sourceUnsold == "YES"{
                self.dropDownImageView.image = UIImage.init(named: "Checkbox Selected")
            }else{
                self.dropDownImageView.image = UIImage.init(named: "Checkbox")
            }
            
        default:
            break
        }
        
    }
    
    func displayObjectiveCellContent(_ indexPath : IndexPath){
        
        switch indexPath.row{
        case 0:
            if OpportunitiesFilterMenuModel.objective9L == "YES"{
                self.dropDownImageView.image = UIImage.init(named: "Checkbox Selected")
            }else{
                self.dropDownImageView.image = UIImage.init(named: "Checkbox")
            }
            
        case 1:
            if OpportunitiesFilterMenuModel.objectiveACS == "YES"{
                self.dropDownImageView.image = UIImage.init(named: "Checkbox Selected")
            }else{
                self.dropDownImageView.image = UIImage.init(named: "Checkbox")
            }
            
        case 2:
            if OpportunitiesFilterMenuModel.objectiveDecimal == "YES"{
                self.dropDownImageView.image = UIImage.init(named: "Checkbox Selected")
            }else{
                self.dropDownImageView.image = UIImage.init(named: "Checkbox")
            }
            
        case 3:
            if OpportunitiesFilterMenuModel.objectivePOD == "YES"{
                self.dropDownImageView.image = UIImage.init(named: "Checkbox Selected")
            }else{
                self.dropDownImageView.image = UIImage.init(named: "Checkbox")
            }
            
        case 4:
            if OpportunitiesFilterMenuModel.objectiveRevenue == "YES"{
                self.dropDownImageView.image = UIImage.init(named: "Checkbox Selected")
            }else{
                self.dropDownImageView.image = UIImage.init(named: "Checkbox")
            }
            
        default:
            break
        }
        
    }
    
}
