//
//  AccountsDetailsViewController.swift
//  SWSApp
//
//  Created by r.a.jantakal on 04/04/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation
import UIKit

class AccountDetailsViewController : UIViewController{
    
    var accountsForLoggedInUser : Account?
    
    @IBOutlet weak var centerLabel : UILabel?
    @IBOutlet weak var lblAccountTitle : UILabel?
    @IBOutlet weak var lblAddress1 : UILabel?
    @IBOutlet weak var lblAddress2 : UILabel?
    @IBOutlet weak var lblPastDue : UILabel?
    @IBOutlet weak var lblMTDSales : UILabel?
    @IBOutlet weak var lblLicenseStatus : UILabel?
    @IBOutlet weak var lblActionItem : UILabel?
    @IBOutlet weak var lblPhoneNumber : UILabel?
    @IBOutlet weak var btnPercentage : UIButton?
    
    @IBOutlet weak var containerView : UIView?
    
    @IBOutlet weak var btnOverview : UIButton?
    @IBOutlet weak var btnDetails : UIButton?
    @IBOutlet weak var btnInsights : UIButton?
    @IBOutlet weak var btnOpportunities : UIButton?
    @IBOutlet weak var btnStrategy : UIButton?
    @IBOutlet weak var btnActionItems : UIButton?
    @IBOutlet weak var btnCommunication : UIButton?
    @IBOutlet weak var imgStatus : UIImageView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Account details Screen is loaded")
        
        lblActionItem?.layer.borderColor = UIColor.init(named: "Data New")?.cgColor
        
        containerView?.isHidden = true
        
        
        centerLabel?.text = "A"
      
        btnPercentage?.setTitle("91%", for: .normal)
        lblPhoneNumber?.text = "(123)456-6789"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        lblAccountTitle?.text = accountsForLoggedInUser?.name
        
        lblAddress1?.text = ""
        lblAddress2?.text = ""
        
        let addressData = accountsForLoggedInUser?.address
        let addressArray : NSArray = (addressData?.components(separatedBy: ",") as NSArray?)!
        if (addressArray.count > 0) {
            if addressArray.count == 1{
                lblAddress1?.text = addressArray[0] as? String
                lblAddress2?.text = ""
            }else{
                lblAddress1?.text = addressArray[0] as? String
                lblAddress2?.text = addressArray[1] as? String
            }
        }
        lblActionItem?.text = String(describing: accountsForLoggedInUser!.actionItem)
        lblPastDue?.text = accountsForLoggedInUser!.balance
        lblMTDSales?.text = accountsForLoggedInUser!.totalR12NetSales
        
        print(accountsForLoggedInUser!)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        
    }
    
    @IBAction func itemsClicked(sender : UIButton){
        
        containerView?.isHidden = true
        
        btnOverview?.backgroundColor = UIColor(named: "LightGrey")
        btnDetails?.backgroundColor = UIColor(named: "LightGrey")
        btnInsights?.backgroundColor = UIColor(named: "LightGrey")
        btnOpportunities?.backgroundColor = UIColor(named: "LightGrey")
        btnStrategy?.backgroundColor = UIColor(named: "LightGrey")
        btnActionItems?.backgroundColor = UIColor(named: "LightGrey")
        btnCommunication?.backgroundColor = UIColor(named: "LightGrey")
        
        btnOverview?.setTitleColor(UIColor.gray, for: .normal)
        btnDetails?.setTitleColor(UIColor.gray, for: .normal)
        btnInsights?.setTitleColor(UIColor.gray, for: .normal)
        btnOpportunities?.setTitleColor(UIColor.gray, for: .normal)
        btnStrategy?.setTitleColor(UIColor.gray, for: .normal)
        btnActionItems?.setTitleColor(UIColor.gray, for: .normal)
        btnCommunication?.setTitleColor(UIColor.gray, for: .normal)
        
        switch sender.tag {
        case 0:
            btnOverview?.backgroundColor = UIColor.white
            btnOverview?.setTitleColor(UIColor.black, for: .normal)
        case 1:
            containerView?.isHidden = false
            btnDetails?.backgroundColor = UIColor.white
            btnDetails?.setTitleColor(UIColor.black, for: .normal)
        case 2:
            btnInsights?.backgroundColor = UIColor.white
            btnInsights?.setTitleColor(UIColor.black, for: .normal)
        case 3:
            btnOpportunities?.backgroundColor = UIColor.white
            btnOpportunities?.setTitleColor(UIColor.black, for: .normal)
        case 4:
            btnStrategy?.backgroundColor = UIColor.white
            btnStrategy?.setTitleColor(UIColor.black, for: .normal)
        case 5:
            btnActionItems?.backgroundColor = UIColor.white
            btnActionItems?.setTitleColor(UIColor.black, for: .normal)
        case 6:
            btnCommunication?.backgroundColor = UIColor.white
            btnCommunication?.setTitleColor(UIColor.black, for: .normal)
            
        default:
            break
        }
    }
}


