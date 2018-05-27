//
//  AccountVisitListViewController.swift
//  SWSApp
//
//  Created by Krishna, Kamya on 4/23/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit
//import DropDown

class AccountVisitListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var mainArray = [WorkOrderUserObject]()
    var tableViewDataArray : [WorkOrderUserObject]?
    var filteredTableViewDataArray = [WorkOrderUserObject]()
    var addNewDropDown = DropDown()
    var searchStr = ""
    
    var titleAscendingSort = false
    var statusAscendingSort = false
    var dateAscendingSort = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.refreshAccountVisitList), name: NSNotification.Name("refreshAccountVisitList"), object: nil)

        getTheDataFromDB()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        customizedUI()
        //initializingXIBs()
    }
    
    @objc func refreshAccountVisitList(){
        getTheDataFromDB()
    }
    
    func getTheDataFromDB(){
        tableViewDataArray = [WorkOrderUserObject]()
        let visitArray = VisitsViewModel()
        mainArray = visitArray.visitsForUser()
        tableViewDataArray = visitArray.visitsForUser()
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'00:00:00.000+0000"
        let timeStamp = dateFormatter.string(from: date)
        
        tableViewDataArray = tableViewDataArray?.filter({ return $0.startDate > timeStamp })
        tableViewDataArray = tableViewDataArray?.sorted(by: { $0.startDate < $1.startDate })
        
        //Used for Past events during filtering
        let newDate = date.addingTimeInterval(-(60 * 60 * 24))
        let pastVisitsEventsTimeStamp = dateFormatter.string(from: newDate)
        
        mainArray = mainArray.filter({ return $0.startDate > pastVisitsEventsTimeStamp })
        mainArray = mainArray.sorted(by: { $0.startDate < $1.startDate })
        
        DispatchQueue.main.async {
            //UIView.performWithoutAnimation({() -> Void in
                self.tableView.reloadData()
            //})
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("refreshAccountVisitList"), object: nil)
    }
    
    func customizedUI(){
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        self.tableView.estimatedRowHeight = 100
        self.tableView.allowsSelection = true
        self.tableView.allowsMultipleSelectionDuringEditing = true
    }
    
    func initializingXIBs(){
        //self.tableView.register(UINib(nibName: "AccountVisitListTableViewCell", bundle: nil), forCellReuseIdentifier: "AccountVisitListTableViewCell")
    }
    
    @IBAction func newVisitButtonTapped(_ sender: UIButton){
        addNewDropDown.anchorView = sender
        addNewDropDown.bottomOffset = CGPoint(x: (((sender.frame.size.width) - 100)-((sender.frame.size.width)/6.0)), y :( addNewDropDown.anchorView?.plainView.bounds.height)!)
        
        addNewDropDown.backgroundColor = UIColor.white
        
        let dropDownItem1 = NSLocalizedString("Visit", comment: "Visit")
        let dropDownItem2 = NSLocalizedString("Event", comment: "Event")
        
        addNewDropDown.dataSource = [dropDownItem1, dropDownItem2]
        self.addNewDropDown.textFont = UIFont(name: "Ubuntu", size: 13)!
        self.addNewDropDown.textColor = UIColor.gray
        
        addNewDropDown.show()
        
        addNewDropDown.selectionAction = {(index: Int, item: String) in
            switch index {
            case 0:
                let createVisitViewController = UIStoryboard(name: "AccountVisit", bundle: nil).instantiateViewController(withIdentifier :"CreateNewVisitViewController") as! CreateNewVisitViewController
                createVisitViewController.isEditingMode = false
                PlanVisitManager.sharedInstance.visit = nil
                DispatchQueue.main.async {
                    self.present(createVisitViewController, animated: true)
                }
            case 1:
                let createEventViewController = UIStoryboard(name: "CreateEvent", bundle: nil).instantiateViewController(withIdentifier :"CreateNewEventViewController") as! CreateNewEventViewController
                PlanVisitManager.sharedInstance.visit = nil
                DispatchQueue.main.async {
                    self.present(createEventViewController, animated: true, completion: nil)
                }
            default:
                break
            }
        }
    }
    
    @IBAction func sortByTitleButtonAction(_ sender: UIButton){
        if AccountVisitListFilterModel.filterApplied{
            if titleAscendingSort {
                filteredTableViewDataArray = filteredTableViewDataArray.sorted(by: { $0.subject < $1.subject })
                titleAscendingSort = false
            }else{
                filteredTableViewDataArray = filteredTableViewDataArray.sorted(by: { $0.subject > $1.subject })
                titleAscendingSort = true
            }
        }else{
            if titleAscendingSort {
                tableViewDataArray = tableViewDataArray?.sorted(by: { $0.subject < $1.subject })
                titleAscendingSort = false
            }else{
                tableViewDataArray = tableViewDataArray?.sorted(by: { $0.subject > $1.subject })
                titleAscendingSort = true
            }
        }
        tableView.reloadData()
    }
    
    @IBAction func sortByStatusButtonAction(_ sender: UIButton){
        if AccountVisitListFilterModel.filterApplied{
            if statusAscendingSort{

                
                
                statusAscendingSort = false
            }else{
                
                statusAscendingSort = true
            }
        }else{
            if statusAscendingSort{
                
                
                
                statusAscendingSort = false
            }else{
                
                
                
                
                statusAscendingSort = true
            }
        }
        tableView.reloadData()
    }
    
    @IBAction func sortByDateButtonAction(_ sender: UIButton){
        if AccountVisitListFilterModel.filterApplied{
            if dateAscendingSort{
                filteredTableViewDataArray = filteredTableViewDataArray.sorted(by: { $0.startDate < $1.startDate })
                dateAscendingSort = false
            }else{
                filteredTableViewDataArray = filteredTableViewDataArray.sorted(by: { $0.startDate > $1.startDate })
                dateAscendingSort = true
            }
        }else{
            if dateAscendingSort{
                tableViewDataArray = tableViewDataArray?.sorted(by: { $0.startDate < $1.startDate })
                dateAscendingSort = false
            }else{
                tableViewDataArray = tableViewDataArray?.sorted(by: { $0.startDate > $1.startDate })
                dateAscendingSort = true
            }
        }
        tableView.reloadData()
    }
}

extension AccountVisitListViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if AccountVisitListFilterModel.filterApplied{
            return filteredTableViewDataArray.count
        }
        return tableViewDataArray!.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50;
    }
    
    // custom header for the section
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccountVisitListHeaderTableViewCell") as? AccountVisitListTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
  
       let cell = tableView.dequeueReusableCell(withIdentifier: "AccountVisitListTableViewCell") as? AccountVisitListTableViewCell
        cell?.selectionStyle = .none
        //cell?.delegate = self as! SwipeTableViewCellDelegate
        
        let celldata : WorkOrderUserObject?
        if AccountVisitListFilterModel.filterApplied{
            celldata = filteredTableViewDataArray[indexPath.row]
        }else{
            celldata = tableViewDataArray![indexPath.row]
        }
        
        cell?.displayCellData(data: celldata)
        
        return cell!
    }
    
    //MARK:- Table view on Swipe EDIT and DELETE actions
//    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
//
//        guard orientation == .right else { return nil }
//
//        let editAction = SwipeAction(style: .default, title: "Edit") {action, indexPath in
//            let accountStoryboard = UIStoryboard.init(name: "AccountVisit", bundle: nil)
//            let accountVisitsVC = accountStoryboard.instantiateViewController(withIdentifier: "AccountVisitSummaryViewController") as? AccountVisitSummaryViewController
//
//            let data : Visit = self.tableViewDataArray![indexPath.row]
//
//            if data.status == "Scheduled"{
//                accountVisitsVC?.visitStatus = .scheduled
//            }else if data.status  == "Completed"{
//                accountVisitsVC?.visitStatus = .completed
//            }else {
//                accountVisitsVC?.visitStatus = .inProgress
//            }
//            accountVisitsVC?.modalPresentationStyle = .overCurrentContext
//            self.present(accountVisitsVC!, animated: true, completion: nil)
//        }
//
//        editAction.hidesWhenSelected = true
//        editAction.image = UIImage(named:"editIcon")
//        editAction.backgroundColor = UIColor(named:"InitialsBackground")
//
//        let deleteAction = SwipeAction(style: .default, title: "Delete") {action, indexPath in
//            let cell = tableView.cellForRow(at: indexPath) as! AccountVisitListTableViewCell
//            let closure: (UIAlertAction) -> Void = { _ in cell.hideSwipe(animated: true) }
//            let alert = UIAlertController(title: "Visit Delete", message: StringConstants.deleteConfirmation, preferredStyle: UIAlertControllerStyle.alert)
//            let continueAction = UIAlertAction(title: "Delete", style: .default , handler: closure)
//            alert.addAction(continueAction)
//            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: closure))
//            self.present(alert, animated: true, completion: nil)
//
//
//        }
//        deleteAction.image = #imageLiteral(resourceName: "deletX")
//        deleteAction.backgroundColor = UIColor(named:"InitialsBackground")
//        return [deleteAction, editAction]
//    }
    
//    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeTableOptions {
//        var options = SwipeTableOptions()
//        //options.expansionStyle = .
//        options.transitionStyle = .border
//        return options
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let workOrder : WorkOrderUserObject?
        if AccountVisitListFilterModel.filterApplied{
            workOrder  = filteredTableViewDataArray[indexPath.row]
        }else{
            workOrder = tableViewDataArray![indexPath.row]
        }
        
        if(workOrder?.recordTypeId == StoreDispatcher.shared.workOrderRecordTypeIdEvent){
            let accountStoryboard = UIStoryboard.init(name: "Event", bundle: nil)
            let accountVisitsVC = accountStoryboard.instantiateViewController(withIdentifier: "AccountEventSummaryViewController") as? AccountEventSummaryViewController
            
            if AccountVisitListFilterModel.filterApplied{
                PlanVisitManager.sharedInstance.visit = filteredTableViewDataArray[indexPath.row]
                accountVisitsVC?.visitId = filteredTableViewDataArray[indexPath.row].Id
            }else{
                PlanVisitManager.sharedInstance.visit = tableViewDataArray![indexPath.row]
                accountVisitsVC?.visitId = tableViewDataArray![indexPath.row].Id
            }
            
            (accountVisitsVC)?.delegate = self
            
            DispatchQueue.main.async {
                self.present(accountVisitsVC!, animated: true, completion: nil)
            }
        } else {
            
            let accountStoryboard = UIStoryboard.init(name: "AccountVisit", bundle: nil)
            let accountVisitsVC = accountStoryboard.instantiateViewController(withIdentifier: "AccountVisitSummaryViewController") as? AccountVisitSummaryViewController
            
            if AccountVisitListFilterModel.filterApplied{
                PlanVisitManager.sharedInstance.visit = filteredTableViewDataArray[indexPath.row]
                accountVisitsVC?.visitId = filteredTableViewDataArray[indexPath.row].Id
                
            }else{
                PlanVisitManager.sharedInstance.visit = tableViewDataArray![indexPath.row]
                accountVisitsVC?.visitId = tableViewDataArray![indexPath.row].Id
            }
            
            (accountVisitsVC)?.delegate = self
            
            DispatchQueue.main.async {
                self.present(accountVisitsVC!, animated: true, completion: nil)
            }
        }
    }
}

//MARK:- AccountVisitSearchButtonTapped Delegate
extension AccountVisitListViewController : AccountVisitSearchButtonTappedDelegate{
    
    func clearFilter() {
        AccountVisitListFilterModel.filterApplied = false
        self.tableView.reloadData()
        
        DispatchQueue.main.async {
            if(self.tableViewDataArray!.count > 0){
                self.tableView.scrollToRow(at: IndexPath.init(row: 0, section: 0), at: .top, animated: true)
            }
        }
    }
    
    func performFilterOperation(searchText: UISearchBar) {
        AccountVisitListFilterModel.filterApplied = true
        //Perform Search Operation First then do Filtering
        applyFilter(searchText: searchText.text!)
    }
    
    func applyFilter(searchText: String){
        if searchText != ""{
            searchStr = searchText
            //Condition check to get the past dates
            if AccountVisitListFilterModel.isPastVisits == "YES"{
                filteredTableViewDataArray =  AccountVisitListSortUtility().searchAndFilter(searchStr: searchText, actionItems: mainArray)
            }else{
                filteredTableViewDataArray =  AccountVisitListSortUtility().searchAndFilter(searchStr: searchText, actionItems: tableViewDataArray!)
            }
        }else{
            //Condition check to get the past dates
            if AccountVisitListFilterModel.isPastVisits == "YES"{
                filteredTableViewDataArray = AccountVisitListSortUtility().filterOnly(actionItems: mainArray)
            }else{
                filteredTableViewDataArray = AccountVisitListSortUtility().filterOnly(actionItems: tableViewDataArray!)
            }
        }
        self.tableView.reloadData()
        
        DispatchQueue.main.async {
            if(self.filteredTableViewDataArray.count > 0){
                self.tableView.scrollToRow(at: IndexPath.init(row: 0, section: 0), at: .top, animated: true)
            }
        }
    }
}


//MARK:- NavigateToContacts Delegate
extension AccountVisitListViewController : NavigateToContactsDelegate{
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

enum AccountVisitStatus : String {
    case scheduled
    case inProgress
    case completed
    case planned
}
