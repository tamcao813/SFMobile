//
//  CurrencyFormatter.swift
//  SWSApp
//
//  Created by shubham.e.shukla on 4/15/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation

class CurrencyFormatter {
    
    
    static func convertToCurrencyFormat(amountToConvert:Double)-> String{
        
        
        let formatter = NumberFormatter()
        formatter.locale = Locale.current // Change this to another locale if you want to force a specific locale, otherwise this is redundant as the current locale is the default already
        formatter.numberStyle = .currency
        let formattedAmount = formatter.string(from:amountToConvert as NSNumber)
        return formattedAmount!
        
    }

}
