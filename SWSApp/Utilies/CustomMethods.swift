//
//  CustomMethods.swift
//  MonthCalendar
//
//  Created by vipin.vijay on 14/05/18.
//  Copyright © 2018 vipin.vijay. All rights reserved.
//

import Foundation

func getNumberOfDays(year:Int, month: Int) -> Int {
    
    // let dateComponents = DateComponents(year: 2015, month: 7)
    let dateComponents = DateComponents(year: year, month: month)
    
    let calendar = Calendar.current
    let date = calendar.date(from: dateComponents)!
    
    let range = calendar.range(of: .day, in: .month, for: date)!
    let numDays = range.count
    print(numDays) // 31
    return numDays
}

func getPreviousMonthDays(currentMonthIndex: Int, currentYear:Int) -> Int {
    
    var currentMonth = currentMonthIndex
    var currentYearIndex = currentYear
    currentMonth = currentMonth - 1
    if currentMonth < 0 {
        currentMonth = 11
        currentYearIndex -= 1
    }
    
   return getNumberOfDays(year:currentYearIndex, month: currentMonth)
}

func getNextMonthDays(currentMonthIndex: Int, currentYear:Int) -> Int {
    
    var currentMonth = currentMonthIndex
    var currentYearIndex = currentYear
    currentMonth += 1
    if currentMonth > 11 {
        currentMonth = 0
        currentYearIndex += 1
    }
    
    return getNumberOfDays(year:currentYearIndex, month: currentMonth)
}

func getNextMonth(currentMonthIndex: Int) -> Int {
    var currentMonth = currentMonthIndex
    currentMonth += 1
    if currentMonth > 12 {
        currentMonth = 1
    }
    return currentMonth
}

func getNextYear(currentMonthIndex: Int, currentYearIndex: Int) -> Int {
    var  currentMonth = currentMonthIndex
    var currentYear = currentYearIndex
    
    currentMonth += 1
    if currentMonth > 12 {
        currentYear += 1
    }
    return currentYear
}

func getPreviousMonth(currentMonthIndex: Int) -> Int {
    
    var currentMonth = currentMonthIndex
    currentMonth = currentMonth - 1
    if currentMonth == 0 {
        currentMonth = 12
    }
    return currentMonth
}

func getPreviousYear(currentMonthIndex: Int, currentYearIndex: Int) -> Int {
    var currentMonth = currentMonthIndex
    var currentYear = currentYearIndex
    currentMonth = currentMonth - 1
    if currentMonth == 0 {
        currentYear -= 1
    }
    return currentYear
}
