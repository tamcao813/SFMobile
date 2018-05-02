//
//  StrategyAnswersViewModel.swift
//  SWSApp
//
//  Created by shubham.e.shukla on 5/2/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation
class StrategyAnswersViewModel {
    
    func getStrategyAnswers() -> [StrategyAnswers] {
        return StoreDispatcher.shared.fetchStrategyAnswers()
    }

}
