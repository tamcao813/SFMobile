//
//  LocationTableViewCell.swift
//  Acoount Visit
//
//  Created by maco on 19/04/18.
//  Copyright © 2018 maco. All rights reserved.
//

import UIKit


protocol NavigateToAccountAccountVisitSummaryDelegate {
    func navigateToAccountVisitSummaryScreen()
}

class LocationTableViewCell: UITableViewCell {

    var delegate : NavigateToAccountAccountVisitSummaryDelegate?
    @IBOutlet weak var accountLabel: UILabel!
    @IBOutlet weak var accountNumberLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    var account: Account?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func displayCellContent(){
        accountNumberLabel.text = account?.accountNumber
        accountLabel.text = account?.accountName
//        var fullAddress = ""
//        if account?.shippingStreet == "" && account?.shippingCity == "" && account?.shippingState == "" && account?.shippingPostalCode == "" {
//
//            fullAddress = account?.shippingStreet + " " + account?.shippingCity + " " + account?.shippingState +  " " + account?.shippingPostalCode
//        }else{
//            if (account?.shippingStreet != "" || account?.shippingCity != "") {
//                if (account?.shippingState != "" || account?.shippingPostalCode != "") {
//
//                    fullAddress = account?.shippingStreet + " " + account?.shippingCity + "," + " " + account?.shippingState +  " " + account?.shippingPostalCode
//                }else{
//                    fullAddress = account?.shippingStreet + " " + account?.shippingCity + " " + account?.shippingState +  " " + account?.shippingPostalCode
//                }
//            }else{
//                fullAddress = account?.shippingStreet + " " + account?.shippingCity + " " + account?.shippingState +  " " + account?.shippingPostalCode
//            }
//        }
//        addressLabel?.text = fullAddress
    }
    
 
    
    @IBAction func navigateToAccountDetailsScreen(sender : UIButton){
        delegate?.navigateToAccountVisitSummaryScreen()
    }
}
