//
//  SearchAccountTableViewCell.swift
//  SWSApp
//
//  Created by manu.a.gupta on 30/04/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class SearchAccountTableViewCell: UITableViewCell {

    @IBOutlet weak var searchContactTextField: DesignableUITextField!
    @IBOutlet weak var accountsTableView: UITableView!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    var searchAccounts = [Account]()
    let accountViewModel = AccountsViewModel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customizedUI()
    }
    
    func customizedUI(){        
        accountsTableView.register(UINib(nibName: "LocationTableViewCell", bundle: nil), forCellReuseIdentifier: "LocationTableViewCell")
        searchAccounts = self.accountViewModel.accountsForLoggedUser
        accountsTableView.delegate = self
        accountsTableView.dataSource = self
        searchContactTextField.delegate = self
    }
    
    
    func getAccountData(searchStr: String) -> [Account] {
        let account = self.accountViewModel.accountsForLoggedUser
        let arr = account.filter( { return $0.accountName.contains(searchStr) } )
        return arr
    }
    
}

extension SearchAccountTableViewCell: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        heightConstraint.constant = 200
        self.setNeedsLayout()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.isEmpty {
            searchAccounts = self.accountViewModel.accountsForLoggedUser
            accountsTableView.reloadData()
        } else {
            searchAccounts = self.getAccountData(searchStr: string)
            accountsTableView.reloadData()
        }
        return true
    }
}

extension SearchAccountTableViewCell: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchAccounts.count;
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: LocationTableViewCell = tableView.dequeueReusableCell(withIdentifier: "LocationTableViewCell") as! LocationTableViewCell
//        let account = searchAccounts[indexPath.row]
//        cell.accountLabel.text = account.accountName
//        cell.phoneNumberLabel.text = account.phone
//        cell.addressLabel.text = account.shippingStreet + " " + account.shippingCity + " " + account.shippingPostalCode
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        searchContactTextField.text = values[indexPath.row]
//        tableView.isHidden = true
//        searchContactTextField.endEditing(true)
    }
}
