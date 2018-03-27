//
//  Account.swift
//  SWSApp
//
//  Created by maria.min-hui.yu on 3/22/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation

class Account {
    var Id: String
    var AccountNumber: String
    var Name: String
    //var ConsultantId: String
    //var Balance: String
    
    init()  {
        Id = ""
        AccountNumber = ""
        Name = ""
        //ConsultantId = ""
        //Balance = ""
    }
    
    init(withAry ary: [Any]) {
        Id = ary[0] as! String
        AccountNumber = ary[1] as! String
        Name = ary[2] as! String
        //ConsultantId = ary[3] as! String
        //Balance = ary[4] as! String
    }
    
    init(json: [String: AnyObject]) {
        Id = json["Id"] as! String
        AccountNumber = json["AccountNumber"] as! String
        Name = json["Name"] as! String
        //ConsultantId = json["Name"] as! String
        //Balance = json["Name"] as! String
    }
}

