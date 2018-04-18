//
//  Account.swift
//  SWSApp
//
//  Created by maria.min-hui.yu on 3/22/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation

class Account {
    static let AccountFields: [String] = ["Account.SGWS_Account_Health_Grade__c","Account.Name","Account.AccountNumber","Account.SWS_Total_CY_MTD_Net_Sales__c","Account.SWS_Total_AR_Balance__c","Account.IS_Next_Delivery_Date__c","Account.SWS_Premise_Code__c","Account.SWS_License_Type__c","Account.SWS_License__c","Account.Google_Place_Operating_Hours__c","Account.SWS_License_Expiration_Date__c","Account.SWS_Total_CY_R12_Net_Sales__c","Account.SWS_Credit_Limit__c","Account.SWS_TD_Channel__c","Account.SWS_TD_Sub_Channel__c","Account.SWS_License_Status_Description__c","Account.ShippingCity","Account.ShippingCountry","Account.ShippingPostalCode","Account.ShippingState","Account.ShippingStreet","Account.SWS_PCT_to_Last_Year_MTD_Net_Sales__c","Account.SWS_AR_Past_Due_Amount__c","Account.SWS_Delivery_Frequency__c","Account.SGWS_Single_Multi_Locations_Filter__c","Account.Google_Place_Formatted_Phone__c","Account.SWS_Status_Description__c","AccountId","Account.SWS_PCT_to_Last_Year_R12_Net_Sales__c"]
    //,,,
//  ,,,,,,,,,,,,"Account.ShippingGeocodeAccuracy",,,,,"Account.SWS_License_Status__c",,"Account.SGWS_Account_Health_Grade__c",,"Account.SWS_License_Type_Description__c"]
    
    // "Account.ShippingLatitude","Account.ShippingLongitude",
    
    var accountName: String
    var siteId: String
    var phone: String
    var licenseStatus: String
    var nextDeliveryDate: String
    var mtdNetSales: Double
    var pastDueAmount: String
    var accountNumber: String
    var premiseCode: String
    var licenseType: String
    var licenseNumber: String
    var operatingHours: String
    var licenseExpirationDate: String
    var totalCYR12NetSales: Double
    var totalARBalance: Double
    var creditLimit: Double
    var channelTD: String
    var subChannelTD: String
    var licenseStatusDescription: String
    var shippingCity: String
    var shippingCountry: String
    var shippingGeocodeAccuracy: String
//    var shippingLatitude: Double
//    var shippingLongitude: Double
    var shippingPostalCode: String
    var shippingState: String
    var shippingStreet: String
    //var shippingAddress: String
    //var userId: String
    var acctHealthGrade: String
    var deliveryFrequency: String
    var licenseTypeDescription: String
    var pastDueAlert: String
    var actionItem: Int
    var percentageLastYearMTDNetSales: String
    var singleMultiLocationFilter:String // single multi
    var acctDescStatus: String
    var account_Id: String
    var percentageLastYearR12NetSales:String
    

    
    var pastDueAmountDouble: Double
  
  
    convenience init(withAry ary: [Any]) {
        let resultDict = Dictionary(uniqueKeysWithValues: zip(Account.AccountFields, ary))
        self.init(json: resultDict)
    }
    
    init(json: [String: Any]) {
        
        print("Json coming here is*** \(json)")
        singleMultiLocationFilter = json["Account.SGWS_Single_Multi_Locations_Filter__c"] as? String ?? ""
        acctHealthGrade = json["Account.SGWS_Account_Health_Grade__c"] as? String ?? ""
        accountName = json["Account.Name"] as? String ?? ""
        siteId = json["SiteId"] as? String ?? ""
        phone = json["Account.Google_Place_Formatted_Phone__c"] as? String ?? ""
        licenseStatus = json["Account.SWS_License_Status_Description__c"] as? String ?? ""
        mtdNetSales = json["Account.SWS_Total_CY_MTD_Net_Sales__c"] as? Double ?? 0.0
        pastDueAmount = json["Account.SWS_AR_Past_Due_Amount__c"] as? String ?? ""
        accountNumber = json["Account.AccountNumber"] as? String ?? ""
        premiseCode = json["Account.SWS_Premise_Code__c"] as? String ?? ""
        licenseType = json["Account.SWS_License_Type__c"] as? String ?? ""
        percentageLastYearMTDNetSales = json["Account.SWS_PCT_to_Last_Year_MTD_Net_Sales__c"] as? String ?? ""
        licenseNumber = json["Account.SWS_License__c"] as? String ?? ""
        operatingHours = json["Account.Google_Place_Operating_Hours__c"] as? String ?? ""
        licenseExpirationDate = json["Account.SWS_License_Expiration_Date__c"] as? String ?? "" //need to check if ok to have a default or make it a string
        totalCYR12NetSales = json["Account.SWS_Total_CY_R12_Net_Sales__c"] as? Double ?? 0.0
        totalARBalance = json["Account.SWS_Total_AR_Balance__c"] as? Double ?? 0.0
        creditLimit = json["Account.SWS_Credit_Limit__c"] as? Double ?? 0.0
        channelTD = json["Account.SWS_TD_Channel__c"] as? String ?? ""
        subChannelTD = json["Account.SWS_TD_Sub_Channel__c"] as? String ?? ""
        licenseStatusDescription = json["Account.SWS_License_Status_Description__c"] as? String ?? ""
        shippingCity = json["Account.ShippingCity"] as? String ?? ""
        shippingCountry = json["Account.ShippingCountry"] as? String ?? ""
        shippingGeocodeAccuracy = json["Account.ShippingGeocodeAccuracy"] as? String ?? ""
        
//        shippingLatitude = json["Account.ShippingLatitude"] as? Double ?? 0.0
//        shippingLongitude = json["Account.ShippingLongitude"] as? Double ?? 0.0
        
        shippingPostalCode = json["Account.ShippingPostalCode"] as? String ?? ""
        shippingState = json["Account.ShippingState"] as? String ?? ""
        shippingStreet = json["Account.ShippingStreet"] as? String ?? ""
      //  shippingAddress = json["Account.ShippingAddress"] as? String ?? ""
       // userId = json["UserId"] as? String ?? ""
        nextDeliveryDate = json["Account.IS_Next_Delivery_Date__c"] as? String ?? "" //need to check if ok to have a default or make it a string
       
        deliveryFrequency = json["Account.SWS_Delivery_Frequency__c"] as? String ?? ""
        licenseTypeDescription = json["Account.SWS_License_Type_Description__c"] as? String ?? ""
        pastDueAlert = json["Past_Due_Alert"] as? String ?? ""
        acctDescStatus = json["Account.SWS_Status_Description__c"] as? String ?? ""
        account_Id = json["AccountId"] as? String ?? ""
        percentageLastYearR12NetSales = json["Account.SWS_PCT_to_Last_Year_R12_Net_Sales__c"] as? String ?? ""
        actionItem = 2 //need to get from query
        
        pastDueAmountDouble = Double(pastDueAmount)!
      
     
    }
    
    init(for: String)  {
        accountName = ""
        siteId = ""
        phone = ""
        acctHealthGrade = ""
        licenseStatus = ""
        mtdNetSales = 0.0
        pastDueAmount = ""
        accountNumber = ""
        premiseCode = ""
        licenseType = ""
        licenseNumber = ""
        operatingHours = ""
        licenseExpirationDate = ""
        totalCYR12NetSales = 0.0
        totalARBalance = 0.0
        creditLimit = 0.0
        channelTD = ""
        subChannelTD = ""
        licenseStatusDescription = ""
        shippingCity = ""
        shippingCountry = ""
        shippingGeocodeAccuracy = ""
//        shippingLatitude = 0.0
//        shippingLongitude = 0.0
        shippingPostalCode = ""
        shippingState = ""
        shippingStreet = ""
       // shippingAddress = ""
       // userId = ""
        nextDeliveryDate = ""
        deliveryFrequency = ""
        licenseTypeDescription = ""
        pastDueAlert = ""
        percentageLastYearMTDNetSales = ""
        actionItem = 2
        singleMultiLocationFilter = ""
        acctDescStatus = ""
        account_Id = ""
        pastDueAmountDouble = 0.0
        percentageLastYearR12NetSales = ""
      
       
       
    }
    
    static func mockAccount1() -> Account {
        let acc = Account(for: "mockup")
       // acc.accountId =  "001m000000cHLmDAAW"
        acc.accountNumber = "148"
        acc.accountName = "Crown Liquor Store"
      //  acc.shippingAddress =  "B1- 202 Argentina"
        acc.shippingStreet = "W. Broadway Blvd"
        acc.shippingCity = "New York4"
        acc.shippingState = "NY"
        acc.shippingPostalCode = "12105"
        acc.shippingCountry = "USA"
        acc.totalARBalance = 90.98
        acc.totalCYR12NetSales = 2000.00
     //   acc.nextDeliveryDate = Date()
        acc.actionItem = 2
        return acc
    }
    static func mockAccount2() -> Account {
        let acc = Account(for: "mockup")
        //acc.accountId =  "001m000000cHLmDAAZ"
        acc.accountNumber = "188"
        acc.accountName = "Big Liquor Store"
     //   acc.shippingAddress = "B1- 202 California"
        acc.shippingStreet = "W. Broadway Blvd"
        acc.shippingCity = "New York3"
        acc.shippingState = "NY"
        acc.shippingPostalCode = "12102"
        acc.shippingCountry = "USA"
        acc.totalARBalance = 80.98
        acc.totalCYR12NetSales = 4000.00
     //   acc.nextDeliveryDate = Date()
        acc.actionItem = 5
        
        return acc
    }
    
    static func mockAccount3() -> Account {
        let acc = Account(for: "mockup")
      //  acc.accountId =  "001m000000cHLmDAAZ"
        acc.accountNumber = "198"
        acc.accountName = "Bigger Liquor Store"
     //   acc.shippingAddress = "7890"
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
     //   acc.nextDeliveryDate = dateFormatter.date(from:"2018-05-10")!
        acc.actionItem = 7
        
        return acc
    }
    
    static func mockAccount4() -> Account {
        let acc = Account(for: "mockup")
      //  acc.accountId =  "001m000000cHLmDAAZ"
        acc.accountNumber = "208"
        acc.accountName = "Biggest Liquor Store"
      //  acc.shippingAddress = "4567"
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
  //      acc.nextDeliveryDate = dateFormatter.date(from:"2018-07-13")!
        acc.actionItem = 15
        
        return acc
    }
}
