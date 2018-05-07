//
//  AccountStrategyCollectionReusableView.swift
//  SWSApp
//
//  Created by r.a.jantakal on 24/04/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class AccountStrategyCollectionReusableView: UICollectionReusableView {
    
    @IBOutlet weak var headerLabel : UILabel?
    @IBOutlet weak var questionLabel : UILabel?
    
    
    //Used to present the header data
    func displayHeaderViewData(data : NSMutableArray , indexPath : IndexPath){
        let headerQuestion = data[indexPath.section] as! NSDictionary
        self.headerLabel?.text = (headerQuestion["header"] as! String)
        self.questionLabel?.text = (headerQuestion["subHeader"] as! String)
    }
}
