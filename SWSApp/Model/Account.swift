//
//  Account.swift
//  SWSApp
//
//  Created by maria.min-hui.yu on 3/22/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation

class Account {
    static let AccountFields: [String] = ["Account.Id", "Account.Name", "Account.SWS_Account_Site__r.SWS_External_ID__c", "Account.Google_Place_Formatted_Phone__c", "Account.SWS_License_Status__c", "Account.SWS_Growth_in_MTD_Net_Sales__c", "Account.SWS_AR_Past_Due_Amount__c", "Account.AccountNumber", "Account.SWS_Premise_Code__c", "Account.SWS_License_Type__c", "Account.SWS_License__c", "Account.Google_Place_Operating_Hours__c", "Account.SWS_License_Expiration_Date__c", "Account.SWS_Total_CY_R12_Net_Sales__c", "Account.SWS_Total_AR_Balance__c", "Account.SWS_Credit_Limit__c", "Account.SWS_TD_Channel__c", "Account.SWS_TD_Sub_Channel__c", "Account.SWS_License_Status_Description__c", "Account.ShippingCity", "Account.ShippingCountry", "Account.ShippingGeocodeAccuracy", "Account.ShippingLatitude", "Account.ShippingLongitude", "Account.ShippingPostalCode", "Account.ShippingState", "Account.ShippingStreet", "Account.ShippingAddress", "UserId", "Account.IS_Next_Delivery_Date__c", "Account.SWS_Delivery_Frequency__c", "Account.SWS_License_Type_Description__c", "Account.SWS_AR_Past_Due_Alert__c"]
    
    var accountId: String
    var accountName: String
    var siteId: String
    var phone: String
    var licenseStatus: String
    var netSales: Double
    var pastDueAmount: Double
    var accountNumber: String
    var premiseCode: String
    var licenseType: String
    var license: String
    var operatingHours: String
    var licenseExpirationDate: Date
    var totalCYR12NetSales: Double
    var totalARBalance: Double
    var creditLimit: Double
    var channelTD: String
    var subChannelTD: String
    var licenseStatusDescription: String
    var shippingCity: String
    var shippingCountry: String
    var shippingGeocodeAccuracy: String
    var shippingLatitude: Double
    var shippingLongitude: Double
    var shippingPostalCode: String
    var shippingState: String
    var shippingStreet: String
    var shippingAddress: String
    var userId: String
    var nextDeliveryDate: Date
    var deliveryFrequency: String
    var licenseTypeDescription: String
    var pastDueAlert: String
    var actionItem: Int
    
    
    convenience init(withAry ary: [Any]) {
        let resultDict = Dictionary(uniqueKeysWithValues: zip(Account.AccountFields, ary))
        self.init(json: resultDict)
    }
    
    init(json: [String: Any]) {
        accountId = json["AccountId"] as! String
        accountName = json["AccountName"] as? String ?? ""
        siteId = json["SiteId"] as? String ?? ""
        phone = json["Phone"] as? String ?? ""
        licenseStatus = json["License_Status"] as? String ?? ""
        netSales = json["MTD_Net_Sales"] as? Double ?? 0.0
        pastDueAmount = json["Past_Due_Amount"] as? Double ?? 0.0
        accountNumber = json["AccountNumber"] as? String ?? ""
        premiseCode = json["Premise_Code"] as? String ?? ""
        licenseType = json["License_Type"] as? String ?? ""
        license = json["License"] as? String ?? ""
        operatingHours = json["Operating_Hours"] as? String ?? ""
        licenseExpirationDate = json["License_Expiration_Date"] as? Date ?? Date() //need to check if ok to have a default or make it a string
        totalCYR12NetSales = json["Total_CY_R12_Net_Sales"] as? Double ?? 0.0
        totalARBalance = json["Total_AR_Balance"] as? Double ?? 0.0
        creditLimit = json["Credit_Limit"] as? Double ?? 0.0
        channelTD = json["TD_Channel"] as? String ?? ""
        subChannelTD = json["TD_Sub_Channel"] as? String ?? ""
        licenseStatusDescription = json["License_Status_Description"] as? String ?? ""
        shippingCity = json["ShippingCity"] as? String ?? ""
        shippingCountry = json["ShippingCountry"] as? String ?? ""
        shippingGeocodeAccuracy = json["ShippingGeocodeAccuracy"] as? String ?? ""
        shippingLatitude = json["ShippingLatitude"] as? Double ?? 0.0
        shippingLongitude = json["ShippingLongitude"] as? Double ?? 0.0
        shippingPostalCode = json["ShippingPostalCode"] as? String ?? ""
        shippingState = json["ShippingState"] as? String ?? ""
        shippingStreet = json["ShippingStreet"] as? String ?? ""
        shippingAddress = json["ShippingAddress"] as? String ?? ""
        userId = json["UserId"] as? String ?? ""
        nextDeliveryDate = json["Next_Delivery_Date"] as? Date ?? Date() //need to check if ok to have a default or make it a string
        deliveryFrequency = json["Delivery_Frequency"] as? String ?? ""
        licenseTypeDescription = json["License_Type_Description"] as? String ?? ""
        pastDueAlert = json["Past_Due_Alert"] as? String ?? ""
        actionItem = 2 //need to get from query
    }
    
    init(for: String)  {
        accountId = ""
        accountName = ""
        siteId = ""
        phone = ""
        licenseStatus = ""
        netSales = 0.0
        pastDueAmount = 0.0
        accountNumber = ""
        premiseCode = ""
        licenseType = ""
        license = ""
        operatingHours = ""
        licenseExpirationDate = Date()
        totalCYR12NetSales = 0.0
        totalARBalance = 0.0
        creditLimit = 0.0
        channelTD = ""
        subChannelTD = ""
        licenseStatusDescription = ""
        shippingCity = ""
        shippingCountry = ""
        shippingGeocodeAccuracy = ""
        shippingLatitude = 0.0
        shippingLongitude = 0.0
        shippingPostalCode = ""
        shippingState = ""
        shippingStreet = ""
        shippingAddress = ""
        userId = ""
        nextDeliveryDate = Date()
        deliveryFrequency = ""
        licenseTypeDescription = ""
        pastDueAlert = ""
        actionItem = 2
    }
    
    static func mockAccount1() -> Account {
        let acc = Account(for: "mockup")
        acc.accountId =  "001m000000cHLmDAAW"
        acc.accountNumber = "148"
        acc.accountName = "Crown Liquor Store"
        acc.shippingAddress =  "B1- 202 Argentina"
        acc.shippingStreet = "W. Broadway Blvd"
        acc.shippingCity = "New York4"
        acc.shippingState = "NY"
        acc.shippingPostalCode = "12105"
        acc.shippingCountry = "USA"
        acc.totalARBalance = 90.98
        acc.totalCYR12NetSales = 2000.00
        acc.nextDeliveryDate = Date()
        acc.actionItem = 2
        return acc
    }
    static func mockAccount2() -> Account {
        let acc = Account(for: "mockup")
        acc.accountId =  "001m000000cHLmDAAZ"
        acc.accountNumber = "188"
        acc.accountName = "Big Liquor Store"
        acc.shippingAddress = "B1- 202 California"
        acc.shippingStreet = "W. Broadway Blvd"
        acc.shippingCity = "New York3"
        acc.shippingState = "NY"
        acc.shippingPostalCode = "12102"
        acc.shippingCountry = "USA"
        acc.totalARBalance = 80.98
        acc.totalCYR12NetSales = 4000.00
        acc.nextDeliveryDate = Date()
        acc.actionItem = 5
        
        return acc
    }
    
    static func mockAccount3() -> Account {
        let acc = Account(for: "mockup")
        acc.accountId =  "001m000000cHLmDAAZ"
        acc.accountNumber = "198"
        acc.accountName = "Bigger Liquor Store"
        acc.shippingAddress = "7890"
        acc.shippingStreet = "W. Broadway Blvd"
        acc.shippingCity = "New York2"
        acc.shippingState = "NY"
        acc.shippingPostalCode = "12101"
        acc.shippingCountry = "USA"
        acc.totalARBalance = 90.98
        acc.totalCYR12NetSales = 4500.00
        let dateFormatter = DateFormatter()
        //dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"// MM-DD-YYYY
        dateFormatter.dateFormat = "yyyy-MM-dd"// MM-DD-YYYY
        dateFormatter.timeZone = TimeZone(identifier:"UTC")
        acc.nextDeliveryDate = dateFormatter.date(from:"2018-05-10")!
        acc.actionItem = 7
        
        return acc
    }
    
    static func mockAccount4() -> Account {
        let acc = Account(for: "mockup")
        acc.accountId =  "001m000000cHLmDAAZ"
        acc.accountNumber = "208"
        acc.accountName = "Biggest Liquor Store"
        acc.shippingAddress = "4567"
        acc.shippingStreet = "W. Broadway Blvd"
        acc.shippingCity = "New York1"
        acc.shippingState = "NY"
        acc.shippingPostalCode = "12100"
        acc.shippingCountry = "USA"
        acc.totalARBalance = 99.98
        acc.totalCYR12NetSales = 4300.00
        let dateFormatter = DateFormatter()
        //dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"// MM-DD-YYYY
        dateFormatter.dateFormat = "yyyy-MM-dd"// MM-DD-YYYY
        dateFormatter.timeZone = TimeZone(identifier:"UTC")
        acc.nextDeliveryDate = dateFormatter.date(from:"2018-07-13")!
        acc.actionItem = 15
        
        return acc
    }
}
