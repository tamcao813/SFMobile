//
//  DayHomeCalendarViewController.swift
//  SWSApp
//
//  Created by vipin.vijay on 01/06/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class DayHomeCalendarViewController: UIViewController {
    
    let userViewModel = UserViewModel()
    var loggerInUser: User?
    var currentCalendarViewType: GlobalConstants.CalendarViewType = .Week
    var weekEndsEnabled: Bool = true
    var currentShowingDate: Date?
    var globalVisit = [WREvent]()
    let dropDownAddNew = DropDown()
    let defaults:UserDefaults = UserDefaults.standard
    
    @IBOutlet weak var weekView: WRWeekView!
    @IBOutlet weak var dateHeaderLabel: UILabel!
    @IBOutlet weak var addNewButton: UIButton!
    
    //MARK:- View Life Cycle
    
    override func viewDidLoad() {
        loggerInUser = userViewModel.loggedInUser
        
        defaults.set(true, forKey: "FromHomeVC")
        setupDropDownAddNew()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.refreshCalendar), name: NSNotification.Name("REFRESH_MONTH_CALENDAR"), object: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("Home VC will appear")
        
        globalVisit = CalendarViewModel().loadVisitData()!
        CalendarFilterMenuModel.searchText = ""
        CalendarFilterMenuModel.visitsType = "YES"
        CalendarFilterMenuModel.eventsType = "YES"
        
        currentCalendarViewType = .Day
        weekEndsEnabled = true
        
        reloadCalendarView()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("Home VC will disappear")
        defaults.set(false, forKey: "FromHomeVC")
    }
    
    //MARK:- Custom Methods
    
    // MARK: - Calendar Refresh
    @objc func refreshCalendar(){
        globalVisit = CalendarViewModel().loadVisitData()!
        reloadCalendarView()
    }
    
    // Reload The Calendar With Itz Properties - START
    
    func reloadCalendarView() {
        setupCalendarData()
        setupCalendarEventDataAfterFiler()
        moveToToday()
    }
    
    // Setup The Calendar Type (Month, Week and Day) - START
    
    func setupCalendarData() {
        guard currentCalendarViewType != .None else {
            return
        }
        currentShowingDate = Date()
        
        weekView.setCalendarDate(Date())
        weekView.delegate = self
        weekView.showWeekEnds = self.weekEndsEnabled
        
        switch currentCalendarViewType {
        case .Day:
            weekView.calendarType = .day
            
        case .Week:
            weekView.calendarType = .week
            
        case .Month:
            print("TBD")
            
        default:
            break
        }
    }
    
    // Navigate Calendar To Current Date - START
    
    func moveToToday() {
        currentShowingDate = Date()
        weekView.setCalendarDate(Date(), animated: true)
    }
    
    // Refersh The View With Weekends - START
    
    func refreshWeekEnds() {
        weekView.isFirst = true
        weekView.showWeekEnds = weekEndsEnabled
        weekView.setCalendarDate(currentShowingDate!)
    }
    
    // Search The Calendar For Events And Visits Get The Result - START
    
    func setupCalendarEventDataAfterFiler() {
        if let eventsFiltered = CalendarSortUtility.searchCalendarBySearch(calendarEvents: globalVisit) {
            DispatchQueue.main.async {
                self.setupCalendarEventData(withEvents: eventsFiltered)
            }
        }
        else {
            DispatchQueue.main.async {
                self.setupCalendarEventData(withEvents: [WREvent]())
            }
        }
    }
    
    // Set Up Calendar With Events - START
    
    func setupCalendarEventData(withEvents: [WREvent]) {
        weekView.setEvents(events: withEvents)
    }
    
    // Display Date Header In Calendar
    
    func displayDateHeader(_ startDate: Date) {
        if weekView.calendarType == .day {
            dateHeaderLabel.text = DateTimeUtility.getEEEEMMMMdFormattedDateString(date: startDate)
        }
        else if weekView.calendarType == .week {
            dateHeaderLabel.text = DateTimeUtility.getWeekFormattedDateString(date: startDate, includeWeekend: weekEndsEnabled)
        }
    }
    
    // MARK: - DropDown Addnew
    func setupDropDownAddNew() {
        dropDownAddNew.anchorView = addNewButton
        dropDownAddNew.bottomOffset = CGPoint(x: 0, y:(dropDownAddNew.anchorView?.plainView.bounds.height)!)
        dropDownAddNew.backgroundColor = UIColor.white
        dropDownAddNew.selectionBackgroundColor = UIColor.clear
        dropDownAddNew.shadowOffset = CGSize(width: 0, height: 15)
        dropDownAddNew.textFont = UIFont(name:"Ubuntu", size: 14.0)!
        dropDownAddNew.dataSource = ["Visit", "Event"]
        
        dropDownAddNew.selectionAction = { (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            
            switch index {
            case 0:
                self.launchNewVisit()
                
            case 1:
                self.launchNewEvent()
                
            default:
                break
            }
            self.dropDownAddNew.hide()
        }
    }
    
    func launchNewVisit() {
        let createVisitViewController = UIStoryboard(name: "AccountVisit", bundle: nil).instantiateViewController(withIdentifier :"CreateNewVisitViewController") as! CreateNewVisitViewController
        createVisitViewController.isEditingMode = false
        
        //Reset the PlanVisitManager
        PlanVisitManager.sharedInstance.visit = nil
        
        self.present(createVisitViewController, animated: true)
    }
    
    func launchNewEvent() {
        
        let eventStoryboard = UIStoryboard.init(name: "CreateEvent", bundle: nil)
        let createEventViewController = eventStoryboard.instantiateViewController(withIdentifier: "CreateNewEventViewController") as? CreateNewEventViewController
        createEventViewController?.isEditingMode = false
        PlanVisitManager.sharedInstance.visit = nil
        DispatchQueue.main.async {
            self.present(createEventViewController!, animated: true, completion: nil)
        }
    }
    
    
    
    //MARK:- IBAction
    
    @IBAction func actionButtonLeft(_ sender: Any) {
        weekView.scrollToPreviousItem()
    }
    
    @IBAction func actionButtonRight(_ sender: Any) {
        weekView.scrollToNextItem()
    }
    
    @IBAction func actionButtonNew(_ sender: Any) {
        dropDownAddNew.show()
    }
    @IBAction func viewCalendar(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SwitchToCalendar"), object:nil)

    }
}

//MARK:- NavigateToContacts Delegate
extension DayHomeCalendarViewController : NavigateToContactsDelegate{
    func navigateToVisitListing() {
        self.dismiss(animated: true, completion: nil)
    }
    
    //Send a notification to Parent VC to load respective VC
    func navigateTheScreenToContactsInPersistantMenu(data: LoadThePersistantMenuScreen) {
        if data == .contacts{
            ContactFilterMenuModel.comingFromDetailsScreen = ""
            if let visit = PlanVisitManager.sharedInstance.visit{
                ContactsGlobal.accountId = visit.accountId
            }
            
            if let contactId = PlanVisitManager.sharedInstance.visit?.contactId{
                // Added this line so that Contact detail view is not launched for this scenario.
                ContactFilterMenuModel.selectedContactId = contactId
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showAllContacts"), object:nil)
            }
            
        }else {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "loadMoreScreens"), object:data.rawValue)
        }
    }
    
    func navigateToAccountScreen() {
        // Added this line so that Account detail view is not launched for this scenario.
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showAllAccounts"), object:nil)
    }
}

extension DayHomeCalendarViewController: WRWeekViewDelegate {
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
            PlanVisitManager.sharedInstance.visit = WorkOrderUserObject(for: "") // Todo read visit object from VisitViewModel
            PlanVisitManager.sharedInstance.visit?.Id = event.Id
            
            let accountStoryboard = UIStoryboard.init(name: "AccountVisit", bundle: nil)
            let accountVisitsVC = accountStoryboard.instantiateViewController(withIdentifier: "AccountVisitSummaryViewController") as? AccountVisitSummaryViewController
            accountVisitsVC?.visitId = event.Id
            accountVisitsVC?.delegate = self
            PlanVisitManager.sharedInstance.visit?.Id = event.Id
            DispatchQueue.main.async {
                self.present(accountVisitsVC!, animated: true, completion: nil)
            }
        } else {
            
            let accountStoryboard = UIStoryboard.init(name: "Event", bundle: nil)
            let accountVisitsVC = accountStoryboard.instantiateViewController(withIdentifier: "AccountEventSummaryViewController") as? AccountEventSummaryViewController
            PlanVisitManager.sharedInstance.visit = WorkOrderUserObject(for: "")
            (accountVisitsVC)?.delegate = self
            accountVisitsVC?.visitId = event.Id
            DispatchQueue.main.async {
                self.present(accountVisitsVC!, animated: true, completion: nil)
            }
        }
        
    }
}
