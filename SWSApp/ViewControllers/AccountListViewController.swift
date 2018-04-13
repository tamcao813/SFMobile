//
//  AccountListViewController.swift
//  SWSApp
//
//  Created by shilpa.a.kulkarni on 29/03/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

protocol DetailsScreenDelegate{
    func pushTheScreenToDetailsScreen(accountData : Account)
}

struct OrderOfAccountListItems {
    static var isAscending = "NO"
    static var isAscendingActionItems = "NO"
    static var isAscendingNetSales = "NO"
    static var isAscendingBalance = "NO"
    static var isAscendingNextDeliveryDate = "NO"
}


/// <#Description#>
class AccountsListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SearchByEnteredTextDelegate{
    
    @IBOutlet weak var accountListTableView: UITableView!
    
    var delegate : DetailsScreenDelegate?
    
    let accountViewModel = AccountsViewModel()
    
    
    
    //Master Data to display Tableview when First Logged in
    var accountsForLoggedUserOriginal = [Account]()
    
    
    
    
    var selectedAccount:Account?
    var isFiltering = false
    // filtered list
    var accountsForLoggedUserFiltered = [Account]() //aftersearch operation if search is enabled
    // sort related
    var isSorting = false
    var sortedAccountsList = [Account]() //after applying for sort
    var ascendingSort = true // action item, net sale, balance, next delivery date
    
    
    //Used to display Table View Content
    var tableViewDisplayData = [Account]()
    var numberOfAccountRows = 0
    
    var itemsToShowInTableView = -1
    
    
    //Used for Page control operation
    @IBOutlet var pageButtonArr: [UIButton]!
    
    //var inputArray = [1,2,3,4, 5,6,7,8, 9,10,11,12, 13,14,15,16, 17,18,19,20, 21,22,23,24, 25,26,27,28, 29,30,31,32, 33,34,35,36, 37,38,39,40, 41]
    
    
    //External
    var outputArray:[Any]?
    var indexInOrignalArray:Int?
    
    //Internal
    var kPageSize:Int = 10
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
    
    
    override func viewDidLoad() {
        //OrderOfAccountListItems.isAscending = "YES"
        accountsForLoggedUserOriginal = AccountSortUtility.sortByAccountNameAlphabetically(accountsListToBeSorted:accountViewModel.accountsForLoggedUser, ascending: true)
        print(accountsForLoggedUserOriginal.count)
        
        tableViewDisplayData = accountsForLoggedUserOriginal
        
        
        initPageViewWith(inputArr: tableViewDisplayData, pageSize: kPageSize)
        updateUI()
        
        
        
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        if(isSorting)
        //        {
        //            return sortedAccountsList.count
        //        }
        //        else
        //        {
        //            if(isFiltering)
        //            {
        //                return accountsForLoggedUserFiltered.count
        //            }
        //            return accountsForLoggedUserOriginal.count
        //        }
        let cellsToDisplay = tableViewDisplayData.count - currentPageIndex!
        
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
        
        //return tableViewDisplayData.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 200.0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        // get the account details from accountsForLoggedUser
        //        var account:Account = accountsForLoggedUserOriginal[indexPath.row]
        //        if(isSorting)
        //        {
        //            account = sortedAccountsList[indexPath.row]
        //        }
        //        else
        //        {
        //            if(isFiltering)
        //            {
        //                account = accountsForLoggedUserFiltered[indexPath.row]
        //            }
        //            else
        //            {
        //                account = accountsForLoggedUserOriginal[indexPath.row]
        //            }
        //        }
        
        let account:Account = tableViewDisplayData[indexPath.row + currentPageIndex!]
        
        let cell:AccountRowCell = tableView.dequeueReusableCell(withIdentifier: "accountRowCellID", for: indexPath) as! AccountRowCell
        cell.selectionStyle = .none
        cell.storeNameLabel.text = account.accountName
        cell.accountNumberLabel.text = account.accountNumber
        
        // Create Full shipping address
        
        
        let fullAddress = account.shippingStreet + " " + account.shippingCity + "," + " " + account.shippingState +  " " + account.shippingPostalCode
        cell.addressLabel.text = fullAddress
        
        cell.actionItemsLabel.text = String(account.actionItem)
        
        cell.netSalesAmountLabel.text = String(format: "$%.2f",account.totalCYR12NetSales)
        cell.pastDueAmountTextLabel.text = String(format: "$%.2f",account.pastDueAmountDouble)
        
        //Past due amount value is greater than 0 than only show indicator else hide it
        
        if account.pastDueAmountDouble <= 0.0 {
            cell.pastDueIndicatorImageView.isHidden = true
        }else {
             cell.pastDueIndicatorImageView.isHidden = false
        }
        
        cell.nextDeliveryDateLabel.text = account.nextDeliveryDate
    
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //        var account:Account = accountsForLoggedUserOriginal[indexPath.row]
        //        if(isSorting)
        //        {
        //            account = sortedAccountsList[indexPath.row]
        //        }
        //        else
        //        {
        //            if(isFiltering)
        //            {
        //                account = accountsForLoggedUserFiltered[indexPath.row]
        //            }
        //            else
        //            {
        //                account = accountsForLoggedUserOriginal[indexPath.row]
        //            }
        //        }
        
        let account:Account = tableViewDisplayData[indexPath.row  + currentPageIndex!]
        
        delegate?.pushTheScreenToDetailsScreen(accountData: account)
        FilterMenuModel.comingFromDetailsScreen = "YES"
    }
    
    
    // custom header for the section
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let headerCell:SortingCell = tableView.dequeueReusableCell(withIdentifier: "sortingCellID") as! SortingCell
        return headerCell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80.0;
    }
    
    
    
    
    
    
    /// <#Description#>
    ///
    /// - Parameter animated: <#animated description#>
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("Accounts List VC will appear")
        
        //self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("Accounts List VC will disappear")
    }
    
    //MARK:- Segue Methods
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailsScreenSegue" {
            let accountDetailsScreen = segue.destination as! AccountDetailsViewController
            accountDetailsScreen.accountDetailForLoggedInUser = selectedAccount
        }
    }
    
    
    // # MARK: Account List Sorting related
    @IBAction func sortAccountListByAccountName(_ sender: Any)
    {
        print("sortAccountListByAccountName")
        isSorting = true
        if(isFiltering == true)
        {
            if OrderOfAccountListItems.isAscending == "YES"{
                OrderOfAccountListItems.isAscending = "NO"
                sortedAccountsList = AccountSortUtility.sortByAccountNameAlphabetically(accountsListToBeSorted:accountsForLoggedUserFiltered, ascending: true)
            }
            else
            {
                OrderOfAccountListItems.isAscending = "YES"
                sortedAccountsList = AccountSortUtility.sortByAccountNameAlphabetically(accountsListToBeSorted:accountsForLoggedUserFiltered, ascending: false)
            }
        }
        else
        {
            if OrderOfAccountListItems.isAscending == "YES"{
                OrderOfAccountListItems.isAscending = "NO"
                sortedAccountsList = AccountSortUtility.sortByAccountNameAlphabetically(accountsListToBeSorted:accountsForLoggedUserOriginal, ascending: true)
                
            }
            else
            {
                OrderOfAccountListItems.isAscending = "YES"
                sortedAccountsList = AccountSortUtility.sortByAccountNameAlphabetically(accountsListToBeSorted:accountsForLoggedUserOriginal, ascending: false)
                
            }
        }
        
        //self.accountListTableView.reloadData()
        self.updateTheTableViewDataAccordingly()
        
    }
    
    @IBAction func sortAccountListByActionItems(_ sender: Any)
    {
        print("sortAccountListByActionItems")
        isSorting = true
        if(isFiltering == true)
        {
            if OrderOfAccountListItems.isAscendingActionItems == "YES"{
                OrderOfAccountListItems.isAscendingActionItems = "NO"
                sortedAccountsList =
                    AccountSortUtility.sortAccountsByActionItems(accountsListToBeSorted: accountsForLoggedUserFiltered, ascending: true)
            }
            else
            {
                OrderOfAccountListItems.isAscendingActionItems = "YES"
                sortedAccountsList =
                    AccountSortUtility.sortAccountsByActionItems(accountsListToBeSorted: accountsForLoggedUserFiltered, ascending: false)
            }
        }
        else
        {
            if OrderOfAccountListItems.isAscendingActionItems == "YES"{
                OrderOfAccountListItems.isAscendingActionItems = "NO"
                sortedAccountsList = AccountSortUtility.sortAccountsByActionItems(accountsListToBeSorted:accountsForLoggedUserOriginal, ascending: true)
                
            }
            else
            {
                OrderOfAccountListItems.isAscendingActionItems = "YES"
                sortedAccountsList = AccountSortUtility.sortAccountsByActionItems(accountsListToBeSorted:accountsForLoggedUserOriginal, ascending: false)
                
            }
        }
        
        //self.accountListTableView.reloadData()
        self.updateTheTableViewDataAccordingly()
    }
    
    @IBAction func sortAccountListByNetSales(_ sender: Any)
    {
        print("sortAccountListByNetSales")
        isSorting = true
        if(isFiltering == true)
        {
            if OrderOfAccountListItems.isAscendingNetSales == "YES"{
                OrderOfAccountListItems.isAscendingNetSales = "NO"
                sortedAccountsList =
                    AccountSortUtility.sortAccountsByTotalNetSales(accountsListToBeSorted: accountsForLoggedUserFiltered, ascending: true)
            }
            else
            {
                OrderOfAccountListItems.isAscendingNetSales = "YES"
                sortedAccountsList =
                    AccountSortUtility.sortAccountsByTotalNetSales(accountsListToBeSorted: accountsForLoggedUserFiltered, ascending: false)
            }
        }
        else
        {
            if OrderOfAccountListItems.isAscendingNetSales == "YES"{
                OrderOfAccountListItems.isAscendingNetSales = "NO"
                sortedAccountsList = AccountSortUtility.sortAccountsByTotalNetSales(accountsListToBeSorted:accountsForLoggedUserOriginal, ascending: true)
                
            }
            else
            {
                OrderOfAccountListItems.isAscendingNetSales = "YES"
                sortedAccountsList = AccountSortUtility.sortAccountsByTotalNetSales(accountsListToBeSorted:accountsForLoggedUserOriginal, ascending: false)
                
            }
        }
        
        //self.accountListTableView.reloadData()
        self.updateTheTableViewDataAccordingly()
    }
    
    @IBAction func sortAccountListByBalance(_ sender: Any)
    {
        print("sortAccountListByBalance")
        isSorting = true
        if(isFiltering == true)
        {
            if OrderOfAccountListItems.isAscendingBalance == "YES"{
                
                OrderOfAccountListItems.isAscendingBalance = "NO"
                sortedAccountsList =
                    AccountSortUtility.sortAccountsByBalance(accountsListToBeSorted: accountsForLoggedUserFiltered, ascending: true)
            }
            else
            {
                OrderOfAccountListItems.isAscendingBalance = "YES"
                sortedAccountsList =
                    AccountSortUtility.sortAccountsByBalance(accountsListToBeSorted: accountsForLoggedUserFiltered, ascending: false)
            }
        }
        else
        {
            if OrderOfAccountListItems.isAscendingBalance == "YES"{
                OrderOfAccountListItems.isAscendingBalance = "NO"
                
                sortedAccountsList = AccountSortUtility.sortAccountsByBalance(accountsListToBeSorted: accountsForLoggedUserOriginal, ascending: true)
            }
            else
            {
                OrderOfAccountListItems.isAscendingBalance = "YES"
                
                sortedAccountsList = AccountSortUtility.sortAccountsByBalance(accountsListToBeSorted: accountsForLoggedUserOriginal, ascending: false)
            }
        }
        
        //self.accountListTableView.reloadData()
        self.updateTheTableViewDataAccordingly()
    }
    
    @IBAction func sortAccountListByNextDelivery(_ sender: Any)
    {
        print("sortAccountListByNextDelivery")
        isSorting = true
        if(isFiltering == true)
        {
            if OrderOfAccountListItems.isAscendingNextDeliveryDate == "YES"{
                OrderOfAccountListItems.isAscendingNextDeliveryDate = "NO"
                sortedAccountsList =
                    AccountSortUtility.sortAccountsByNextDeliveryDate(accountsListToBeSorted: accountsForLoggedUserFiltered, ascending: true)
            }
            else
            {
                OrderOfAccountListItems.isAscendingNextDeliveryDate = "YES"
                sortedAccountsList =
                    AccountSortUtility.sortAccountsByNextDeliveryDate(accountsListToBeSorted: accountsForLoggedUserFiltered, ascending: false)
            }
        }
        else
        {
            if OrderOfAccountListItems.isAscendingNextDeliveryDate == "YES"{
                OrderOfAccountListItems.isAscendingNextDeliveryDate = "NO"
                sortedAccountsList = AccountSortUtility.sortAccountsByNextDeliveryDate(accountsListToBeSorted: accountsForLoggedUserOriginal, ascending: true)
            }
            else
            {
                OrderOfAccountListItems.isAscendingNextDeliveryDate = "YES"
                sortedAccountsList = AccountSortUtility.sortAccountsByNextDeliveryDate(accountsListToBeSorted: accountsForLoggedUserOriginal, ascending: false)
            }
        }
        
        //self.accountListTableView.reloadData()
        self.updateTheTableViewDataAccordingly()
    }
    
    // # MARK: sort by entered text
    func sortAccountsData(searchString: String)
    {
        isSorting = false
        print("AccountsListViewController sortAccountsData: " + searchString)
        if(isFiltering)
        {
            if(isSorting)
            {
                sortedAccountsList = AccountSortUtility.searchAccountBySearchBarQuery(accountsForLoggedUser: accountsForLoggedUserFiltered, searchText: searchString)
            }
            else
            {
                accountsForLoggedUserFiltered = AccountSortUtility.searchAccountBySearchBarQuery(accountsForLoggedUser: accountsForLoggedUserOriginal, searchText: searchString)
            }
        }
        else
        {
            sortedAccountsList = AccountSortUtility.searchAccountBySearchBarQuery(accountsForLoggedUser: accountsForLoggedUserOriginal, searchText: searchString)
        }
        
        //self.accountListTableView.reloadData()
        self.updateTheTableViewDataAccordingly()
    }
    
    func filtering(filtering: Bool)
    {
        isFiltering = filtering
        if(isFiltering == false)
        {
            isSorting = false
            if(isSorting)
            {
                sortedAccountsList = AccountSortUtility.sortByAccountNameAlphabetically(accountsListToBeSorted:accountsForLoggedUserOriginal, ascending: true)
            }
            //self.accountListTableView.reloadData()
            self.updateTheTableViewDataAccordingly()
            
            for count in 1...5 {
                pageButtonArr[count].setTitleColor(UIColor.black, for: .normal)
                pageButtonArr[count].backgroundColor = UIColor.white
            }
            pageButtonArr[1].backgroundColor = UIColor.lightGray
        }

    }
    
    
    
    //Use to update the table view data
    func updateTheTableViewDataAccordingly(){
        
        if(isSorting)
        {
            tableViewDisplayData = sortedAccountsList
        }
        else
        {
            if(isFiltering)
            {
                tableViewDisplayData = accountsForLoggedUserFiltered
            }
            else
            {
                tableViewDisplayData = accountsForLoggedUserOriginal
            }
        }
        
        initPageViewWith(inputArr: tableViewDisplayData, pageSize: kPageSize)
        updateUI()
        print("\(self.noOfPages!)")
        if(numberOfAccountRows > 0)
        {
            self.accountListTableView.scrollToRow(at: IndexPath.init(row: 0, section: 0), at: .top, animated: true)
        } else {
            for count in 1...5 {
                pageButtonArr[count].setTitleColor(UIColor.black, for: .normal)
                pageButtonArr[count].backgroundColor = UIColor.white
            }
            pageButtonArr[1].backgroundColor = UIColor.lightGray
//            pageButtonArr[1].setTitleColor(white, for: <#T##UIControlState#>)
        }
        
        //self.accountListTableView.reloadData()
        
    }
    
    
    
    
    
}

// # MARK: SortingCell
// sorting table view cell
class SortingCell: UITableViewCell
{
    
    @IBOutlet weak var SortByNextDeliveryView: UIView!
    @IBOutlet weak var SortByBalanceView: UIView!
    @IBOutlet weak var SortByNetSalesView: UIView!
    @IBOutlet weak var SortByActionItemsView: UIView!
    @IBOutlet weak var SortByAccountNameView: UIView!
}

// # MARK: AccountRowCell
// account row cell
class AccountRowCell: UITableViewCell
{
    @IBOutlet weak var storeNameLabel: UILabel!
    @IBOutlet weak var accountNumberLabel: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var actionItemsLabel: UILabel!
    @IBOutlet weak var netSalesAmountLabel: UILabel!
    @IBOutlet weak var pastDueIndicatorImageView: UIImageView!
    
    @IBOutlet weak var pastDueAmountLabel: UILabel!
    @IBOutlet weak var pastDueAmountTextLabel: UILabel!
    @IBOutlet weak var nextDeliveryDateLabel: UILabel!
}


//MARK:- PageControl Implementation
extension AccountsListViewController{
    
    
    enum Page: Int {
        case  previousLbl=0, oneLbl, twoLbl, threeLbl, fourLbl, fiveLbl, nextLbl,lastLbl,firstLbl
        case first = 100, previous, one, two, three, four, five, next,last
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
        
        accountListTableView.reloadData()
        
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
            currentPageIndex = currentPageIndex! + kPageSize * (kNoOfPagesInEachSet * byPageSet)
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
        
        switch sender.tag {
            
        case Page.first.rawValue:
            for i in 1...kNoOfPagesInEachSet {
                pageButtonArr[i].setTitle(String(i), for: .normal)
            }
            self.currentPageIndex = 0
            self.currentPageSet = 0
            
            updateUI()
            print ("First")
            print ("New \(self.currentPageIndex!)")
            
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
            let lastSetNo = (kNoOfPageSet!-1) * kNoOfPagesInEachSet
            for i in 1...kNoOfPagesInEachSet {
                pageButtonArr[i].setTitle(String(lastSetNo + i), for: .normal)
            }
            
            self.currentPageIndex = (kNoOfPageSet!-1) * kPageSize * kNoOfPagesInEachSet
            self.currentPageSet = kNoOfPageSet! - 1
            updateUI()
            print ("Last")
            print ("New \(self.currentPageIndex!)")
            
        default:
            break
        }
        
        
        //let tableViewData = accountsForLoggedUserOriginal[self.currentPageIndex!]
        //tableViewDisplayData = [tableViewData]
        
        if(numberOfAccountRows > 0)
        {
            accountListTableView.reloadData()
            self.accountListTableView.scrollToRow(at: IndexPath.init(row: 0, section: 0), at: .top, animated: true)
        }
        
    }
    
    func performFilterOperation(searchString: String) {
        //filteringFromLeftMenu = isFiltering
        accountsForLoggedUserFiltered = AccountSortUtility.filterAccountByAppliedFilter(accountsListToBeSorted: accountsForLoggedUserOriginal, searchBarText: searchString)
        self.updateTheTableViewDataAccordingly()
        
    }
}



