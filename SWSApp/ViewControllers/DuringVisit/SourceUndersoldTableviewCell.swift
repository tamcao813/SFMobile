//
//  SourceUndersoldTableviewCell.swift
//  SWSApp
//
//  Created by chandana on 14/06/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit
import SwipeCellKit

protocol InsightsUndersoldSourceTableCellDelegate : class {
    func updateDataFromUndersoldTableCellTextfield(_ index: Int,commit: String)
    func updateDataFromUndersoldTableCellButton(index:Int,outcome:String)
}

class InsightsSourceUnderSoldTableViewCell: UITableViewCell,UITextFieldDelegate {
    
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var accLabel: UILabel!
    @IBOutlet weak var segmentLabel: UILabel!
    @IBOutlet weak var gapLabel: UILabel!
    @IBOutlet weak var commitAmtTextFiels: UITextField!
    @IBOutlet weak var outcomeButton: UIButton!
    let dropDown = DropDown()
    var buttonTag:Int?
    weak var cellDelegate: InsightsUndersoldSourceTableCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addNewDropDown()

        // Initialization code
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        cellDelegate?.updateDataFromUndersoldTableCellTextfield(textField.tag,commit:textField.text!)
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
            self.cellDelegate?.updateDataFromUndersoldTableCellButton(index: self.buttonTag!, outcome: item)

            self.dropDown.hide()
        }
    }
    
    @IBAction func showDropDownMenu(sender:UIButton) {
        buttonTag = sender.tag
        dropDown.show()
    }
    
    
    
}
