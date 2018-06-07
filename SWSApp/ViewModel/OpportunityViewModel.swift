//
//  OpportunityViewModel.swift
//  SWSApp
//
//  Created by Thillaiganesh, C. on 07/06/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class OpportunityViewModel {

    func opportunityAll() -> [Opportunity] {
        return StoreDispatcher.shared.fetchOpportunity()
    }
    
}
