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
        let smallString = "Add New "
        let bigString = "+"
        let fullString = "\(smallString) \(bigString)"
        let attrString = NSMutableAttributedString(string: fullString,
                                                         attributes: [NSAttributedStringKey.foregroundColor : UIColor.white])

        let smallStringRange = NSRange(location: 0, length: smallString.count)
        let bigStringRange = NSRange(location: smallStringRange.length+1, length: bigString.count)
        
        let smallStringFontSize: CGFloat = 17
        let bigStringFontSize: CGFloat = 30
        
        attrString.beginEditing()
        
        attrString.addAttribute(.font, value: UIFont(name:"Ubuntu", size: smallStringFontSize)!, range: smallStringRange)
        attrString.addAttribute(.font, value: UIFont(name:"Ubuntu", size: bigStringFontSize)!, range: bigStringRange)
        attrString.addAttribute(.baselineOffset, value: (bigStringFontSize - smallStringFontSize) / 4, range: smallStringRange)
        
        attrString.endEditing()
        
        addNewButton.setAttributedTitle(attrString, for: .normal)
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
//                self.launchNewVisit()

            default:
                break
            }

            self.dropDownAddNew.hide()
        }
    }

    // MARK: - DropDown Calendar View
    func setupDropDownCalView() {
        dropDownCalView.anchorView = calViewButton
        dropDownCalView.bottomOffset = CGPoint(x: 0, y:(dropDownAddNew.anchorView?.plainView.bounds.height)!)
        dropDownCalView.backgroundColor = UIColor.white
        dropDownCalView.selectionBackgroundColor = UIColor.clear
        dropDownCalView.shadowOffset = CGSize(width: 0, height: 15)
        
        dropDownCalView.dataSource = ["Day View", "Week View", "Month View"]

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


