//
//  AccountsMenuTableTableViewCell.swift
//  SWSApp
//
//  Created by r.a.jantakal on 01/04/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class AccountsMenuTableTableViewCell: UITableViewCell {
    
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
        
        if indexPath.section == 8 { //Manager section
            let consult = titleContent![indexPath.row] as? Consultant
            self.filterLabel.text = consult?.name
        }
        else {
            self.filterLabel.text = titleContent![indexPath.row] as? String
        }
        
        self.titleLabel.text = ""
        
        switch indexPath.section{
        case 0:
            self.showPastDueCell(indexPath: indexPath)
            
        case 2:
            self.showStatusCell(indexPath: indexPath)
            
        case 3:
            self.showPremiseCell(indexPath: indexPath)
            
        case 4:
            self.showSingleOrMultiSelectionCell(indexPath: indexPath)
            
        case 5:
            self.showChannelCell(indexPath: indexPath)
            
        case 6:
            self.showSubchannelCell(indexPath: indexPath)
            
        case 7:
            self.showLicenseCell(indexPath: indexPath)
        
        case 8:
            self.showManagerCell(indexPath: indexPath, rowContent: titleContent as! [Consultant])
            
        default:
            break
        }
    }
    
    //Show PastDue Cell
    func showPastDueCell(indexPath : IndexPath){
        
        switch indexPath.row{
        case 0:
            if FilterMenuModel.pastDueYes == "YES"{
                self.dropDownImageView.image = UIImage.init(named: "radioSelected")
            }else{
                self.dropDownImageView.image = UIImage.init(named: "radioUnselected")
            }
        case 1:
            if FilterMenuModel.pastDueNo == "YES"{
                self.dropDownImageView.image = UIImage.init(named: "radioSelected")
            }else{
                self.dropDownImageView.image = UIImage.init(named: "radioUnselected")
            }
        default:
            break
        }
    }
    
    //Show Status Cell
    func showStatusCell(indexPath : IndexPath){
        
        switch indexPath.row{
        case 0:
            if FilterMenuModel.statusIsActive != ""{
                self.dropDownImageView.image = UIImage.init(named: "radioSelected")
            }else{
                self.dropDownImageView.image = UIImage.init(named: "radioUnselected")
            }
        case 1:
            if FilterMenuModel.statusIsInActive != ""{
                self.dropDownImageView.image = UIImage.init(named: "radioSelected")
            }else{
                self.dropDownImageView.image = UIImage.init(named: "radioUnselected")
            }
        case 2:
            if FilterMenuModel.statusIsSuspended != ""{
                self.dropDownImageView.image = UIImage.init(named: "radioSelected")
            }else{
                self.dropDownImageView.image = UIImage.init(named: "radioUnselected")
            }
        default:
            break
        }
    }
    
    //Show Premise Cell
    func showPremiseCell(indexPath : IndexPath){
        
        switch indexPath.row{
        case 0:
            if FilterMenuModel.premiseOn == "YES"{
                self.dropDownImageView.image = UIImage.init(named: "radioSelected")
            }else{
                self.dropDownImageView.image = UIImage.init(named: "radioUnselected")
            }
        case 1:
            if FilterMenuModel.premiseOff == "YES"{
                self.dropDownImageView.image = UIImage.init(named: "radioSelected")
            }else{
                self.dropDownImageView.image = UIImage.init(named: "radioUnselected")
            }
        default:
            break
        }
    }
    
    //Show Single or Multi Selection Cell
    func showSingleOrMultiSelectionCell(indexPath : IndexPath){
        
        switch indexPath.row{
        case 0:
            if FilterMenuModel.singleSelected == "YES"{
                self.dropDownImageView.image = UIImage.init(named: "radioSelected")
            }else{
                self.dropDownImageView.image = UIImage.init(named: "radioUnselected")
            }
        case 1:
            if FilterMenuModel.multiSelected == "YES"{
                self.dropDownImageView.image = UIImage.init(named: "radioSelected")
            }else{
                self.dropDownImageView.image = UIImage.init(named: "radioUnselected")
            }
        default:
            break
        }
    }
    
    //Show Channel Cell
    func showChannelCell(indexPath : IndexPath){
        
        if FilterMenuModel.channelIndex == indexPath.row{
            if FilterMenuModel.channel != ""{
                self.dropDownImageView.image = UIImage.init(named: "radioSelected")
            }else{
                self.dropDownImageView.image = UIImage.init(named: "radioUnselected")
            }
        }else{
            self.dropDownImageView.image = UIImage.init(named: "radioUnselected")
        }
    }
    
    //Show Subchannel Cell
    func showSubchannelCell(indexPath : IndexPath){
        
        if FilterMenuModel.subChannelIndex == indexPath.row{
            if FilterMenuModel.subChannel != ""{
                self.dropDownImageView.image = UIImage.init(named: "radioSelected")
            }else{
                self.dropDownImageView.image = UIImage.init(named: "radioUnselected")
            }
        }else{
            self.dropDownImageView.image = UIImage.init(named: "radioUnselected")
        }
    }
    
    //Show License Cell
    func showLicenseCell(indexPath : IndexPath){
        
        switch indexPath.row{
        case 0:
            if FilterMenuModel.licenseW == "YES"{
                self.dropDownImageView.image = UIImage.init(named: "radioSelected")
            }else{
                self.dropDownImageView.image = UIImage.init(named: "radioUnselected")
            }
        case 1:
            if FilterMenuModel.licenseL == "YES"{
                self.dropDownImageView.image = UIImage.init(named: "radioSelected")
            }else{
                self.dropDownImageView.image = UIImage.init(named: "radioUnselected")
            }
        case 2:
            if FilterMenuModel.licenseB == "YES"{
                self.dropDownImageView.image = UIImage.init(named: "radioSelected")
            }else{
                self.dropDownImageView.image = UIImage.init(named: "radioUnselected")
            }
        case 3:
            if FilterMenuModel.licenseN == "YES"{
                self.dropDownImageView.image = UIImage.init(named: "radioSelected")
            }else{
                self.dropDownImageView.image = UIImage.init(named: "radioUnselected")
            }
        default:
            break
        }
    }
    
    //Show Manager Cell
    func showManagerCell(indexPath : IndexPath, rowContent: [Consultant]){
        self.dropDownImageView.image = UIImage.init(named: "radioUnselected")
        
        if let consult = FilterMenuModel.selectedConsultant {
            if consult.name == rowContent[indexPath.row].name && consult.id == rowContent[indexPath.row].id {
                self.dropDownImageView.image = UIImage.init(named: "radioSelected")
            }
        }
    }
    
    //Used to display Location item cell content
    func displayLocationItemCellContent( indexPath : IndexPath , placeHolderText : String){
        
        self.locationLabel.text = "Location"
        self.locationBorderView.layer.borderColor = UIColor.init(red: 158/255, green: 158/255, blue: 158/255, alpha: 1.0).cgColor
        
        if FilterMenuModel.city == ""{
            self.locationField.placeholder = placeHolderText
        }else{
            self.locationField.text = FilterMenuModel.city
        }
    }
}

//MARK:- TextField Delegate Methods
extension AccountsMenuTableTableViewCell : UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        FilterMenuModel.city = textField.text!
    }
}



