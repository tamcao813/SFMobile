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
        GlobalOpportunityModel.globalOpportunity = StoreDispatcher.shared.fetchOpportunity()
        return GlobalOpportunityModel.globalOpportunity
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
                print("syncOpportunitysWithServer: Sync up failed")
            }
            
            StoreDispatcher.shared.syncDownOpportunity() { _ in
                let _ = self.globalOpportunityReload()
                completion(nil)
            }
            /*
            StoreDispatcher.shared.reSyncOpportunity { error in
                if error != nil {
                    print(error?.localizedDescription ?? "error")
                    print("syncOpportunitysWithServer: reSync failed")
                    completion(error)
                }
                else {
                    completion(nil)
                }
            }*/
        })
    }

}

struct GlobalOpportunityModel {
    static var globalOpportunity = [Opportunity]()
}
