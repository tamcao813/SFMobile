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
    func uploadStrategyQAToServer(fields: [String], completion: @escaping (_ error: NSError?)->() ) {
        StoreDispatcher.shared.syncUpStrategyQA(fieldsToUpload: fields, completion: {error in
            
            if error != nil {
                print(error?.localizedDescription ?? "error")
                completion(error)
            }
            else {
                
                completion(nil)
            }
        })
    }
    
    
}
