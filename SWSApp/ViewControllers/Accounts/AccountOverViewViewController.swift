//
//  AccountOverViewViewController.swift
//  SWSApp
//
//  Created by shubham.e.shukla on 5/11/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class AccountOverViewViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var upcomingActivitiesTableView: UITableView!
    @IBOutlet weak var pastActivitiesTableView: UITableView!
    var account : Account?
    let visitModel = VisitsViewModel()
    let actionItemModel = AccountsActionItemViewModel()
    let notificationModel = NotificationsViewModel()
    var notificationArray = [Notifications]()
    var notificationArrayToDisplay = [Notifications]()
    
    
    var upcomingVisit = [WorkOrderUserObject]()
    var upcomingVisitArrayToDisplay = [WorkOrderUserObject]()
    
    
    var pastVisit = [WorkOrderUserObject]()
    var pastVisitArrayToDisplay = [WorkOrderUserObject]()
    
    var upcomingActionItem = [ActionItem]()
    var upcomingActionItemArrayToDisplay = [ActionItem]()
    
    var pastActionItem = [ActionItem]()
    var pastActionItemArrayToDisplay = [ActionItem]()
    
    let dateFormatter = DateFormatter()
    let myCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
    
    var accountId : String!
    
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)


    override func viewDidLoad() {
        super.viewDidLoad()
        
        upcomingActivitiesTableView.delegate = self
        upcomingActivitiesTableView.dataSource = self
        pastActivitiesTableView.delegate =  self
        pastActivitiesTableView.dataSource = self
        upcomingActivitiesTableView.tableFooterView = UIView()
        pastActivitiesTableView.tableFooterView = UIView()
        self.accountId = account?.account_Id
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.refreshAccountOverView), name: NSNotification.Name("refreshAccountOverView"), object: nil)
        
        activityIndicator.center =  CGPoint(x: self.view.frame.width/2, y: self.view.frame.height/2-200)
        activityIndicator.color = UIColor.darkGray
        self.view.addSubview(activityIndicator)
        
        activityIndicator.startAnimating()
        
        DispatchQueue.global(qos: .userInitiated).async {
            self.getDB()
        }
        
    }
    
    /// Notification function to refresh the arrays 
    @objc func refreshAccountOverView()   {
        getDB()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.upcomingActivitiesTableView.reloadData()
        self.pastActivitiesTableView.reloadData()
    }
    
    /// Function to get the array of all the objects (action items,Notifications,Visits and event)
    func getDB()  {
        
        upcomingVisitArrayToDisplay = [WorkOrderUserObject]()
        pastVisitArrayToDisplay = [WorkOrderUserObject]()
        upcomingActionItemArrayToDisplay = [ActionItem]()
        pastActionItemArrayToDisplay = [ActionItem]()
        notificationArrayToDisplay = [Notifications]()
        
        
        //creating notifications array according to accountId
        notificationArray = notificationModel.accountOverViewNotificationsForUser()
        notificationArrayToDisplay = notificationArray.filter( { return $0.account == accountId } )
        
        //creating upcomingvisit array according to accountId
        upcomingVisit = visitModel.visitsForUserTwoWeeksUpcoming()
        //upcomingVisitArrayToDisplay = upcomingVisit.filter( { return $0.accountId == accountId } )
        
        //creating upcoming action item array according to accountId
        upcomingActionItem = actionItemModel.actionItemForUserTwoWeeksUpcoming()
        //upcomingActionItemArrayToDisplay =  upcomingActionItem.filter( { return $0.accountId == accountId } )
        
        //creating pastvisit array according to accountId
        pastVisit = visitModel.visitsForUserOneWeeksPast()
        //pastVisitArrayToDisplay = pastVisit.filter( { return $0.accountId == accountId } )
        
        //creating past action item array according to accountId
        pastActionItem = actionItemModel.actionItemForUserOneWeeksPast()
        // pastActionItemArrayToDisplay = pastActionItem.filter( { return $0.accountId == accountId } )
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let userViewModel = UserViewModel()
        let loggedInuserid: String = (userViewModel.loggedInUser?.userId)!
        
        if (FilterMenuModel.isFromAccountListView == "YES") && (appDelegate.currentSelectedUserId != loggedInuserid) ||
            (FilterMenuModel.isFromAccountListView == "") && (appDelegate.currentSelectedUserId != loggedInuserid) {

            let upcomingVisitArryfilteredByCounsultant:[WorkOrderUserObject] = upcomingVisit.filter( { return $0.ownerId == appDelegate.currentSelectedUserId })
            
            upcomingVisitArrayToDisplay =  upcomingVisitArryfilteredByCounsultant
            upcomingVisitArrayToDisplay = upcomingVisitArrayToDisplay.filter{$0.accountId == self.accountId}
            
            
            let pastVisitArryfilteredByCounsultant:[WorkOrderUserObject] = pastVisit.filter( { return $0.ownerId == appDelegate.currentSelectedUserId })
            
            pastVisitArrayToDisplay =  pastVisitArryfilteredByCounsultant
            pastVisitArrayToDisplay = pastVisitArrayToDisplay.filter{$0.accountId == self.accountId}
            
            let upcomingActionItemArryfilteredByCounsultant:[ActionItem] = upcomingActionItem.filter( { return $0.ownerId == appDelegate.currentSelectedUserId })
            
            upcomingActionItemArrayToDisplay =  upcomingActionItemArryfilteredByCounsultant
            upcomingActionItemArrayToDisplay = upcomingActionItemArrayToDisplay.filter{$0.accountId == self.accountId}
            
            let pastActionItemArryfilteredByCounsultant:[ActionItem] = pastActionItem.filter( { return $0.ownerId == appDelegate.currentSelectedUserId })
            
            pastActionItemArrayToDisplay =  pastActionItemArryfilteredByCounsultant
            pastActionItemArrayToDisplay = pastActionItemArrayToDisplay.filter{$0.accountId == self.accountId}
            
            
        } else {
            upcomingVisitArrayToDisplay = upcomingVisit.filter( { return $0.accountId == accountId } )
            pastVisitArrayToDisplay = pastVisit.filter( { return $0.accountId == accountId } )
            upcomingActionItemArrayToDisplay =  upcomingActionItem.filter( { return $0.accountId == accountId } )
            pastActionItemArrayToDisplay = pastActionItem.filter( { return $0.accountId == accountId } )
            
        }
        
        DispatchQueue.main.async {
            self.upcomingActivitiesTableView.reloadData()
            self.pastActivitiesTableView.reloadData()
            self.activityIndicator.stopAnimating()
        }
        
    }
    
    
    /// Function to get the Visit day of the date
    ///
    /// - Parameter dateToConvert: Pass the Visit date in String which need to check
    /// - Returns: Day of the Date
    func getDayForVisitCurrentWeek(dateToConvert:String) ->String  {
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000+0000"
        let date = dateFormatter.date(from: dateToConvert)
        let myComponents = myCalendar.components(.weekday, from: date!)
        let weekDay = myComponents.weekday
        switch weekDay {
        case 1?:
            return "Sunday"
        case 2?:
            return "Monday"
        case 3?:
            return "Tuesday"
        case 4?:
            return "Wednesday"
        case 5?:
            return "Thursday"
        case 6?:
            return "Friday"
        case 7?:
            return "Saturday"
        default:
            return dateToConvert
        }
    }
    
    /// Function to get the Action Item day of the date
    ///
    /// - Parameter dateToConvert: Pass the Action Item date in String which need to check
    /// - Returns: Day of the Date
    func getDayForActionCurrentWeek(dateToConvert:String) ->String  {
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let date = dateFormatter.date(from: dateToConvert)
        let myComponents = myCalendar.components(.weekday, from: date!)
        let weekDay = myComponents.weekday
        switch weekDay {
        case 1?:
            return "Sunday"
        case 2?:
            return "Monday"
        case 3?:
            return "Tuesday"
        case 4?:
            return "Wednesday"
        case 5?:
            return "Thursday"
        case 6?:
            return "Friday"
        case 7?:
            return "Saturday"
        default:
            return dateToConvert
        }
    }
    
    
    
    /// Function to check visit date  in Today,Yesterday,Tomorrow or in current week else any other date
    ///
    /// - Parameter dateToConvert: Pass the Visit date in String which need to check
    /// - Returns: Return day if in current week else date
    func getDayFromVisit(dateToConvert:String)-> String  {
        //Getting Today, Tomorrow, Yesterday
        if dateToConvert == "" {
            return ""
        }
        
        let calendar = Calendar.current
        let getTime = DateTimeUtility.convertUTCDateStringToLocalTimeZone(dateString: dateToConvert,dateFormat:"MM/dd/YYYY hh:mm a")
        var dateTime = getTime.components(separatedBy: " ")
        if dateTime.count == 0 {
            return ""
        }
        if dateTime.count == 1 {
            dateTime.append("")
            dateTime.append("")
        }
        if dateTime.count == 2 {
            dateTime.append("")
        }
        guard let date = DateTimeUtility.covertUTCtoLocalTimeZone(dateString: dateToConvert) else {
            return ""
        }
        
        //Gtting time and date
        let dayToCheck = dateFormatter.string(from: date)
        
        if calendar.isDateInToday(date){

            return  "Today at " + dateTime[1] + " " + dateTime[2]
        }
        else if calendar.isDateInTomorrow(date){

            return  "Tomorrow at " + dateTime[1] + " " + dateTime[2]
            
        }else if calendar.isDateInYesterday(date){
            
            return  "Yesterday at " + dateTime[1] + " " + dateTime[2]
            
        }else if getDayForVisitCurrentWeek(dateToConvert: dayToCheck) == "Sunday"{
            
            return "Sunday"
            
        }
        else if getDayForVisitCurrentWeek(dateToConvert: dayToCheck) == "Monday"{
            
            return "Monday"
            
        }
        else if getDayForVisitCurrentWeek(dateToConvert: dayToCheck) == "Tuesday"{
            
            return "Tuesday"
            
        }
        else if getDayForVisitCurrentWeek(dateToConvert: dayToCheck) == "Wednesday"{
            
            return "Wednesday"
            
        }
        else if getDayForVisitCurrentWeek(dateToConvert: dayToCheck) == "Thursday"{
            
            return "Thursday"
            
        }
        else if getDayForVisitCurrentWeek(dateToConvert: dayToCheck) == "Friday"{
            
            return "Friday"
            
        }
        else if getDayForVisitCurrentWeek(dateToConvert: dayToCheck) == "Saturday"{
            
            return "Saturday"
        }
        
        dateFormatter.dateFormat = "MM/dd/yyyy h:mm a"
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        dateFormatter.timeZone = TimeZone.current
        let timeStamp = dateFormatter.string(from: date)
        return timeStamp
    }
    
    /// Function to check Action Item date  in Today,Yesterday,Tomorrow or in current week else any other date
    ///
    /// - Parameter dateToConvert: Pass the Action Item date in String which need to check
    /// - Returns: Return day if in current week else date
    func getDayFromActionItem(dateToConvert:String)-> String  {
        //Getting Today, Tomorrow, Yesterday
        let calendar = Calendar.current
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone.current
        // dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let date = dateFormatter.date(from: dateToConvert)
        //Gtting time and date
        dateFormatter.dateFormat = "MM/dd/yyyy"
        //dateFormatter.timeZone = TimeZone.current
        let timeStamp = dateFormatter.string(from: date!)
        
        if calendar.isDateInToday(date!){
            return  "Today"
        }
        else if calendar.isDateInTomorrow(date!){
            return  "Tomorrow"
        }else if calendar.isDateInYesterday(date!){
            return  "Yesterday"
        }else if getDayForActionCurrentWeek(dateToConvert: timeStamp) == "Sunday"{
            return "Sunday"
        }
        else if getDayForActionCurrentWeek(dateToConvert: timeStamp) == "Monday"{
            return "Monday"
        }
        else if getDayForActionCurrentWeek(dateToConvert: timeStamp) == "Tuesday"{
            return "Tuesday"
        }
        else if getDayForActionCurrentWeek(dateToConvert: timeStamp) == "Wednesday"{
            return "Wednesday"
        }
        else if getDayForActionCurrentWeek(dateToConvert: timeStamp) == "Thursday"{
            return "Thursday"
        }
        else if getDayForActionCurrentWeek(dateToConvert: timeStamp) == "Friday"{
            return "Friday"
        }
        else if getDayForActionCurrentWeek(dateToConvert: timeStamp) == "Saturday"{
            return "Saturday"
        }
        
        
        return timeStamp
    }
    
    
    // MARK: - TableView Functions
    // tableView.tag == 1 = Upcoming Activities table
    // tableView.tag == 2 = Past Activities table
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        // Notification section
        case 0:
            if tableView.tag == 1{
                return notificationArrayToDisplay.count
            }else{
                return notificationArrayToDisplay.count
            }
        // visit section
        case 1:
            if tableView.tag == 1{
                return upcomingVisitArrayToDisplay.count
            }else{
                return pastVisitArrayToDisplay.count
            }
        // action item section
        case 2:
            if tableView.tag == 1{
                return upcomingActionItemArrayToDisplay.count
            }else{
                return pastActionItemArrayToDisplay.count
            }
        default:
            return 0
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:UpComingVisitTableViewCell = upcomingActivitiesTableView.dequeueReusableCell(withIdentifier: "upcomingVisitCell") as! UpComingVisitTableViewCell
        
        switch indexPath.section {
        //Upcoming Notification section
        case 0:
            if tableView.tag == 1{
                if notificationArrayToDisplay[indexPath.row].sgwsType == "Birthday"{
                    cell.UpComingActivities_TitleLabel.text = notificationArrayToDisplay[indexPath.row].sgwsContactBirthdayNotification
                    cell.UpComingActivities_TimeLabel.text = DateTimeUtility.convertUtcDatetoReadableDateString(dateString: notificationArrayToDisplay[indexPath.row].createdDate)
                    
                    cell.UpComingActivities_Image.image = UIImage(named: "Bell")
                    return cell
                }else{
                    
                    cell.UpComingActivities_TitleLabel.text = notificationArrayToDisplay[indexPath.row].sgwsAccLicenseNotification
                    cell.UpComingActivities_TimeLabel.text = DateTimeUtility.convertUtcDatetoReadableDateString(dateString: notificationArrayToDisplay[indexPath.row].createdDate)
                    cell.UpComingActivities_Image.image = UIImage(named: "Small Status Critical")
                    return cell
                }
                
            }else {
                return UITableViewCell()
            }
        // visit section
        case 1:
            // upcoming visit section
            if tableView.tag == 1{
                if upcomingVisitArrayToDisplay[indexPath.row].recordTypeId == SyncConfigurationViewModel().syncConfigurationRecordIdforVisit() {
                    cell.UpComingActivities_TitleLabel.text = "Visit " + upcomingVisitArrayToDisplay[indexPath.row].accountName
                }else{
                    cell.UpComingActivities_TitleLabel.text = upcomingVisitArrayToDisplay[indexPath.row].subject
                }
                
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000+0000"
                let date = dateFormatter.date(from: upcomingVisitArrayToDisplay[indexPath.row].startDate)
                
                if (date?.isInThisWeek)!{
                    cell.UpComingActivities_TimeLabel.text = getDayFromVisit(dateToConvert: upcomingVisitArrayToDisplay[indexPath.row].startDate)
                }else{
                    /*  BUG:6: Visit and Event scheduled time displayed in Account Overview is not matching with actual scheduled time of the Visit and Event
                     Fixed by adding method with UTC and Current Time ZONE
                     */
                    cell.UpComingActivities_TimeLabel.text = DateTimeUtility.convertUtcDatetoReadableDateAndTimeString(dateString:upcomingVisitArrayToDisplay[indexPath.row].startDate)
                }
                cell.UpComingActivities_Image.image = UIImage(named: "Bell")
                return cell
                
            }
                // Past visit section
            else{
                if pastVisitArrayToDisplay[indexPath.row].recordTypeId == SyncConfigurationViewModel().syncConfigurationRecordIdforVisit() {
                    cell.UpComingActivities_TitleLabel.text = "Visit " + pastVisitArrayToDisplay[indexPath.row].accountName
                }else{
                    cell.UpComingActivities_TitleLabel.text =  pastVisitArrayToDisplay[indexPath.row].subject
                }
                
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000+0000"
                let date = dateFormatter.date(from:pastVisitArrayToDisplay[indexPath.row].startDate)
                if (date?.isInThisWeek)!{
                    cell.UpComingActivities_TimeLabel.text = getDayFromVisit(dateToConvert: pastVisitArrayToDisplay[indexPath.row].startDate)
                    
                } else
                {
                    /*  BUG:6: Visit and Event scheduled time displayed in Account Overview is not matching with actual scheduled time of the Visit and Event
                     Fixed by adding method with UTC and Current Time ZONE
                     */
                    cell.UpComingActivities_TimeLabel.text = DateTimeUtility.convertUtcDatetoReadableDateAndTimeString(dateString: pastVisitArrayToDisplay[indexPath.row].startDate)
                    
                }
                
                
                cell.UpComingActivities_Image.image = UIImage(named: "Bell")
                return cell
            }
        // action item section
        case 2:
            //upcoming action item section
            if tableView.tag == 1{
                cell.UpComingActivities_TitleLabel.text = upcomingActionItemArrayToDisplay[indexPath.row].subject
                
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let date = dateFormatter.date(from:upcomingActionItemArrayToDisplay[indexPath.row].activityDate)
                if (date?.isInThisWeek)!{
                    
                    cell.UpComingActivities_TimeLabel.text = getDayFromActionItem(dateToConvert: upcomingActionItemArrayToDisplay[indexPath.row].activityDate)
                    
                }else {
                    
                    cell.UpComingActivities_TimeLabel.text = DateTimeUtility.convertUtcDatetoReadableDateOnlyDate(dateStringfromAccountNotes: upcomingActionItemArrayToDisplay[indexPath.row].activityDate)
                    
                }
                
                
                if upcomingActionItemArrayToDisplay[indexPath.row].isUrgent{
                    cell.UpComingActivities_Image.image = UIImage(named: "Small Status Critical")
                    cell.upcomingImageWidthConstraint.constant = 20
                    cell.upcomingTimeLeadingConstraint.constant = 10
                }else{
                    cell.UpComingActivities_Image.image = nil
                    cell.upcomingImageWidthConstraint.constant = 0
                    cell.upcomingTimeLeadingConstraint.constant = 0
                }
                
                return cell
            }
                //past action item section
            else{
                cell.UpComingActivities_TitleLabel.text = pastActionItemArrayToDisplay[indexPath.row].subject
                
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let date = dateFormatter.date(from:pastActionItemArrayToDisplay[indexPath.row].activityDate)
                if (date?.isInThisWeek)!{
                    
                    cell.UpComingActivities_TimeLabel.text = getDayFromActionItem(dateToConvert: pastActionItemArrayToDisplay[indexPath.row].activityDate)
                }else {
                    cell.UpComingActivities_TimeLabel.text = DateTimeUtility.convertUtcDatetoReadableDateOnlyDate(dateStringfromAccountNotes: pastActionItemArrayToDisplay[indexPath.row].activityDate)
                }
                
                if pastActionItemArrayToDisplay[indexPath.row].isUrgent{
                    cell.UpComingActivities_Image.image = UIImage(named: "Small Status Critical")
                    cell.upcomingImageWidthConstraint.constant = 20
                    cell.upcomingTimeLeadingConstraint.constant = 10
                }
                else{
                    cell.UpComingActivities_Image.image = nil
                    cell.upcomingImageWidthConstraint.constant = 0
                    cell.upcomingTimeLeadingConstraint.constant = 0
                    
                }
                return cell
            }
        default:
            return UITableViewCell()
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView.tag == 2{
            if indexPath.section == 0{
                return 0
            }
        }
        
        return 100
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            return 50
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch tableView.tag {
        case 1:
            if indexPath.section == 1 {
                
                if(upcomingVisitArrayToDisplay[indexPath.row].recordTypeId == SyncConfigurationViewModel().syncConfigurationRecordIdforEvent()){
                    
                    let accountStoryboard = UIStoryboard.init(name: "Event", bundle: nil)
                    let accountVisitsVC = accountStoryboard.instantiateViewController(withIdentifier: "AccountEventSummaryViewController") as? AccountEventSummaryViewController
                    PlanVisitManager.sharedInstance.visit = upcomingVisitArrayToDisplay[indexPath.row]
                    (accountVisitsVC)?.delegate = self
                    accountVisitsVC?.visitId = upcomingVisitArrayToDisplay[indexPath.row].Id
                    DispatchQueue.main.async {
                        self.present(accountVisitsVC!, animated: true, completion: nil)
                    }
                }else{
                    
                    let accountStoryboard = UIStoryboard.init(name: "AccountVisit", bundle: nil)
                    let accountVisitsVC = accountStoryboard.instantiateViewController(withIdentifier: "AccountVisitSummaryViewController") as? AccountVisitSummaryViewController
                    PlanVisitManager.sharedInstance.visit = upcomingVisitArrayToDisplay[indexPath.row]
                    (accountVisitsVC)?.delegate = self
                    accountVisitsVC?.visitId = upcomingVisitArrayToDisplay[indexPath.row].Id
                    self.present(accountVisitsVC!, animated: true, completion: nil)
                }
                
            }else if indexPath.section == 2{
                DispatchQueue.main.async {
                    let detailViewController = UIStoryboard(name: "ActionItem", bundle: nil).instantiateViewController(withIdentifier :"ActionItemDetailsViewController") as! ActionItemDetailsViewController
                    detailViewController.actionItemId = self.upcomingActionItemArrayToDisplay[indexPath.row].Id
                    detailViewController.delegate = self as? ActionItemDetailsViewControllerDelegate
                    self.present(detailViewController, animated: true)
                }
            }
        case 2:
            if indexPath.section == 1 {
                if(pastVisitArrayToDisplay[indexPath.row].recordTypeId == SyncConfigurationViewModel().syncConfigurationRecordIdforEvent()){
                    
                    let accountStoryboard = UIStoryboard.init(name: "Event", bundle: nil)
                    let accountVisitsVC = accountStoryboard.instantiateViewController(withIdentifier: "AccountEventSummaryViewController") as? AccountEventSummaryViewController
                    PlanVisitManager.sharedInstance.visit = pastVisitArrayToDisplay[indexPath.row]
                    (accountVisitsVC)?.delegate = self
                    accountVisitsVC?.visitId = pastVisitArrayToDisplay[indexPath.row].Id
                    DispatchQueue.main.async {
                        self.present(accountVisitsVC!, animated: true, completion: nil)
                    }
                }else{
                    let accountStoryboard = UIStoryboard.init(name: "AccountVisit", bundle: nil)
                    let accountVisitsVC = accountStoryboard.instantiateViewController(withIdentifier: "AccountVisitSummaryViewController") as? AccountVisitSummaryViewController
                    PlanVisitManager.sharedInstance.visit = pastVisitArrayToDisplay[indexPath.row]
                    (accountVisitsVC)?.delegate = self
                    accountVisitsVC?.visitId = pastVisitArrayToDisplay[indexPath.row].Id
                    self.present(accountVisitsVC!, animated: true, completion: nil)
                }
            }else  if indexPath.section == 2{
                DispatchQueue.main.async {
                    let detailViewController = UIStoryboard(name: "ActionItem", bundle: nil).instantiateViewController(withIdentifier :"ActionItemDetailsViewController") as! ActionItemDetailsViewController
                    detailViewController.actionItemId = self.pastActionItemArrayToDisplay[indexPath.row].Id
                    detailViewController.delegate = self as? ActionItemDetailsViewControllerDelegate
                    self.present(detailViewController, animated: true)
                }
            }
        default:
            print("Error Found")
        }
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0{
            let frame = upcomingActivitiesTableView.frame
            let sectionLabel = UILabel.init(frame: CGRect(x: 12, y: 5, width: 300, height: 50))
            if tableView.tag == 1{
                sectionLabel.text = "Upcoming Activities"
            }else{
                sectionLabel.text = "Past Activities"
            }
            sectionLabel.textColor = UIColor.black
            sectionLabel.font = UIFont(name: "Ubuntu-Medium", size: 25)
            
            let headerView = UIView.init(frame: CGRect(x: 0, y: 0, width:frame.width , height:frame.height ))
            headerView.backgroundColor = UIColor.white
            headerView.addSubview(sectionLabel)
            return headerView;
        }
        return nil
    }
    
}

// MARK: - Date Extension to check dates in week, month, today, future.
extension Date {
    func isInSameWeek(date: Date) -> Bool {
        return Calendar.current.isDate(self, equalTo: date, toGranularity: .weekOfYear)
    }
    func isInSameMonth(date: Date) -> Bool {
        return Calendar.current.isDate(self, equalTo: date, toGranularity: .month)
    }
    func isInSameYear(date: Date) -> Bool {
        return Calendar.current.isDate(self, equalTo: date, toGranularity: .year)
    }
    func isInSameDay(date: Date) -> Bool {
        return Calendar.current.isDate(self, equalTo: date, toGranularity: .day)
    }
    var isInThisWeek: Bool {
        return isInSameWeek(date: Date())
    }
    var isInToday: Bool {
        return Calendar.current.isDateInToday(self)
    }
    var isInTheFuture: Bool {
        return Date() < self
    }
    var isInThePast: Bool {
        return self < Date()
    }
}


//MARK:- NavigateToContacts Delegate
extension AccountOverViewViewController : NavigateToContactsDelegate{
    func navigateTheScreenToActionItemsInPersistantMenu(data: LoadThePersistantMenuScreen) {
        if  data == .actionItems{
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showActionItems"), object:nil)
        }
    }
    
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
            // Added this line so that Contact detail view is not launched for this scenario.
            ContactFilterMenuModel.selectedContactId = ""
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showAllContacts"), object:nil)
        }else {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "loadMoreScreens"), object:data.rawValue)
        }
    }
    
    func navigateToAccountScreen() {
        // Added this line so that Account detail view is not launched for this scenario.
        //        FilterMenuModel.selectedAccountId = ""
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showAllAccounts"), object:nil)
    }
}

