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
    @IBOutlet weak var addNewButton: UIButton!
    @IBOutlet weak var calViewButton: UIButton!
    @IBOutlet weak var weekEndsView: UIView!
    @IBOutlet weak var weekEndsButton: UIButton!
    @IBOutlet weak var todayButton: UIButton!
    @IBOutlet weak var bottomView: UIView!

    var currentShowingDate: Date?
    var currentCalendarViewType: GlobalConstants.CalendarViewType = .Week
    var weekEndsEnabled: Bool = true
    
    let dropDownAddNew = DropDown()
    let dropDownCalView = DropDown()
    var calendarMonthController: CalendarMonthViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(self.refreshCalendar), name: NSNotification.Name("refreshCalendar"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.showWeek(_:)), name: NSNotification.Name(rawValue: "LoadWeekView"), object: nil)
        
        setupAddNewButtonText()
        setupDropDownAddNew()
        setupDropDownCalView()
        

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        CalendarFilterMenuModel.searchText = ""
        CalendarFilterMenuModel.visitsType = "YES"
        CalendarFilterMenuModel.eventsType = "YES"
        
        self.calViewButton.setTitle("Week View    ", for: .normal)
        currentCalendarViewType = .Week
        weekEndsEnabled = true
        
        if (self.calendarMonthController?.view != nil) {
            DispatchQueue.main.async {
                self.calendarMonthController?.view.isHidden = true
            }
        }
        for view in self.bottomView.subviews{
            view.isHidden = false
        }
        

        displayWeekends()
        reloadCalendarView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("refreshCalendar"), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("LoadWeekView"), object: nil)
    }
    
    // MARK: - Calendar Refresh
    @objc func refreshCalendar(){
        reloadCalendarView()
    }
    
    @objc func showWeek(_ notification: NSNotification) {

        if (self.calendarMonthController?.view != nil) {
            DispatchQueue.main.async {
                self.calendarMonthController?.view.isHidden = true
            }
        }
        for view in self.bottomView.subviews{
            view.isHidden = false
        }
        self.currentCalendarViewType = .Day
        self.calViewButton.setTitle("Day View    ", for: .normal)
        if let date = notification.userInfo?["date"] as? Date {
            // do something with your image
            currentShowingDate = date
            weekView.setCalendarDate(date, animated: true)
        }
        weekView.calendarType = .day
    }
    
    func reloadCalendarView() {
        setupCalendarData()
        setupCalendarEventDataAfterFiler()
        moveToToday()
    }
    
    func displayDateHeader(_ startDate: Date) {
        if weekView.calendarType == .day {
            dateHeaderLabel.text = DateTimeUtility.getEEEEMMMdFormattedDateString(date: startDate)
        }
        else if weekView.calendarType == .week {
            dateHeaderLabel.text = DateTimeUtility.getWeekFormattedDateString(date: startDate, includeWeekend: weekEndsEnabled)
        }
    }

    // MARK: - Button Action
    @IBAction func actionButtonCalendarTypeView(_ sender: Any) {
        dropDownCalView.show()
    }
    
    @IBAction func actionButtonShowWeekends(_ sender: Any) {
        guard (currentCalendarViewType == .Week || currentCalendarViewType == .Month) else {
            return
        }
        if currentCalendarViewType == .Month {
            NotificationCenter.default.post(name: Notification.Name("WEEKENDTOGGLE"), object: nil, userInfo:nil)
        }
        weekEndsEnabled = !weekEndsEnabled
        displayWeekends()
        refreshWeekEnds()
    }
    
    @IBAction func actionButtonNew(_ sender: Any) {
        dropDownAddNew.show()
    }
    
    @IBAction func actionButtonLeft(_ sender: Any) {
        weekView.scrollToPreviousItem()
    }
        
    @IBAction func actionButtonRight(_ sender: Any) {
        weekView.scrollToNextItem()
    }
    
    @IBAction func actionButtonToday(_ sender: Any) {
        moveToToday()
        
        if (currentCalendarViewType == .Month) {
            
            if (self.calendarMonthController?.view != nil) {
                self.calendarMonthController?.view.removeFromSuperview()
                self.calendarMonthController?.removeFromParentViewController()
                self.calendarMonthController = nil
            }
            for view in self.bottomView.subviews{
                view.isHidden = true
            }
            
            self.calendarMonthController = UIStoryboard(name: "Calendar", bundle: nil).instantiateViewController(withIdentifier: "CalendarMonthViewController") as? CalendarMonthViewController
            self.addChildViewController(self.calendarMonthController!)
            self.calendarMonthController?.view.frame = CGRect(x: self.bottomView.bounds.origin.x, y: self.bottomView.bounds.origin.y, width: self.bottomView.frame.size.width, height: self.bottomView.bounds.size.height)
            self.bottomView.addSubview((self.calendarMonthController?.view)!)
            
            self.calViewButton.setTitle("Month View    ", for: .normal)
            self.currentCalendarViewType = .Month
            
            if( !self.weekEndsEnabled) {
                NotificationCenter.default.post(name: Notification.Name("WEEKENDTOGGLE"), object: nil, userInfo:nil)
            }
        }
        
    }

    // MARK: - Weekend Attribute Helper
    func displayWeekends() {
        if (currentCalendarViewType == .Week || currentCalendarViewType == .Month) {
            weekEndsView.isHidden = false
        }
        else {
            weekEndsView.isHidden = true
        }
        
        
        if weekEndsEnabled {
            weekEndsButton.setImage(UIImage.init(named: "Checkbox Selected"), for: .normal)
        }else{
            weekEndsButton.setImage(UIImage.init(named: "Checkbox"), for: .normal)
        }
    }

    // MARK: - Add new visit / event
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

    // MARK: - Addnew Button Text
    func setupAddNewButtonText() {
    addNewButton.setAttributedTitle(AttributedStringUtil.formatAttributedText(smallString: "Add New ", bigString: "+"), for: .normal)
    }
    
    // MARK: - DropDown Addnew
    func setupDropDownAddNew() {
        dropDownAddNew.anchorView = addNewButton
        dropDownAddNew.bottomOffset = CGPoint(x: 0, y:(dropDownAddNew.anchorView?.plainView.bounds.height)!)
        dropDownAddNew.backgroundColor = UIColor.white
        dropDownAddNew.selectionBackgroundColor = UIColor.clear
        dropDownAddNew.shadowOffset = CGSize(width: 0, height: 15)

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

    // MARK: - DropDown Calendar View
    func setupDropDownCalView() {
        dropDownCalView.anchorView = calViewButton
        dropDownCalView.bottomOffset = CGPoint(x: 0, y:(dropDownCalView.anchorView?.plainView.bounds.height)!)
        dropDownCalView.backgroundColor = UIColor.white
        dropDownCalView.selectionBackgroundColor = UIColor.clear
        dropDownCalView.shadowOffset = CGSize(width: 0, height: 15)
        dropDownCalView.dataSource = ["Day View", "Week View", "Month View"]
        

        dropDownCalView.selectionAction = { (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            
            switch index {
            case 0:
                if self.currentCalendarViewType == .Day {
                    return
                }

                for view in self.bottomView.subviews{
                    view.isHidden = false
                }
                DispatchQueue.main.async {
                    self.calendarMonthController?.view.isHidden = true
                }
                self.currentCalendarViewType = .Day
                self.calViewButton.setTitle("Day View    ", for: .normal)
                
            case 1:
                if self.currentCalendarViewType == .Week {
                    return
                }

                for view in self.bottomView.subviews{
                    view.isHidden = false
                }
                DispatchQueue.main.async {
                    self.calendarMonthController?.view.isHidden = true
                }
                self.currentCalendarViewType = .Week
                self.calViewButton.setTitle("Week View    ", for: .normal)

            case 2:
                if self.currentCalendarViewType == .Month {
                    return
                }
                for view in self.bottomView.subviews{
                    view.isHidden = true
                }
                if (self.calendarMonthController?.view == nil) {
                self.calendarMonthController = UIStoryboard(name: "Calendar", bundle: nil).instantiateViewController(withIdentifier: "CalendarMonthViewController") as? CalendarMonthViewController
                self.addChildViewController(self.calendarMonthController!)
                self.calendarMonthController?.view.frame = CGRect(x: self.bottomView.bounds.origin.x, y: self.bottomView.bounds.origin.y, width: self.bottomView.frame.size.width, height: self.bottomView.bounds.size.height)
                self.bottomView.addSubview((self.calendarMonthController?.view)!)
                } else {
                    DispatchQueue.main.async {
                        self.calendarMonthController?.view.isHidden = false
                    }                }
                
                self.calViewButton.setTitle("Month View    ", for: .normal)
                self.currentCalendarViewType = .Month
                
                if( !self.weekEndsEnabled) {
                    NotificationCenter.default.post(name: Notification.Name("WEEKENDTOGGLE"), object: nil, userInfo:nil)
                }
                
            default:
                break
            }
            
            self.displayWeekends()
            
            self.calViewButton.setNeedsLayout()
            self.weekView.isFirst = true
            self.weekView.showWeekEnds = self.weekEndsEnabled
            self.reloadCalendarView()
            self.dropDownCalView.hide()
        }
    }

    // MARK: - WRCalendarView
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
    
    func moveToToday() {
        currentShowingDate = Date()
        weekView.setCalendarDate(Date(), animated: true)
    }

    func refreshWeekEnds() {
        weekView.isFirst = true
        weekView.showWeekEnds = weekEndsEnabled
        weekView.setCalendarDate(currentShowingDate!)
    }
    
    func setupCalendarEventData(withEvents: [WREvent]) {
        weekView.setEvents(events: withEvents)
    }

    func setupCalendarEventDataAfterFiler() {
        if let eventsFiltered = CalendarSortUtility.searchCalendarBySearch(calendarEvents: CalendarViewModel().loadVisitData()!) {
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

//MARK:- NavigateToContacts Delegate
extension CalendarListViewController : NavigateToContactsDelegate{
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

//MARK:- SearchCalendarByEnteredTextDelegate Delegate
extension CalendarListViewController : SearchCalendarByEnteredTextDelegate{
    
    func sortCalendarData(searchString: String) {
        print("sortCalendarData")
    }
    
    func filteringCalendar(filtering: Bool) {
        if !filtering {
            DispatchQueue.main.async {
                self.setupCalendarEventData(withEvents: CalendarViewModel().loadVisitData()!)
            }
        }
    }
    
    func performCalendarFilterOperation(searchString: String) {
        if let eventsFiltered = CalendarSortUtility.searchCalendarBySearchBarQuery(calendarEvents: CalendarViewModel().loadVisitData()!, searchText: searchString) {
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
    
}
