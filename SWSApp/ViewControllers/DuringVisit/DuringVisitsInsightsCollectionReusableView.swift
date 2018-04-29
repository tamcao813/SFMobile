//
//  DuringVisitsInsightsCollectionReusableView.swift
//  SWSApp
//
//  Created by r.a.jantakal on 27/04/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class DuringVisitsInsightsCollectionReusableView: UICollectionReusableView {
    
    @IBOutlet weak var lblHeaderText : UILabel?
    
    //Used to present the header data
    func displayHeaderViewData(data : NSMutableArray , indexPath : IndexPath){
        let headerQuestion = data[indexPath.section] as! NSDictionary
        self.lblHeaderText?.text = (headerQuestion["headerText"] as! String)
    }
    
}
