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
    var validFor: Int = -1
    
    init(label: String, value: String, validFor: Int = -1) {
        self.label = label
        self.value = value
        self.validFor = validFor
    }
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
    
    //Read Plist For Service Purposes
    
    func readPList(plist:String) -> NSArray {
        
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let path = documentDirectory.appending(plist)
        let array = NSArray(contentsOfFile: path)
        return array!
        
    }
    
}
