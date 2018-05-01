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
    func clearAllMenu()
}

class ContactListViewController: UIViewController, UITableViewDataSource {
    
    var delegate : ContactDetailsScreenDelegate?
    
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
    
    //Used for Page control operation
    @IBOutlet var pageButtonArr: [UIButton]!
    var globalContactCount:Int?
    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.reloadAllContacts), name: NSNotification.Name("reloadAllContacts"), object: nil)
        fetchContacts()
    }
    
    func fetchContacts(){
        globalContactCount = contactViewModel.globalContacts().count
        contactsAcc = contactViewModel.accountsForContacts()
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
        print("full name \(fullName)")
        cell.initialNameLabel.text = globalContact.getIntials(name: fullName)
        cell.nameValueLabel.text = fullName
        cell.phoneValueLabel.text = globalContact.phoneNumber
        cell.emailValueLabel.text =  globalContact.email
        cell.selectionStyle = .none
        var accountsName = [String]()
        for acc in contactsAcc{
            
            if(globalContact.contactId == acc.contactId){
                accountsName.append(acc.accountName)
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
        
        if ContactsGlobal.accountId == "" {

            globalContactsForList = ContactSortUtility.filterContactByAppliedFilter(contactListToBeSorted: contactViewModel.globalContacts(), searchBarText: "")

        }else{
            
            delegate?.clearAllMenu()

            globalContactsForList = contactViewModel.contacts(forAccount: ContactsGlobal.accountId)
            print("globalContactsForList.count  = \(globalContactsForList.count)")
            
        }
        globalContactsForList = ContactSortUtility.sortByContactNameAlphabetically(contactsListToBeSorted: globalContactsForList, ascending: true)
        
        
        if globalContactsForList.count > 0 {
            pageButtonArr[1].backgroundColor = UIColor.lightGray
            pageButtonArr[1].setTitleColor(UIColor.white, for: .normal)
        }
        
        // self.noOfResultLabel.text = "Showing \(globalContactsForList.count) of \(globalContactCount!) results"
        
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
        
        print("filteringContact")
        
        if !filtering {
            loadContactData()
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
        
        if (ContactsGlobal.accountId == "" || ContactFilterMenuModel.comingFromDetailsScreen != "YES") {
            globalContactsForList = ContactSortUtility.filterContactByAppliedFilter(contactListToBeSorted: contactViewModel.globalContacts(), searchBarText: searchString)
        } else {
            globalContactsForList = ContactSortUtility.filterContactByAppliedFilter(contactListToBeSorted: contactViewModel.contacts(forAccount: ContactsGlobal.accountId), searchBarText: searchString)
        }
        
        globalContactsForList = ContactSortUtility.sortByContactNameAlphabetically(contactsListToBeSorted: globalContactsForList, ascending: true)
        
        // self.noOfResultLabel.text = "Showing \(globalContactsForList.count) of \(globalContactCount!) results"
        
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
        
        
        ////////////////////////////////////
        //        initPageViewWith(inputArr: globalContactsForList, pageSize: kPageSize)
        //        updateUI()
        //        print("\(self.noOfPages!)")
        //
        //        if(numberOfAccountRows > 0){
        //            self.tableView.scrollToRow(at: IndexPath.init(row: 0, section: 0), at: .top, animated: true)
        //        }
        //        for count in 1...5 {
        //            pageButtonArr[count].setTitleColor(UIColor.black, for: .normal)
        //            pageButtonArr[count].backgroundColor = UIColor.white
        //            pageButtonArr[count].setTitle(String(count), for: .normal)
        //        }
        //        pageButtonArr[1].backgroundColor = UIColor.lightGray
        //        pageButtonArr[1].setTitleColor(UIColor.white, for: .normal)
        
    }
    
    @objc func reloadAllContacts(notification: NSNotification){
        
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
        self.currentPageIndex = 0   //It will have index value of the page it is displaying right now, 0 or 5 or next 10, 15---
        self.currentPageSet = 0     //[1][2][3][4][5][6] --- CPI
        
        
        //if inputArr.count >= 10{
        //tableViewDisplayData = tableViewDisplayData[0...4]
        //    print(tableViewDisplayData)
        // }else{
        //let items = inputArr.count - 1
        // tableViewDisplayData = tableViewDisplayData[0...items]
        //    print(tableViewDisplayData)
        // }
        
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
            for i in 1...kNoOfPagesInEachSet {
                pageButtonArr[i].setTitle(String(i), for: .normal)
            }
            self.currentPageIndex = 0
            self.currentPageSet = 0
            
            updateUI()
            print ("First")
            print ("New \(self.currentPageIndex!)")
            
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
            let lastSetNo = (kNoOfPageSet!-1) * kNoOfPagesInEachSet
            for i in 1...kNoOfPagesInEachSet {
                pageButtonArr[i].setTitle(String(lastSetNo + i), for: .normal)
            }
            
            self.currentPageIndex = (kNoOfPageSet!-1) * kPageSize * kNoOfPagesInEachSet
            self.currentPageSet = kNoOfPageSet! - 1
            updateUI()
            print ("Last")
            print ("New \(self.currentPageIndex!)")
            
        default:
            break
        }
        
        
        //let tableViewData = accountsForLoggedUserOriginal[self.currentPageIndex!]
        //tableViewDisplayData = [tableViewData]
        
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
        self.present(newContactVC!, animated: true, completion: nil)
    }
}

//MARK:- TableView Delegate Methods
extension ContactListViewController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.view.endEditing(true)
        
//        let globalContact:Contact = globalContactsForList[indexPath.row + currentPageIndex!]
//        delegate?.pushTheScreenToContactDetailsScreen(contactData: globalContact)
//        ContactFilterMenuModel.comingFromDetailsScreen = "YES"
        
    }
    
}







