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
//        var accountObject: Account?
//        let accounts = AccountsViewModel().accountsForLoggedUser
//        for account in accounts {
//            if account.account_Id == data.accountId {
//                accountObject = account
//                break
//            }
//        }
        
        self.addressLabel.text = data.accountName
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
