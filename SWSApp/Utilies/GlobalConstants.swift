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
    // persistent menu related
    enum persistenMenuTabVCIndex:Int
    {
        case HomeVCIndex = 0, AccountVCIndex, ContactsVCIndex, CalendarVCIndex, ObjectivesVCIndex, MoreVCIndex
    }
    
    //Calendar Type Day Week or Month
    enum CalendarViewType: Int {
        case None = 0
        case Day = 1
        case Week = 2
        case Month = 3
    }
    
}

//public func print(_ items: Any..., separator: String = " ", terminator: String = "\n") {
//    let output = items.map { "\($0)" }.joined(separator: separator)
//    Swift.print(output, terminator: terminator)
//}

