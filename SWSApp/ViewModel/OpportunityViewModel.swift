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
        GlobalOpportunityObjectiveModel.globalOpportunityObjective = StoreDispatcher.shared.fetchOpportunityObjective()
        GlobalOpportunityModel.globalOpportunity = StoreDispatcher.shared.fetchOpportunity()
        return GlobalOpportunityModel.globalOpportunity
    }
    
    func globalOpportunityObjective() -> [OpportunityObjective] {
        return GlobalOpportunityObjectiveModel.globalOpportunityObjective
    }
    
    func createNewOpportunityWorkorderLocally(fields: [String:Any]) -> (Bool,Int) {
        return StoreDispatcher.shared.createNewOpportunityWorkorderLocally(fieldsToUpload:fields)
    }
    
    func globalOpportunityWorkorder() -> [OpportunityWorkorder] {
        return StoreDispatcher.shared.fetchOpportunityWorkorder()
    }
    
    func syncOpportunitysWithServer(_ completion:@escaping (_ error: NSError?)->()) {
        
        StoreDispatcher.shared.syncUpOpportunity(completion: {error in
            if error != nil {
                print(error?.localizedDescription ?? "error")
                print("syncOpportunitysWithServer: syncUpOpportunity failed")
            }
            
            StoreDispatcher.shared.reSyncUploadOpportunity { error in
                if error != nil {
                    print(error?.localizedDescription ?? "error")
                    print("syncOpportunitysWithServer: reSyncOpportunityObjective failed")
                }
                
                StoreDispatcher.shared.reSyncOpportunityObjective { error in
                    if error != nil {
                        print(error?.localizedDescription ?? "error")
                        print("syncOpportunitysWithServer: reSyncOpportunityObjective failed")
                    }
                    
                    StoreDispatcher.shared.reSyncOpportunity { error in
                        if error != nil {
                            print(error?.localizedDescription ?? "error")
                            print("syncOpportunitysWithServer: reSyncOpportunity failed")
                            completion(error)
                        }
                        else {
                            let _ = OpportunityViewModel().globalOpportunityReload()
                            
                            completion(nil)
                        }
                    }
                }
            }
        })
    }

}

struct GlobalOpportunityModel {
    static var globalOpportunity = [Opportunity]()
}

struct GlobalOpportunityObjectiveModel {
    static var globalOpportunityObjective = [OpportunityObjective]()
}
