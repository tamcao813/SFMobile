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

    func displayCellData(data : WorkOrderUserObject){
        //Used to Check wheather its an Event or Visit
        if(data.recordTypeId == StoreDispatcher.shared.workOrderRecordTypeIdEvent){
            statusView.backgroundColor = UIColor.orange
            self.addressLabel.text = data.subject
        } else {
            statusView.backgroundColor = UIColor(named:"Data New")
            self.addressLabel.text = data.accountName
        }
        
        //self.addressLabel.text = data.accountName
        self.visitStatusLabel.text = data.status
        
        let lastModifiedDate = data.lastModifiedDate
        if(lastModifiedDate != ""){
            let getTime = DateTimeUtility.convertUtcDatetoReadableDate(dateStringfromAccountNotes: lastModifiedDate)
            var dateTime = getTime.components(separatedBy: " ")
            
            if(dateTime.count > 0){
                dateLabel?.text  = dateTime[0]
                timeLabel?.text = dateTime[1]
            }
        }
    }
}
