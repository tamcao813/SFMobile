//
//  WREvent.swift
//  Pods
//
//  Created by wayfinder on 2017. 4. 29..
//
//

import UIKit
import DateToolsSwift

open class WREvent: TimePeriod {
    open var Id: String = ""
    open var type: String = ""
    open var title: String = ""
    open var accountName: String = ""
    open var accountNumber: String = ""
    open var accountId: String = ""
    open var contactName: String = ""
    open var startDate: String = ""
    open var location: String = ""
    open var date: Date = Date()
    
    open var ownerId : String = ""
    
    open class func make(date:Date, chunk: TimeChunk, title: String) -> WREvent {
        let event = WREvent(beginning: date, chunk: chunk)
        event.title = title
        
        return event
    }
    
    open class func makeVisitEvent(Id: String, type: String, date: Date, startDate:String, chunk: TimeChunk, title: String, location:String , ownerId:String) -> WREvent {
        let event = WREvent(beginning: date, chunk: chunk)
        event.title = title
        event.Id = Id
        event.type = type
        event.date = date
        event.startDate = startDate
        event.location = location
        event.ownerId = ownerId
        return event
    }
}
