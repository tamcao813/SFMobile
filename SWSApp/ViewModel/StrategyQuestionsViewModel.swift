//
//  StrategyQuestionsViewModel.swift
//  SWSApp
//
//  Created by shubham.e.shukla on 5/2/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation
class StrategyQuestionsViewModel {
    
    func getStrategyQuestions() -> [StrategyQuestions] {
        return StoreDispatcher.shared.fetchStrategyQuestions()
    }
    
    
    
}
