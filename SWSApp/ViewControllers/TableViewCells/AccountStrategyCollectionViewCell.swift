//
//  AccountStrategyCollectionViewCell.swift
//  SWSApp
//
//  Created by r.a.jantakal on 23/04/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class AccountStrategyCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var centerLabel : UILabel?
    @IBOutlet weak var textView : UITextView?
    @IBOutlet weak var bottomView : UIView?
    @IBOutlet weak var selectedIcon : UIImageView?
    
    //Display Collection View data
    func displayCellData(data : NSMutableDictionary){
        self.centerLabel?.text = (data["answerText"] as! String)
        
        if (data["isSelected"] as! String) == "NO"{
            self.layer.borderColor = UIColor.white.cgColor
            selectedIcon?.isHidden = true
        }else{
            self.layer.borderColor = UIColor(named: "Data New")?.cgColor
            selectedIcon?.isHidden = false
        }
    }
}


//MARK:- UITextView Delegate
extension AccountStrategyCollectionViewCell : UITextViewDelegate{
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n"{
            self.endEditing(true)
        }
        return true
    }
}
