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
    
    var sectionItems : Array<Any> = [ ["9L Case", "Case Decimal"], ["Closed", "Closed Won", "Open", "Planned"], ["Overview", "Top Sellers", "Undersold", "What’s Hot", "Unsold"], ["9L​ Case", "ACS", "Case Decimal", "POD", "Revenue"] ]

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

    static var statusClosed = ""
    static var statusClosedWon = ""
    static var statusOpen = ""
    static var statusPlanned = ""

    static var sourceOverview = ""
    static var sourceTopSellers = ""
    static var sourceUndersold = ""
    static var sourceHotNot = ""
    static var sourceUnsold = ""

    static var objective9L = ""
    static var objectiveACS = ""
    static var objectiveDecimal = ""
    static var objectivePOD = ""
    static var objectiveRevenue = ""
    
}
