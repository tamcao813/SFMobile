//
//  AccountStrategyCollectionViewCell.swift
//  SWSApp
//
//  Created by r.a.jantakal on 24/04/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class AccountStrategyCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lblTitleText : UILabel?
    
    //Display Collection View data
    func displayCellData(data : NSMutableDictionary, indexPath: IndexPath , arrayData : NSMutableArray){
        if indexPath.section < arrayData.count - 1{
             lblTitleText?.text = "\u{2022} " + (data["answerText"] as! String)
        }else{
 
            //lblTitleTextConstraint?.constant = -50
            lblTitleText?.text = (data["answerText"] as! String)
        }
    }
}
