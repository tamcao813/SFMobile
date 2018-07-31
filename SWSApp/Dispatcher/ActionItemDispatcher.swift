//
//  ActionItemDispatcher.swift
//  SWSApp
//
//  Created by r.a.jantakal on 30/07/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation
import SmartStore
import SmartSync

class ActionItemDispatcher : StoreDispatcher {
    
    func fetchOpenStateActionItem()->[ActionItem]{
        var actionItem: [ActionItem] = []
        let soapQueryWithoutAccount = "SELECT DISTINCT {Task:Id},{Task:SGWS_Account__c},{Task:Subject},{Task:Description},{Task:Status},{Task:ActivityDate},{Task:SGWS_Urgent__c},{Task:SGWS_AppModified_DateTime__c},{Task:RecordTypeId},{Task:OwnerId},{Task:_soupEntryId} FROM {Task} Where {Task:Status} = 'Open' AND ({Task:ActivityDate} IS NOT NULL OR {Task:ActivityDate} != '') AND {Task:ActivityDate} < '\(DateTimeUtility.getCurrentDateInString())'"
        
        let querySpecWithoutAccount = SFQuerySpec.newSmartQuerySpec(soapQueryWithoutAccount, withPageSize: 100000)
        
        var error : NSError?
        let resultWithoutAccount = sfaStore.query(with: querySpecWithoutAccount!, pageIndex: 0, error: &error)
        
        if (error == nil && resultWithoutAccount.count > 0) {
            
            for i in 0...resultWithoutAccount.count - 1 {
                
                let soupDataWithoutAccount = resultWithoutAccount[i] as! [Any]
                
                let entryArryWithoutAccount = sfaStore.retrieveEntries([soupDataWithoutAccount[10]], fromSoup: SoupActionItem)
                
                let itemWithoutAccount = entryArryWithoutAccount[0]
                let subItemWithoutAccount = itemWithoutAccount as! [String:Any]
                
                let flag = subItemWithoutAccount["__locally_deleted__"] as! Bool
                // if deleted skip
                if(flag){
                    continue
                }
                
                let aryWithoutAccount:[Any] = resultWithoutAccount[i] as! [Any]
                let actionItemArrayWithoutAccount = ActionItem(withAryNoAccount: aryWithoutAccount)
                actionItem.append(actionItemArrayWithoutAccount)
            }
        }
        else if error != nil {
            print("fetch action item  " + " error:" + (error?.localizedDescription)!)
        }
        return actionItem
    }
    
    func editActionItemStatusBulkAutomatically(id : String) -> Bool{
        
        let querySpecAll = SFQuerySpec.newExactQuerySpec(SoupActionItem, withSelectPaths: nil, withPath: "Id", withMatchKey: "\(id)", withOrderPath: "Id", with: .ascending, withPageSize: 1)
        var error : NSError?
        let result = sfaStore.query(with: querySpecAll!, pageIndex: 0, error: &error)
        
        print(result)
        
        if result.count == 0{
            return false
        }
        
        var actionItemModif = [String: Any]()
        
        for actionItemData in result{
            actionItemModif = actionItemData as! [String:Any]
            actionItemModif["Status"] = "Overdue"
            actionItemModif[kSyncTargetLocal] = true
            
            let createdFlag = actionItemModif[kSyncTargetLocallyCreated] as? Bool
            if createdFlag != nil{
                if(createdFlag)!{
                    actionItemModif[kSyncTargetLocallyUpdated] = false
                    actionItemModif[kSyncTargetLocallyCreated] = true
                }else {
                    actionItemModif[kSyncTargetLocallyCreated] = false
                    actionItemModif[kSyncTargetLocallyUpdated] = true
                }
            }
        }
        
        let ary = sfaStore.upsertEntries([actionItemModif], toSoup: SoupActionItem)
        if ary.count > 0 {
            var result = ary[0] as! [String:Any]
            let soupEntryId = result["_soupEntryId"]
            print("\(result) Edit And Save Action Item successfully" )
            print(soupEntryId!)
            return true
        }else{
            print(" Error in deleting Action Items" )
            return false
        }
    }
}
