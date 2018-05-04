//
//  VisitSchedulerViewModel.swift
//  SWSApp
//
//  Created by vipin.vijay on 03/05/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation

class VisitSchedulerViewModel {
    
    func visitsForUser() -> [PlanVisit] {
        return StoreDispatcher.shared.fetchSchedulerVisits()
    }
}
