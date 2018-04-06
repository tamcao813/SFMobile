//
//  Account.swift
//  SWSApp
//
//  Created by maria.min-hui.yu on 3/22/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation

class Account {
    var sfid: String
    var accountNumber: String
    var name: String
    var address: String
    var balance: String
    var actionItem: Int
    var totalR12NetSales: String
    var nextDelivery: String //might be date, use string for now
    
    init()  {
        sfid = ""
        accountNumber = ""
        name = ""
        address = "1234 W. Broadway Blvd, New York NY12000"
        balance = "0.0"
        actionItem = 2
        totalR12NetSales = "2,000.00"
        nextDelivery = "02-10-2018"
    }
    
    init(withAry ary: [Any]) {
        sfid = ary[0] as! String
        accountNumber = ary[1] as! String
        name = ary[2] as! String
        address = "1234 W. Broadway Blvd, New York NY12000"
        balance = "0.0"
        actionItem = 2
        totalR12NetSales = "2,000.00"
        nextDelivery = "02-10-2018"
    }
    
    init(json: [String: AnyObject]) {
        sfid = json["Id"] as! String
        accountNumber = json["AccountNumber"] as! String
        name = json["Name"] as! String
        address = "1234 W. Broadway Blvd, New York NY12000"
        balance = "0.0"
        actionItem = 2
        totalR12NetSales = "2,000.00"
        nextDelivery = "02-10-2018"
    }
    
    static func mockAccount1() -> Account {
        let acc = Account()
        acc.sfid =  "001m000000cHLmDAAW"
        acc.accountNumber = "148"
        acc.name = "Crown Liquor Store"
        acc.address = "1234 W. Broadway Blvd, New York NY12000"
        acc.balance = "$"+"90.98"
        acc.actionItem = 2
        acc.totalR12NetSales = "$"+"2,000.00"
        acc.nextDelivery = "02-10-2018"
        
        return acc
    }
    static func mockAccount2() -> Account {
        let acc = Account()
        acc.sfid =  "001m000000cHLmDAAZ"
        acc.accountNumber = "188"
        acc.name = "Big Liquor Store"
        acc.address = "1234 W. Broadway Blvd, New York NY12000"
        acc.balance = "$"+"80.98"
        acc.actionItem = 5
        acc.totalR12NetSales = "$"+"4,000.00"
        acc.nextDelivery = "05-10-2018"
        
        return acc
    }
}

