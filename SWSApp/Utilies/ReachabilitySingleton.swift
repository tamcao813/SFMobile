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
    
    class func sharedInstance() -> Reachability{
        instance = instance ?? Reachability()
        return instance!
    }
    
}
