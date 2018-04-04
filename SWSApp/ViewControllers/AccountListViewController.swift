//
//  AccountListViewController.swift
//  SWSApp
//
//  Created by shilpa.a.kulkarni on 29/03/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit


protocol DetailsScreenDelegate : class {
    func pushTheScreenToDetailsScreen(accountData : Account)
}

/// <#Description#>
class AccountsListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var accountListTableView: UITableView!
    
    var delegate : DetailsScreenDelegate?
    
    let accountViewModel = AccountsViewModel()
    var accountsForLoggedUser = [Account]()
    
    var selectedAccount:Account?
    
    override func viewDidLoad() {
        accountsForLoggedUser = accountViewModel.accountsForLoggedUser
        print(accountsForLoggedUser.count)
    
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accountsForLoggedUser.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 200.0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        // get the account details from accountsForLoggedUser
        let account:Account = accountsForLoggedUser[indexPath.row]
        
        let cell:AccountRowCell = tableView.dequeueReusableCell(withIdentifier: "accountRowCellID", for: indexPath) as! AccountRowCell
        cell.selectionStyle = .none
        cell.storeNameLabel.text = account.name
        cell.accountNumberLabel.text = account.accountNumber
        cell.addressLabel.text = account.address
        cell.actionItemsLabel.text = String(account.actionItem)
        cell.netSalesAmountLabel.text = account.totalR12NetSales
        cell.pastDueAmountTextLabel.text = account.balance
        cell.nextDeliveryDateLabel.text = account.nextDelivery
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //delegate?.pushTheScreenToDetailsScreen(accountData: accountsForLoggedUser[indexPath.row])

        
        let accountDetailsVC = self.storyboard?.instantiateViewController(withIdentifier: "AccountDetailsViewControllerID") as! AccountDetailsViewController
        
        let accountsView = self.storyboard?.instantiateViewController(withIdentifier: "AccountsViewControllerID") as! AccountsViewController
        accountsView.view.addSubview(accountDetailsVC.view)
        
        
        
        accountDetailsVC.accountsForLoggedInUser = accountsForLoggedUser[indexPath.row]
        self.view.addSubview(accountDetailsVC.view)//present(accountDetailsVC, animated: false, completion: nil)
        
        
        //selectedAccount = accountsForLoggedUser[indexPath.row]
        //self.performSegue(withIdentifier: "detailsScreenSegue", sender: nil)
        
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
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat{
        return 0;
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
    }
    
    @IBAction func sortAccountListByActionItems(_ sender: Any)
    {
        print("sortAccountListByActionItems")
    }
    
    @IBAction func sortAccountListByNetSales(_ sender: Any)
    {
        print("sortAccountListByActionItems")
    }
    
    @IBAction func sortAccountListByBalance(_ sender: Any)
    {
        print("sortAccountListByBalance")
    }
    
    @IBAction func sortAccountListByNextDelivery(_ sender: Any)
    {
        print("sortAccountListByNextDelivery")
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

