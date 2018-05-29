//
//  AccountVisitListFilterTableViewCell.swift
//  SWSApp
//
//  Created by r.a.jantakal on 25/05/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class AccountVisitListFilterTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dropDownImageView : UIImageView!
    
    @IBOutlet weak var lblTitle : UILabel!
    @IBOutlet weak var lblDate : UITextField?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lblDate?.addPaddingLeft(10)
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
            self.showTypeCell(indexPath: indexPath)
        case 1:
            self.showDateRangeCell(indexPath: indexPath)
        case 2:
            self.showStatusCell(indexPath: indexPath)
        case 3:
            self.showPastVisitCell(indexPath: indexPath)
        default:
            break
        }
    }
    
    func showTypeCell(indexPath : IndexPath){
        switch indexPath.row{
        case 0:
            if AccountVisitListFilterModel.isTypeVisit == "YES"{
                self.dropDownImageView.image = UIImage(named: "Checkbox Selected")
            }else{
                self.dropDownImageView.image = UIImage(named: "Checkbox")
            }
        case 1:
            if AccountVisitListFilterModel.isTypeEvent == "YES"{
                self.dropDownImageView.image = UIImage(named: "Checkbox Selected")
            }else{
                self.dropDownImageView.image = UIImage(named: "Checkbox")
            }
        default:
            break
        }
    }
    
    func showDateRangeCell(indexPath : IndexPath){
        switch indexPath.row{
        case 2:
            if AccountVisitListFilterModel.isToday == "YES"{
                self.dropDownImageView.image = UIImage(named: "radioSelected")
            }else{
                self.dropDownImageView.image = UIImage(named: "radioUnselected")
            }
        case 3:
            if AccountVisitListFilterModel.isTomorrow == "YES"{
                self.dropDownImageView.image = UIImage(named: "radioSelected")
            }else{
                self.dropDownImageView.image = UIImage(named: "radioUnselected")
            }
        case 4:
            if AccountVisitListFilterModel.isThisWeek == "YES"{
                self.dropDownImageView.image = UIImage(named: "radioSelected")
            }else{
                self.dropDownImageView.image = UIImage(named: "radioUnselected")
            }
        default:
            break
        }
    }
    
    func showStatusCell(indexPath : IndexPath){
        switch indexPath.row{
        case 0:
            if AccountVisitListFilterModel.isStatusScheduled == "YES"{
                self.dropDownImageView.image = UIImage(named: "Checkbox Selected")
            }else{
                self.dropDownImageView.image = UIImage(named: "Checkbox")
            }
        case 1:
            if AccountVisitListFilterModel.isStatusPlanned == "YES"{
                self.dropDownImageView.image = UIImage(named: "Checkbox Selected")
            }else{
                self.dropDownImageView.image = UIImage(named: "Checkbox")
            }
        case 2:
            if AccountVisitListFilterModel.isInProgress == "YES"{
                self.dropDownImageView.image = UIImage(named: "Checkbox Selected")
            }else{
                self.dropDownImageView.image = UIImage(named: "Checkbox")
            }
        case 3:
            if AccountVisitListFilterModel.isComplete == "YES"{
                self.dropDownImageView.image = UIImage(named: "Checkbox Selected")
            }else{
                self.dropDownImageView.image = UIImage(named: "Checkbox")
            }
        default:
            break
        }
    }
    
    func showPastVisitCell(indexPath : IndexPath){
        switch indexPath.row{
        case 0:
            if AccountVisitListFilterModel.isPastVisits == "YES"{
                self.dropDownImageView.image = UIImage(named: "Checkbox Selected")
            }else{
                self.dropDownImageView.image = UIImage(named: "Checkbox")
            }
        default:
            break
        }
    }
}

extension AccountVisitListFilterTableViewCell: UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
}




