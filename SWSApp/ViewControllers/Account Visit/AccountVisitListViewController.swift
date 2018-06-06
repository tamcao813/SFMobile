//
//  AccountVisitListViewController.swift
//  SWSApp
//
//  Created by Krishna, Kamya on 4/23/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit
//import DropDown

protocol ClearTheAccountVisitModelDelegate{
    func reloadTheDataFromBegining()
}

class AccountVisitListViewController: UIViewController {
    
    //External
    var outputArray:[Any]?
    var indexInOrignalArray:Int?
    
    //Internal
    var kPageSize:Int = 15
    var kSizeOfArray:Int = 103
    var kNoOfPagesInEachSet = 5
    var noOfPages:Int?
    var kNoOfPageSet:Int?
    var currentPageIndex:Int?
    var currentPageSet:Int?
    //    var previousPageSet:Int?
    let kNoOfPagesDisplayed = 5
    var kRemainderNoPagesEnabed = 0
    var kRemainderNoPagesDisabled = 0
    var kRemainderNoLeft = 0
    var kOrignalArray:[Any]?
    var isDisabledPreviously = false
    //Outlets Used for Page control operation
    @IBOutlet var pageButtonArr: [UIButton]!
    var numberOfAccountRows = 0
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addNewButton : UIButton!
    
    var globalWorkorderObjectArray = [WorkOrderUserObject]()
    var mainArray = [WorkOrderUserObject]()
    var dataArrayFromToday = [WorkOrderUserObject]()
    var tableViewDataArray = [WorkOrderUserObject]()
    var filteredTableViewDataArray = [WorkOrderUserObject]()
    var addNewDropDown = DropDown()
    var searchStr = ""
    
    var titleAscendingSort = false
    var statusAscendingSort = false
    var dateAscendingSort = false
    
    var delegate : ClearTheAccountVisitModelDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.refreshAccountVisitList), name: NSNotification.Name("refreshAccountVisitList"), object: nil)
        self.getTheDataFromDB()
        //customizedUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //initializingXIBs()
        addNewButton.setAttributedTitle(AttributedStringUtil.formatAttributedText(smallString: "Add New ", bigString: "+"), for: .normal)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //DispatchQueue.global().async {
       
        //}
    }
    
    @objc func refreshAccountVisitList(){

        getTheDataFromDB()
       
    }
    
    func getTheDataFromDB(){
        let visitArray = VisitsViewModel()
        globalWorkorderObjectArray = visitArray.visitsForUser()
        mainArray = visitArray.visitsForUser()
        tableViewDataArray = visitArray.visitsForUser()
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone.current
        let timeStamp = dateFormatter.string(from: date)
        
        tableViewDataArray = tableViewDataArray.filter({
            let date = DateTimeUtility.convertUtcDatetoReadableDateString(dateString: $0.startDate)
            return date >= timeStamp
        })
        
        tableViewDataArray = tableViewDataArray.sorted(by: { $0.startDate < $1.startDate })
        
        dataArrayFromToday = tableViewDataArray.sorted(by: { $0.startDate < $1.startDate })
        
        //Used for Past events during filtering
        let newDate = date.addingTimeInterval(-(60 * 60 * 24))
        let pastVisitsEventsTimeStamp = dateFormatter.string(from: newDate)
        
        mainArray = mainArray.filter({
            let date = DateTimeUtility.convertUtcDatetoReadableDateString(dateString: $0.startDate)
            return date >= pastVisitsEventsTimeStamp
        })
        
        mainArray = mainArray.sorted(by: { $0.startDate < $1.startDate })
        
        delegate?.reloadTheDataFromBegining()
        
        self.initializePagination()
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
    
    func scrollTableViewToTop(){
        tableView.reloadData()
        DispatchQueue.main.async {
            if(self.tableViewDataArray.count > 0){
                self.tableView.scrollToRow(at: IndexPath.init(row: 0, section: 0), at: .top, animated: true)
            }
        }
    }
    
    @IBAction func newVisitButtonTapped(_ sender: UIButton){
        
        addNewDropDown.anchorView = sender
        addNewDropDown.bottomOffset = CGPoint(x: 0, y:(addNewDropDown.anchorView?.plainView.bounds.height)!)
        addNewDropDown.backgroundColor = UIColor.white
        addNewDropDown.dataSource = ["Visit", "Event"]
        self.addNewDropDown.textFont = UIFont(name: "Ubuntu", size: 14)!
        self.addNewDropDown.textColor = UIColor.black
        
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
        
        if titleAscendingSort {
            tableViewDataArray = tableViewDataArray.sorted(by: { $0.subject.lowercased() < $1.subject.lowercased() })
            titleAscendingSort = false
        }else{
            tableViewDataArray = tableViewDataArray.sorted(by: { $0.subject.lowercased() > $1.subject.lowercased() })
            titleAscendingSort = true
        }
        self.scrollTableViewToTop()
    }
    
    @IBAction func sortByStatusButtonAction(_ sender: UIButton){
        
        if statusAscendingSort{
            tableViewDataArray = tableViewDataArray.sorted(by: { $0.status.lowercased() < $1.status.lowercased() })
            statusAscendingSort = false
        }else{
            tableViewDataArray = tableViewDataArray.sorted(by: { $0.status.lowercased() > $1.status.lowercased() })
            statusAscendingSort = true
        }
        self.scrollTableViewToTop()
    }
    
    @IBAction func sortByDateButtonAction(_ sender: UIButton){
      
        if dateAscendingSort{
            tableViewDataArray = tableViewDataArray.sorted(by: { $0.startDate < $1.startDate })
            dateAscendingSort = false
        }else{
            tableViewDataArray = tableViewDataArray.sorted(by: { $0.startDate > $1.startDate })
            dateAscendingSort = true
        }
        self.scrollTableViewToTop()
    }
}

extension AccountVisitListViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return kPageSize //tableViewDataArray.count
//    }
    
    //Pagination changes needed in TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let cellsToDisplay = tableViewDataArray.count - currentPageIndex!
        
        if cellsToDisplay <= self.kPageSize && cellsToDisplay > 0 {
            numberOfAccountRows = cellsToDisplay
            return cellsToDisplay
        } else if (cellsToDisplay == 0) {
            numberOfAccountRows = 0
            return 0
        }
        else {
            numberOfAccountRows = self.kPageSize
            return self.kPageSize
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50;
    }
    
    // custom header for the section
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccountVisitListHeaderTableViewCell") as? AccountVisitListTableViewCell
        //cell?.cen
        return cell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let visitNEventCellData:WorkOrderUserObject = tableViewDataArray[indexPath.row + currentPageIndex!]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccountVisitListTableViewCell") as? AccountVisitListTableViewCell
        cell?.selectionStyle = .none
        //cell?.delegate = self as! SwipeTableViewCellDelegate
        
//        let celldata = tableViewDataArray[indexPath.row]
        
        cell?.displayCellData(data: visitNEventCellData)
        
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
        self.view.endEditing(true)
        
        let workOrder = tableViewDataArray[indexPath.row + currentPageIndex!]
        
        if(workOrder.recordTypeId == StoreDispatcher.shared.workOrderRecordTypeIdEvent){
            let accountStoryboard = UIStoryboard.init(name: "Event", bundle: nil)
            let accountVisitsVC = accountStoryboard.instantiateViewController(withIdentifier: "AccountEventSummaryViewController") as? AccountEventSummaryViewController
            
            PlanVisitManager.sharedInstance.visit = tableViewDataArray[indexPath.row]
            accountVisitsVC?.visitId = tableViewDataArray[indexPath.row].Id
            
            (accountVisitsVC)?.delegate = self
            
            DispatchQueue.main.async {
                self.present(accountVisitsVC!, animated: true, completion: nil)
            }
        } else {
            
            let accountStoryboard = UIStoryboard.init(name: "AccountVisit", bundle: nil)
            let accountVisitsVC = accountStoryboard.instantiateViewController(withIdentifier: "AccountVisitSummaryViewController") as? AccountVisitSummaryViewController
   
            PlanVisitManager.sharedInstance.visit = tableViewDataArray[indexPath.row]
            accountVisitsVC?.visitId = tableViewDataArray[indexPath.row].Id
            
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
        
        tableViewDataArray.removeAll()
        tableViewDataArray = dataArrayFromToday
        
        self.initializePagination()
        self.scrollTableViewToTop()
    }
    
    func performFilterOperation(searchText: UISearchBar) {
        AccountVisitListFilterModel.filterApplied = true
        //Perform Search Operation First then do Filtering
        applyFilter(searchText: searchText.text!)
    }
    
    func applyFilter(searchText: String){
        if searchText != ""{
            searchStr = searchText
            
            if AccountVisitListFilterModel.startDate != "" && AccountVisitListFilterModel.endDate != ""{
                filteredTableViewDataArray =  AccountVisitListSortUtility().searchAndFilter(searchStr: searchText, actionItems: globalWorkorderObjectArray)
                
            }else{
                //Condition check to get the past dates
                if AccountVisitListFilterModel.isPastVisits == "YES"{
                    filteredTableViewDataArray =  AccountVisitListSortUtility().searchAndFilter(searchStr: searchText, actionItems: mainArray)
                }else{
                    filteredTableViewDataArray =  AccountVisitListSortUtility().searchAndFilter(searchStr: searchText, actionItems: dataArrayFromToday)
                }
            }
            
        }else{
            
            if AccountVisitListFilterModel.startDate != "" && AccountVisitListFilterModel.endDate != ""{
                filteredTableViewDataArray = AccountVisitListSortUtility().filterOnly(actionItems: globalWorkorderObjectArray)
                
            }else{
                //Condition check to get the past dates
                if AccountVisitListFilterModel.isPastVisits == "YES"{
                    filteredTableViewDataArray = AccountVisitListSortUtility().filterOnly(actionItems: mainArray)
                }else{
                    filteredTableViewDataArray = AccountVisitListSortUtility().filterOnly(actionItems: dataArrayFromToday)
                }
            }
        }
        
        tableViewDataArray.removeAll()
        tableViewDataArray = filteredTableViewDataArray
        
        self.initializePagination()
        self.scrollTableViewToTop()
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


//MARK:- PageControl Implementation
extension AccountVisitListViewController{
    enum Page: Int {
        case  previousLbl=0, oneLbl, twoLbl, threeLbl, fourLbl, fiveLbl, nextLbl,lastLbl,firstLbl
        case first = 100, previous, one, two, three, four, five, next,last
    }
    
    //Used to reload the Pagination for refresh
    func initializePagination(){
        
        initPageViewWith(inputArr:tableViewDataArray, pageSize: kPageSize)
        updateUI()
        
        if(numberOfAccountRows > 0){
            if tableViewDataArray.count > 0{
                self.tableView.scrollToRow(at: IndexPath.init(row: 0, section: 0), at: .top, animated: true)
            }
        }
        for count in 1...5 {
            pageButtonArr[count].setTitleColor(UIColor.black, for: .normal)
            pageButtonArr[count].backgroundColor = UIColor.white
            pageButtonArr[count].setTitle(String(count), for: .normal)
        }
        pageButtonArr[1].backgroundColor = UIColor.lightGray
        pageButtonArr[1].setTitleColor(UIColor.white, for: .normal)
    }
    
    func initPageViewWith(inputArr: [Any], pageSize:Int) {
        self.kOrignalArray = inputArr
        self.kPageSize = pageSize
        self.kSizeOfArray = inputArr.count
        self.noOfPages = (self.kSizeOfArray/self.kPageSize)
        self.kNoOfPageSet = self.noOfPages! / kNoOfPagesDisplayed
        
        if(self.kPageSize * kNoOfPagesDisplayed * self.kNoOfPageSet!  <  self.kSizeOfArray) {
            
            self.kRemainderNoLeft = self.kSizeOfArray - (self.kPageSize * kNoOfPagesDisplayed * self.kNoOfPageSet!)
            self.kRemainderNoPagesEnabed = self.kRemainderNoLeft/self.kPageSize
            if(self.kRemainderNoLeft % self.kPageSize > 0) {
                self.kRemainderNoPagesEnabed = self.kRemainderNoPagesEnabed + 1
            }
            self.kRemainderNoPagesDisabled = kNoOfPagesDisplayed - self.kRemainderNoPagesEnabed
            
            self.kNoOfPageSet! += 1
        }
        self.currentPageIndex = 0   //It will have index value of the page it is displaying right now, 0 or 5 or next 10, 15---
        self.currentPageSet = 0     //[1][2][3][4][5][6] --- CPI
        
        //if inputArr.count >= 10{
        //tableViewDisplayData = tableViewDisplayData[0...4]
        //    print(tableViewDisplayData)
        // }else{
        //let items = inputArr.count - 1
        // tableViewDisplayData = tableViewDisplayData[0...items]
        //    print(tableViewDisplayData)
        // }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func disableBtn(from:Int, to:Int) {
        for i in from...to {
            pageButtonArr[i].isEnabled = false
            isDisabledPreviously = true
        }
    }
    
    func enableBtn(from:Int, to:Int) {
        for i in from...to {
            pageButtonArr[i].isEnabled = true
        }
    }
    
    func changeBtnText(byPageSet:Int) {
        if(currentPageSet! + byPageSet >= 0 &&
            currentPageSet! < kNoOfPageSet!) {
            for i in 1...kNoOfPagesInEachSet {
                if let labelText = pageButtonArr[i].titleLabel?.text {
                    if let intVal = Int(labelText) {
                        pageButtonArr[i].setTitle(String(intVal + (byPageSet * kNoOfPagesInEachSet)), for: .normal)
                    }
                }
            }
            currentPageSet = currentPageSet! + byPageSet
            currentPageIndex = currentPageSet! * kNoOfPagesInEachSet * kPageSize
            print("Page Set Selected = \(currentPageSet!) Base Index Calulated \(currentPageIndex!)")
        }
    }
    
    func updateUI(){
        
        if(kSizeOfArray == 0) {
            disableBtn(from:0, to: 8)
        }
        else {
            if (isDisabledPreviously == true){
                enableBtn(from:0, to: 8)
            }
            
            //Get Size of aray and enable the tabs
            if(currentPageSet == 0){
                disableBtn(from: 0, to: 0)
                disableBtn(from: 7, to: 7)
            }
            
            if(currentPageSet! >= kNoOfPageSet! - 1 ){
                disableBtn(from: 6, to: 6)
                disableBtn(from: 8, to: 8)
                
                if(kRemainderNoPagesDisabled > 0) {
                    let enableBtns = kNoOfPagesInEachSet - kRemainderNoPagesDisabled
                    enableBtn(from: 1, to: enableBtns)
                    if(enableBtns+1 <= 5) {
                        disableBtn(from: enableBtns+1, to: 5)
                    }
                }
            }
        }
    }
    
    @IBAction func pageActionHandeler(sender: UIButton) {
        
        print("\(sender.titleLabel)")
        print("\(sender.tag)")
        pageButtonArr[1].setTitleColor(UIColor.black, for: .normal)
        pageButtonArr[2].setTitleColor(UIColor.black, for: .normal)
        pageButtonArr[3].setTitleColor(UIColor.black, for: .normal)
        pageButtonArr[4].setTitleColor(UIColor.black, for: .normal)
        pageButtonArr[5].setTitleColor(UIColor.black, for: .normal)
        
        pageButtonArr[1].backgroundColor = UIColor.white
        pageButtonArr[2].backgroundColor = UIColor.white
        pageButtonArr[3].backgroundColor = UIColor.white
        pageButtonArr[4].backgroundColor = UIColor.white
        pageButtonArr[5].backgroundColor = UIColor.white
        
        self.changePaginationTitleText(sender: sender.tag)
        
        //let tableViewData = accountsForLoggedUserOriginal[self.currentPageIndex!]
        //tableViewDisplayData = [tableViewData]
        
        if(numberOfAccountRows > 0) {
            tableView.reloadData()
            self.tableView.scrollToRow(at: IndexPath.init(row: 0, section: 0), at: .top, animated: false)
        }
    }
    
    private func changePaginationTitleText(sender : Int){
        
        switch sender {
        case Page.first.rawValue:
            
            self.setupFirstPageButton()
            
        case Page.previous.rawValue:
            //On pres of Previous if pageSet is grater than 0 than we have one pageSet to display decrement by 1
            changeBtnText(byPageSet:-1)
            //                self.currentPageIndex = (currentPageSet! * kNoOfPagesInEachSet+0) * kPageSize
            print ("One: Index is \(currentPageIndex!)")
            updateUI()
            
        case Page.one.rawValue:
            self.currentPageIndex = (currentPageSet! * kNoOfPagesInEachSet+0) * kPageSize
            print ("One: Index is \(currentPageIndex!)")
            
            pageButtonArr[1].setTitleColor(UIColor.white, for: .normal)
            pageButtonArr[1].backgroundColor = UIColor.lightGray
            
        case Page.two.rawValue:
            self.currentPageIndex = (currentPageSet! * kNoOfPagesInEachSet+1) * kPageSize
            print ("two: Index is \(currentPageIndex!)")
            
            pageButtonArr[2].setTitleColor(UIColor.white, for: .normal)
            pageButtonArr[2].backgroundColor = UIColor.lightGray
            
        case Page.three.rawValue:
            self.currentPageIndex = (currentPageSet! * kNoOfPagesInEachSet+2) * kPageSize
            print ("three: Index is \(currentPageIndex!)")
            
            pageButtonArr[3].setTitleColor(UIColor.white, for: .normal)
            pageButtonArr[3].backgroundColor = UIColor.lightGray
            
        case Page.four.rawValue:
            self.currentPageIndex = (currentPageSet! * kNoOfPagesInEachSet+3) * kPageSize
            print ("four: Index is \(currentPageIndex!)")
            
            pageButtonArr[4].setTitleColor(UIColor.white, for: .normal)
            pageButtonArr[4].backgroundColor = UIColor.lightGray
            
        case Page.five.rawValue:
            self.currentPageIndex = (currentPageSet! * kNoOfPagesInEachSet+4) * kPageSize
            print ("five: Index is \(currentPageIndex!)")
            
            pageButtonArr[5].setTitleColor(UIColor.white, for: .normal)
            pageButtonArr[5].backgroundColor = UIColor.lightGray
            
        case Page.next.rawValue:
            changeBtnText(byPageSet: 1)
            updateUI()
            print ("Next")
            
        case Page.last.rawValue:
            
            self.setupLastPageButton()
            
        default:
            break
        }
    }
    
    func setupFirstPageButton(){
        for i in 1...kNoOfPagesInEachSet {
            pageButtonArr[i].setTitle(String(i), for: .normal)
        }
        self.currentPageIndex = 0
        self.currentPageSet = 0
        updateUI()
        print ("First")
        print ("New \(self.currentPageIndex!)")
    }
    
    func setupLastPageButton(){
        self.setCurrentPageIndex()
        self.currentPageIndex = (kNoOfPageSet!-1) * kPageSize * kNoOfPagesInEachSet
        self.currentPageSet = kNoOfPageSet! - 1
        updateUI()
        print ("Last")
        print ("New \(self.currentPageIndex!)")
    }
    
    func setCurrentPageIndex(){
        let lastSetNo = (kNoOfPageSet!-1) * kNoOfPagesInEachSet
        for i in 1...kNoOfPagesInEachSet {
            pageButtonArr[i].setTitle(String(lastSetNo + i), for: .normal)
        }
    }
}

