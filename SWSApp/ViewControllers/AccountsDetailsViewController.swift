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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Account details Screen is loaded")
        
        lblActionItem?.layer.borderColor = UIColor.init(named: "Data New")?.cgColor
        
        
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
        
        
        
        print(accountsForLoggedInUser!)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        
    }
    
    
}
