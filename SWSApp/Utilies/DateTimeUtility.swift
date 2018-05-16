//
//  DateTimeUtility.swift
//  SWSApp
//
//  Created by shilpa.a.kulkarni on 13/04/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation
class DateTimeUtility
{
    static func getDDMMYYYFormattedDateString(dateStringfromAccountObject:String?)->String
    {
        // 13April Shilpa: Handling the empty date coming from backend for some of the accounts 1969
        if(dateStringfromAccountObject?.count == 0 || dateStringfromAccountObject == "1969-12-31")
        {
            return ""
        }
        //print("dateStringfromAccountObject: " + dateStringfromAccountObject!)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"// MM/DD/YYYY
        // get Date object from dateStringfromAccountObject
        let dateObjectFromDateStringfromAccountObject:Date = dateFormatter.date(from: dateStringfromAccountObject!)!
        dateFormatter.dateFormat = "mm/dd/yyyy"// MM/DD/YYYY
        let formattedMMDDYYDateStr = dateFormatter.string(from: dateObjectFromDateStringfromAccountObject)
        print("formattedMMDDYYDateStr: " + formattedMMDDYYDateStr)
        return formattedMMDDYYDateStr
    }
    
    static func convertUtcDatetoReadableDate(dateStringfromAccountNotes:String?)->String{
        if(dateStringfromAccountNotes?.isEmpty)!{
            return ""
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000+0000"
        
        dateFormatter.timeZone = TimeZone.current
        let date = dateFormatter.date(from: dateStringfromAccountNotes!)// create date from string
        // change to a readable time format and change to local time zone
        dateFormatter.dateFormat = "MM/dd/YYYY h:mma"
        let timeStamp = dateFormatter.string(from: date!)
        
        return timeStamp
    }
    
    static func convertUtcDatetoReadableDateLikeStrategy(dateString :String?)->String{
        if(dateString?.isEmpty)!{
            return ""
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000+0000"
        
        dateFormatter.timeZone = TimeZone.current
        let date = dateFormatter.date(from: dateString!)// create date from string
        // change to a readable time format and change to local time zone
        dateFormatter.dateFormat = "MMM dd,yyyy"
        let timeStamp = dateFormatter.string(from: date!)
        
        return timeStamp
        
    }
    
    static func getEEEEMMMdFormattedDateString(date: Date?) -> String {
        if(date == nil) {
            return ""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d"
        
        let timeStamp = dateFormatter.string(from: date!)
        
        return timeStamp
    }
    
    static func getDateFromyyyyMMddTimeFormattedDateString(dateString: String) -> Date? {
        
        var returnDate: Date?
        
        if(dateString == "") {
            return returnDate
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.zzz+zzzz"
        dateFormatter.timeZone = TimeZone(identifier:"UTC")
        returnDate = dateFormatter.date(from: dateString)
        
        guard let _ = returnDate else {
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            dateFormatter.timeZone = TimeZone(identifier:"UTC")
            returnDate = dateFormatter.date(from: dateString)
            
            return returnDate
        }
        
        return returnDate
        
    }
    
}

extension Date {
    
    //An integer representation of age from the date object (read-only).
    var age: Int {
        get {
            let now = Date()
            let calendar = Calendar.current
            
            let ageComponents = calendar.dateComponents([.year], from: self, to: now)
            let age = ageComponents.year!
            return age
        }
    }
    
    func set(year: Int?=nil, month: Int?=nil, day: Int?=nil, hour: Int?=nil, minute: Int?=nil, second: Int?=nil, tz: String?=nil) -> Date {
        let timeZone = Calendar.current.timeZone
        let year = year ?? self.year
        let month = month ?? self.month
        let day = day ?? self.day
        let hour = hour ?? self.hour
        let minute = minute ?? self.minute
        let second = second ?? self.second
        let dateComponents = DateComponents(timeZone:timeZone, year:year, month:month, day:day, hour:hour, minute:minute, second:second)
        let date = Calendar.current.date(from: dateComponents)
        return date!
    }
    
    func add(component: Calendar.Component, value: Int) -> Date {
        return Calendar.current.date(byAdding: component, value: value, to: self)!
    }
    
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }
    
    var endOfDay: Date {
        return self.set(hour: 23, minute: 59, second: 59)
    }
    
    init(year: Int, month: Int, day: Int) {
        var dc = DateComponents()
        dc.year = year
        dc.month = month
        dc.day = day
        
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(secondsFromGMT: 0)!
        if let date = calendar.date(from: dc) {
            self.init(timeInterval: 0, since: date)
        } else {
            fatalError("Date component values were invalid.")
        }
    }
    
    static func daysBetween(start: Date, end: Date, ignoreHours: Bool) -> Int {
        let startDate = ignoreHours ? start.startOfDay : start
        let endDate = ignoreHours ? end.startOfDay : end
        return Calendar.current.dateComponents([.day], from: startDate, to: endDate).day!
    }
    
    static func hoursBetween(start: Date, end: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: start, to: end).hour!
    }
    
    static func minutesBetween(start: Date, end: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: start, to: end).minute!
    }
    
}
