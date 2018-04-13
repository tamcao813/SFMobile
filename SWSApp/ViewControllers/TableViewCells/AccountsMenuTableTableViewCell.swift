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
        self.filterLabel.text = titleContent![indexPath.row] as? String
        self.titleLabel.text = ""
        
        switch indexPath.section{
            case 0:
                
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
            
            case 2:
            
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
            
            case 3:
            
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
            
            case 4:
                
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
            
        case 5:           
            
            if FilterMenuModel.channelIndex == indexPath.row{
                if FilterMenuModel.channel != ""{
                    self.dropDownImageView.image = UIImage.init(named: "radioSelected")
                }else{
                    self.dropDownImageView.image = UIImage.init(named: "radioUnselected")
                }
            }else{
                self.dropDownImageView.image = UIImage.init(named: "radioUnselected")
            }
            
            
            //switch indexPath.row{
            //case 0:
//                if FilterMenuModel.channel != ""{
//                    self.dropDownImageView.image = UIImage.init(named: "radioSelected")
//                }else{
//                    self.dropDownImageView.image = UIImage.init(named: "radioUnselected")
//                }
            //default:
            //    break
           // }
            
        case 6:
            
            if FilterMenuModel.subChannelIndex == indexPath.row{
                if FilterMenuModel.subChannel != ""{
                    self.dropDownImageView.image = UIImage.init(named: "radioSelected")
                }else{
                    self.dropDownImageView.image = UIImage.init(named: "radioUnselected")
                }
            }else{
                self.dropDownImageView.image = UIImage.init(named: "radioUnselected")
            }
            
            
//            switch indexPath.row{
//            case 0:
//                if FilterMenuModel.subChannel != ""{
//                    self.dropDownImageView.image = UIImage.init(named: "radioSelected")
//                }else{
//                    self.dropDownImageView.image = UIImage.init(named: "radioUnselected")
//                }
//            default:
//                break
//            }
            
            
            case 7:
            
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
            default:
                break
            
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



