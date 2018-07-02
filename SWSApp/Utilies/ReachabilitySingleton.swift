//
//  ReachabilitySingleton.swift
//  SWSApp
//
//  Created by manu.a.gupta on 02/07/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation
import Reachability

class ReachabilitySingleton {
    
    var isReachable: Bool?
    static var instance : Reachability? = nil
    
    // Singleton should be used for network reachability check
    // This was intergrated for webview offline issue so that now it has been applied to all webview instances
    
    class func sharedInstance() -> Reachability{
        instance = instance ?? Reachability()
        return instance!
    }
    
}
