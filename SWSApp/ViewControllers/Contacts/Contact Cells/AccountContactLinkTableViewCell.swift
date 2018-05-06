//
//  AccountContactLinkTableViewCell.swift
//  SWSApp
//
//  Created by manu.a.gupta on 02/05/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit
import DropDown

protocol AccountContactLinkTableViewCellDelegate: NSObjectProtocol  {
    func removeAccount()
}

class AccountContactLinkTableViewCell: DropDownCell {
    
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var accountLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var containerTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var containerLeadingConstraint: NSLayoutConstraint!
    weak var delegate : AccountContactLinkTableViewCellDelegate!
    @IBOutlet weak var containerView: UIView!
    
    func displayCellContent(account: Account){
        phoneNumberLabel.text = account.accountNumber
        accountLabel.text = account.accountName
        var fullAddress = ""
        if account.shippingStreet == "" && account.shippingCity == "" && account.shippingState == "" && account.shippingPostalCode == "" {
            fullAddress = account.shippingStreet + " " + account.shippingCity + " " + account.shippingState +  " " + account.shippingPostalCode
            
        }else{
            if (account.shippingStreet != "" || account.shippingCity != "") {
                if (account.shippingState != "" || account.shippingPostalCode != "") {
                    fullAddress = account.shippingStreet + " " + account.shippingCity + "," + " " + account.shippingState +  " " + account.shippingPostalCode
                }else{
                    fullAddress = account.shippingStreet + " " + account.shippingCity + " " + account.shippingState +  " " + account.shippingPostalCode
                }
            }else{
                fullAddress = account.shippingStreet + " " + account.shippingCity + " " + account.shippingState +  " " + account.shippingPostalCode
            }
        }
        addressLabel?.text = fullAddress        
    }
    
    @IBAction func deleteButtonTapped(_ sender: UIButton){
        self.delegate.removeAccount()
    }
}
