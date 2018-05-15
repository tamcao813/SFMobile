//
//  String+PartString.swift
//  SWSApp
//
//  Created by shubham.e.shukla on 4/11/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation

extension String {
    
    func slice(from: String, to: String) -> String? {
        
        return (range(of: from)?.upperBound).flatMap { substringFrom in
            (range(of: to, range: substringFrom..<endIndex)?.lowerBound).map { substringTo in
                substring(with: substringFrom..<substringTo)
            }
        }
    }
    
    var stripped: String {
        let okayChars = Set("abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLKMNOPQRSTUVWXYZ1234567890+-=().!_")
        return self.filter {okayChars.contains($0) }
    }
    
    func unescapeXMLCharacter(stringValue:String)->String {
        
        var returnValue = stringValue
        
        if(stringValue.isEmpty){
            return ""
        }
        if stringValue.range(of:"&#39;") != nil {
            returnValue = stringValue.replacingOccurrences(of: "&#39;", with: "'")
            
        } else if (stringValue.range(of:"&amp;") != nil){
            returnValue = stringValue.replacingOccurrences(of: "&amp;", with: "&")

        } else if (stringValue.range(of:"&#38;") != nil){
            returnValue = stringValue.replacingOccurrences(of: "&#38;", with: "\"")
            
        } else if (stringValue.range(of:"&#34;") != nil){
            returnValue = stringValue.replacingOccurrences(of: "&#34;", with: "\"")
            
        }else if (stringValue.range(of:"&#60;") != nil){
            returnValue = stringValue.replacingOccurrences(of: "&#60;", with: "<")
            
        }else if (stringValue.range(of:"&#62;") != nil){
            returnValue = stringValue.replacingOccurrences(of: "&#62;", with: "'")
            
        }else if (stringValue.range(of:"&#169;") != nil){
            returnValue = stringValue.replacingOccurrences(of: "&#169;", with: "©")
            
        }else if (stringValue.range(of:"&quot;") != nil){
            returnValue = stringValue.replacingOccurrences(of: "&quot;", with: "\"")
            
        }
        
        return returnValue;
    }
}
