//
//  ContactListAccountLinkDetails.swift
//  SWSApp
//
//  Created by Thillaiganesh, C. on 27/04/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class ContactListAccountLinkDetails: UITableViewCell {

    @IBOutlet weak var accountNameValueLabel: UILabel!
    @IBOutlet weak var accountNumberValueLabel: UILabel!
    @IBOutlet weak var accountAddress1ValueLabel: UILabel!
    @IBOutlet weak var accountAddress2ValueLabel: UILabel!
    @IBOutlet weak var accountRolesValueLabel: UILabel!
    @IBOutlet weak var accountBuyerInfluencerOtherValueLabel: UILabel!
    @IBOutlet weak var accountLinkButton: UIButton!
    @IBOutlet weak var accountEditButton: UIButton!
    
    @IBOutlet weak var unlinkAccountContactButton: UIButton!
    @IBOutlet weak var editAccountContactButton: UIButton!
    
    var contactId: String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func displayCellContent(_ accountId: String, withRoles roles: String, forClassification classification: String) {
        
        let accountList: [Account]? = AccountSortUtility.searchAccountByAccountId(accountsForLoggedUser: AccountsViewModel().accountsForLoggedUser(), accountId: accountId)
        guard accountList != nil, (accountList?.count)! > 0  else {
            return;
        }
        
        accountNameValueLabel.text = accountList![0].accountName
        accountNumberValueLabel.text = accountList![0].accountNumber
        accountAddress1ValueLabel.text = accountList![0].shippingStreet
        if accountList![0].shippingCity != "" {
            accountAddress2ValueLabel.text = accountList![0].shippingCity + ", " + accountList![0].shippingState + " " + accountList![0].shippingPostalCode
        }
        else {
            accountAddress2ValueLabel.text = ""
        }
        accountRolesValueLabel.text = roles
        accountBuyerInfluencerOtherValueLabel.text = classification
    }
}
