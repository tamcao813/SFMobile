//
//  OpportunitiesFilterMenuModel.swift
//  SWSApp
//
//  Created by Thillaiganesh, C. on 01/06/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class OpportunitiesFilter {

    var sectionNames : Array<Any>  = ["View By", "Status", "Source", "Objective"]
    
    var sectionItems : Array<Any> = [ ["Case Decimal", "9L"], ["Open", "Planned", "Closed-Won", "Closed"], ["Book of Business", "Top Sellers", "Undersold", "What’s Hot/What’s Not", "Unsold"], ["9L​", "Decimal", "Revenue", "ACS", "POD"] ]

}

let OpportunitiesFilterCell = "opportunitiesMenuTableViewCell"

struct OpportunitiesFilterMenuModel {
    
    static var accountId: String?

    static var isAscendingProductName = ""
    static var isAscendingSource = ""
    static var isAscendingPYCMSold = ""
    static var isAscendingCommit = ""
    static var isAscendingSold = ""
    static var isAscendingMonth = ""
    static var isAscendingStatus = ""
    
    static var searchText = ""
    
    static var viewBy9L = ""
    static var viewByCaseDecimal = ""

    static var statusOpen = ""
    static var statusPlanned = ""
    static var statusClosedWon = ""
    static var statusClosed = ""

    static var sourceBookOfBusiness = ""
    static var sourceTopSellers = ""
    static var sourceUndersold = ""
    static var sourceHotNot = ""
    static var sourceUnsold = ""

    static var objective9L = ""
    static var objectiveDecimal = ""
    static var objectiveRevenue = ""
    static var objectiveACS = ""
    static var objectivePOD = ""
    
}
