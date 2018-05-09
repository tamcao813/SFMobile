//
//  PlanVisitViewController.swift
//  SWSApp
//
//  Created by vipin.vijay on 19/04/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit
import SmartSync

let kAccountTxtTag = 100
let kContactTxtTag = 101
let kSelectedContactTag = 102

//protocol PlanVisitViewControllerDelegate: NSObjectProtocol {
//    func refershList()
//}

class PlanVisitViewController: UIViewController, CloseAccountViewDelegate {
    
    var associatedSelectedContact = [Contact]()
    var searchAccounts = [Account]()
    var nonSelectedContact = [Contact]()
    
    var selectedAccount: Int = -1
    
    private var myTableView: UITableView!
    private var associatedContactTableView: UITableView!
    private var containerView: UIView!
    var textFieldTag: Int = 0
    var accountID: String = ""
    let accountViewModel = AccountsViewModel()
    var conatctViewModel = ContactsViewModel()
    lazy var  accountView = AccountView()
    var planVist:PlanVisit? = PlanVisit(for: "")
    var editVist:Visit? = Visit(for: "")
    var editContact:Contact? = Contact(for: "")
    var tableViewData : [PlanVisit]?
    //    weak var delegate: PlanVisitViewControllerDelegate!
    var visitViewModel = VisitSchedulerViewModel()
    
    
    // MARK:- IBOutlets
    
    @IBOutlet var searchAccountLbl: UILabel!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var planLbl: UILabel!
    @IBOutlet var errorLbl: UILabel!
    @IBOutlet var bottomView: UIView!
    @IBOutlet var searchAccountTxt: DesignableUITextField!
    @IBOutlet var searchContactTxt: DesignableUITextField!
    @IBOutlet var schedulerComponentView: SchedulerComponent!
    
    @IBOutlet weak var bottomViewSpacing: NSLayoutConstraint!
    
    // MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Plan VC viewDidLoad")
        searchContactTxt.isEnabled = false
        self.getTheDataFromDB()
        print("PlanVistManager.sharedInstance.visit", PlanVistManager.sharedInstance.visit as Any)
        
        NotificationCenter.default.addObserver(self, selector: #selector(PlanVisitViewController.removeAssociate(notification:)), name: Notification.Name("REMOVEASSOCIATE"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(PlanVisitViewController.validateDate(notification:)), name: Notification.Name("VALIDATEFIELDS"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        
        self.associatedContactTableView = UITableView(frame: CGRect(x: 10, y: 300, width: self.searchAccountTxt.frame.size.width, height: 206))
        self.associatedContactTableView.register(UINib(nibName: "SelectedAssociateTableViewCell", bundle: nil), forCellReuseIdentifier: "SelectedAssociateTableViewCell")
        self.associatedContactTableView.separatorStyle = UITableViewCellSeparatorStyle.none
        self.associatedContactTableView.dataSource = self
        self.associatedContactTableView.delegate = self
        self.scrollView.addSubview(self.associatedContactTableView)
        self.associatedContactTableView.isHidden = true
        self.textFieldTag = kSelectedContactTag
        
        bottomViewSpacing.constant = 30
        
        //self.createNewVisit()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if (PlanVistManager.sharedInstance.editPlanVisit) {
            self.editAccountScreen()
            self.editContactScreen()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if (PlanVistManager.sharedInstance.editPlanVisit) {
            self.editDate()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("Plan VC will disappear")
        PlanVistManager.sharedInstance.editPlanVisit = false
        NotificationCenter.default.removeObserver(self, name: Notification.Name(rawValue: "CLOSEACCOUNTVIEW"), object: nil)
        NotificationCenter.default.removeObserver(self, name: Notification.Name(rawValue: "REMOVEASSOCIATE"), object: nil)
    }
    
    // MARK:- Delegate Custom Methods
    
    func closeAccountView() {
        
        //Take Action on Notification
        
        self.selectedAccount = -1
        
        self.searchAccountLbl.isHidden = false
        self.searchAccountTxt.isHidden = false
        searchContactTxt.isEnabled = false
        associatedSelectedContact.removeAll()
        if self.myTableView != nil {
            self.myTableView.removeFromSuperview()
        }
        
        
        // Adjust View
        
        self.associatedContactTableView.isHidden = true
        bottomViewSpacing.constant = 30
        
        // Remove contact array
        nonSelectedContact.removeAll()
    }
    
    // MARK:- Notification
    
    @objc func validateDate(notification: Notification){
        let arr = validatefields()
        print("arr", arr)
    }
    
    @objc func removeAssociate(notification: Notification){
        //Take Action on Notification
        if let userInfo = notification.userInfo // or use if you know the type  [AnyHashable : Any]
        {
            if let tag = userInfo["tag"] as? Int {
                self.associatedSelectedContact.remove(at: tag)
                self.searchContactTxt.resignFirstResponder()
                self.associatedContactTableView.reloadData()
                if (self.associatedSelectedContact.count > 0) {
                    self.associatedContactTableView.frame = CGRect(x: self.searchContactTxt.frame.origin.x, y: self.searchContactTxt.frame.origin.y + self.searchContactTxt.frame.size.height + 40, width: self.searchContactTxt.frame.size.width, height: CGFloat(102 * self.associatedSelectedContact.count))
                    
                    bottomViewSpacing.constant = 30 + associatedContactTableView.frame.height + 20
                    
                } else {
                    self.associatedContactTableView.isHidden = true
                    bottomViewSpacing.constant = 30
                    
                }
            }
        }
    }
    
    @objc func keyboardWillShow(notification:NSNotification){
        //give room at the bottom of the scroll view, so it doesn't cover up anything the user needs to tap
        var userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
        var contentInset:UIEdgeInsets = self.scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height
        scrollView.contentInset = contentInset
    }
    
    @objc func keyboardWillHide(notification:NSNotification){
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
    }
    
    // MARK:- IBAction
    
    @IBAction func closeVC(sender: UIButton) {
        DispatchQueue.main.async {
            AlertUtilities.showAlertMessageWithTwoActionsAndHandler("Any changes will not be saved", errorMessage: "Are you sure you want to ?", errorAlertActionTitle: "Yes", errorAlertActionTitle2: "No", viewControllerUsed: self, action1: {
                if (self.myTableView != nil) {
                    self.myTableView.removeFromSuperview()
                    self.view.endEditing(true)
                }
                self.dismiss(animated: true, completion: nil)
            }){
                
            }
        }
        
    }
    
    @IBAction func planAction(sender: UIButton) {
        let validateArray = validatefields()
        if validateArray.contains(false) {
            errorLbl.isHidden = false
        } else {
            PlanVistManager.sharedInstance.visit?.status = "Scheduled"
            errorLbl.isHidden = true
            self.insetValuesToDB()
            // createNewVisit()
            let storyboard = UIStoryboard(name: "PlanVisitEditableScreen", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier :"SelectOpportunitiesViewControllerID")
            self.present(viewController, animated: true)
        }
        
    }
    
    @IBAction func scheduleAndClose(sender: UIButton) {
        let validateArray = validatefields()
        
        if validateArray.contains(false) {
            errorLbl.isHidden = false
            
        } else {
            
            //            PlanVistManager.sharedInstance.status = "Scheduled"
            PlanVistManager.sharedInstance.visit?.status = "Scheduled"
            
            errorLbl.isHidden = true
            self.insetValuesToDB()
            
            //Edit the visit
            
            if((PlanVistManager.sharedInstance.visit?.Id) != nil){
                
                let status = PlanVistManager.sharedInstance.editAndSaveVisit()
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshAccountList"), object:nil)
                print(status)
                
            } else{
                
                //First Time A Visit is created and Saved
                createNewVisit()
                
            }
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshAccountList"), object:nil)
            self.dismiss(animated: true)
        }
    }
    
    // MARK:- Custom Methods
    
    func removeSpecialCharsFromString(text: String) -> String {
        let okayChars : Set<Character> =
            Set("abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLKMNOPQRSTUVWXYZ1234567890+-*=(),.:!_".characters)
        return String(text.characters.filter {okayChars.contains($0) })
    }
    
    // Edit Screen For Accounts
    
    func editAccountScreen()  {
        
        self.searchAccountLbl.isHidden = true
        self.searchAccountTxt.isHidden = true
        self.searchAccountTxt.resignFirstResponder()
        self.searchContactTxt.isEnabled = true
        
        self.accountView = AccountView(frame: CGRect(x: self.planLbl.frame.origin.x - 20, y:
            self.planLbl.frame.origin.y + 20, width: self.searchAccountTxt.frame.size.width, height: 100))
        
        editVist = PlanVistManager.sharedInstance.visit
        self.accountID = (editVist?.accountId)!
        self.accountView.delegate = self
        self.accountView.accountLabel.text = editVist?.accountName
        self.accountView.phoneNumberLabel.text = editVist?.accountNumber
        var accountObject: Account?
        let accounts = AccountsViewModel().accountsForLoggedUser
        if let accountId = editVist?.accountId {
            for account in accounts {
                if account.account_Id == accountId {
                    accountObject = account
                    break
                }
            }
        }
        
        var fullAddress = ""
        if let shippingStreet = accountObject?.shippingStreet, let shippingCity = accountObject?.shippingCity , let shippingState = accountObject?.shippingState, let shippingPostalCode = accountObject?.shippingPostalCode{
            // latitudeDouble and longitudeDouble are non-optional in here
            if shippingStreet == "" && shippingCity == "" && shippingState == "" && shippingPostalCode == "" {
                fullAddress = "\(shippingStreet) \(shippingCity) \(shippingState) \(shippingPostalCode)"
            }else{
                if (shippingStreet != "" || shippingCity != "") {
                    if (shippingState != "" || shippingPostalCode != "") {
                        fullAddress = "\(shippingStreet) \(shippingCity), \(shippingState) \(shippingPostalCode)"
                    }else{
                        fullAddress = "\(shippingStreet) \(shippingCity) \(shippingState) \(shippingPostalCode)"
                    }
                }else{
                    fullAddress = "\(shippingStreet) \(shippingCity) \(shippingState) \(shippingPostalCode)"
                }
            }
        }
        self.accountView.addressLabel.text = fullAddress
        
        self.accountView.frame.origin = CGPoint(x:20, y:self.planLbl.frame.origin.y + 10)
        self.scrollView.addSubview(self.accountView)
    }
    
    func editContactScreen()  {
        
        editVist = PlanVistManager.sharedInstance.visit
        if (editVist?.contactId.isEmpty)! {
            
        } else {
            editContact?.contactId = (editVist?.contactId)!
            editContact?.name = (editVist?.contactName)!
            editContact?.phoneNumber = (editVist?.contactPhone)!
            editContact?.email = (editVist?.contactEmail)!
            editContact?.functionRole = (editVist?.contactSGWS_Roles)!
            
            self.textFieldTag = kSelectedContactTag
            self.associatedSelectedContact.append(editContact!)
            self.associatedContactTableView.isHidden = false
            self.searchContactTxt.resignFirstResponder()
            self.associatedContactTableView.reloadData()
            
            self.associatedContactTableView.frame = CGRect(x: self.searchContactTxt.frame.origin.x, y: self.searchContactTxt.frame.origin.y + self.searchContactTxt.frame.size.height + 40, width: self.searchContactTxt.frame.size.width, height: CGFloat(102 * self.associatedSelectedContact.count))
            
            bottomViewSpacing.constant = 30 + associatedContactTableView.frame.height + 20
            
        }
        
    }
    
    
    func editDate() {
        editVist = PlanVistManager.sharedInstance.visit
        
        for subviews in schedulerComponentView.subviews
        {
            if let textField = subviews as? DesignableUITextField {
                switch textField.tag {
                case 200:
                    textField.text = self.getDate(date: (editVist?.startDate)!)
                case 201:
                    textField.text = self.getTime(date: (editVist?.startDate)!)
                case 202:
                    textField.text = self.getTime(date: (editVist?.endDate)!)
                default:
                    print("NA")
                }
            }
        }
    }
    
    func getDate(date: String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.zzz+zzzz" // This formate is input formated .
        
        var formateDate = Date()
        if dateFormatter.date(from:(date)) != nil {
            formateDate = dateFormatter.date(from:(date))!
            dateFormatter.dateFormat = "dd-MM-yyyy" // Output Formated
        } else {
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss" // This formate is input formated .
            formateDate = dateFormatter.date(from:(date))!
            dateFormatter.dateFormat = "dd-MM-yyyy" // Output Formated
        }
        
        return dateFormatter.string(from: formateDate)
    }
    
    func getTime(date: String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.zzz+zzzz" // This formate is input formated .
        
        var formateDate = Date()
        if dateFormatter.date(from:(date)) != nil {
            formateDate = dateFormatter.date(from:(date))!
            dateFormatter.dateFormat = "hh:mm a" // Output Formated
            dateFormatter.amSymbol = "AM"
            dateFormatter.pmSymbol = "PM"
        } else {
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss" // This formate is input formated .
            formateDate = dateFormatter.date(from:(date))!
            dateFormatter.dateFormat = "hh:mm a" // Output Formated
            dateFormatter.amSymbol = "AM"
            dateFormatter.pmSymbol = "PM"
        }
        
        return dateFormatter.string(from: formateDate)
    }
    
    func getNonSelectedContacts() -> [Contact] {
        //        var tempContacts = conatctViewModel.contacts(forAccount: accountID)
        var tempContacts = conatctViewModel.globalContacts()
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
    
    // Get Account array after searching keyword
    
    func getAccountData(searchStr: String) -> [Account] {
        let account = self.accountViewModel.accountsForLoggedUser
        let arr = account.filter( { return $0.accountName.lowercased().contains(searchStr.lowercased()) } )
        print(arr)
        return arr
    }
    
    
    // Get contact array after searching keyword
    
    func getContactstData(searchStr: String) -> [Contact] {
        let contact = self.getNonSelectedContacts()
        let arr = contact.filter( { return $0.name.lowercased().contains(searchStr.lowercased()) } )
        return arr
    }
    
    // validating all fields in the view
    
    func validatefields() -> Array<Bool> {
        var validate: Bool = false
        var validateArray: [Bool] = []
        if (self.searchAccountTxt.isHidden == false){
            self.searchAccountTxt.borderColor = UIColor.red
            self.searchAccountTxt.layer.borderWidth = 2.0
            validate = false
            validateArray.append(validate)
        } else {
            self.searchAccountTxt.layer.borderWidth = 1.0
            self.searchAccountTxt.borderColor = UIColor(red: 204/255.0, green: 204/255.0, blue: 204/255.0, alpha: 1.0)
            validate = true
            validateArray.append(validate)
        }
        
        for subviews in schedulerComponentView.subviews
        {
            if let textField = subviews as? DesignableUITextField {
                if (textField.text?.isEmpty)! {
                    textField.layer.borderWidth = 2.0
                    textField.borderColor = UIColor.red
                    validate = false
                    validateArray.append(validate)
                } else {
                    textField.layer.borderWidth = 1.0
                    textField.borderColor = UIColor(red: 204/255.0, green: 204/255.0, blue: 204/255.0, alpha: 1.0)
                    validate = true
                    validateArray.append(validate)
                }
            }
        }
        return validateArray
    }
    
    // Get all values from all fields
    
    func addValuesPushToDB() {
        
    }
    
    func getDataTimeinStr(date:String, time: String) -> String {
        
        let timeFormatter = DateFormatter()
        
        timeFormatter.dateFormat = "hh:mm a"
        
        let fullTime = timeFormatter.date(from: time)
        
        timeFormatter.dateFormat = "HH:mm:ss"
        
        let formattedTime = timeFormatter.string(from: fullTime!)
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        let fullDate = dateFormatter.date(from: date)
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let formattedDate = dateFormatter.string(from: fullDate!)
        
        let formattedDateTime = formattedDate + "T" + formattedTime
        
        return formattedDateTime
    }
    
    // Get all details to push to server
    
    func insetValuesToDB() {
        
        if selectedAccount == -1 {
            return
        }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if !associatedSelectedContact.isEmpty {
            let contactObj = associatedSelectedContact[0]
            PlanVistManager.sharedInstance.contactId = contactObj.contactId
        }
        if !searchAccounts.isEmpty {
            let accountObj = searchAccounts[selectedAccount]
            PlanVistManager.sharedInstance.accountId = accountObj.account_Id
        }
        if ((schedulerComponentView.dateTextField.text != nil) && (schedulerComponentView.startTimeTextField.text != nil)) {
            PlanVistManager.sharedInstance.startDate = self.getDataTimeinStr(date: schedulerComponentView.dateTextField.text!, time: schedulerComponentView.startTimeTextField.text!)
        }
        
        if ((schedulerComponentView.dateTextField.text != nil) && (schedulerComponentView.endTimeTextField.text != nil)) {
            PlanVistManager.sharedInstance.endDate = self.getDataTimeinStr(date: schedulerComponentView.dateTextField.text!, time: schedulerComponentView.endTimeTextField.text!)
        }
        PlanVistManager.sharedInstance.userID = (appDelegate.loggedInUser?.userId)!
        
    }
    
    // Get PlanVisit Objects
    func getTheDataFromDB(){
        let visitArray = VisitSchedulerViewModel()
        
        tableViewData = visitArray.visitsForUser()
        
        print(tableViewData)
        
    }
}

// MARK:- UITableView Datasource

extension PlanVisitViewController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count: Int = 0
        if(textFieldTag == kSelectedContactTag) {
            count = associatedSelectedContact.count
        } else if(textFieldTag == kAccountTxtTag) {
            count = self.searchAccounts.count
        } else if(textFieldTag == kContactTxtTag) {
            count = nonSelectedContact.count
        }
        return count
    }
}

// MARK:- UITableView Delegates

extension PlanVisitViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(textFieldTag == kAccountTxtTag) {
            let cell: AccountTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath) as! AccountTableViewCell
            let account = self.searchAccounts[indexPath.row]
            cell.accountLabel.text = account.accountName
            cell.phoneNumberLabel.text = account.accountNumber
            cell.addressLabel.text = account.shippingStreet + " " + account.shippingCity + " " + account.shippingPostalCode
            return cell
        } else if(textFieldTag == kContactTxtTag) {
            let cell: AssociateTableViewCell = tableView.dequeueReusableCell(withIdentifier: "AssociateTableViewCell", for: indexPath as IndexPath) as! AssociateTableViewCell
            let contacts = nonSelectedContact[indexPath.row]
            cell.initialNameLabel.text = contacts.getIntials(name: contacts.name)
            cell.nameLabel.text = contacts.name
            cell.emailAddrLabel.text = contacts.email
            cell.phoneNumLabel.text = contacts.phoneNumber
            cell.roleLabel.text = contacts.functionRole
            return cell
        } else {
            let cell: SelectedAssociateTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SelectedAssociateTableViewCell", for: indexPath as IndexPath) as! SelectedAssociateTableViewCell
            cell.removeButton.tag = indexPath.row
            let contacts = associatedSelectedContact[indexPath.row]
            cell.initialNameLabel.text = contacts.getIntials(name: contacts.name)
            cell.nameLabel.text = contacts.name
            cell.emailAddrLabel.text = contacts.email
            cell.phoneNumLabel.text = contacts.phoneNumber
            cell.roleLabel.text = contacts.functionRole
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
                self.searchAccountTxt.resignFirstResponder()
                self.searchContactTxt.isEnabled = true
                
                self.accountView = AccountView(frame: CGRect(x: self.planLbl.frame.origin.x - 20, y:
                    self.planLbl.frame.origin.y + 20, width: self.searchAccountTxt.frame.size.width, height: 100))
                let account = self.searchAccounts[indexPath.row]
                self.selectedAccount = indexPath.row
                self.accountID = account.account_Id
                self.accountView.delegate = self
                self.accountView.accountLabel.text = account.accountName
                self.accountView.phoneNumberLabel.text = account.accountNumber
                self.accountView.addressLabel.text = account.shippingStreet + " " + account.shippingCity + " " + account.shippingPostalCode
                self.accountView.frame.origin = CGPoint(x:20, y:self.planLbl.frame.origin.y + 10)
                self.scrollView.addSubview(self.accountView)
            } else if(self.textFieldTag == kContactTxtTag) {
                self.textFieldTag = kSelectedContactTag
                let contacts = self.nonSelectedContact[indexPath.row]
                self.associatedSelectedContact.append(contacts)
                self.associatedContactTableView.isHidden = false
                self.searchContactTxt.resignFirstResponder()
                self.associatedContactTableView.reloadData()
                
                self.associatedContactTableView.frame = CGRect(x: self.searchContactTxt.frame.origin.x, y: self.searchContactTxt.frame.origin.y + self.searchContactTxt.frame.size.height + 40, width: self.searchContactTxt.frame.size.width, height: CGFloat(102 * self.associatedSelectedContact.count))
                self.bottomViewSpacing.constant = 30 + self.associatedContactTableView.frame.height + 20
                
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if tableView == self.associatedContactTableView {
            return 102.0;
        }
        return 62.0;//Choose your custom row height
    }
}

// MARK:- TextFieldDelegates

extension PlanVisitViewController : UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        switch textField.tag {
        case kAccountTxtTag:
            myTableView = UITableView(frame: CGRect(x: textField.frame.origin.x, y: textField.frame.origin.y + textField.frame.size.height, width: textField.frame.size.width, height: 310))
            textFieldTag = textField.tag
            myTableView.register(UINib(nibName: "AccountTableViewCell", bundle: nil), forCellReuseIdentifier: "MyCell")
            searchAccounts = self.accountViewModel.accountsForLoggedUser
            myTableView.separatorStyle = UITableViewCellSeparatorStyle.none
            myTableView.dataSource = self
            myTableView.delegate = self
            self.scrollView.addSubview(myTableView)
        case kContactTxtTag:
            if (self.getNonSelectedContacts().count != 0) {
                myTableView = UITableView(frame: CGRect(x: textField.frame.origin.x, y: textField.frame.origin.y + textField.frame.size.height, width: textField.frame.size.width, height: 310))
                textFieldTag = textField.tag
                myTableView.register(UINib(nibName: "AssociateTableViewCell", bundle: nil), forCellReuseIdentifier: "AssociateTableViewCell")
                nonSelectedContact = self.getNonSelectedContacts()
                myTableView.separatorStyle = UITableViewCellSeparatorStyle.none
                myTableView.dataSource = self
                myTableView.delegate = self
                self.scrollView.addSubview(myTableView)
            }
        default:
            print("default")
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("textFieldDidEndEditing")
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        if(textFieldTag == kAccountTxtTag) {
            if string.isEmpty {
                self.searchAccounts = self.accountViewModel.accountsForLoggedUser
                myTableView.reloadData()
            } else {
                self.searchAccounts = self.getAccountData(searchStr: textField.text!+string)
                myTableView.reloadData()
            }
        } else if (textFieldTag == kContactTxtTag) {
            if string.isEmpty {
                nonSelectedContact = self.getNonSelectedContacts()
                myTableView.reloadData()
            } else {
                nonSelectedContact = self.getContactstData(searchStr: textField.text!+string)
                myTableView.reloadData()
            }
        }
        
        return true
    }
    
    func generateRandomIDForVisit()->String  {
        //  Make a variable equal to a random number....
        let randomNum:UInt32 = arc4random_uniform(99999999) // range is 0 to 99
        // convert the UInt32 to some other  types
        let someString:String = String(randomNum)
        print("random Id for Visit  is \(someString)")
        return someString
    }
    
    // saving a visit locally
    
    func createNewVisit() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let accountId = appDelegate.loggedInUser?.accountId
        print("Account id in plan is \(String(describing: accountId))")
        
        
        
        let new_visit = PlanVisit(for: "newVisit")
        
        new_visit.Id = self.generateRandomIDForVisit()
        new_visit.subject = (planVist?.subject)!
        new_visit.accountId = PlanVistManager.sharedInstance.accountId
        new_visit.sgwsAppointmentStatus = (planVist?.sgwsAppointmentStatus)!
        new_visit.startDate =  PlanVistManager.sharedInstance.startDate //"2018-05-02T14:00:00.000Z"
        new_visit.endDate = PlanVistManager.sharedInstance.endDate //"2018-05-02T15:00:00.000Z"
        new_visit.sgwsVisitPurpose = (planVist?.sgwsVisitPurpose)!
        new_visit.description = (planVist?.description)!
        new_visit.sgwsAgendaNotes = (planVist?.sgwsAgendaNotes)!
        new_visit.status = (PlanVistManager.sharedInstance.visit?.status)!
        let attributeDict = ["type":"WorkOrder"]
        
        
        let addNewDict: [String:Any] = [
            
            PlanVisit.planVisitFields[0]: new_visit.Id,
            PlanVisit.planVisitFields[1]: new_visit.subject,
            PlanVisit.planVisitFields[2]: new_visit.accountId,
            PlanVisit.planVisitFields[3]: new_visit.sgwsAppointmentStatus,
            PlanVisit.planVisitFields[4]: new_visit.startDate,
            PlanVisit.planVisitFields[5]: new_visit.endDate,
            PlanVisit.planVisitFields[6]: new_visit.sgwsVisitPurpose,
            PlanVisit.planVisitFields[7]: new_visit.description,
            PlanVisit.planVisitFields[8]: new_visit.sgwsAgendaNotes,
            PlanVisit.planVisitFields[9]: new_visit.status,
            
            kSyncTargetLocal:true,
            kSyncTargetLocallyCreated:true,
            kSyncTargetLocallyUpdated:false,
            kSyncTargetLocallyDeleted:false,
            "attributes":attributeDict]
        
        let success = visitViewModel.createNewVisitLocally(fields: addNewDict)
        print("Success is here \(success)")
        
        
    }
    
    
}

// Show the alert if not saved




