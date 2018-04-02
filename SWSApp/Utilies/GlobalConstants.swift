//
//  GlobalConstants.swift
//  SWSApp
//
//  Created by shubham.e.shukla on 3/30/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation

class GlobalConstants
{
    struct contactTableViewConstants {
        static let cellHeight:CGFloat = 150.0
        static let heightForHeaderInSection:CGFloat = 200.0
    }
    // persistent menu related
    enum persistenMenuTabVCIndex:Int
    {
        case HomeVCIndex = 0, AccountVCIndex, ContactsVCIndex, CalendarVCIndex, MoreVCIndex
    }
}

