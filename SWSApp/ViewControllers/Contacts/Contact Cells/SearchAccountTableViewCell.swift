//
//  SearchAccountTableViewCell.swift
//  SWSApp
//
//  Created by manu.a.gupta on 30/04/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit
//import DropDown
import IQKeyboardManagerSwift

protocol SearchAccountTableViewCellDelegate: NSObjectProtocol {
    func accountSelected(account: Account)
}

class SearchAccountTableViewCell: UITableViewCell {

    @IBOutlet weak var searchContactTextField: DesignableUITextField!
    @IBOutlet weak var titleLabel: UILabel!
    var searchAccounts = [Account]()
    var searchAccountsString = [String]()
    let accountViewModel = AccountsViewModel()
    let accountsDropDown = DropDown()
    weak var delegate: SearchAccountTableViewCellDelegate!
    var search:String=""
    
    
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
//            cell.containerView.borderColor = .clear
            cell.deleteButton.isHidden = true
            cell.displayCellContent(account: self.searchAccounts[index])
            }
        accountsDropDown.cellHeight = 70
        accountsDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.delegate.accountSelected(account: self.searchAccounts[index])
            self.searchContactTextField.resignFirstResponder()
        }
        self.accountsDropDown.textFont = UIFont(name: "Ubuntu-Bold", size: 16)!
//        self.moreDropDown.textColor =  UIColor.gray
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
        return arr
    }
    
}

extension SearchAccountTableViewCell: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        ActionItemFilterModel.isAccountField = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            self.accountsDropDown.show()
        })
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if accountsDropDown != nil {
            accountsDropDown.hide()
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        searchAccounts = [Account]()
        searchAccountsString = [String]()
        if string.isEmpty{
            search = String(search.characters.dropLast())
        }else{
            search = textField.text!+string
        }
        if search == "" {
            searchAccounts = self.accountViewModel.accountsForLoggedUser
        }else{
            searchAccounts = self.getAccountData(searchStr: search)
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
