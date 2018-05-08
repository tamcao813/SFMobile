//
//  StrategyQAViewModel.swift
//  SWSApp
//
//  Created by shubham.e.shukla on 4/30/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation
class StrategyQAViewModel {
    
    func getStrategyQuestionAnswer() -> [StrategyQA] {
        return StoreDispatcher.shared.fetchStrategyQA()
    }
    func createNewStrategyQALocally(fields: [String:Any]) -> Bool {
        return StoreDispatcher.shared.createNewStrategyQALocally(fieldsToUpload:fields)
    }
    
    func fetchStrategy(acc: String)->[StrategyQA]{
        
        return StoreDispatcher.shared.fetchStrategy(forAccount: acc)
    }
    
}
