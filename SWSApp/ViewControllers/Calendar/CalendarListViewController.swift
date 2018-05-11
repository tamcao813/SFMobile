//
//  CalendarListViewController.swift
//  SWSApp
//
//  Created by Thillaiganesh, C. on 11/05/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class CalendarListViewController: UIViewController {

    @IBOutlet weak var weekView: WRWeekView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupCalendarData()
        
        //add events
        weekView.addEvent(event: WREvent.make(date: Date(), chunk: 2.hours, title: "#1"))
        weekView.addEvent(event: WREvent.make(date: Date(), chunk: 1.hours, title: "#2"))
        weekView.addEvent(event: WREvent.make(date: Date().add(90.minutes), chunk: 1.hours, title: "#3"))
        weekView.addEvent(event: WREvent.make(date: Date().add(110.minutes), chunk: 1.hours, title: "#4"))
        
        weekView.addEvent(event: WREvent.make(date: Date().add(1.days), chunk: 1.hours, title: "tomorrow"))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func moveToToday() {
        weekView.setCalendarDate(Date(), animated: true)
    }
    
    // MARK: - WRCalendarView
    func setupCalendarData() {
        weekView.setCalendarDate(Date())
        weekView.delegate = self        
        weekView.calendarType = .day
    }
    
}

extension CalendarListViewController: WRWeekViewDelegate {
    func view(startDate: Date, interval: Int) {
        print(startDate, interval)
    }
    
    func tap(date: Date) {
        print(date)
    }
    
    func selectEvent(_ event: WREvent) {
        print(event.title)
    }
}
