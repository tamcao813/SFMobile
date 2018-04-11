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
    static var isAscending = "YES"
    static var isAscendingActionItems = "YES"
    static var isAscendingNetSales = "YES"
    static var isAscendingBalance = "YES"
    static var isAscendingNextDeliveryDate = "YES"
}


/// <#Description#>
class AccountsListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SearchByEnteredTextDelegate{
    
    @IBOutlet weak var accountListTableView: UITableView!
    
    var delegate : DetailsScreenDelegate?
    
    let accountViewModel = AccountsViewModel()
    var accountsForLoggedUserOriginal = [Account]()
    
    var selectedAccount:Account?
    var isFiltering = false
    // filtered list
    var accountsForLoggedUserFiltered = [Account]()
    // sort related
    var isSorting = false
    var sortedAccountsList = [Account]()
    var ascendingSort = true // action item, net sale, balance, next delivery date
    
    override func viewDidLoad() {
        accountsForLoggedUserOriginal = AccountSortUtility.sortByAccountNameAlphabetically(accountsListToBeSorted:accountViewModel.accountsForLoggedUser, ascending: true)
        print(accountsForLoggedUserOriginal.count)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(isSorting)
        {
            return sortedAccountsList.count
        }
        else
        {
            if(isFiltering)
            {
                return accountsForLoggedUserFiltered.count
            }
            return accountsForLoggedUserOriginal.count
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 200.0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        // get the account details from accountsForLoggedUser
        var account:Account = accountsForLoggedUserOriginal[indexPath.row]
        if(isSorting)
        {
            account = sortedAccountsList[indexPath.row]
        }
        else
        {
            if(isFiltering)
            {
                account = accountsForLoggedUserFiltered[indexPath.row]
            }
            else
            {
                account = accountsForLoggedUserOriginal[indexPath.row]
            }
        }
        
        let cell:AccountRowCell = tableView.dequeueReusableCell(withIdentifier: "accountRowCellID", for: indexPath) as! AccountRowCell
        cell.selectionStyle = .none
        cell.storeNameLabel.text = account.accountName
        cell.accountNumberLabel.text = account.accountNumber
        cell.addressLabel.text = account.shippingAddress
        cell.actionItemsLabel.text = String(account.actionItem)
        cell.netSalesAmountLabel.text = String(format: "$%.1f",account.totalCYR12NetSales)
        cell.pastDueAmountTextLabel.text = String(format: "$%.1f",account.totalARBalance)
        // TODO: have to create utility method for this
        let dateFormatter = DateFormatter()
        //dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"// MM-DD-YYYY
        dateFormatter.dateFormat = "yyyy-MM-dd"// MM-DD-YYYY
        dateFormatter.timeZone = TimeZone(identifier:"UTC")
        cell.nextDeliveryDateLabel.text = dateFormatter.string(from: account.nextDeliveryDate)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        var account:Account = accountsForLoggedUserOriginal[indexPath.row]
        if(isSorting)
        {
            account = sortedAccountsList[indexPath.row]
        }
        else
        {
            if(isFiltering)
            {
                account = accountsForLoggedUserFiltered[indexPath.row]
            }
            else
            {
                account = accountsForLoggedUserOriginal[indexPath.row]
            }
        }
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
            accountDetailsScreen.accountsForLoggedInUser = selectedAccount
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
        
        self.accountListTableView.reloadData()
        
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
        
        self.accountListTableView.reloadData()
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
        
        self.accountListTableView.reloadData()
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
        
        self.accountListTableView.reloadData()
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
        
        self.accountListTableView.reloadData()
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
        
        self.accountListTableView.reloadData()
        
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
            self.accountListTableView.reloadData()
        }
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

