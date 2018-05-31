//
//  AccountVisitListFilterTableViewCell.swift
//  SWSApp
//
//  Created by r.a.jantakal on 25/05/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

protocol ReloadTableViewForNewAppliedFilterDelegate {
    func reloadTableView()
}

class AccountVisitListFilterTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dropDownImageView : UIImageView!
    
    @IBOutlet weak var lblStartDate : UITextField?
    @IBOutlet weak var lblEndDate : UITextField?
    
    var delegate : ReloadTableViewForNewAppliedFilterDelegate?
    let datePickerView = UIDatePicker()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lblStartDate?.addPaddingLeft(10)
        lblEndDate?.addPaddingLeft(10)
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
    
    func dateView(textField: UITextField) {
        let inputView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 240))
        inputView.backgroundColor = UIColor.white
        datePickerView.frame.origin = CGPoint(x: 350, y: 20)
        datePickerView.datePickerMode = .date
        datePickerView.minuteInterval = 15
        inputView.addSubview(datePickerView) // add date picker to UIView
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(handleDatePicker(sender:)))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(doneButton(sender:)))
        doneButton.tag = textField.tag
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        textField.inputView = inputView
        textField.inputAccessoryView = toolBar
    }
    
    @objc func handleDatePicker(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if sender.tag == 300{
            lblStartDate?.text = dateFormatter.string(from: datePickerView.date)
        }else{
            lblEndDate?.text = dateFormatter.string(from: datePickerView.date)
        }
        
        if ((lblStartDate?.text! == "") && (lblEndDate?.text! == "")) {
            if DateTimeUtility.getDDMMYYYFormattedDateFromString(dateString: (lblStartDate?.text!)!).compare(DateTimeUtility.getDDMMYYYFormattedDateFromString(dateString: (lblEndDate?.text!)!)) == .orderedDescending  {
                lblEndDate?.text! = ""
                
                let alert = UIAlertView()
                alert.title = "Alert"
                alert.message = "Start Date should be lesser than End Date"
                alert.addButton(withTitle: "OK")
                alert.show()
            }
        }
        resignTextField()
        self.endEditing(true)
    }
    
    func resignTextField(){
        lblStartDate?.resignFirstResponder()
        lblEndDate?.resignFirstResponder()
    }
    
    @objc func doneButton(sender:UIButton){
        resignTextField()
        self.endEditing(true)// To resign the inputView on clicking done.
    }
}

//MARK:- UITextField Delegate
extension AccountVisitListFilterTableViewCell: UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField.tag == 300{
            self.dateView(textField: textField)
        }else{
            self.dateView(textField: textField)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        AccountVisitListFilterModel.isToday = "NO"
        AccountVisitListFilterModel.isTomorrow = "NO"
        AccountVisitListFilterModel.isThisWeek = "NO"
        
        delegate?.reloadTableView()
        
        if textField.tag == 300{
            AccountVisitListFilterModel.startDate = textField.text!
        }else{
            AccountVisitListFilterModel.endDate = textField.text!
        }
    }
}




