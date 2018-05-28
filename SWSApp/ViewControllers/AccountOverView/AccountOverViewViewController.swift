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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        upcomingActivitiesTableView.delegate = self
        upcomingActivitiesTableView.dataSource = self
        pastActivitiesTableView.delegate =  self
        pastActivitiesTableView.dataSource = self
        
        
//                upcomingActivitiesTableView.rowHeight = UITableViewAutomaticDimension;
//                upcomingActivitiesTableView.estimatedRowHeight = 100
//                upcomingActivitiesTableView.tableFooterView = UIView()
//        
//                pastActivitiesTableView.rowHeight = UITableViewAutomaticDimension;
//                pastActivitiesTableView.estimatedRowHeight = 100
//                pastActivitiesTableView.tableFooterView = UIView()
        
        self.accountId = account?.account_Id
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.refreshAccountOverView), name: NSNotification.Name("refreshAccountOverView"), object: nil)
        
        getDB()
        
        
    }
    
    @objc func refreshAccountOverView()   {
        getDB()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.upcomingActivitiesTableView.reloadData()
        self.pastActivitiesTableView.reloadData()
    }
    
    func getDB()  {
        
        upcomingVisitArrayToDisplay = [WorkOrderUserObject]()
        pastVisitArrayToDisplay = [WorkOrderUserObject]()
        upcomingActionItemArrayToDisplay = [ActionItem]()
        pastActionItemArrayToDisplay = [ActionItem]()
        
        //creating upcomingvisit array according to accountId
        upcomingVisit = visitModel.visitsForUserTwoWeeksUpcoming()
        for accVisit in upcomingVisit {
            
            if(accVisit.accountId ==  accountId) {
                upcomingVisitArrayToDisplay.append(accVisit)
            }
        }
        
        //creating upcoming action item array according to accountId
        upcomingActionItem = actionItemModel.actionItemForUserTwoWeeksUpcoming()
        for accAction in upcomingActionItem{
            
            if (accAction.accountId == accountId){
                
                upcomingActionItemArrayToDisplay.append(accAction)
            }
            
        }
        
        
        //creating pastvisit array according to accountId
        pastVisit = visitModel.visitsForUserOneWeeksPast()
        for accVisit in pastVisit {
            
            if(accVisit.accountId ==  accountId) {
                pastVisitArrayToDisplay.append(accVisit)
            }
        }
        
        //creating past action item array according to accountId
        pastActionItem = actionItemModel.actionItemForUserOneWeeksPast()
        for accAction in pastActionItem{
            
            if (accAction.accountId == accountId){
                pastActionItemArrayToDisplay.append(accAction)
                
            }
            
        }
        DispatchQueue.main.async {
            self.upcomingActivitiesTableView.reloadData()
            self.pastActivitiesTableView.reloadData()
        }
        
    }
    
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
            return "No Day"
        }
    }
    
    func getDayForActionCurrentWeek(dateToConvert:String) ->String  {
        
        dateFormatter.dateFormat = "MM-dd-yyyy"
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
            return "No Day"
        }
    }
    
    
    
    func getDayFromVisit(dateToConvert:String)-> String  {
        //Getting Today, Tomorrow, Yesterday
        let calendar = Calendar.current
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000+0000"
        let date = dateFormatter.date(from: dateToConvert)
        //Gtting time and date
        let getTime = DateTimeUtility.convertUtcDatetoReadableDate(dateStringfromAccountNotes: dateToConvert)
        let dayToCheck = dateFormatter.string(from: date!)
        var dateTime = getTime.components(separatedBy: " ")
        
        if calendar.isDateInToday(date!){
            
            return  "Today at " + dateTime[1]
        }
        else if calendar.isDateInTomorrow(date!)
        {
            
            return  "Tomorrow at " + dateTime[1]
            
        }else if calendar.isDateInYesterday(date!)
        {
            
            return  "Yesterday at " + dateTime[1]
            
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
        
        
        dateFormatter.dateFormat = "MM-dd-yyyy h:mma"
        let timeStamp = dateFormatter.string(from: date!)
        return timeStamp
    }
    
    
    
    func getDayFromActionItem(dateToConvert:String)-> String  {
        //Getting Today, Tomorrow, Yesterday
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: dateToConvert)
        //Gtting time and date
        let getDate = DateTimeUtility.getDateActionItemFromDateString(dateString: dateToConvert)
        dateFormatter.dateFormat = "MM-dd-yyyy"
        let timeStamp = dateFormatter.string(from: date!)
        if calendar.isDateInToday(date!){
            
            return  "Today"
        }
        else if calendar.isDateInTomorrow(date!)
        {
            return  "Tomorrow"
            
        }else if calendar.isDateInYesterday(date!)
        {
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            if tableView.tag == 1{
                return upcomingVisitArrayToDisplay.count
            }else{
                return pastVisitArrayToDisplay.count
            }
        case 1:
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
        case 0:
            if tableView.tag == 1{
                if upcomingVisitArrayToDisplay[indexPath.row].recordTypeId == StoreDispatcher.shared.workOrderRecordTypeIdVisit{
                    cell.UpComingActivities_TitleLabel.text = "Visit " + upcomingVisitArrayToDisplay[indexPath.row].accountName
                }else{
                    cell.UpComingActivities_TitleLabel.text = upcomingVisitArrayToDisplay[indexPath.row].subject
                }
                cell.UpComingActivities_TimeLabel.text = getDayFromVisit(dateToConvert: upcomingVisitArrayToDisplay[indexPath.row].startDate)
                cell.UpComingActivities_Image.image = UIImage(named: "Bell")
                return cell
            }else{
                if pastVisitArrayToDisplay[indexPath.row].recordTypeId == StoreDispatcher.shared.workOrderRecordTypeIdVisit{
                    cell.UpComingActivities_TitleLabel.text = "Visit " + pastVisitArrayToDisplay[indexPath.row].accountName
                }else{
                    cell.UpComingActivities_TitleLabel.text =  pastVisitArrayToDisplay[indexPath.row].subject
                }
                cell.UpComingActivities_TimeLabel.text = getDayFromVisit(dateToConvert: pastVisitArrayToDisplay[indexPath.row].startDate)
                cell.UpComingActivities_Image.image = UIImage(named: "Bell")
                return cell
            }
        case 1:
            if tableView.tag == 1{
                cell.UpComingActivities_TitleLabel.text = upcomingActionItemArrayToDisplay[indexPath.row].subject
                cell.UpComingActivities_TimeLabel.text = getDayFromActionItem(dateToConvert: upcomingActionItemArrayToDisplay[indexPath.row].activityDate)
                if upcomingActionItemArrayToDisplay[indexPath.row].isUrgent{
                    cell.UpComingActivities_Image.image = UIImage(named: "Small Status Critical")
                }
                else{
                    cell.UpComingActivities_Image.image = nil
                }
                
                return cell
            }
                
            else{
                cell.UpComingActivities_TitleLabel.text = pastActionItemArrayToDisplay[indexPath.row].subject
                cell.UpComingActivities_TimeLabel.text = getDayFromActionItem(dateToConvert: pastActionItemArrayToDisplay[indexPath.row].activityDate)
                if pastActionItemArrayToDisplay[indexPath.row].isUrgent{
                    cell.UpComingActivities_Image.image = UIImage(named: "Small Status Critical")
                }
                else{
                    cell.UpComingActivities_Image.image = nil
                }
                return cell
            }
        default:
            return UITableViewCell()
        }
    }
    
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//       return 150
//    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
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
            if indexPath.section == 0 {
                
                if(upcomingVisitArrayToDisplay[indexPath.row].recordTypeId == StoreDispatcher.shared.workOrderRecordTypeIdEvent){
                    
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
                
            }else{
                DispatchQueue.main.async {
                    let detailViewController = UIStoryboard(name: "ActionItem", bundle: nil).instantiateViewController(withIdentifier :"ActionItemDetailsViewController") as! ActionItemDetailsViewController
                    detailViewController.actionItemId = self.upcomingActionItemArrayToDisplay[indexPath.row].Id
                    detailViewController.delegate = self as? ActionItemDetailsViewControllerDelegate
                    self.present(detailViewController, animated: true)
                }
            }
        case 2:
            if indexPath.section == 0 {
                if(pastVisitArrayToDisplay[indexPath.row].recordTypeId == StoreDispatcher.shared.workOrderRecordTypeIdEvent){
                    
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
                
                
            }else{
                
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
//MARK:- NavigateToContacts Delegate
extension AccountOverViewViewController : NavigateToContactsDelegate{
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
