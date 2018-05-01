//
//  VisitsViewModel.swift
//  SWSApp
//
//  Created by r.a.jantakal on 30/04/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation

class VisitsViewModel {
    
    func visitsForUser() -> [Visit] {
        return StoreDispatcher.shared.fetchVisits()
    }
    
}
