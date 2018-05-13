//
//  SearchForContactTableViewCell.swift
//  SWSApp
//
//  Created by manu.a.gupta on 30/04/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit
import DropDown
import IQKeyboardManagerSwift

protocol SearchForContactTableViewCellDelegate: NSObjectProtocol {
    func contactSelected(contact: Contact)
}

class SearchForContactTableViewCell: UITableViewCell {
    
    @IBOutlet weak var searchContactTextField: DesignableUITextField!
    var searchContacts = [Contact]()
    var searchContactsString = [String]()
    let contactViewModel = ContactsViewModel()
    let contactDropDown = DropDown()
    weak var delegate: SearchForContactTableViewCellDelegate!
    var search:String=""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customizedUI()
        addingDropdown()
    }
    
    func addingDropdown(){
        contactDropDown.anchorView =  searchContactTextField
        contactDropDown.width = (UIScreen.main.bounds.width - 80)
        contactDropDown.dataSource = searchContactsString
        contactDropDown.bottomOffset = CGPoint(x: 0, y: searchContactTextField.frame.height)
        contactDropDown.backgroundColor = UIColor.white
        contactDropDown.direction = .bottom
        contactDropDown.cellNib = UINib(nibName: "ContactVisitLinkTableViewCell", bundle: nil)
        contactDropDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
            guard let cell = cell as? ContactVisitLinkTableViewCell else {
                return
            }
            cell.displayCellContent(contact: self.searchContacts[index])
        }
        contactDropDown.cellHeight = 80
        contactDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.delegate.contactSelected(contact: self.searchContacts[index])
            self.searchContactTextField.resignFirstResponder()
        }
        self.contactDropDown.textFont = UIFont(name: "Ubuntu-Bold", size: 16)!
    }
    
    func customizedUI(){
        searchContactsString = []
        searchContacts = []
        searchContacts = self.contactViewModel.globalContacts()
        for contact in searchContacts {
            searchContactsString.append(contact.name)
        }
        DropDown.startListeningToKeyboard()
        searchContactTextField.delegate = self
    }
    
    func getContactsData(searchStr: String) -> [Contact] {
        let contact = self.contactViewModel.globalContacts()
        let arr = contact.filter( { return $0.name.lowercased().contains(searchStr.lowercased()) } )
        print(arr)
        return arr
    }
    
}

extension SearchForContactTableViewCell: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        CreateNewVisitViewController.createNewVisitViewControllerGlobals.isContactField = true
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            self.contactDropDown.show()
            CreateNewVisitViewController.createNewVisitViewControllerGlobals.userInput = true
//        })
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
      
        CreateNewVisitViewController.createNewVisitViewControllerGlobals.isContactField = false
        textField.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        CreateNewVisitViewController.createNewVisitViewControllerGlobals.isContactField = false
        if contactDropDown != nil {
            contactDropDown.hide()
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        searchContacts = [Contact]()
        searchContactsString = [String]()
        if string.isEmpty{
            search = String(search.characters.dropLast())
        }else{
            search = textField.text!+string
        }
        if search == "" {
            searchContacts = self.contactViewModel.globalContacts()
        }else{
            searchContacts = self.getContactsData(searchStr: search)
        }
        for contact in searchContacts {
            searchContactsString.append(contact.name)
        }
        contactDropDown.dataSource = searchContactsString
        contactDropDown.reloadAllComponents()
        contactDropDown.show()
        return true
    }
}

