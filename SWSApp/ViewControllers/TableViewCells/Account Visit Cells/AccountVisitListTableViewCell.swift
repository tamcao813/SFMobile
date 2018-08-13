//
//  AccountVisitListTableViewCell.swift
//  SWSApp
//
//  Created by Krishna, Kamya on 4/23/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit
import SwipeCellKit

class AccountVisitListTableViewCell: SwipeTableViewCell {

    @IBOutlet weak var visitStatusLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var statusView: UIView!

    @IBOutlet weak var lblAccountName : UILabel!
    @IBOutlet weak var lblAccountId : UILabel!
    @IBOutlet weak var lblAddress : UILabel!
    @IBOutlet weak var lblLocation : UILabel!
   
    //Display cell data from WorkOrderUserObject
    func displayCellData(data : WorkOrderUserObject?){
        //Used to Check wheather its an Event or Visit
        if(data?.recordTypeId == SyncConfigurationViewModel().syncConfigurationRecordIdforEvent()){
            DispatchQueue.main.async {
                self.statusView.backgroundColor = UIColor.orange
            }
            self.addressLabel.text = data?.subject
        } else {
            DispatchQueue.main.async {
                self.statusView.backgroundColor = UIColor(named:"Data New")
            }
            self.addressLabel.text = data?.accountName
        }
        
        self.visitStatusLabel.text = data?.status
        lblAccountName.text = data?.accountName
        lblAccountId.text = data?.accountNumber
        lblLocation.text = data?.location
        
        var fullAddress = ""
        if let shippingStreet = data?.shippingStreet, let shippingCity = data?.shippingCity , let shippingState = data?.shippingState, let shippingPostalCode = data?.shippingPostalCode{
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
        
        lblAddress.text = fullAddress
        
        let startTime = data?.startDate
        if(startTime != ""){
            let getTime = DateTimeUtility.convertUtcDatetoReadableDateAndTimeString(dateString: startTime)
            var dateTime = getTime.components(separatedBy: " ")
            
            if(dateTime.count > 0){
                dateLabel?.text  = dateTime[0]
                timeLabel?.text = dateTime[1]
                if dateTime.count > 2{
                    timeLabel?.text = "\(dateTime[1]) \(dateTime[2])"
                }
                
                
            }
        }
    }
}
