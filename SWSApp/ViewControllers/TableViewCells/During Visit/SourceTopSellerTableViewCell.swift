//
//  SourceTopSellerTableViewCell.swift
//  SWSApp
//
//  Created by chandana on 13/06/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit
import SwipeCellKit

protocol SourceTableCellDelegate : class {
    func updateDataFromTopSellerCellTextfield(_ index: Int,commit: String)
    func updateDataFromTopSellerCellButton(_index:Int , outcome:String)
}
class InsightsSourceTopSellerTableViewCell: UITableViewCell,UITextFieldDelegate{
    
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var r12Label: UILabel!
    @IBOutlet weak var r6TrendLabel: UILabel!
    @IBOutlet weak var r3TrendLabel: UILabel!
    @IBOutlet weak var commitAmtTextFiels: UITextField!
    @IBOutlet weak var outcomeButton: UIButton!
    weak var cellDelegate: SourceTableCellDelegate?
    var buttonTag:Int?

    let dropDown = DropDown()

    override func awakeFromNib() {
        super.awakeFromNib()
        self.addNewDropDown()
        // Initialization code
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        cellDelegate?.updateDataFromTopSellerCellTextfield(textField.tag,commit:textField.text!)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if(range.length + range.location > (textField.text?.count)!)
        {
            return false
        }
        
        if string == "\n" || string == ""{
            return true
        }else if (textField.text?.count)! > 4{
            return false
        }
        
        let inverseSet = NSCharacterSet(charactersIn:"0123456789").inverted
        let components = string.components(separatedBy: inverseSet)
        let filtered = components.joined(separator: "")
        
        if filtered == string {
            return true
        } else {
            if string == "." {
                let countdots = textField.text!.components(separatedBy:".").count - 1
                if countdots == 0 {
                    return true
                }else{
                    if countdots > 0 && string == "." {
                        return false
                    } else {
                        return true
                    }
                }
            }else{
                return false
            }
        }
    }
    
    func addNewDropDown() {
        dropDown.anchorView = self.outcomeButton
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.backgroundColor = UIColor.white
        dropDown.selectionBackgroundColor = UIColor.clear
        dropDown.shadowOffset = CGSize(width: 0, height: 15)
        dropDown.textFont = UIFont(name:"Ubuntu", size: 14.0)!
      //  dropDown.dataSource = self.dropDownOptions
        dropDown.selectionAction = { (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.outcomeButton.setTitle(item, for: UIControlState.normal)
            self.cellDelegate?.updateDataFromTopSellerCellButton(_index: self.buttonTag!, outcome: item)
            self.dropDown.hide()
        }
    }
    
    
    @IBAction func showDropDownMenu(sender:UIButton) {
        self.endEditing(true)
        buttonTag = sender.tag
        dropDown.show()
    }

    
    
}
