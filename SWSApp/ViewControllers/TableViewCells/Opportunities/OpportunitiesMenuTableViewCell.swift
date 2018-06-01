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
        
        switch indexPath.section{
        case 0:
            displayViewByCellContent(indexPath)
            
        default:
            break
            
        }
    }
    
    func displayViewByCellContent(_ indexPath : IndexPath){
        
        switch indexPath.row{
        case 0:
            if OpportunitiesFilterMenuModel.viewByCaseDecimal == "YES"{
                self.dropDownImageView.image = UIImage.init(named: "radioSelected")
            }else{
                self.dropDownImageView.image = UIImage.init(named: "radioUnselected")
            }
        case 1:
            if OpportunitiesFilterMenuModel.viewBy9L == "YES"{
                self.dropDownImageView.image = UIImage.init(named: "radioSelected")
            }else{
                self.dropDownImageView.image = UIImage.init(named: "radioUnselected")
            }
        default:
            break
        }
        
    }
    

}
