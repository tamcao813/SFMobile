//
//  PlanVisitViewController.swift
//  SWSApp
//
//  Created by vipin.vijay on 19/04/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

let kAccountTxtTag = 100
let kContactTxtTag = 101
let kSelectedContactTag = 102

class PlanVisitViewController: UIViewController {

    var associatedSelectedContact = [Contact]()
    private var myTableView: UITableView!
    private var associatedContactTableView: UITableView!
    var textFieldTag: Int = 0
    var accountID: String = ""
    let accountViewModel = AccountsViewModel()
    var conatctViewModel = ContactsViewModel()
    
    // MARK:- IBOutlets
    
    @IBOutlet var searchAccountLbl: UILabel!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var planLbl: UILabel!
    @IBOutlet var bottomView: UIView!
    @IBOutlet var searchAccountTxt: DesignableUITextField!
    @IBOutlet var searchContactTxt: DesignableUITextField!
    @IBOutlet var schedulerComponentView: SchedulerComponent!
    
    // MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Plan VC viewDidLoad")
        
        
        for account in accountViewModel.accountsForLoggedUser {
            print("globalAccountForList", account.accountName)
        }
        
        for contact in conatctViewModel.globalContacts() {
            print("globalContactsForList", contact.name)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(PlanVisitViewController.closeView(notification:)), name: Notification.Name("CLOSEACCOUNTVIEW"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(PlanVisitViewController.removeAssociate(notification:)), name: Notification.Name("REMOVEASSOCIATE"), object: nil)
        
        self.associatedContactTableView = UITableView(frame: CGRect(x: 10, y: 300, width: self.searchAccountTxt.frame.size.width, height: 206))
        self.associatedContactTableView.register(UINib(nibName: "SelectedAssociateTableViewCell", bundle: nil), forCellReuseIdentifier: "SelectedAssociateTableViewCell")
        
        self.associatedContactTableView.separatorStyle = UITableViewCellSeparatorStyle.none
        self.associatedContactTableView.dataSource = self
        self.associatedContactTableView.delegate = self
        self.scrollView.addSubview(self.associatedContactTableView)
        self.associatedContactTableView.isHidden = true
        self.textFieldTag = kSelectedContactTag
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("Plan VC will appear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("Plan VC will disappear")
    }
    
    // MARK:- Notification
    
    @objc func removeAssociate(notification: Notification){
        //Take Action on Notification
        print("hi")
        if let userInfo = notification.userInfo // or use if you know the type  [AnyHashable : Any]
        {
            if let tag = userInfo["tag"] as? Int {
                self.associatedSelectedContact.remove(at: tag)
                self.associatedContactTableView.reloadData()
                if (self.associatedSelectedContact.count > 0) {
                    self.associatedContactTableView.frame = CGRect(x: self.searchContactTxt.frame.origin.x, y: self.searchContactTxt.frame.origin.y + self.searchContactTxt.frame.size.height + 40, width: self.searchContactTxt.frame.size.width, height: CGFloat(62 * self.associatedSelectedContact.count))
                    
                    self.bottomView.frame = CGRect(x: 0, y: self.associatedContactTableView.frame.origin.y +  self.associatedContactTableView.frame.size.height + 20, width: self.bottomView.frame.size.width, height: self.bottomView.frame.size.height)
                    
                    self.scrollView.contentSize = CGSize(width: self.scrollView.frame.size.width, height: self.scrollView.frame.size.height + CGFloat(62 * self.associatedSelectedContact.count) + 40)
                } else {
                    self.associatedContactTableView.isHidden = true
                    
                    self.bottomView.frame = CGRect(x: 0, y: self.searchContactTxt.frame.origin.y +  self.searchContactTxt.frame.size.height + 20, width: self.bottomView.frame.size.width, height: self.bottomView.frame.size.height)
                    
                    self.scrollView.contentSize = CGSize(width: self.scrollView.frame.size.width, height: self.scrollView.frame.size.height)
                }
            }
        }
    }
    
    @objc func closeView(notification: Notification){
        //Take Action on Notification
        self.searchAccountLbl.isHidden = false
        self.searchAccountTxt.isHidden = false
        self.myTableView.removeFromSuperview()
    }
    
    // MARK:- IBAction
    
    @IBAction func closeVC(sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    // MARK:- Custom Methods
    
    func getNonSelectedContacts() -> [Contact] {
        var tempContacts = conatctViewModel.contacts(forAccount: accountID)
        for selectedContact in associatedSelectedContact {
            for contact in tempContacts {
                if (contact.contactId == selectedContact.contactId)
                {
                    if let index = tempContacts.enumerated().filter( { $0.element === contact }).map({ $0.offset }).first {
                        tempContacts.remove(at: index)
                    }
                }
            }
        }
        return tempContacts
    }
}
    
    // MARK:- UITableView Datasource

    extension PlanVisitViewController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count: Int = 0
        if(textFieldTag == kSelectedContactTag) {
            count = associatedSelectedContact.count
        } else if(textFieldTag == kAccountTxtTag) {
            count = accountViewModel.accountsForLoggedUser.count
        } else if(textFieldTag == kContactTxtTag) {
            
        var tempContacts = conatctViewModel.contacts(forAccount: accountID)
            
        for selectedContact in associatedSelectedContact {
            for contact in tempContacts {
                if (contact.contactId == selectedContact.contactId)
                {
                    if let index = tempContacts.enumerated().filter( { $0.element === contact }).map({ $0.offset }).first {
                        tempContacts.remove(at: index)
                    }
                }
            }
        }
            
            count = conatctViewModel.contacts(forAccount: accountID).count
        }
        return count
    }
}
    
    // MARK:- UITableView Delegates

    extension PlanVisitViewController : UITableViewDelegate {
    
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            if(textFieldTag == kAccountTxtTag) {
                let cell: AccountTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath) as! AccountTableViewCell
                let account = accountViewModel.accountsForLoggedUser[indexPath.row]
                cell.accountLabel.text = account.accountName
                cell.phoneNumberLabel.text = account.phone
                cell.addressLabel.text = account.shippingStreet + " " + account.shippingCity + " " + account.shippingPostalCode
                return cell
            } else if(textFieldTag == kContactTxtTag) {
                let cell: AssociateTableViewCell = tableView.dequeueReusableCell(withIdentifier: "AssociateTableViewCell", for: indexPath as IndexPath) as! AssociateTableViewCell
                let contacts = conatctViewModel.contacts(forAccount: accountID)[indexPath.row]
                cell.nameLabel.text = contacts.name
                cell.emailAddrLabel.text = contacts.email
                cell.phoneNumLabel.text = contacts.phoneuNmber
                cell.roleLabel.text = contacts.functionRole
                return cell
            } else {
                let cell: SelectedAssociateTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SelectedAssociateTableViewCell", for: indexPath as IndexPath) as! SelectedAssociateTableViewCell
                cell.removeButton.tag = indexPath.row
                return cell
            }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Num: \(indexPath.row)")
        
        UIView.animate(withDuration: 1.0, animations: {
            self.myTableView.alpha = 0
        }) { _ in
            self.myTableView.removeFromSuperview()
            if(self.textFieldTag == kAccountTxtTag) {
                self.searchAccountLbl.isHidden = true
                self.searchAccountTxt.isHidden = true
                
                let accountView = AccountView(frame: CGRect(x: self.planLbl.frame.origin.x - 20, y:
                    self.planLbl.frame.origin.y + 20, width: self.searchAccountTxt.frame.size.width, height: 100))
                let account = self.accountViewModel.accountsForLoggedUser[indexPath.row]
                self.accountID = account.account_Id
                accountView.accountLabel.text = account.accountName
                accountView.phoneNumberLabel.text = account.phone
                accountView.addressLabel.text = account.shippingStreet + " " + account.shippingCity + " " + account.shippingPostalCode
                self.scrollView.addSubview(accountView)
            } else if(self.textFieldTag == kContactTxtTag) {
                self.textFieldTag = kSelectedContactTag
                let contacts = self.conatctViewModel.contacts(forAccount: self.accountID)[indexPath.row]
                self.associatedSelectedContact.append(contacts)
                self.associatedContactTableView.isHidden = false
                self.associatedContactTableView.reloadData()
                
                self.associatedContactTableView.frame = CGRect(x: self.searchContactTxt.frame.origin.x, y: self.searchContactTxt.frame.origin.y + self.searchContactTxt.frame.size.height + 40, width: self.searchContactTxt.frame.size.width, height: CGFloat(62 * self.associatedSelectedContact.count))
                
                self.bottomView.frame = CGRect(x: 0, y: self.associatedContactTableView.frame.origin.y +  self.associatedContactTableView.frame.size.height + 20, width: self.bottomView.frame.size.width, height: self.bottomView.frame.size.height)
                
                self.scrollView.contentSize = CGSize(width: self.scrollView.frame.size.width, height: self.scrollView.frame.size.height + CGFloat(62 * self.associatedSelectedContact.count) + 40)
                }
            }
        }
    
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
        {
        return 62.0;//Choose your custom row height
        }
    }
    
    // MARK:- TextFieldDelegates

    extension PlanVisitViewController : UITextFieldDelegate{
    
        func textFieldDidBeginEditing(_ textField: UITextField) {
            myTableView = UITableView(frame: CGRect(x: textField.frame.origin.x, y: textField.frame.origin.y + textField.frame.size.height, width: textField.frame.size.width, height: 206))
            print("width", textField.frame.size.width);
            textFieldTag = textField.tag
            switch textField.tag {
            case kAccountTxtTag:
                myTableView.register(UINib(nibName: "AccountTableViewCell", bundle: nil), forCellReuseIdentifier: "MyCell")
            case kContactTxtTag:
                myTableView.register(UINib(nibName: "AssociateTableViewCell", bundle: nil), forCellReuseIdentifier: "AssociateTableViewCell")
            default:
                print("default")
            }
            
            myTableView.separatorStyle = UITableViewCellSeparatorStyle.none
            myTableView.dataSource = self
            myTableView.delegate = self
            self.scrollView.addSubview(myTableView)
        }
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            print("qweqwe")
        }
    }
    
