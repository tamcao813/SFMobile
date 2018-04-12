//
//  CustomerHeaderTableViewCell.swift
//  SWSApp
//
//  Created by shubham.e.shukla on 3/30/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class CustomerHeaderTableViewCell: UITableViewCell {

    //Titles
    @IBOutlet weak var accountIDlbl: UILabel!
    @IBOutlet weak var accountIDValue: UILabel!
    
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var addressValue: UILabel!
    
    
    @IBOutlet weak var phoneLbl: UILabel!
    @IBOutlet weak var phoneValue: UILabel!
    
    @IBOutlet weak var businessHoursLbl: UILabel!
    @IBOutlet weak var businessHoursValue: UILabel!
    //MARK:- -
    @IBOutlet weak var accountType: UILabel!
    @IBOutlet weak var accountTypeValue: UILabel!
    
    
    @IBOutlet weak var licenseTypeLbl: UILabel!
    @IBOutlet weak var licenseTypeValue: UILabel!
    
    @IBOutlet weak var licenseNumberLbl: UILabel!
    @IBOutlet weak var licenseNumberValue: UILabel!
    
    @IBOutlet weak var expirationLbl: UILabel!
    @IBOutlet weak var expirationValue: UILabel!
    
    //MARK:- -
    @IBOutlet weak var nestsalesLbl: UILabel!
    @IBOutlet weak var netsalesValue: UILabel!
    
    @IBOutlet weak var creditLimitLbl: UILabel!
    @IBOutlet weak var creditLimitValue: UILabel!
    
    @IBOutlet weak var totalBalanceLbl: UILabel!
    @IBOutlet weak var totalBalanceValue: UILabel!
    
    @IBOutlet weak var pastDueLbl: UILabel!
    @IBOutlet weak var pastDueValue: UILabel!
    
    //MARK:- -
    @IBOutlet weak var deliveryLbl: UILabel!
    @IBOutlet weak var deliveryValue: UILabel!
    
    @IBOutlet weak var deliveryFrequencyLbl: UILabel!
    @IBOutlet weak var deliveryFrequencyValue: UILabel!
    
    @IBOutlet weak var nextDeliveryDateLbl: UILabel!
    @IBOutlet weak var nextDeliveryDateValue: UILabel!
    
    @IBOutlet weak var accountHealthIndicator: UILabel!
    @IBOutlet weak var pastDueIndicatorImage: UIImageView!
    
    
    // MARK:- View Outlets
    
    @IBOutlet weak var AccountID_View: UIView!
    @IBOutlet weak var AccountType_View: UIView!
    @IBOutlet weak var NetSales_View: UIView!
    @IBOutlet weak var Delivery_View: UIView!
    
  
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.AccountID_View.layer.borderWidth = 1
        self.AccountID_View.layer.borderWidth = 1
        self.AccountID_View.layer.borderColor = UIColor(named: "LightGrey")?.cgColor
        
        
        self.AccountType_View.layer.borderWidth = 1
        self.AccountType_View.layer.borderWidth = 1
        self.AccountType_View.layer.borderColor = UIColor(named: "LightGrey")?.cgColor
        
        self.NetSales_View.layer.borderWidth = 1
        self.NetSales_View.layer.borderWidth = 1
        self.NetSales_View.layer.borderColor = UIColor(named: "LightGrey")?.cgColor
        
        self.Delivery_View.layer.borderWidth = 1
        self.Delivery_View.layer.borderWidth = 1
        self.Delivery_View.layer.borderColor = UIColor(named: "LightGrey")?.cgColor
        // Initialization code
        
    
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
