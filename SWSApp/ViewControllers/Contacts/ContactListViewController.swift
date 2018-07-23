//
//  ContactListViewController.swift
//  SWSApp
//
//  Created by shubham.e.shukla on 4/20/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

protocol ContactDetailsScreenDelegate{
    func pushTheScreenToContactDetailsScreen(contactData : Contact)
    func reloadAllMenu()
    func clearAllMenu()
}

class ContactListViewController: UIViewController, UITableViewDataSource {
    
    var delegate : ContactDetailsScreenDelegate?
    static var refreshContactDetailDelegate: ContactDetailsScreenDelegate?
    let contactViewModel = ContactsViewModel()
    var globalContactsForList = [Contact]()
    var accountContactsForList = [Contact]()
    var contactsAcc = [AccountContactRelation]()
    // @IBOutlet weak var noOfResultLabel: UILabel!
    var numberOfAccountRows = 0
    
    //Internal
    var kPageSize:Int = 15
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
    
    var isAccountSpecific: Bool = false
    
    //Used for Page control operation
    @IBOutlet var pageButtonArr: [UIButton]!
    var globalContactCount:Int?
    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        globalContactCount = 0
        currentPageIndex = 0
        NotificationCenter.default.addObserver(self, selector: #selector(self.reloadAllContacts), name: NSNotification.Name("reloadAllContacts"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.selctedContact), name: NSNotification.Name(rawValue: "SelectedContact"), object: nil)
        fetchContacts()
    }
    
    func fetchContacts(){
        contactsAcc = [AccountContactRelation]()
        globalContactCount = contactViewModel.globalContacts().count
        //contactsAcc = contactViewModel.activeAccountsForContacts() //already called in loadContactData()
            //contactViewModel.accountsForContacts()
        loadContactData()
    }
    
    // MARK:- Table View Data Source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        }
        let cellsToDisplay = globalContactsForList.count - currentPageIndex!
        if cellsToDisplay <= self.kPageSize && cellsToDisplay > 0 {
            numberOfAccountRows = cellsToDisplay
            return cellsToDisplay
        }else if (cellsToDisplay == 0) {
            numberOfAccountRows = 0
            return 0
        }
        else {
            numberOfAccountRows = self.kPageSize
            return self.kPageSize
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0{
            
            let buttonCell:ContactListTableViewButtonCell = tableView.dequeueReusableCell(withIdentifier: "buttonCell", for: indexPath) as! ContactListTableViewButtonCell
            buttonCell.delegate = self
            return buttonCell
            
        }
        
        let globalContact:Contact = globalContactsForList[indexPath.row + currentPageIndex!]
        let cell:ContactListTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ContactListTableViewCell
        
        let fullName = globalContact.firstName + " " + globalContact.lastName
        cell.initialNameLabel.text = globalContact.getIntials(name: fullName)
        cell.nameValueLabel.text = fullName
        cell.phoneValueLabel.text = globalContact.phoneNumber
        cell.emailValueLabel.text =  globalContact.email
        cell.selectionStyle = .none
        var accountsName = [String]()
        
        
        for acc in contactsAcc{
            
            if(globalContact.contactId == acc.contactId){
                let accName = AccountsViewModel().accountNameFor(accountId: acc.accountId)
                if(!accName.isEmpty){
                    print("my account names \(accName) \(acc.contactId) \(acc.contactName) \(acc.accountId)")
                    accountsName.append(accName)
                    //break //fix this, need to get all names
                }
                else { // acr table is not populated so reading from accounts table.
                    let accountList: [Account]? = AccountSortUtility.searchAccountByAccountId(accountsForLoggedUser: AccountsViewModel().accountsForLoggedUser(), accountId: acc.accountId)
                    guard accountList != nil, (accountList?.count)! > 0  else {
                        continue
                    }
                    
                    accountsName.append(accountList![0].accountName)
                    break
                }
            }
            
        }
        
        if(accountsName.count > 0){
            accountsName = accountsName.sorted { $0.lowercased() < $1.lowercased() }
            
            let formattedaccountsName = accountsName.joined(separator: ", ")
            print(formattedaccountsName)
            cell.linkedAccountWithContact.text = "\(formattedaccountsName)"
            
        } else {
            cell.linkedAccountWithContact.text = "This contact is not linked to any of your Accounts"
            
        }
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 60
        }
        return 200
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
    
    //MARK:- load contact data
    func loadContactData() {
        //reset ACR data
        contactsAcc.removeAll()
        
        contactsAcc = contactViewModel.activeAccountsForContacts()
        //contactViewModel.accountsForContacts()
        
        delegate?.reloadAllMenu()


        if ContactsGlobal.accountId == "" {
            isAccountSpecific = false
            globalContactsForList = ContactSortUtility.filterContactByAppliedFilter(contactListToBeSorted: contactViewModel.globalContacts(), searchBarText: "")
        }else{
            isAccountSpecific = true
            delegate?.clearAllMenu()
            
            var isValid : Bool = false
            var data = [Contact]()
            print(ContactsGlobal.accountId)
            
            (isValid, data) = ContactSortUtility.filterContactByFilterByAssociationDetails(contactListToBeSorted: contactViewModel.globalContacts(), selectedAccountId: ContactsGlobal.accountId)
            
            if isValid {
                globalContactsForList = data//.filter({$0.accountId == ContactsGlobal.accountId})
            }
            else {
                globalContactsForList = [Contact]()
            }
            
//            globalContactsForList = contactViewModel.contactsWithBuyingPower(forAccount: ContactsGlobal.accountId)
            
            print("globalContactsForList.count  = \(globalContactsForList.count)")
            
            ContactsGlobal.accountId = ""            
        }
        globalContactsForList = ContactSortUtility.sortByContactNameAlphabetically(contactsListToBeSorted: globalContactsForList, ascending: true)
        
        
        if globalContactsForList.count > 0 {
            pageButtonArr[1].backgroundColor = UIColor.lightGray
            pageButtonArr[1].setTitleColor(UIColor.white, for: .normal)
        }
        initPageViewWith(inputArr: globalContactsForList, pageSize: kPageSize)
        updateUI()
        
        
        self.tableView.reloadData()
        
    }
    
}

//MARK:- SearchContactByEnteredTextDelegate Methodss
extension ContactListViewController : SearchContactByEnteredTextDelegate{
    
    func sortContactData(searchString: String) {
        print("sortContactData")
    }
    
    func filteringContact(filtering: Bool) {
        if !filtering {
            fetchContacts()
        }
        
        for count in 1...5 {
            pageButtonArr[count].setTitleColor(UIColor.black, for: .normal)
            pageButtonArr[count].backgroundColor = UIColor.white
            pageButtonArr[count].setTitle(String(count), for: .normal)
        }
        pageButtonArr[1].backgroundColor = UIColor.lightGray
        pageButtonArr[1].setTitleColor(UIColor.white, for: .normal)
    }
    
    func performContactFilterOperation(searchString: String) {
        
        print("performContactFilterOperation")
        print(ContactFilterMenuModel.functionRoles)
        
        if (!isAccountSpecific || ContactFilterMenuModel.comingFromDetailsScreen != "YES") {
            globalContactsForList = ContactSortUtility.filterContactByAppliedFilter(contactListToBeSorted: contactViewModel.globalContacts(), searchBarText: searchString)
        } else {
            globalContactsForList = ContactSortUtility.filterContactByAppliedFilter(contactListToBeSorted: contactViewModel.contacts(forAccount: ContactsGlobal.accountId), searchBarText: searchString)
        }
        
        globalContactsForList = ContactSortUtility.sortByContactNameAlphabetically(contactsListToBeSorted: globalContactsForList, ascending: true)
        
        initPageViewWith(inputArr: globalContactsForList, pageSize: kPageSize)
        updateUI()
        print("\(self.noOfPages!)")
        
        DispatchQueue.main.async {
            UIView.performWithoutAnimation({() -> Void in
                self.tableView.reloadData()
                if(self.numberOfAccountRows > 0){
                    self.tableView.scrollToRow(at: IndexPath.init(row: 0, section: 0), at: .none, animated: true)
                }
                self.tableView.beginUpdates()
                self.tableView.endUpdates()
            })
        }
        
        for count in 1...5 {
            pageButtonArr[count].setTitleColor(UIColor.black, for: .normal)
            pageButtonArr[count].backgroundColor = UIColor.white
            pageButtonArr[count].setTitle(String(count), for: .normal)
        }
        pageButtonArr[1].backgroundColor = UIColor.lightGray
        pageButtonArr[1].setTitleColor(UIColor.white, for: .normal)
        
        
        self.tableView.reloadData()
    }
    
    
    @objc func selctedContact(notification: NSNotification){
        
        if let contact = notification.userInfo?["contact"] as? Contact {
            delegate?.pushTheScreenToContactDetailsScreen(contactData: contact)
        }
    }
    
    @objc func reloadAllContacts(notification: NSNotification){
        contactsAcc = [AccountContactRelation]()
        globalContactCount = contactViewModel.globalContacts().count
        
        contactsAcc = contactViewModel.activeAccountsForContacts()
        //contactViewModel.accountsForContacts()
        
        initPageViewWith(inputArr: globalContactsForList, pageSize: kPageSize)
        updateUI()
        print("\(self.noOfPages!)")
        
        DispatchQueue.main.async {
            UIView.performWithoutAnimation({() -> Void in
                self.tableView.reloadData()
                if(self.numberOfAccountRows > 0){
                    self.tableView.scrollToRow(at: IndexPath.init(row: 0, section: 0), at: .none, animated: true)
                }
                self.tableView.beginUpdates()
                self.tableView.endUpdates()
            })
        }
        
        for count in 1...5 {
            pageButtonArr[count].setTitleColor(UIColor.black, for: .normal)
            pageButtonArr[count].backgroundColor = UIColor.white
            pageButtonArr[count].setTitle(String(count), for: .normal)
        }
        pageButtonArr[1].backgroundColor = UIColor.lightGray
        pageButtonArr[1].setTitleColor(UIColor.white, for: .normal)
        loadContactData()
        
        //Pass data to child using delegates
        if !ContactFilterMenuModel.selectedContactIdFromDetailScreen.isEmpty {
            guard let selectedContact = ContactSortUtility.searchContactByContactId( ContactFilterMenuModel.selectedContactIdFromDetailScreen) else {
                return
            }
              ContactListViewController.refreshContactDetailDelegate?.pushTheScreenToContactDetailsScreen(contactData: selectedContact)
        }
        
        if ContactFilterMenuModel.comingFromDetailsScreen == "YES", ContactFilterMenuModel.selectedContactId != "" {
            
            guard let selectedContact = ContactSortUtility.searchContactByContactId(ContactFilterMenuModel.selectedContactId) else {
                return
            }
            delegate?.pushTheScreenToContactDetailsScreen(contactData: selectedContact)
            
            ContactFilterMenuModel.selectedContactId = ""
            
        }
    }
}



//MARK:- PageControl Implementation
extension ContactListViewController{
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
        self.currentPageIndex = 0
        self.currentPageSet = 0
        tableView.reloadData()
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
            currentPageIndex = currentPageSet! * kNoOfPagesInEachSet * kPageSize
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
    
    @IBAction func pageActionHandelerContactList(sender: UIButton) {
        
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
            self.setupFirstPageButton()
            
        case Page.previous.rawValue:
            changeBtnText(byPageSet:-1)
            updateUI()
        case Page.one.rawValue:
            self.currentPageIndex = (currentPageSet! * kNoOfPagesInEachSet+0) * kPageSize
            pageButtonArr[1].setTitleColor(UIColor.white, for: .normal)
            pageButtonArr[1].backgroundColor = UIColor.lightGray
            
        case Page.two.rawValue:
            self.currentPageIndex = (currentPageSet! * kNoOfPagesInEachSet+1) * kPageSize
            pageButtonArr[2].setTitleColor(UIColor.white, for: .normal)
            pageButtonArr[2].backgroundColor = UIColor.lightGray
            
        case Page.three.rawValue:
            self.currentPageIndex = (currentPageSet! * kNoOfPagesInEachSet+2) * kPageSize
            pageButtonArr[3].setTitleColor(UIColor.white, for: .normal)
            pageButtonArr[3].backgroundColor = UIColor.lightGray
            
        case Page.four.rawValue:
            self.currentPageIndex = (currentPageSet! * kNoOfPagesInEachSet+3) * kPageSize
            pageButtonArr[4].setTitleColor(UIColor.white, for: .normal)
            pageButtonArr[4].backgroundColor = UIColor.lightGray
            
        case Page.five.rawValue:
            self.currentPageIndex = (currentPageSet! * kNoOfPagesInEachSet+4) * kPageSize
            pageButtonArr[5].setTitleColor(UIColor.white, for: .normal)
            pageButtonArr[5].backgroundColor = UIColor.lightGray
            
        case Page.next.rawValue:
            changeBtnText(byPageSet: 1)
            updateUI()
        case Page.last.rawValue:
            self.setupLastPageButton()
            
        default:
            break
        }
        scrollTableViewToSelectedSection()
    }
    
    func scrollTableViewToSelectedSection(){
        DispatchQueue.main.async {
            UIView.performWithoutAnimation({() -> Void in
                self.tableView.reloadData()
                if(self.numberOfAccountRows > 0){
                    self.tableView.scrollToRow(at: IndexPath.init(row: 0, section: 0), at: .none, animated: true)
                }
                self.tableView.beginUpdates()
                self.tableView.endUpdates()
            })
        }
    }
    
    func setupFirstPageButton(){
        for i in 1...kNoOfPagesInEachSet {
            pageButtonArr[i].setTitle(String(i), for: .normal)
        }
        self.currentPageIndex = 0
        self.currentPageSet = 0
        updateUI()
    }
    
    
    func setupLastPageButton(){
        let lastSetNo = (kNoOfPageSet!-1) * kNoOfPagesInEachSet
        for i in 1...kNoOfPagesInEachSet {
            pageButtonArr[i].setTitle(String(lastSetNo + i), for: .normal)
        }
        
        self.currentPageIndex = (kNoOfPageSet!-1) * kPageSize * kNoOfPagesInEachSet
        self.currentPageSet = kNoOfPageSet! - 1
        updateUI()
    }
    
}

extension ContactListViewController : CreateNewContactViewControllerDelegate {
    func updateContactList() {
        fetchContacts()
    }
}

extension ContactListViewController: ContactListTableViewButtonCellDelegate {
    
    func newContactButtonTapped(){
        let newContactStoryboard: UIStoryboard = UIStoryboard(name: "NewContact", bundle: nil)
        let newContactVC = newContactStoryboard.instantiateViewController(withIdentifier: "CreateNewContactViewController") as? CreateNewContactViewController
        newContactVC?.delegate = self
        newContactVC?.isNewContact = true
        self.present(newContactVC!, animated: true, completion: nil)
    }
}

//MARK:- TableView Delegate Methods
extension ContactListViewController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.view.endEditing(true)
        
        if indexPath.section == 1 {
            let globalContact:Contact = globalContactsForList[indexPath.row + currentPageIndex!]
            delegate?.pushTheScreenToContactDetailsScreen(contactData: globalContact)
            ContactFilterMenuModel.comingFromDetailsScreen = "YES"
            ContactFilterMenuModel.selectedContactIdFromDetailScreen = globalContact.contactId
        }
    }
}
