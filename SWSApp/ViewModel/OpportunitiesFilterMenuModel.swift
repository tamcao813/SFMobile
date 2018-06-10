//
//  OpportunitiesFilterMenuModel.swift
//  SWSApp
//
//  Created by Thillaiganesh, C. on 01/06/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class OpportunitiesFilter {

    var sectionNames : Array<Any>  = ["View By", "Status", "Source", "Objective", "Time Frame"]
    
    var sectionItems : Array<Any> = [ ["Case Decimal", "9L"], ["All", "Incomplete", "Complete"], ["All", "Losing Sales", "Top Sellers", "Sold Unsold", "Undersold"], ["All", "9L", "ACS", "POD", "Rev"], ["R90", "R12"] ]
}

let OpportunitiesFilterCell = "opportunitiesMenuTableViewCell"

struct OpportunitiesFilterMenuModel {
    static var searchText = ""
    static var viewByCaseDecimal = ""
    static var viewBy9L = ""
}
