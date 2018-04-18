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
    
    var accountDetailForLoggedInUser : Account?
    
    @IBOutlet weak var centerLabel : UILabel?
    @IBOutlet weak var lblAccountTitle : UILabel?
    @IBOutlet weak var lblAddress1 : UILabel?
    @IBOutlet weak var lblAddress2 : UILabel?
    @IBOutlet weak var lblPastDue : UILabel?
    @IBOutlet weak var lblCYR12Sales : UILabel?
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
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        lblAccountTitle?.text = accountDetailForLoggedInUser?.accountName
        
        if let acc = accountDetailForLoggedInUser{
            
            var fullAddress = ""
            if acc.shippingStreet == "" && acc.shippingCity == "" && acc.shippingState == "" && acc.shippingPostalCode == "" {
                fullAddress = acc.shippingStreet + " " + acc.shippingCity + " " + acc.shippingState +  " " + acc.shippingPostalCode
                
            }else{
                if (acc.shippingStreet != "" || acc.shippingCity != "") {
                    if (acc.shippingState != "" || acc.shippingPostalCode != "") {
                        fullAddress = acc.shippingStreet + " " + acc.shippingCity + "," + " " + acc.shippingState +  " " + acc.shippingPostalCode
                    }else{
                        fullAddress = acc.shippingStreet + " " + acc.shippingCity + " " + acc.shippingState +  " " + acc.shippingPostalCode
                    }
                }else{
                    fullAddress = acc.shippingStreet + " " + acc.shippingCity + " " + acc.shippingState +  " " + acc.shippingPostalCode
                }
            }
            lblAddress1?.text = fullAddress
        }
        
        //let pastDue : Double = Double((accountDetailForLoggedInUser?.pastDueAmount)!)
        
        if accountDetailForLoggedInUser!.pastDueAmountDouble <= 0.0 {
            
            imgStatus?.isHidden = true
        }
        else {
            
            imgStatus?.isHidden = false
        }
        
        if accountDetailForLoggedInUser?.acctHealthGrade == "A"{
            
            centerLabel?.text = accountDetailForLoggedInUser?.acctHealthGrade
            centerLabel?.layer.backgroundColor = UIColor(named: "Good")?.cgColor//green.cgColor
            
        }else if accountDetailForLoggedInUser?.acctHealthGrade == "B"{
            
            centerLabel?.text = accountDetailForLoggedInUser?.acctHealthGrade
            centerLabel?.layer.backgroundColor = UIColor(named: "Medium Alert")?.cgColor//yellow.cgColor
            
        }else if accountDetailForLoggedInUser?.acctHealthGrade == "C"{
            
            centerLabel?.text = accountDetailForLoggedInUser?.acctHealthGrade
            centerLabel?.layer.backgroundColor = UIColor.orange.cgColor
            
        }else if accountDetailForLoggedInUser?.acctHealthGrade == "D"{
            
            centerLabel?.text = accountDetailForLoggedInUser?.acctHealthGrade
            centerLabel?.layer.backgroundColor = UIColor(named: "Bad")?.cgColor//.red.cgColor
            
        }
        else {
            
            centerLabel?.layer.backgroundColor = UIColor.clear.cgColor
            
        }
        
        
        lblActionItem?.text = String(describing: accountDetailForLoggedInUser!.actionItem)
        lblPastDue?.text = CurrencyFormatter.convertToCurrencyFormat(amountToConvert: (accountDetailForLoggedInUser?.pastDueAmountDouble)!) //String(format: "$%.2f",(accountDetailForLoggedInUser?.pastDueAmountDouble)!)
        lblCYR12Sales?.text = CurrencyFormatter.convertToCurrencyFormat(amountToConvert: (accountDetailForLoggedInUser?.totalCYR12NetSales)!)
        lblLicenseStatus?.text = accountDetailForLoggedInUser?.licenseStatus
        lblPhoneNumber?.text = accountDetailForLoggedInUser?.phone
        
        let percLastYearR12DivideBy100:Double = ((accountDetailForLoggedInUser?.percentageLastYearR12NetSales)!as NSString).doubleValue / 100
        let percentYearR12Double:Double =  ((accountDetailForLoggedInUser?.percentageLastYearR12NetSales)!as NSString).doubleValue
        
//        var strVal = String(percLastYearR12DivideBy100)
//        var fullPerR12NetSaleValue = strVal.components(separatedBy: ".")
//        var strNew = fullPerR12NetSaleValue[0] + "." + String(fullPerR12NetSaleValue[1].prefix(2)) + "%"
        
        let titleForButton = String(format: "%.02f",percentYearR12Double) + "%"
        
        
        
        print("the button text is \(titleForButton)")
        
        if percLastYearR12DivideBy100 < 0.80 {
            
            
            btnPercentage?.setTitle(titleForButton, for: .normal)
            btnPercentage?.backgroundColor = UIColor(named: "Bad")
            
        }else if percLastYearR12DivideBy100 >= 0.80 && percLastYearR12DivideBy100 <= 0.99 {
            
            btnPercentage?.setTitle(titleForButton, for: .normal)
            btnPercentage?.backgroundColor = UIColor(named: "Medium Alert")
            
        }
        else if percLastYearR12DivideBy100 > 0.99 {
            
           
            btnPercentage?.setTitle(titleForButton, for: .normal)
            btnPercentage?.backgroundColor = UIColor(named: "Good")
            
            
        }
        
        
        
        
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAccountDetailTab"{
            
            let accountDetailTabViewController = segue.destination as! AccountDetailTabViewController
            
            accountDetailTabViewController.account = accountDetailForLoggedInUser
        }
    }
    
}

