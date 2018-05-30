//
//  MonthViewController.swift
//  SWSApp
//
//  Created by vipin.vijay on 16/05/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

protocol GlobalArrayDelegate {
    func arrayFetch() -> [WREvent]
}

class CalendarMonthViewController: UIViewController, monthViewDelegate, actionDelegate {
    
    let reuseIdentifier = "DateCollectionViewCell" // also enter this string as the cell identifier in the storyboard
    var numberOfDaysinMonths = [31,28,31,30,31,30,31,31,30,31,30,31]
    var previousMonthDates = [Int]()
    var nextMonthDate = 0...10
    var currentMonthIndex: Int = 0
    var currentYear:Int = 0
    var presentMonthIndex = 0
    var presentYear = 0
    var todaysDate = 0
    var firstWeekdayOfMonth = 0 // Saturday - Sunday
    var switchButtton:Bool = false
    var previousMonthDateCount = 0
    var nextMonthDateCount = 0
    var dateInc = 1
    var  swipeDirection = ""
    var visits = [WREvent]()
    var loadedMonthView = 0
    var globalEventVisit = [WREvent]()
    var delegate: GlobalArrayDelegate?
    let dateFormatter: DateFormatter = DateFormatter()
    
    let columnLayout = ColumnFlowLayout(
        cellsPerRow: 7,
        minimumInteritemSpacing: 0,
        minimumLineSpacing:0,
        sectionInset: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    )
    
    
    @IBOutlet weak var collectionView: UICollectionView?
    
    //MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializingXIBs()
        addNotificationObserver()
        
        
        /// Calendar Variables Declaration while loading the page
        currentMonthIndex = Calendar.current.component(.month, from: Date())
        currentYear = Calendar.current.component(.year, from: Date())
        todaysDate = Calendar.current.component(.day, from: Date())
        firstWeekdayOfMonth = getFirstWeekDay()
        previousMonthDateCount = getPreviousMonthDays(currentMonthIndex: currentMonthIndex, currentYear: currentYear)
        previousMonthDates = previousMonthsDates(previousMonthDates: previousMonthDates, previousMonth: previousMonthDateCount)
        
        presentMonthIndex = currentMonthIndex
        presentYear = currentYear
        
//        self.visits = CalendarViewModel().loadVisitData()!
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        if let eventsFiltered = CalendarSortUtility.searchCalendarBySearchBarQuery(calendarEvents: self.globalEventVisit, searchText: CalendarFilterMenuModel.searchText) {
            self.visits = eventsFiltered
        }
        dateInc = 1
        UIView.performWithoutAnimation {
            collectionView?.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {

        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("WEEKENDTOGGLE"), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("REFRESH_MONTH_CALENDAR"), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("EVENT_FILTER"), object: nil)
    }
    
    //MARK:- Custom Methods
    
    func getAttributedSting(date:Date, title:String) -> NSMutableAttributedString {
        
        let timeAttributes = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 9)]
        let eventAttribute = [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 9)]
        
        let timeAttributeStr = NSMutableAttributedString(string: DateTimeUtility.getTimeFromDate(date: date), attributes: timeAttributes)
        let eventAttributeStr = NSMutableAttributedString(string: " " + title, attributes: eventAttribute)
        
        let combination = NSMutableAttributedString()
        
        combination.append(timeAttributeStr)
        combination.append(eventAttributeStr)
        return combination
    }
    
    func initializingXIBs(){
        
        ///---------- Register all Nib Files - START----------////
        collectionView!.register(UINib(nibName:"MonthCollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "MonthCollectionHeaderView")
        collectionView!.register(UINib(nibName:"WeekCollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "WeekCollectionHeaderView")
        collectionView!.register(UINib(nibName: "DateCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DateCollectionViewCell")
        collectionView?.collectionViewLayout = columnLayout
        collectionView?.contentInsetAdjustmentBehavior = .always
        ///---------- Register all Nib Files - END----------////
    }
    
    func addNotificationObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.toggleWeekends), name: NSNotification.Name("WEEKENDTOGGLE"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.refreshMonthCalendar), name: NSNotification.Name("REFRESH_MONTH_CALENDAR"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.getSearchString(_:)), name: NSNotification.Name(rawValue: "EVENT_FILTER"), object: nil)
    }
    
    func getDateFromStr(dateStr: String) -> Date {
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        let DateArray = dateStr.components(separatedBy: "-")
        let components = NSDateComponents()
        components.year = Int(DateArray[0])!
        components.month = Int(DateArray[1])!
        components.day = Int(DateArray[2])!
        components.timeZone = TimeZone.current
        let date = calendar.date(from: components as DateComponents)
        return date!
    }
    
    ///------Get The First Week Day - START -----///
    // Will get the index of week by calculating (1-Mon, 2 - Tue, 3 - Wed ..... 7 - Sun)
    func  getFirstWeekDay() -> Int {
        let date = Calendar.current.date(from: Calendar.current.dateComponents([.year,.month], from: self.getDateFromStr(dateStr: "\(currentYear)-\(currentMonthIndex)-01")))!
        let day = Calendar.current.component(.weekday, from: date)
//        let day = ("\(currentYear)-\(currentMonthIndex)-01".date?.firstDayOfTheMonth.weekday)!
        return day == 1 ? 7 : day - 1
    }
    ///------Get The First Week Day - END -----///
    
    ///------- Function To Get Previous Month Dates -  START ------ ///
    // Returning array with previous month dates that to be displayed in present month
    func previousMonthsDates(previousMonthDates: Array<Int>, previousMonth: Int) -> Array<Int>{
        
        var previousMonthDate = previousMonthDates
        var previousMonthCount = previousMonth
        if !previousMonthDate.isEmpty {previousMonthDate.removeAll()}
        for _ in (1..<firstWeekdayOfMonth) {
            previousMonthDate.append(previousMonthCount)
            previousMonthCount = previousMonthCount - 1
        }
        previousMonthDate = previousMonthDate.sorted()
        return previousMonthDate
    }
    ///------- Function To Get Previous Month Dates -  END ------ ///
    
    func getColorAccordingToEventType(type:String) -> UIColor
    {
        if (type == "visit") {
            return UIColor(hexString: "4287C2")!
        } else {
            return UIColor(hexString: "FF9300")!
        }
    }
    func getNumberOfDaysinPresentMonth(year:Int, month:Int) -> Int
    {
        let dateComponents = DateComponents(year: year, month: month)
        let calendar = Calendar.current
        let date = calendar.date(from: dateComponents)!
        
        let range = calendar.range(of: .day, in: .month, for: date)!
        let numDays = range.count
        
        return numDays
    }
    
    //MARK:- IBAction
    
    @IBAction func hideShowWeekEnds(sender: UIButton) {
        dateInc = 1
        if switchButtton {
            switchButtton = false
        } else {
            switchButtton = true
        }
        UIView.performWithoutAnimation {
            collectionView?.reloadData()
        }
    }
    
    //MARK:- Delegate Methods
    
    func didChangeMonth(monthIndex: Int, year: Int) {
        currentMonthIndex = monthIndex + 1
        swipeDirection = ""
        currentYear = year
        dateInc = 1
        firstWeekdayOfMonth = getFirstWeekDay()
        previousMonthDateCount = getPreviousMonthDays(currentMonthIndex: currentMonthIndex, currentYear: currentYear)
        previousMonthDates = previousMonthsDates(previousMonthDates: previousMonthDates, previousMonth: previousMonthDateCount)
        UIView.performWithoutAnimation {
            collectionView?.reloadData()
        }
    }
    
    func onVisitButtonTap(sender: UIButton, visit:WREvent) {
        
        if visit.type == "visit" {
            PlanVisitManager.sharedInstance.visit?.Id = visit.Id
            
            let accountStoryboard = UIStoryboard.init(name: "AccountVisit", bundle: nil)
            let accountVisitsVC = accountStoryboard.instantiateViewController(withIdentifier: "AccountVisitSummaryViewController") as? AccountVisitSummaryViewController
            accountVisitsVC?.visitId = visit.Id
            accountVisitsVC?.delegate = self
            DispatchQueue.main.async {
                self.present(accountVisitsVC!, animated: true, completion: nil)
            }
        } else {
            
            let eventStoryboard = UIStoryboard.init(name: "Event", bundle: nil)
            let accountEventVC = eventStoryboard.instantiateViewController(withIdentifier: "AccountEventSummaryViewController") as? AccountEventSummaryViewController
            PlanVisitManager.sharedInstance.visit = WorkOrderUserObject(for: "")
            (accountEventVC)?.delegate = self
            accountEventVC?.visitId = visit.Id
            DispatchQueue.main.async {
                self.present(accountEventVC!, animated: true, completion: nil)
            }
        }
    }
    
    @objc func loadWeekView(_ sender : UIButton) {
        
        let weekDate =  DateTimeUtility.getDateFromStringFormat(dateStr: sender.accessibilityHint!)
        let weekDataDict:[String: Date] = ["date": weekDate]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "LoadWeekView"), object: nil, userInfo: weekDataDict)
        
    }
    
    //MARK:- NSNotification Methods
    
    @objc func toggleWeekends() {
        dateInc = 1
        if switchButtton {
            switchButtton = false
        } else {
            switchButtton = true
        }
        UIView.performWithoutAnimation {
            collectionView?.reloadData()
        }
    }
    
    @objc func refreshMonthCalendar() {
        let tempVisitArray = delegate?.arrayFetch()
        let eventsFiltered = CalendarSortUtility.searchCalendarBySearchBarQuery(calendarEvents: tempVisitArray, searchText: CalendarFilterMenuModel.searchText)
        self.visits = eventsFiltered!
        dateInc = 1
        UIView.performWithoutAnimation {
            collectionView?.reloadData()
        }
    }
    
    @objc func getSearchString(_ notification: NSNotification) {
        
        if let searchString = notification.userInfo?["SearchStr"] as? String {
            let tempVisitArray = delegate?.arrayFetch()
            let eventsFiltered = CalendarSortUtility.searchCalendarBySearchBarQuery(calendarEvents: tempVisitArray, searchText: searchString)
            visits = eventsFiltered!
            dateInc = 1
            UIView.performWithoutAnimation {
                collectionView?.reloadData()
            }
        }
    }
    
}

//MARK:- UICollectioView Datasource
extension CalendarMonthViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionElementKindSectionHeader:
            switch indexPath.section {
            case 0:
                let reusableview = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "MonthCollectionHeaderView", for: indexPath) as! MonthCollectionHeaderView
                reusableview.delegate = self
                
                return reusableview
            case 1:
                let reusableview = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "WeekCollectionHeaderView", for: indexPath) as! WeekCollectionHeaderView
                switchButtton == true ? reusableview.withoutWeekends() : reusableview.withWeekends()
                
                return reusableview
            default:
                return UICollectionReusableView()
            }
            
        default:  fatalError("Unexpected element kind")
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 0
        } else {
            if (getNumberOfDaysinPresentMonth(year: currentYear, month: currentMonthIndex) + firstWeekdayOfMonth - 1 <= 35) {
                return 35
            } else {
                return 42
            }
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:DateCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath)as! DateCollectionViewCell
        cell.delegate = self
        
        /// --------- Hide the event buttons - START ---------- ///
        var buttonTag = 100
        for _ in 1...3 {
            let button:EventButton = cell.viewWithTag(buttonTag) as! EventButton
            button.isHidden = true
            buttonTag = buttonTag + 1
        }
        /// --------- Hide the event buttons - END ---------- ///

        if indexPath.item <= firstWeekdayOfMonth - 2 {
            if !previousMonthDates.isEmpty {
                cell.dateLabel.text = "\(previousMonthDates[indexPath.row])"
            }
            cell.dateLabel.textColor = UIColor.lightGray
            cell.isHidden = false

            let dateStr = "\(getPreviousYear(currentMonthIndex: currentMonthIndex, currentYearIndex: currentYear))" + "-" + String(format: "%02d", getPreviousMonth(currentMonthIndex: currentMonthIndex)) + "-" + String(format: "%02d", (previousMonthDates[indexPath.row]))+" "+"00:00:00"

            //------------- Adding Events To Past Calendar Dates - START --------------- //
            
                let eventArr = DateTimeUtility.getEventDates(currentDate: dateStr, visitArray: self.visits, dateFormatter: self.dateFormatter).0
                let isMore = DateTimeUtility.getEventDates(currentDate: dateStr, visitArray: self.visits, dateFormatter: self.dateFormatter).1
                if isMore {
                    let tempDate = "\((self.self.previousMonthDates[indexPath.row]))" + "-" + "\(getPreviousMonth(currentMonthIndex: self.currentMonthIndex))" + "-" + "\(self.currentYear)"
                    cell.moreButton.isHidden = false
                    cell.moreButton.accessibilityHint = tempDate
                    cell.moreButton.addTarget(self, action:#selector(self.loadWeekView(_:)), for: .touchUpInside)
                    
                } else {   cell.moreButton.isHidden = true}
                var inc:Int = 100
                if !eventArr.isEmpty {
                    for event in eventArr {
                        let button:EventButton = cell.viewWithTag(inc) as! EventButton
                        
                        button.visit = event
                        button.isHidden = false
                        button.setAttributedTitle(self.getAttributedSting(date: event.date, title: event.title), for: .normal)
                        // Border Color according to evevt type (BLUE OR ORANGE)
                        button.borderColor(value:self.getColorAccordingToEventType(type: event.type))
                        inc = inc + 1
                    }
                }
            //------------- Adding Events To Past Calendar Dates - END --------------- //

        } else
        if (indexPath.item < getNumberOfDaysinPresentMonth(year: currentYear, month: currentMonthIndex) + firstWeekdayOfMonth - 1) {

            let calcDate = indexPath.row-firstWeekdayOfMonth + 2
            cell.isHidden = false
            cell.dateLabel.text = "\(calcDate)"
            cell.dateLabel.textColor = UIColor.black

            //------------- Adding Events To Present Calendar Dates - START --------------- //
                let dateStr = "\(self.currentYear)" + "-" + String(format: "%02d", self.currentMonthIndex) + "-" + String(format: "%02d", calcDate)+" "+"00:00:00"
                let eventArr = DateTimeUtility.getEventDates(currentDate: dateStr, visitArray: self.visits, dateFormatter: self.dateFormatter).0
                let isMore = DateTimeUtility.getEventDates(currentDate: dateStr, visitArray: self.visits, dateFormatter: self.dateFormatter).1
                if isMore {
                    let tempDate = "\(calcDate)" + "-" + "\(self.currentMonthIndex)" + "-" + "\(self.self.currentYear)"
                    cell.moreButton.isHidden = false
                    cell.moreButton.accessibilityHint = tempDate
                    cell.moreButton.addTarget(self, action:#selector(self.loadWeekView(_:)), for: .touchUpInside)
                    
                } else {   cell.moreButton.isHidden = true}
                var inc:Int = 100
                if !eventArr.isEmpty {
                    for event in eventArr {
                        let button:EventButton = cell.viewWithTag(inc) as! EventButton
                        button.isHidden = false
                        button.visit = event
                        button.setAttributedTitle(self.getAttributedSting(date: event.date, title: event.title), for: .normal)
                        // Border Color according to evevt type (BLUE OR ORANGE)
                        button.borderColor(value:self.getColorAccordingToEventType(type: event.type))
                        
                        inc = inc + 1
                    }
                }
        }
        else {
            cell.dateLabel.text = "\(dateInc)"
            cell.dateLabel.textColor = UIColor.lightGray
            cell.isHidden = false
            
            let dateStr = "\(getNextYear(currentMonthIndex: currentMonthIndex, currentYearIndex: currentYear))" + "-" + String(format: "%02d", getNextMonth(currentMonthIndex: currentMonthIndex)) + "-" + "\(dateInc)" + " " + "00:00:00"
            
            //------------- Adding Events To Future Calendar Dates - START --------------- //
                let eventArr = DateTimeUtility.getEventDates(currentDate: dateStr, visitArray: self.visits, dateFormatter: self.dateFormatter).0
                let isMore = DateTimeUtility.getEventDates(currentDate: dateStr, visitArray: self.visits, dateFormatter: self.self.dateFormatter).1
                if isMore {
                    let tempDate = "\(self.self.dateInc)" + "-" + "\(getNextMonth(currentMonthIndex: self.currentMonthIndex))" + "-" + "\(self.currentYear)"
                    cell.moreButton.isHidden = false
                    cell.moreButton.accessibilityHint = tempDate
                    cell.moreButton.addTarget(self, action:#selector(self.loadWeekView(_:)), for: .touchUpInside)
                    
                } else {   cell.moreButton.isHidden = true}
                var inc:Int = 100
                if !eventArr.isEmpty {
                    for event in eventArr {
                        let button:EventButton = cell.viewWithTag(inc) as! EventButton
                        button.isHidden = false
                        button.visit = event
                        button.setAttributedTitle(self.getAttributedSting(date: event.date, title: event.title), for: .normal)
                        
                        // Border Color according to evevt type (BLUE OR ORANGE)
                        button.borderColor(value:self.getColorAccordingToEventType(type: event.type))
                        inc = inc + 1
                    }
                }
            
            //------------- Adding Events To Future Calendar Dates - END --------------- //
            
            dateInc = dateInc + 1
            
        }
        return cell
    }
}

//MARK:- UICollectioView DelegateFlowLayout

extension CalendarMonthViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: collectionView.frame.width, height: 50) //add your height here
        } else {
            return CGSize(width: collectionView.frame.width, height: 30) //add your height here
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height: CGFloat = 100.0
        let minimumInteritemSpacing: CGFloat = 0
        let minimumLineSpacing: CGFloat = 0
        let sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        
        ///----------- Set Cell Size According To Weekend Hide/Show - START ------------------- ///
        
        if switchButtton {
            switch indexPath.row {
            // Set Cell Size When Numbers Of Cells In Row Is 5 (Mon - Fri) - START
            case 0...4, 7...11, 14...18, 21...25, 28...32, 35...39:
                let cellsPerRow = 5
                let marginsAndInsets = sectionInset.left + sectionInset.right + collectionView.safeAreaInsets.left + collectionView.safeAreaInsets.right + minimumInteritemSpacing * CGFloat(cellsPerRow - 1)
                let itemWidth = ((collectionView.bounds.size.width - marginsAndInsets) / CGFloat(cellsPerRow)).rounded(.down)
                let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
                flowLayout?.sectionInset = sectionInset
                flowLayout?.minimumInteritemSpacing = minimumInteritemSpacing
                flowLayout?.minimumLineSpacing = minimumLineSpacing
                return CGSize(width: itemWidth, height: height)
            // Set Cell Size When Numbers Of Cells In Row Is 5 (Mon - Fri) - END
            case 5...6, 12...13, 19...20, 26...27, 33...34, 40...41:
                // Set Cell Size When Numbers Of Cells In Row Is 5 (Sat - Sun) - START
                return CGSize(width: 0, height: height)
                // Set Cell Size When Numbers Of Cells In Row Is 5 (Sat - Sun) - END

            default:
                let cellsPerRow = 7
                let marginsAndInsets = sectionInset.left + sectionInset.right + collectionView.safeAreaInsets.left + collectionView.safeAreaInsets.right + minimumInteritemSpacing * CGFloat(cellsPerRow - 1)
                let itemWidth = ((collectionView.bounds.size.width - marginsAndInsets) / CGFloat(cellsPerRow)).rounded(.down)
                let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
                flowLayout?.sectionInset = sectionInset
                flowLayout?.minimumInteritemSpacing = minimumInteritemSpacing
                flowLayout?.minimumLineSpacing = minimumLineSpacing
                return CGSize(width: itemWidth, height: height)
            }
        } else {
            // Set Cell Size When Numbers Of Cells In Row Is 7 (Mon - Sun) - START
            let cellsPerRow = 7
            let marginsAndInsets = sectionInset.left + sectionInset.right + collectionView.safeAreaInsets.left + collectionView.safeAreaInsets.right + minimumInteritemSpacing * CGFloat(cellsPerRow - 1)
            let itemWidth = ((collectionView.bounds.size.width - marginsAndInsets) / CGFloat(cellsPerRow)).rounded(.down)
            let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
            flowLayout?.sectionInset = sectionInset
            flowLayout?.minimumInteritemSpacing = minimumInteritemSpacing
            flowLayout?.minimumLineSpacing = minimumLineSpacing
            return CGSize(width: itemWidth, height: height)
            // Set Cell Size When Numbers Of Cells In Row Is 7 (Mon - Sun) - END
        }
    }
    
    ///----------- Set Cell Size According To Weekend Hide/Show - END ------------------- ///
}

//MARK:- NavigateToContacts Delegate
extension CalendarMonthViewController : NavigateToContactsDelegate{
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
        //        FilterMenuModel.selectedAccountId = (PlanVistManager.sharedInstance.visit?.accountId)!
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showAllAccounts"), object:nil)
    }
}

