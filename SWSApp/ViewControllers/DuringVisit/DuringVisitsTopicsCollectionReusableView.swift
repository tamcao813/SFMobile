//
//  DuringVisitsTopicsCollectionReusableView.swift
//  SWSApp
//
//  Created by r.a.jantakal on 26/04/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class DuringVisitsTopicsCollectionReusableView: UICollectionReusableView {
    
    @IBOutlet weak var lblHeaderText : UILabel?
    @IBOutlet weak var lblSubSectionHeader : UILabel?
    
    //Used to present the header data
    func displayHeaderViewData(data : NSMutableArray , indexPath : IndexPath){
        let headerQuestion = data[indexPath.section] as! NSDictionary
        self.lblHeaderText?.text = (headerQuestion["headerText"] as! String)
        self.lblSubSectionHeader?.text = (headerQuestion["subHeader"] as! String)
        
    }
    
}



