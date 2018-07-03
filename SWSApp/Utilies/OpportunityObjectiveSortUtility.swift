//
//  OpportunityObjectiveSortUtility.swift
//  SWSApp
//
//  Created by Thillaiganesh, C. on 03/07/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class OpportunityObjectiveSortUtility {

    static func filterOpportunityObjectiveByFilterByOpportunity(opportunityIdToBeFiltered : String)-> [OpportunityObjective]{
        
        var filteredOpportunityObjectiveArray = [OpportunityObjective]()
        
        filteredOpportunityObjectiveArray = GlobalOpportunityObjectiveModel.globalOpportunityObjective.filter( { return
            ($0.OpportunityId == opportunityIdToBeFiltered) } )

        return filteredOpportunityObjectiveArray
    }
    
}
