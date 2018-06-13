//
//  SyncConfigurationSortUtility.swift
//  SWSApp
//
//  Created by Thillaiganesh, C. on 29/05/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class SyncConfigurationSortUtility {

    static func searchSyncConfigurationByRecordTypeId(_ recordTypeId: String) -> SyncConfiguration?
    {
        
        let syncConfigurationList = SyncConfigurationViewModel().syncConfiguration().filter( { return $0.id == recordTypeId } )
        if syncConfigurationList.count > 0 {
            return syncConfigurationList[0]
        }
        else {
            return nil
        }
        
    }
    
    static func searchSyncConfigurationByRecordTypeId(syncConfigurationList: [SyncConfiguration], recordTypeId: String) -> SyncConfiguration?
    {
        
        let syncConfigurationList = syncConfigurationList.filter( { return $0.recordTypeId == recordTypeId } )
        if syncConfigurationList.count > 0 {
            return syncConfigurationList[0]
        }
        else {
            return nil
        }

    }
    
}
