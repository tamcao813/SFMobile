//
//  DuringVisitsInsightsCollectionViewCell.swift
//  SWSApp
//
//  Created by r.a.jantakal on 27/04/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class DuringVisitsInsightsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lblItemName : UILabel?
    @IBOutlet weak var lblItemDescription : UILabel?
    @IBOutlet weak var lblObjectives : UILabel?
    @IBOutlet weak var lblCases : UILabel?
    @IBOutlet weak var lblChange : UILabel?
    @IBOutlet weak var lblStatus : UILabel?
    @IBOutlet weak var imgIcom : UIImageView?
    
    //Display Collection View data
    func displayCellData(data : NSMutableDictionary , indexPath : IndexPath){
        
        self.lblItemName?.text = data["itemName"] as? String
        self.lblItemDescription?.text = data["itemDescription"] as? String
        self.lblObjectives?.text = data["objectives"] as? String
        self.lblCases?.text = data["cases"] as? String
        self.lblChange?.text = data["changes"] as? String
        
        let completion = data["status"] as? String
        if completion == "0"{
            self.imgIcom?.isHidden = true
            self.lblStatus?.isHidden = false
        }else{
            self.imgIcom?.isHidden = false
            self.lblStatus?.isHidden = true
        }
        
        let change = data["percentage"] as? String
        if change == "1"{
            lblChange?.backgroundColor = UIColor(named: "Bad")
        }else{
            lblChange?.backgroundColor = UIColor(named: "Good")
        }
        
    }
}
