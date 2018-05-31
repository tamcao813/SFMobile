//
//  DuringVisitsTopicsCollectionViewCell.swift
//  SWSApp
//
//  Created by r.a.jantakal on 26/04/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

protocol NavigateToStrategyFromDuringVisitsDelegate {
    func navigateToStrategyScreen()
}

class DuringVisitsTopicsCollectionViewCell: UICollectionViewCell,UITextViewDelegate {
    
    //Address Cell
    @IBOutlet weak var lblStoreName : UILabel?
    @IBOutlet weak var lblPinCode : UILabel?
    @IBOutlet weak var lblAddress : UILabel?
    @IBOutlet weak var addressView : UIView?
    
    //Notes Cell
    @IBOutlet weak var lblNotesHeading : UILabel?
    @IBOutlet weak var lblNotesContent : UILabel?
    @IBOutlet weak var lblNotesDescription : UITextView?
    @IBOutlet weak var notesView : UIView?
    
    //Account Situation Cell
    @IBOutlet weak var lblCenterLabel : UILabel?
    
    var delegate : NavigateToStrategyFromDuringVisitsDelegate?
    
    
    override func awakeFromNib() {
        addressView?.layer.borderColor = UIColor.lightGray.cgColor//(named: "LightGrey")?.cgColor
        notesView?.layer.borderColor = UIColor.lightGray.cgColor//(named: "LightGrey")?.cgColor
    }
    
    func displayAddressCellData(data : NSDictionary){
        lblStoreName?.text = data["storeName"] as? String
        lblPinCode?.text = data["accountNumber"] as? String
        lblAddress?.text = data["storeAddress"] as? String
    }
    
    func displayNotesCellData(data : NSDictionary){
        
//        lblNotesDescription?.text = data["notesText"] as? String
        lblNotesDescription?.text = PlanVisitManager.sharedInstance.visit?.description
        //Save the Visit Notes in Visit
        PlanVisitManager.sharedInstance.visit?.description = (lblNotesDescription?.text)!
    }
    
    //Display Collection View data
    func displayCellData(data : NSMutableDictionary , indexPath : IndexPath){
        
        if indexPath.section >= 3{
            if data["answerText"] as! String != "" {
                self.lblCenterLabel?.text = "    \u{2022} " + (data["answerText"] as! String)
            }
        }else{
           self.lblCenterLabel?.text = (data["answerText"] as! String)
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        print("exampleTextView: END EDIT")
        PlanVisitManager.sharedInstance.visit?.description = (lblNotesDescription?.text)!
    }
    
    
    @IBAction func accountStrategyButtonClicked(sender : UIButton){
        delegate?.navigateToStrategyScreen()
        
    }
}





