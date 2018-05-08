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
        var fullAddress = ""
        if let shippingStreet = account?.shippingStreet, let shippingCity = account?.shippingCity , let shippingState = account?.shippingState, let shippingPostalCode = account?.shippingPostalCode{
            // latitudeDouble and longitudeDouble are non-optional in here
            if shippingStreet == "" && shippingCity == "" && shippingState == "" && shippingPostalCode == "" {
                fullAddress = "\(shippingStreet) \(shippingCity) \(shippingState) \(shippingPostalCode)"
            }else{
                if (shippingStreet != "" || shippingCity != "") {
                    if (shippingState != "" || shippingPostalCode != "") {
                        fullAddress = "\(shippingStreet) \(shippingCity), \(shippingState) \(shippingPostalCode)"
                    }else{
                        fullAddress = "\(shippingStreet) \(shippingCity) \(shippingState) \(shippingPostalCode)"
                    }
                }else{
                    fullAddress = "\(shippingStreet) \(shippingCity) \(shippingState) \(shippingPostalCode)"
                }
            }
        }
        addressLabel?.text = fullAddress
    }
    
 
    
    @IBAction func navigateToAccountDetailsScreen(sender : UIButton){
        delegate?.navigateToAccountVisitSummaryScreen()
    }
}
