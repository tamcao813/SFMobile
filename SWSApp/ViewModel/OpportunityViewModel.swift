//
//  OpportunityViewModel.swift
//  SWSApp
//
//  Created by Thillaiganesh, C. on 07/06/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class OpportunityViewModel {

    func globalOpportunity() -> [Opportunity] {
        return GlobalOpportunityModel.globalOpportunity
    }
    
    func globalOpportunityReload() -> [Opportunity] {
        GlobalOpportunityModel.globalOpportunity = StoreDispatcher.shared.fetchOpportunity()
        return GlobalOpportunityModel.globalOpportunity
    }
    
}

struct GlobalOpportunityModel {
    static var globalOpportunity = [Opportunity]()
}
