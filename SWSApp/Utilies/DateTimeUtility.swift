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
    
    /* Function Will return the date in format yyyy-dd-mm from sting in format yyyy-dd-mm */
    
    static func getDDMMYYYFormattedDateFromString(dateString: String) -> Date {
        
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        let DateArray = dateString.components(separatedBy: "-")
        let components = NSDateComponents()
        components.year = Int(DateArray[0])!
        components.month = Int(DateArray[1])!
        components.day = Int(DateArray[2])!
        components.timeZone = TimeZone(abbreviation: "GMT+0:00")
        let date = calendar.date(from: components as DateComponents)
        
        return date!

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
        dateFormatter.dateFormat = "MM-dd-YYYY h:mma"
        let timeStamp = dateFormatter.string(from: date!)
        
        return timeStamp
    }
    
    static func convertUtcDatetoReadableDateOnlyDate(dateStringfromAccountNotes:String?)->String{
        if(dateStringfromAccountNotes?.isEmpty)!{
            return ""
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
       // dateFormatter.timeZone = TimeZone.current
        let date = dateFormatter.date(from: dateStringfromAccountNotes!)// create date from string
        
        if date != nil{
            dateFormatter.dateFormat = "MM-dd-yyyy"
            let timeStamp = dateFormatter.string(from: date!)
            return timeStamp
        }else{
            return dateStringfromAccountNotes!
        }
    }
    
    func convertDateSendToServerActionItem(dateString: String?) -> String{
        if (dateString?.isEmpty)! {
            return ""
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        
        let date = dateFormatter.date(from: dateString!)// create date from string        
        if date != nil{
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let timeStamp = dateFormatter.string(from: date!)
            return timeStamp
        }
        return dateString!
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
    
    static func convertUtcDatetoReadableDateString(dateString :String?)->String{
        if(dateString?.isEmpty)!{
            return ""
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000+0000"
        dateFormatter.timeZone = TimeZone(identifier:"UTC")
        let date = dateFormatter.date(from: dateString!)// create date from string
        // change to a readable time format and change to local time zone
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone.current
        let timeStamp = dateFormatter.string(from: date!)
        return timeStamp
    }
    
    static func convertUtcDatetoReadableDateAndTimeString(dateString :String?)->String{
        if(dateString?.isEmpty)!{
            return ""
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000+0000"
        dateFormatter.timeZone = TimeZone(identifier:"UTC")
        let date = dateFormatter.date(from: dateString!)// create date from string
        
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:a"
        dateFormatter.timeZone = TimeZone.current
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
    
    static func getWeekFormattedDateString(date: Date?, includeWeekend: Bool) -> String {
        if(date == nil) {
            return ""
        }
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "MMM d"
        let dateString1 = dateFormatter.string(from: date!)
        
        dateFormatter.dateFormat = "d"
        let dateString2 = dateFormatter.string(from: date!.add(component: .day, value: includeWeekend ? 6 : 4))
        
        dateFormatter.dateFormat = "yyyy"
        let dateString3 = dateFormatter.string(from: date!)
        
        return (dateString1 + " - " + dateString2 + ", " + dateString3)
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
    
    static func getDateActionItemFromDateString(dateString: String) -> Date? {
        
        var returnDate: Date?
        
        if(dateString == "") {
            return returnDate
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(identifier:"UTC")
        returnDate = dateFormatter.date(from: dateString)
        
        guard let _ = returnDate else {
            dateFormatter.dateFormat = "yyyy-MM-dd"
            dateFormatter.timeZone = TimeZone(identifier:"UTC")
            returnDate = dateFormatter.date(from: dateString)
            
            return returnDate
        }
        
        return returnDate
        
    }
    
    static func sendCurrentDateToServer() -> String? {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000+0000"
        let timeStamp = dateFormatter.string(from: date)
        return timeStamp
    }
    
    
    ///-------- Check Whether The Dates Are WeekEnds OR Not - START ------ ///
    //Using the components in calendar library will get each dd/mm/yyyy is weekend or not
    static func isWeekend(date: Date) -> Bool {
        let calendar = Calendar(identifier: .gregorian)
        let components:DateComponents = calendar.dateComponents([.weekday], from: date)
        if components.weekday == 1 || components.weekday == 7 {
            return true
        }
        return false
    }
    ///-------- Check Whether The Dates Are WeekEnds OR Not - END ------ ///
    
    ///------------ Convert String To Date Format - START ------- ///
    // Using calendar components convering the string to date format
    static func getDateFromString(dateStr: String) -> Date {
        
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        let DateArray = dateStr.components(separatedBy: "-")
        let components = NSDateComponents()
        components.year = Int(DateArray[2])!
        components.month = Int(DateArray[1])!
        components.day = Int(DateArray[0])!
        components.timeZone = TimeZone(abbreviation: "GMT+0:00")
        let date = calendar.date(from: components as DateComponents)
        return date!
    }
    ///------------ Convert String To Date Format - END ------- ///
    
    ///------------ Convert String To Date Format - START ------- ///
    // Using calendar components convering the string to date format
    static func getDateFromStringFormat(dateStr: String) -> Date {
        
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        let DateArray = dateStr.components(separatedBy: "-")
        let components = NSDateComponents()
        components.year = Int(DateArray[2])!
        components.month = Int(DateArray[1])!
        components.day = Int(DateArray[0])!
        components.timeZone = TimeZone.current
        let date = calendar.date(from: components as DateComponents)
        return date!
    }
    ///------------ Convert String To Date Format - END ------- ///
    
    
    ///------------ Convert Date To String Format - START ------- ///
    // Using the dateformatter convering date to string format
    static func getDate(dateString: String) -> Date? {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss" //Getting this right is very important!
        guard let date = dateFormatter.date(from: "\(dateString)") else {
            //handle error
            return nil
        }
        return date
    }
    ///------------ Convert Date To String Format - END ------- ///
    
    ///------------ Convert Date To Time Format - START ------- ///
    
    static func getTimeFromDate(date: Date) -> String {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "h:mm a"
        let fullTime = timeFormatter.string(from: date)
        return fullTime
    }
    
    ///------------ Convert Date To Time Format - END ------- ///
    
    
    ///-----------Sort Array With Time -  START --------///
    // returning array with sorted value of time in descending order
    static func getAllSortedTime(visitsArray: Array<WREvent>) -> (Array<WREvent>, isMoreCount:Bool) {
        var minuteArr = [WREvent]()
        var isMoreCount = false
        if visitsArray.count > 3 {isMoreCount = true }
        for visit in visitsArray {
            if minuteArr.count < 3 {
                minuteArr.append(visit)
            }
        }
        return (minuteArr, isMoreCount)
    }
    ///-----------Sort Array With Time -  END --------///
    
    ///------- Compare Each Date Of Month With Array Objects - START --------////
    // Converting array of dates in string format in descending order
    static func getEventDates(currentDate: String, visitArray: Array<WREvent>) -> (Array<WREvent>, isMoreCount:Bool) {
        
        let calendar  =  Calendar.current
        var tempDateArr = [WREvent]()
        for visit in visitArray {
            let  isSameDate  =  calendar.isDate (getDate(dateString: currentDate)!  ,  inSameDayAs :  visit.date)
            if isSameDate {
                tempDateArr.append(visit)
            }
        }
        tempDateArr = tempDateArr.sorted(by: { $0.date < $1.date })
        let minutesArr = getAllSortedTime(visitsArray: tempDateArr).0
        let isMoreCount = getAllSortedTime(visitsArray: tempDateArr).1
        return (minutesArr, isMoreCount)
    }
    ///------- Compare Each Date Of Month With Array Objects - END --------////
    
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
    
    var startOfWeek: Date {
        let date = Calendar.current.date(from: Calendar.current.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self))!
        let dslTimeOffset = NSTimeZone.local.daylightSavingTimeOffset(for: date)
        return date.addingTimeInterval(dslTimeOffset)
    }
    
    var endOfWeek: Date {
        return Calendar.current.date(byAdding: .second, value: 604799, to: self.startOfWeek)!
    }

}

