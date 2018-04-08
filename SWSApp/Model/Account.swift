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
        acc.address = "1234 W. Broadway Blvd, Canada NY12000"
        acc.balance = "$"+"91.98"
        acc.actionItem = 1
        acc.totalR12NetSales = "$"+"1,000.00"
        acc.nextDelivery = "02-10-2018"
        
        return acc
    }
    static func mockAccount2() -> Account {
        let acc = Account()
        acc.sfid =  "001m000000cHLmDAAZ"
        acc.accountNumber = "188"
        acc.name = "Big Liquor Store"
        acc.address = "2345 W. Broadway Blvd, Mexico NY12000"
        acc.balance = "$"+"82.98"
        acc.actionItem = 2
        acc.totalR12NetSales = "$"+"2,000.00"
        acc.nextDelivery = "05-10-2018"
        
        return acc
    }
    
    static func mockAccount3() -> Account {
        let acc = Account()
        acc.sfid =  "001m000000cHLmDAAZ"
        acc.accountNumber = "189"
        acc.name = "Ace of Spades"
        acc.address = "3456 W. Broadway Blvd, Florida NY12000"
        acc.balance = "$"+"83.98"
        acc.actionItem = 3
        acc.totalR12NetSales = "$"+"3,000.00"
        acc.nextDelivery = "06-10-2018"
        
        return acc
    }
    
    static func mockAccount4() -> Account {
        let acc = Account()
        acc.sfid =  "001m000000cHLmDAAZ"
        acc.accountNumber = "190"
        acc.name = "Angélus"
        acc.address = "4567 W. Broadway Blvd, Miami NY12000"
        acc.balance = "$"+"84.98"
        acc.actionItem = 4
        acc.totalR12NetSales = "$"+"4,000.00"
        acc.nextDelivery = "07-10-2018"
        
        return acc
    }
    
    static func mockAccount5() -> Account {
        let acc = Account()
        acc.sfid =  "001m000000cHLmDAAZ"
        acc.accountNumber = "191"
        acc.name = "Astralis Shiraz"
        acc.address = "5678 W. Broadway Blvd, California NY12000"
        acc.balance = "$"+"85.98"
        acc.actionItem = 5
        acc.totalR12NetSales = "$"+"5,000.00"
        acc.nextDelivery = "08-10-2018"
        
        return acc
    }
    
    static func mockAccount6() -> Account {
        let acc = Account()
        acc.sfid =  "001m000000cHLmDAAZ"
        acc.accountNumber = "192"
        acc.name = "Ausone"
        acc.address = "6789 W. Broadway Blvd, Nevada NY12000"
        acc.balance = "$"+"86.98"
        acc.actionItem = 6
        acc.totalR12NetSales = "$"+"6,000.00"
        acc.nextDelivery = "09-10-2018"
        
        return acc
    }
    
    static func mockAccount7() -> Account {
        let acc = Account()
        acc.sfid =  "001m000000cHLmDAAZ"
        acc.accountNumber = "193"
        acc.name = "Beaucastel"
        acc.address = "7890 W. Broadway Blvd, Virginia NY12000"
        acc.balance = "$"+"87.98"
        acc.actionItem = 7
        acc.totalR12NetSales = "$"+"7,000.00"
        acc.nextDelivery = "10-10-2018"
        
        return acc
    }
    
    static func mockAccount8() -> Account {
        let acc = Account()
        acc.sfid =  "001m000000cHLmDAAZ"
        acc.accountNumber = "194"
        acc.name = "Beaux Freres"
        acc.address = "1590 W. Broadway Blvd, Las Vegas NY12000"
        acc.balance = "$"+"88.98"
        acc.actionItem = 8
        acc.totalR12NetSales = "$"+"8,000.00"
        acc.nextDelivery = "11-10-2018"
        
        return acc
    }
    
    static func mockAccount9() -> Account {
        let acc = Account()
        acc.sfid =  "001m000000cHLmDAAZ"
        acc.accountNumber = "195"
        acc.name = "Beaulieu Vineyard"
        acc.address = "4680 W. Broadway Blvd, Atlanta NY12000"
        acc.balance = "$"+"89.98"
        acc.actionItem = 9
        acc.totalR12NetSales = "$"+"9,000.00"
        acc.nextDelivery = "12-10-2018"
        
        return acc
    }
    
    static func mockAccount10() -> Account {
        let acc = Account()
        acc.sfid =  "001m000000cHLmDAAZ"
        acc.accountNumber = "197"
        acc.name = "Calon-Ségur"
        acc.address = "1357 W. Broadway Blvd, Argentina NY12000"
        acc.balance = "$"+"90.98"
        acc.actionItem = 10
        acc.totalR12NetSales = "$"+"10,000.00"
        acc.nextDelivery = "13-10-2018"
        
        return acc
    }
    
    
}

