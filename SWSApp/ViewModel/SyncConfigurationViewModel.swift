//
//  SyncConfigurationViewModel.swift
//  SWSApp
//
//  Created by Thillaiganesh, C. on 28/05/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class SyncConfigurationViewModel {

    func syncConfiguration() -> [SyncConfiguration] {
        return StoreDispatcher.shared.fetchSyncConfiguration()
    }

    func syncConfigurationRecordIdforEvent() -> String! {
        
        return syncConfigurationRecordIdfor(developerName: "SGWS_WorkOrder_Event", object: "WorkOrder")

    }

    func syncConfigurationRecordIdforVisit() -> String! {
        
        return syncConfigurationRecordIdfor(developerName: "SGWS_WorkOrder_Visit", object: "WorkOrder")
        
    }

    func syncConfigurationRecordIdfor(developerName: String, object: String) -> String! {
        
        let syncConfigurationList = syncConfiguration().filter( { return $0.developerName == developerName && $0.sObjectType == object} )
        if syncConfigurationList.count > 0 {
            return syncConfigurationList[0].recordTypeId
        }
        else {
            return ""
        }
    }
    
}
