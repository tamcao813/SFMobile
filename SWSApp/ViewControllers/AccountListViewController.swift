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
    func dismissKeyBoard()
}

struct ScreenLoadFromParent {
    static var loadedFromParent = "NO"
}

class AccountsListViewController: UIViewController {
    
    @IBOutlet weak var accountListTableView: UITableView!
    
    var delegate : DetailsScreenDelegate?
    
    let accountViewModel = AccountsViewModel()
    // sorting flags
    var isAscendingAccountName = false
    var isAscendingActionItems = false
    var isAscendingNetSales = false
    var isAscendingBalance = false
    var isAscendingNextDeliveryDate = false
    
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
    
    
    //MARK:- ViewLifeCycle
    override func viewDidLoad() {
        
       
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.reloadAllAccounts), name: NSNotification.Name("showAllAccounts"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.refreshAccountItemList), name: NSNotification.Name("reloadAccountsData"), object: nil)
        self.reloadAllAccountListData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let currentUserId = UserViewModel().selectedUserId
        print("AccountListviewcontroller currentSelectedUserId: " + currentUserId)
        
        //self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    //MARK:-
    //Reload all the Account List Data
    func reloadAllAccountListData(){
        //isAscending = true
        accountsForLoggedUserOriginal = AccountSortUtility.sortByAccountNameAlphabetically(accountsListToBeSorted:accountViewModel.accountsForLoggedUser(), ascending: true)
        print(accountsForLoggedUserOriginal.count)
        
        tableViewDisplayData = accountsForLoggedUserOriginal
        
        if accountsForLoggedUserOriginal.count > 0 {
            pageButtonArr[1].backgroundColor = UIColor.lightGray
            pageButtonArr[1].setTitleColor(UIColor.white, for: .normal)
        }
        
        initPageViewWith(inputArr: tableViewDisplayData, pageSize: kPageSize)
        DispatchQueue.main.async {
           self.accountListTableView.reloadData()
             self.updateUI()
            
        }
       
        
    }
    
    @objc func refreshAccountItemList(notification: NSNotification){
        self.reloadAllAccountListData()
        DispatchQueue.main.async {
            self.accountListTableView.reloadData()
            self.updateUI()
            
        }
    }
    
    //Account List Notification
    @objc func reloadAllAccounts(notification: NSNotification){
        
        if FilterMenuModel.selectedAccountId != "" {
            let accountList: [Account]? = AccountSortUtility.searchAccountByAccountId(accountsForLoggedUser: AccountsViewModel().accountsForLoggedUser(), accountId: FilterMenuModel.selectedAccountId)
            guard accountList != nil, (accountList?.count)! > 0  else {
                return;
            }
            delegate?.pushTheScreenToDetailsScreen(accountData: accountList![0])
            FilterMenuModel.selectedAccountId = ""
        }
    }
    
    //MARK:- Segue Methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailsScreenSegue" {
            let accountDetailsScreen = segue.destination as! AccountDetailsViewController
            accountDetailsScreen.accountDetailForLoggedInUser = selectedAccount
        }
    }
    
    //MARK:- IBAction Methods
    //Sort by Account Name
    @IBAction func sortAccountListByAccountName(_ sender: Any)
    {
        print("sortAccountListByAccountName")
        isSorting = true
        if(isFiltering == true)
        {
            if isAscendingAccountName == true{
                isAscendingAccountName = false
                sortedAccountsList = AccountSortUtility.sortByAccountNameAlphabetically(accountsListToBeSorted:accountsForLoggedUserFiltered, ascending: true)
            }
            else
            {
                isAscendingAccountName = true
                sortedAccountsList = AccountSortUtility.sortByAccountNameAlphabetically(accountsListToBeSorted:accountsForLoggedUserFiltered, ascending: false)
            }
        }
        else
        {
            if isAscendingAccountName == true{
                isAscendingAccountName = false
                sortedAccountsList = AccountSortUtility.sortByAccountNameAlphabetically(accountsListToBeSorted:accountsForLoggedUserOriginal, ascending: true)
                
            }
            else
            {
                isAscendingAccountName = true
                sortedAccountsList = AccountSortUtility.sortByAccountNameAlphabetically(accountsListToBeSorted:accountsForLoggedUserOriginal, ascending: false)
                
            }
        }
        
        //self.accountListTableView.reloadData()
        self.updateTheTableViewDataAccordingly()
        
    }
    
    //Sort by Action Item
    @IBAction func sortAccountListByActionItems(_ sender: Any)
    {
        print("sortAccountListByActionItems")
        isSorting = true
        if(isFiltering == true)
        {
            if isAscendingActionItems == true{
                isAscendingActionItems = false
                sortedAccountsList =
                    AccountSortUtility.sortAccountsByActionItems(accountsListToBeSorted: accountsForLoggedUserFiltered, ascending: true)
            }
            else
            {
                isAscendingActionItems = true
                sortedAccountsList =
                    AccountSortUtility.sortAccountsByActionItems(accountsListToBeSorted: accountsForLoggedUserFiltered, ascending: false)
            }
        }
        else
        {
            if isAscendingActionItems == true{
                isAscendingActionItems = false
                sortedAccountsList = AccountSortUtility.sortAccountsByActionItems(accountsListToBeSorted:accountsForLoggedUserOriginal, ascending: true)
                
            }
            else
            {
                isAscendingActionItems = true
                sortedAccountsList = AccountSortUtility.sortAccountsByActionItems(accountsListToBeSorted:accountsForLoggedUserOriginal, ascending: false)
                
            }
        }
        
        //self.accountListTableView.reloadData()
        self.updateTheTableViewDataAccordingly()
    }
    
    //Sort by NetSales
    @IBAction func sortAccountListByNetSales(_ sender: Any)
    {
        print("sortAccountListByNetSales")
        isSorting = true
        if(isFiltering == true)
        {
            if isAscendingNetSales == true{
                isAscendingNetSales = false
                sortedAccountsList =
                    AccountSortUtility.sortAccountsByTotalNetSales(accountsListToBeSorted: accountsForLoggedUserFiltered, ascending: true)
            }
            else
            {
                isAscendingNetSales = true
                sortedAccountsList =
                    AccountSortUtility.sortAccountsByTotalNetSales(accountsListToBeSorted: accountsForLoggedUserFiltered, ascending: false)
            }
        }
        else
        {
            if isAscendingNetSales == true{
                isAscendingNetSales = false
                sortedAccountsList = AccountSortUtility.sortAccountsByTotalNetSales(accountsListToBeSorted:accountsForLoggedUserOriginal, ascending: true)
                
            }
            else
            {
                isAscendingNetSales = true
                sortedAccountsList = AccountSortUtility.sortAccountsByTotalNetSales(accountsListToBeSorted:accountsForLoggedUserOriginal, ascending: false)
                
            }
        }
        
        //self.accountListTableView.reloadData()
        self.updateTheTableViewDataAccordingly()
    }
    
    //Sort by Balence
    @IBAction func sortAccountListByBalance(_ sender: Any)
    {
        print("sortAccountListByBalance")
        isSorting = true
        if(isFiltering == true)
        {
            if isAscendingBalance == true{
                
                isAscendingBalance = false
                sortedAccountsList =
                    AccountSortUtility.sortAccountsByBalance(accountsListToBeSorted: accountsForLoggedUserFiltered, ascending: true)
            }
            else
            {
                isAscendingBalance = true
                sortedAccountsList =
                    AccountSortUtility.sortAccountsByBalance(accountsListToBeSorted: accountsForLoggedUserFiltered, ascending: false)
            }
        }
        else
        {
            if isAscendingBalance == true{
                isAscendingBalance = false
                
                
                sortedAccountsList = AccountSortUtility.sortAccountsByBalance(accountsListToBeSorted: accountsForLoggedUserOriginal, ascending: true)
            }
            else
            {
                isAscendingBalance = true
                
                sortedAccountsList = AccountSortUtility.sortAccountsByBalance(accountsListToBeSorted: accountsForLoggedUserOriginal, ascending: false)
            }
        }
        
        //self.accountListTableView.reloadData()
        self.updateTheTableViewDataAccordingly()
    }
    
    //Sort by Next Delivery Date
    @IBAction func sortAccountListByNextDelivery(_ sender: Any)
    {
        print("sortAccountListByNextDelivery")
        isSorting = true
        if(isFiltering == true)
        {
            if isAscendingNextDeliveryDate == true{
                isAscendingNextDeliveryDate = false
                sortedAccountsList =
                    AccountSortUtility.sortAccountsByNextDeliveryDate(accountsListToBeSorted: accountsForLoggedUserFiltered, ascending: true)
            }
            else
            {
                isAscendingNextDeliveryDate = true
                sortedAccountsList =
                    AccountSortUtility.sortAccountsByNextDeliveryDate(accountsListToBeSorted: accountsForLoggedUserFiltered, ascending: false)
            }
        }
        else
        {
            if isAscendingNextDeliveryDate == true{
                isAscendingNextDeliveryDate = false
                sortedAccountsList = AccountSortUtility.sortAccountsByNextDeliveryDate(accountsListToBeSorted: accountsForLoggedUserOriginal, ascending: true)
            }
            else
            {
                isAscendingNextDeliveryDate = true
                sortedAccountsList = AccountSortUtility.sortAccountsByNextDeliveryDate(accountsListToBeSorted: accountsForLoggedUserOriginal, ascending: false)
            }
        }
        
        //self.accountListTableView.reloadData()
        self.updateTheTableViewDataAccordingly()
    }
    
    //Navigate to Details Screen
    @objc func navigateToDetailsScreen(){
        
        if ScreenLoadFromParent.loadedFromParent == "YES"{
            ScreenLoadFromParent.loadedFromParent = "NO"
            
            if tableViewDisplayData.count > 0{
                let account:Account = tableViewDisplayData[0]
                delegate?.pushTheScreenToDetailsScreen(accountData: account)
            }
        }
    }
    
    //Sort by entered text
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
    
    //Used to check wheather to perform Filter by search or only Filter
    func filtering(filtering: Bool)
    {
        isFiltering = filtering
        isSorting = false
        if(isFiltering == false)
        {
            /*isSorting = false
             if(isSorting)
             {
             sortedAccountsList = AccountSortUtility.sortByAccountNameAlphabetically(accountsListToBeSorted:accountsForLoggedUserOriginal, ascending: true)
             }*/
            //self.accountListTableView.reloadData()
            self.updateTheTableViewDataAccordingly()
        }
        
        //if isSorting == false{
        for count in 1...5 {
            pageButtonArr[count].setTitleColor(UIColor.black, for: .normal)
            pageButtonArr[count].backgroundColor = UIColor.white
            pageButtonArr[count].setTitle(String(count), for: .normal)
        }
        pageButtonArr[1].backgroundColor = UIColor.lightGray
        pageButtonArr[1].setTitleColor(UIColor.white, for: .normal)
        //}
    }
    
    //Use to update the table view data
    func updateTheTableViewDataAccordingly(){
        
        delegate?.dismissKeyBoard()
        
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
        
        if(numberOfAccountRows > 0){
            self.accountListTableView.scrollToRow(at: IndexPath.init(row: 0, section: 0), at: .top, animated: true)
        }
        for count in 1...5 {
            pageButtonArr[count].setTitleColor(UIColor.black, for: .normal)
            pageButtonArr[count].backgroundColor = UIColor.white
            pageButtonArr[count].setTitle(String(count), for: .normal)
        }
        pageButtonArr[1].backgroundColor = UIColor.lightGray
        pageButtonArr[1].setTitleColor(UIColor.white, for: .normal)
        
    }
}

//MARK:- SortingCell
// sorting table view cell
class SortingCell: UITableViewCell
{
    @IBOutlet weak var SortByNextDeliveryView: UIView!
    @IBOutlet weak var SortByBalanceView: UIView!
    @IBOutlet weak var SortByNetSalesView: UIView!
    @IBOutlet weak var SortByActionItemsView: UIView!
    @IBOutlet weak var SortByAccountNameView: UIView!
}

//MARK:- AccountRowCell
//account row cell
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
    @IBOutlet weak var percentR12NetSales: UIButton!
    
}

//MARK:- PageControl Implementation
extension AccountsListViewController{
    enum Page: Int {
        case  previousLbl=0, oneLbl, twoLbl, threeLbl, fourLbl, fiveLbl, nextLbl,lastLbl,firstLbl
        case first = 100, previous, one, two, three, four, five, next,last
    }
    
    //Initialize the Page with the Pagination
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
        
        accountListTableView.reloadData()
    }
    
    //Disable the button for the available items
    func disableBtn(from:Int, to:Int) {
        for i in from...to {
            pageButtonArr[i].isEnabled = false
            isDisabledPreviously = true
        }
    }
    
    //Enable the button for the available items
    func enableBtn(from:Int, to:Int) {
        for i in from...to {
            pageButtonArr[i].isEnabled = true
        }
    }
    
    //Used to change the button text title
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
    
    //Used to update the UI Based the User Input
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
    
    //Pagination Button Action
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
        
        self.changePaginationTitleText(sender: sender.tag)
        
        //let tableViewData = accountsForLoggedUserOriginal[self.currentPageIndex!]
        //tableViewDisplayData = [tableViewData]
        
        if(numberOfAccountRows > 0) {
            accountListTableView.reloadData()
            self.accountListTableView.scrollToRow(at: IndexPath.init(row: 0, section: 0), at: .top, animated: true)
        }
    }
    
    //Used to change the pagination Title Text
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
    
    //Used to setup the first pagination button
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
    
    //Used to setup last Pagination Button
    func setupLastPageButton(){
        self.setCurrentPageIndex()
        self.currentPageIndex = (kNoOfPageSet!-1) * kPageSize * kNoOfPagesInEachSet
        self.currentPageSet = kNoOfPageSet! - 1
        updateUI()
        print ("Last")
        print ("New \(self.currentPageIndex!)")
    }
    
    //Used to set the current page index
    func setCurrentPageIndex(){
        let lastSetNo = (kNoOfPageSet!-1) * kNoOfPagesInEachSet
        for i in 1...kNoOfPagesInEachSet {
            pageButtonArr[i].setTitle(String(lastSetNo + i), for: .normal)
        }
    }
}

//MARK:- SearchByEnteredText Delegate
extension AccountsListViewController : SearchByEnteredTextDelegate{
    
    func performFilterOperation(searchString: String) {
        //filteringFromLeftMenu = isFiltering
        accountsForLoggedUserFiltered = AccountSortUtility.filterAccountByAppliedFilter(accountsListToBeSorted: accountsForLoggedUserOriginal, searchBarText: searchString)
        self.updateTheTableViewDataAccordingly()
    }
}

//MARK:- UITableView DataSource
extension AccountsListViewController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
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
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80.0;
    }
    
    // custom header for the section
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
        let headerCell:SortingCell = tableView.dequeueReusableCell(withIdentifier: "sortingCellID") as! SortingCell
        return headerCell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let account:Account = tableViewDisplayData[indexPath.row + currentPageIndex!]
        
        let cell:AccountRowCell = tableView.dequeueReusableCell(withIdentifier: "accountRowCellID", for: indexPath) as! AccountRowCell
        cell.selectionStyle = .none
        cell.storeNameLabel.text = account.accountName
        cell.accountNumberLabel.text = account.accountNumber
        cell.actionItemsLabel.text = String(account.actionItem) 
        //cell.percentR12NetSales.setTitle("150 " + "%", for: .normal)
        
        // Create Full shipping address
        var fullAddress = ""
        if account.shippingStreet == "" && account.shippingCity == "" && account.shippingState == "" && account.shippingPostalCode == "" {
            fullAddress = account.shippingStreet + " " + account.shippingCity + " " + account.shippingState +  " " + account.shippingPostalCode
            
        }else{
            if (account.shippingStreet != "" || account.shippingCity != "") {
                if (account.shippingState != "" || account.shippingPostalCode != "") {
                    fullAddress = account.shippingStreet + " " + account.shippingCity + "," + " " + account.shippingState +  " " + account.shippingPostalCode
                }else{
                    fullAddress = account.shippingStreet + " " + account.shippingCity + " " + account.shippingState +  " " + account.shippingPostalCode
                }
            }else{
                fullAddress = account.shippingStreet + " " + account.shippingCity + " " + account.shippingState +  " " + account.shippingPostalCode
            }
        }
        cell.addressLabel.text = fullAddress
    
        cell.netSalesAmountLabel.text = CurrencyFormatter.convertToCurrencyFormat(amountToConvert: account.totalCYR12NetSales)
        
        cell.pastDueAmountTextLabel.text = CurrencyFormatter.convertToCurrencyFormat(amountToConvert: account.pastDueAmountDouble) //String(format: "$%.2f",account.pastDueAmountDouble)
        
        //Past due amount value is greater than 0 than only show indicator else hide it
        
        if account.pastDueAmountDouble <= 0.0 {
            cell.pastDueIndicatorImageView.isHidden = true
        }else {
            cell.pastDueIndicatorImageView.isHidden = false
        }
        
        cell.nextDeliveryDateLabel.text = DateTimeUtility.getDDMMYYYFormattedDateString(dateStringfromAccountObject: account.nextDeliveryDate)
        
        let percLastYearR12DivideBy100:Double = ((account.percentageLastYearR12NetSales)as NSString).doubleValue / 100
        let percentYearR12Double:Double =  ((account.percentageLastYearR12NetSales)as NSString).doubleValue
            
            let titleForButton = String(format: "%.02f",percentYearR12Double) + "%"
            
            if percLastYearR12DivideBy100 < 0.80 {
                cell.percentR12NetSales?.setTitle(titleForButton, for: .normal)
                cell.percentR12NetSales?.backgroundColor = UIColor(named: "Bad")
            }else if percLastYearR12DivideBy100 >= 0.80 && percLastYearR12DivideBy100 <= 0.99 {
                cell.percentR12NetSales?.setTitle(titleForButton, for: .normal)
                cell.percentR12NetSales?.backgroundColor = UIColor(named: "Medium Alert")
            }
            else if percLastYearR12DivideBy100 > 0.99 {
                cell.percentR12NetSales?.setTitle(titleForButton, for: .normal)
                cell.percentR12NetSales?.backgroundColor = UIColor(named: "Good")
            }
        return cell
    }
}

//MARK:- UITableView Delegate
extension AccountsListViewController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let account:Account = tableViewDisplayData[indexPath.row  + currentPageIndex!]
        
        delegate?.pushTheScreenToDetailsScreen(accountData: account)
        FilterMenuModel.comingFromDetailsScreen = "YES"
    }
}






