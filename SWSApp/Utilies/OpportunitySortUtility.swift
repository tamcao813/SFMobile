//
//  OpportunitySortUtility.swift
//  SWSApp
//
//  Created by Thillaiganesh, C. on 07/06/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class OpportunitySortUtility {

    func opportunityFor(forAccount accountId:String) -> [Opportunity] {
        return GlobalOpportunityModel.globalOpportunity.filter( { return $0.accountId == accountId } )
    }
    
}
