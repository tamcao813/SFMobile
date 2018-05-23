//
//  AccountStrategyCollectionReusableView.swift
//  SWSApp
//
//  Created by r.a.jantakal on 23/04/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class EditAccountStrategyCollectionReusableView: UICollectionReusableView {
    
    @IBOutlet weak var headerLabel : UILabel?
    @IBOutlet weak var questionLabel : UILabel?
    @IBOutlet weak var selectionLabel : UILabel?
    
    //Used to present the header data
    func displayHeaderViewData(data : NSMutableArray , indexPath : IndexPath){
        self.isHidden = false
        let headerQuestion = data[indexPath.section] as! NSDictionary
        self.headerLabel?.text = (headerQuestion["header"] as! String)
        self.questionLabel?.text = (headerQuestion["subHeader"] as! String) + ":*"
        
        if validateTheReguiredVield.isSaveClicked == "1"{
            if validateTheReguiredVield.showRedForQuestionHeader.contains(indexPath.section){
                self.questionLabel?.textColor = UIColor.red
            }else{
                self.questionLabel?.textColor = UIColor.black
            }
        }
        
        
//        if (headerQuestion["selectionType"] as! String) == "1"{
//            self.selectionLabel?.text = "Single Select"
//        }else{
//            self.selectionLabel?.text = "Multi Select"
//        }
    }
}
