//
//  VisitSortUtility.swift
//  SWSApp
//
//  Created by Thillaiganesh, C. on 18/05/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class VisitSortUtility {

    static func searchVisitByVisitId(visitId:String) -> WorkOrderUserObject?
    {
        
        let visitList =  VisitsViewModel().visitsForUser().filter( { return $0.Id == visitId } )
        if visitList.count > 0 {
            return visitList[0]
        }
        else {
            return nil
        }
        
    }
    
}
