//
//  PlistMap.swift
//  SWSApp
//
//  Created by maria.min-hui.yu on 4/25/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation

struct PlistOption {
    var label: String
    var value: String
}

class PlistMap {
    
    static let sharedInstance: PlistMap = PlistMap()
    fileprivate var picklistMap:[String:[PlistOption]]!  //[FieldName:[PlistOption]]
    
    fileprivate init() {
        picklistMap = [String:[PlistOption]]()
    }
    
    func addToMap(field: String, map:[PlistOption]) {
        picklistMap[field] = map
    }
    
    func getPicklist(fieldname:String) -> [PlistOption] {
        if let opts = picklistMap[fieldname] {
            return opts
        }
        
        return [PlistOption]()
    }
    
}
