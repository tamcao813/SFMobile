//
//  ContactMenuTableTableViewCell.swift
//  SWSApp
//
//  Created by Thillaiganesh, C. on 23/04/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class ContactMenuTableTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var filterLabel: UILabel!
    @IBOutlet weak var borderView : UIView!
    @IBOutlet weak var dropDownImageView : UIImageView!
    
    @IBOutlet weak var locationField: UITextField!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var locationBorderView : UIView!

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
            
            switch indexPath.row{
            case 0:
                if ContactFilterMenuModel.allContacts == "YES"{
                    self.dropDownImageView.image = UIImage.init(named: "radioSelected")
                }else{
                    self.dropDownImageView.image = UIImage.init(named: "radioUnselected")
                }
            case 1:
                if ContactFilterMenuModel.contactsOnMyRoute == "YES"{
                    self.dropDownImageView.image = UIImage.init(named: "radioSelected")
                }else{
                    self.dropDownImageView.image = UIImage.init(named: "radioUnselected")
                }
            default:
                break
            }
            
        case 1:
            
            switch indexPath.row{
            case 0:
                if ContactFilterMenuModel.allRole == "YES"{
                    self.dropDownImageView.image = UIImage.init(named: "Checkbox Selected")
                }else{
                    self.dropDownImageView.image = UIImage.init(named: "Checkbox")
                }
            default:
                if ContactFilterMenuModel.functionRoles.contains(self.filterLabel.text!) {
                    self.dropDownImageView.image = UIImage.init(named: "Checkbox Selected")
                }
                else {
                    self.dropDownImageView.image = UIImage.init(named: "Checkbox")
                }
                break
            }
            
        case 2:
            
            switch indexPath.row{
            case 0:
                if ContactFilterMenuModel.allBuyingPower == "YES"{
                    self.dropDownImageView.image = UIImage.init(named: "Checkbox Selected")
                }else{
                    self.dropDownImageView.image = UIImage.init(named: "Checkbox")
                }
            case 1:
                if ContactFilterMenuModel.buyingPower == "YES"{
                    self.dropDownImageView.image = UIImage.init(named: "Checkbox Selected")
                }else{
                    self.dropDownImageView.image = UIImage.init(named: "Checkbox")
                }
            case 2:
                if ContactFilterMenuModel.nobuyingPower == "YES"{
                    self.dropDownImageView.image = UIImage.init(named: "Checkbox Selected")
                }else{
                    self.dropDownImageView.image = UIImage.init(named: "Checkbox")
                }
            default:
                /*
                if ContactFilterMenuModel.buyerFlags.contains(self.filterLabel.text!) {
                    self.dropDownImageView.image = UIImage.init(named: "Checkbox Selected")
                }
                else {
                    self.dropDownImageView.image = UIImage.init(named: "Checkbox")
                }*/
                break
            }
            
        default:
            break
            
        }
    }
    
    //Used to display Location item cell content
    func displayLocationItemCellContent( indexPath : IndexPath , placeHolderText : String){
        
        //This needs to be revisited for Contact Query
        
    }
    
}

