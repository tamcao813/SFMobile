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
    func editStrategyQALocally(fields: [String:Any]) -> Bool {
        return StoreDispatcher.shared.editStrategyQALocally(fieldsToUpload:fields)
    }
    func uploadStrategyQAToServer(fields: [String], completion: @escaping (_ error: NSError?)->() ) {
        StoreDispatcher.shared.syncUpStrategyQA(fieldsToUpload: fields, completion: {error in
            if error != nil {
                print(error?.localizedDescription ?? "error")
                completion(error)
            }else {
                completion(nil)
            }
        })
    }
    
    func fetchStrategy(acc: String)->[StrategyQA]{
        return StoreDispatcher.shared.fetchStrategy(forAccount: acc)
    }
    
    func syncStrategyWithServer(_ completion:@escaping (_ error: NSError?)->()) {
        let fields: [String] = ["OwnerId","SGWS_Account__c","SGWS_Answer_Description_List__c","SGWS_Answer_Options__c","SGWS_Notes__c","SGWS_Question__c"]
        
        StoreDispatcher.shared.syncUpStrategyQA(fieldsToUpload: fields, completion: {error in
            if error != nil {
                print(error?.localizedDescription ?? "error")
                print("syncStrategyWithServer: Strategy Sync up failed")
            }
            
            StoreDispatcher.shared.reSyncStrategyQA{ error in
                if error != nil {
                    print(error?.localizedDescription ?? "error")
                    print("syncStrategyWithServer: Strategy reSync failed")
                    completion(error)
                }
                else {
                    completion(nil)
                }
            }
        })
    }
    
    func syncStrategyQuestionsWithServer(_ completion:@escaping (_ error: NSError?)->()) {

            StoreDispatcher.shared.reSyncStrategyQuestions{ error in
                if error != nil {
                    print(error?.localizedDescription ?? "error")
                    print("syncStrategyQuestionsWithServer: StrategyQuestions reSync failed")
                    completion(error)
                }
                else {
                    completion(nil)
                }
            }
    }
    
    func syncStrategyAnswersWithServer(_ completion:@escaping (_ error: NSError?)->()) {
        
        StoreDispatcher.shared.reSyncStrategyAnswers{ error in
            if error != nil {
                print(error?.localizedDescription ?? "error")
                print("syncStrategyAnswersWithServer: StrategyAnswers reSync failed")
                completion(error)
            }
            else {
                completion(nil)
            }
        }
    }
    
}
