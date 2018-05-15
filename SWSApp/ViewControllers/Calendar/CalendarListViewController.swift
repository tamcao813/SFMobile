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
    @IBOutlet weak var dateHeaderLabel: UILabel!

    var currentShowingDate: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(self.refreshCalendar), name: NSNotification.Name("refreshCalendar"), object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("CalendarListViewController : viewWillAppear")
        reloadCalendarView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("refreshCalendar"), object: nil)
    }
    
    @objc func refreshCalendar(){
        reloadCalendarView()
    }
    
    func reloadCalendarView() {
        setupCalendarData()
        weekView.setEvents(events: CalendarViewModel().loadVisitData()!)
        moveToToday()
    }
    
    func displayDateHeader(_ startDate: Date) {
        if weekView.calendarType == .day {
            dateHeaderLabel.text = DateTimeUtility.getEEEEMMMdFormattedDateString(date: startDate)
        }
    }

    // MARK: - Button Action
    @IBAction func actionButtonCalendarTypeView(_ sender: Any) {
    }
    
    @IBAction func actionButtonNewVisit(_ sender: Any) {
        let createVisitViewController = UIStoryboard(name: "AccountVisit", bundle: nil).instantiateViewController(withIdentifier :"CreateNewVisitViewController") as! CreateNewVisitViewController
        createVisitViewController.isEditingMode = false
        
        //Reset the PlanVistManager
        PlanVistManager.sharedInstance.visit = nil
        
        self.present(createVisitViewController, animated: true)
    }
    
    @IBAction func actionButtonLeft(_ sender: Any) {
        
        weekView.scrollToPreviousItem()

    }
        
    @IBAction func actionButtonRight(_ sender: Any) {

        weekView.scrollToNextItem()

    }
    
    // MARK: - WRCalendarView
    func setupCalendarData() {
        
        currentShowingDate = Date()
        
        weekView.setCalendarDate(Date())
        weekView.delegate = self        
        weekView.calendarType = .day
        
    }
    
    func moveToToday() {

        currentShowingDate = Date()
        weekView.setCalendarDate(Date(), animated: true)

    }

}

extension CalendarListViewController: WRWeekViewDelegate {
    func view(startDate: Date, interval: Int) {
        print(startDate, interval)
        currentShowingDate = startDate
        DispatchQueue.main.async {
            self.displayDateHeader(startDate)
        }
    }
    
    func tap(date: Date) {
        print(date)
    }
    
    func selectEvent(_ event: WREvent) {
        print("selectEvent: WREvent.Id: \(event.Id) : WREvent.title: \(event.title) : WREvent.type: \(event.type)")
        
        if event.type == "visit" {
            let accountStoryboard = UIStoryboard.init(name: "AccountVisit", bundle: nil)
            let accountVisitsVC = accountStoryboard.instantiateViewController(withIdentifier: "AccountVisitSummaryViewController") as? AccountVisitSummaryViewController
            accountVisitsVC?.visitId = event.Id
            DispatchQueue.main.async {
                self.present(accountVisitsVC!, animated: true, completion: nil)
            }
        }

    }
}


