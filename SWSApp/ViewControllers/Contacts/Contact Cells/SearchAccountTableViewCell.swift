//
//  SearchAccountTableViewCell.swift
//  SWSApp
//
//  Created by manu.a.gupta on 30/04/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit
import DropDown

protocol SearchAccountTableViewCellDelegate: NSObjectProtocol {
    func accountSelected(account: Account)
}

class SearchAccountTableViewCell: UITableViewCell {

    @IBOutlet weak var searchContactTextField: DesignableUITextField!
    var searchAccounts = [Account]()
    var searchAccountsString = [String]()
    let accountViewModel = AccountsViewModel()
    let accountsDropDown = DropDown()
    weak var delegate: SearchAccountTableViewCellDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customizedUI()
        addingDropdown()
    }
    
    func addingDropdown(){
        accountsDropDown.anchorView =  searchContactTextField
        accountsDropDown.width = (UIScreen.main.bounds.width - 80)
        accountsDropDown.dataSource = searchAccountsString
        accountsDropDown.bottomOffset = CGPoint(x: 0, y: searchContactTextField.frame.height)
        accountsDropDown.backgroundColor = UIColor.white
        accountsDropDown.direction = .bottom
        accountsDropDown.cellNib = UINib(nibName: "AccountContactLinkTableViewCell", bundle: nil)
        accountsDropDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
                guard let cell = cell as? AccountContactLinkTableViewCell else { return }
            cell.deleteButton.isHidden = true
            cell.displayCellContent(account: self.searchAccounts[index])
            }
        accountsDropDown.cellHeight = 100
        accountsDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.delegate.accountSelected(account: self.searchAccounts[index])
            self.searchContactTextField.resignFirstResponder()
        }
    }
    
    func customizedUI(){
        searchAccountsString = []
        searchAccounts = []
        searchAccounts = self.accountViewModel.accountsForLoggedUser
        for account in searchAccounts {
            searchAccountsString.append(account.accountName)
        }
        DropDown.startListeningToKeyboard()
        searchContactTextField.delegate = self
    }
        
    func getAccountData(searchStr: String) -> [Account] {
        let account = self.accountViewModel.accountsForLoggedUser
        let arr = account.filter( { return $0.accountName.lowercased().contains(searchStr.lowercased()) } )
        print(arr)
        return arr
    }
    
}

extension SearchAccountTableViewCell: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        accountsDropDown.show()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        print(textField.text)
        searchAccounts = [Account]()
        searchAccountsString = [String]()
        let searchString = searchContactTextField.text! + string
        if searchString == "" {
            searchAccounts = self.accountViewModel.accountsForLoggedUser
        }else{
            searchAccounts = self.getAccountData(searchStr: searchString)
        }
        for account in searchAccounts {
            searchAccountsString.append(account.accountName)
        }
        accountsDropDown.dataSource = searchAccountsString
        accountsDropDown.reloadAllComponents()
        accountsDropDown.show()
        return true
    }
}
