//
//  CalendarListViewController.swift
//  SWSApp
//
//  Created by Thillaiganesh, C. on 11/05/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit
import DropDown

class CalendarListViewController: UIViewController {

    @IBOutlet weak var weekView: WRWeekView!
    @IBOutlet weak var dateHeaderLabel: UILabel!
    @IBOutlet weak var addNewButton: UIButton!
    @IBOutlet weak var calViewButton: UIButton!

    var currentShowingDate: Date?
    var currentCalendarViewType: GlobalConstants.CalendarViewType = .Day
    
    let dropDownAddNew = DropDown()
    let dropDownCalView = DropDown()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(self.refreshCalendar), name: NSNotification.Name("refreshCalendar"), object: nil)
        
        setupAddNewButtonText()
        setupDropDownAddNew()
        setupDropDownCalView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
        else if weekView.calendarType == .week {
            dateHeaderLabel.text = DateTimeUtility.getWeekFormattedDateString(date: startDate, includeWeekend: false)
        }
    }

    // MARK: - Button Action
    @IBAction func actionButtonCalendarTypeView(_ sender: Any) {
        dropDownCalView.show()

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
    }

    // MARK: - Add new visit / event
    func launchNewVisit() {
        let createVisitViewController = UIStoryboard(name: "AccountVisit", bundle: nil).instantiateViewController(withIdentifier :"CreateNewVisitViewController") as! CreateNewVisitViewController
        createVisitViewController.isEditingMode = false
        
        //Reset the PlanVistManager
        PlanVistManager.sharedInstance.visit = nil
        
        self.present(createVisitViewController, animated: true)
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
                print("TBD launch Event")

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
                self.currentCalendarViewType = .Day
                self.calViewButton.setTitle("Day View    ", for: .normal)
                
            case 1:
                if self.currentCalendarViewType == .Week {
                    return
                }
                self.currentCalendarViewType = .Week
                self.calViewButton.setTitle("Week View    ", for: .normal)

            case 2:
                print("TBD launch Event")
                
            default:
                break
            }
            
            self.calViewButton.setNeedsLayout()
            self.weekView.isFirst = true
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
            accountVisitsVC?.delegate = self
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
            if let visit = PlanVistManager.sharedInstance.visit{
                ContactsGlobal.accountId = visit.accountId
            }
            // Added this line so that Contact detail view is not launched for this scenario.
            ContactFilterMenuModel.selectedContactId = ""
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showAllContacts"), object:nil)
        }else {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "loadMoreScreens"), object:data.rawValue)
        }
    }
    
    func navigateToAccountScreen() {
        // Added this line so that Account detail view is not launched for this scenario.
        FilterMenuModel.selectedAccountId = ""
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showAllAccounts"), object:nil)
    }
}
