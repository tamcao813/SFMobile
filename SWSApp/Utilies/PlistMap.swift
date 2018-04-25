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
    fileprivate var picklistMap:[String:[String:[PlistOption]]]!  //[SoupName:[FieldName:[PlistOption]]]
    
    fileprivate init() {
        picklistMap = [String:[String:[PlistOption]]]()
    }
    
    func addToMap(_ soup:String, map:[String:[PlistOption]]) {
        picklistMap[soup] = map
    }
    
    func getPicklist(_ soupname:String, fieldname:String) -> [PlistOption] {
        if let dict = picklistMap[soupname] {
            if let opts = dict[fieldname] {
                return opts
            }
        }
        
        return [PlistOption]()
    }
    
}
