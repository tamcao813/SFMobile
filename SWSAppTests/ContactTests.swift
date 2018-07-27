//
//  ContactTests.swift
//  SWSAppTests
//
//  Created by Krishna, Kamya on 7/26/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import XCTest
@testable import SWSApp

class MockContactDataProvider {
    
    static func mockTestContact1() -> Contact {
        let contact = Contact(for: "mockup")
        contact.contactId =  "111ASD"
        contact.name = "test1"
        contact.accountId = "001m000000cHLa7AAG"
        let n = Int(arc4random_uniform(1000) + 35)
        contact.firstName = "Greg" + "\(n)"
        contact.lastName = "Opa" + "\(n)"
        contact.phoneNumber = "(716) 666-8888"
        contact.preferredCommunicationMethod = "Phone"
        contact.contactClassification = "Influencer"
        
        return contact
    }
    
    static func mockTestContact2() -> Contact {
        let contact = Contact(for: "mockup")
        contact.contactId =  "212ASD"
        contact.name = "contactTest"
        contact.accountId = "001m000000cHLmDAAW"
        let n = Int(arc4random_uniform(1000) + 35)
        contact.firstName = "Greg" + "\(n)"
        contact.lastName = "Opa" + "\(n)"
        contact.phoneNumber = "(516) 666-9999"
        contact.preferredCommunicationMethod = "Phone"
        contact.contactClassification = "Influencer"
        
        return contact
    }
    
    static func mockTestContact3() -> Contact {
        let contact = Contact(for: "mockup")
        contact.contactId =  "xxxAAW"
        contact.name = "mockContactTest"
        contact.accountId = "001m000000cHLmDAAZ"
        let n = Int(arc4random_uniform(1000) + 35)
        contact.firstName = "Greg" + "\(n)"
        contact.lastName = "Opa" + "\(n)"
        contact.phoneNumber = "(314) 556-8458"
        contact.preferredCommunicationMethod = "Phone"
        contact.contactClassification = "Influencer"
        
        return contact
    }
    
    static func getListOfMockContactObjects() -> [Contact] {
        
        var arrayOfMockObjects = [Contact]()
        
        arrayOfMockObjects.append(mockTestContact1())
        arrayOfMockObjects.append(mockTestContact2())
        arrayOfMockObjects.append(mockTestContact3())
        
        return arrayOfMockObjects
    }
}

class ContactTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInitContactDetails() {
        
        let contact = Contact.init(for: "")
        XCTAssertEqual(contact.accountId, "")
        XCTAssertEqual(contact.name, "")
        XCTAssertEqual(contact.firstName, "")
        XCTAssertEqual(contact.lastName, "")
        XCTAssertEqual(contact.email, "")
        //XCTAssertEqual(contact.birthDate, Date())
        XCTAssertEqual(contact.accountId, "")
        XCTAssertEqual(contact.accountSite, "")
        XCTAssertEqual(contact.functionRole, "")
    }
    
    func testContactInitJson(){
        
        let contactFields: [String: Any] = ["Id": "", "Name": " ", "FirstName": "", "LastName": "", "Phone": "", "Email": "", "Birthdate": "","SGWS_Buying_Power__c": "false","AccountId": "", "Account.SWS_Account_Site__c": "","SGWS_Account_Site_Number__c": "","Title": "","Department": "","SGWS_Preferred_Name__c": "","SGWS_Contact_Hours__c": "","SGWS_Notes__c": "", "LastModifiedBy.Name": "","SGWS_AppModified_DateTime__c": "","SGWS_Child_1_Name__c": "","SGWS_Child_1_Birthday__c": "","SGWS_Child_2_Name__c": "","SGWS_Child_2_Birthday__c": "","SGWS_Child_3_Name__c": "","SGWS_Child_3_Birthday__c": "","SGWS_Child_4_Name__c": "","SGWS_Child_4_Birthday__c": "","SGWS_Child_5_Name__c": "","SGWS_Child_5_Birthday__c": "","SGWS_Anniversary__c": "","SGWS_Likes__c": "","SGWS_Dislikes__c": "","SGWS_Favorite_Activities__c": "","SGWS_Life_Events__c": "","SGWS_Life_Events_Date__c": "","Fax": "","SGWS_Other_Specification__c": "","SGWS_Roles__c": "","SGWS_Preferred_Communication_Method__c": "", "SGWS_Contact_Classification__c": ""]
        
        let contact = Contact.init(json: contactFields)
        XCTAssertEqual(contact.contactId, contactFields["Id"] as! String)
        XCTAssertEqual(contact.name, contactFields["Name"] as! String)
        XCTAssertEqual(contact.firstName, contactFields["FirstName"] as! String)
        XCTAssertEqual(contact.lastName, contactFields["LastName"] as! String)
        XCTAssertEqual(contact.lastName, contactFields["LastName"] as! String)
        XCTAssertEqual(contact.phoneNumber, contactFields["Phone"] as! String)
        XCTAssertEqual(contact.email, contactFields["Email"] as! String)
        XCTAssertEqual(contact.birthDate, contactFields["Birthdate"] as! String)
        XCTAssertFalse(contact.buyerFlag, contactFields["SGWS_Buying_Power__c"] as! String)
        XCTAssertEqual(contact.accountId, contactFields["AccountId"] as! String)
        XCTAssertEqual(contact.accountSite, contactFields["Account.SWS_Account_Site__c"] as! String)
        XCTAssertEqual(contact.accountSiteNumber, contactFields["SGWS_Account_Site_Number__c"] as! String)
        XCTAssertEqual(contact.title, contactFields["Title"] as! String)
        XCTAssertEqual(contact.department, contactFields["Department"] as! String)
        XCTAssertEqual(contact.preferredName, contactFields["SGWS_Preferred_Name__c"] as! String)
        XCTAssertEqual(contact.contactHours, contactFields["SGWS_Contact_Hours__c"] as! String)
        XCTAssertEqual(contact.sgwsNotes, contactFields["SGWS_Notes__c"] as! String)
        XCTAssertEqual(contact.lastModifiedByName, contactFields["LastModifiedBy.Name"] as! String)
        XCTAssertEqual(contact.lastModifiedDate, contactFields["SGWS_AppModified_DateTime__c"] as! String)
        XCTAssertEqual(contact.child1Name, contactFields["SGWS_Child_1_Name__c"] as! String)
        XCTAssertEqual(contact.child1Birthday, contactFields["SGWS_Child_1_Birthday__c"] as! String)
        XCTAssertEqual(contact.child2Name, contactFields["SGWS_Child_2_Name__c"] as! String)
        XCTAssertEqual(contact.child2Birthday, contactFields["SGWS_Child_2_Birthday__c"] as! String)
        XCTAssertEqual(contact.child3Name, contactFields["SGWS_Child_3_Name__c"] as! String)
        XCTAssertEqual(contact.child3Birthday, contactFields["SGWS_Child_3_Birthday__c"] as! String)
        XCTAssertEqual(contact.child4Name, contactFields["SGWS_Child_4_Name__c"] as! String)
        XCTAssertEqual(contact.child4Birthday, contactFields["SGWS_Child_4_Birthday__c"] as! String)
        XCTAssertEqual(contact.child5Name, contactFields["SGWS_Child_5_Name__c"] as! String)
        XCTAssertEqual(contact.child5Birthday, contactFields["SGWS_Child_5_Birthday__c"] as! String)
        XCTAssertEqual(contact.anniversary, contactFields["SGWS_Anniversary__c"] as! String)
        XCTAssertEqual(contact.likes, contactFields["SGWS_Likes__c"] as! String)
        XCTAssertEqual(contact.dislikes, contactFields["SGWS_Dislikes__c"] as! String)
        XCTAssertEqual(contact.dislikes, contactFields["SGWS_Dislikes__c"] as! String)
        XCTAssertEqual(contact.favouriteActivities, contactFields["SGWS_Favorite_Activities__c"] as! String)
        XCTAssertEqual(contact.lifeEvents, contactFields["SGWS_Life_Events__c"] as! String)
        XCTAssertEqual(contact.lifeEventDate, contactFields["SGWS_Life_Events_Date__c"] as! String)
        XCTAssertEqual(contact.fax, contactFields["Fax"] as! String)
        XCTAssertEqual(contact.otherSpecification, contactFields["SGWS_Other_Specification__c"] as! String)
        XCTAssertEqual(contact.functionRole, contactFields["SGWS_Roles__c"] as! String)
        XCTAssertEqual(contact.preferredCommunicationMethod, contactFields["SGWS_Preferred_Communication_Method__c"] as! String)
        XCTAssertEqual(contact.contactClassification, contactFields["SGWS_Contact_Classification__c"] as! String)
        
    }
    
    func testToJson() {
        
        let contact = Contact(for: "test Json")
        let result = contact.toJson()
        XCTAssertEqual(result["Id"] as! String, contact.contactId)
        XCTAssertEqual(result["FirstName"] as! String, contact.firstName)
        XCTAssertEqual(result["LastName"] as! String, contact.lastName)
        XCTAssertEqual(result["Phone"] as! String, contact.phoneNumber)
        XCTAssertEqual(result["Email"] as! String, contact.email)
        XCTAssertEqual(result["AccountId"] as! String, contact.accountId)
        XCTAssertEqual(result["SGWS_AppModified_DateTime__c"] as! String, contact.lastModifiedDate)
        XCTAssertEqual(result["SGWS_Title__c"] as! String, contact.title)
        XCTAssertEqual(result["Department"] as! String, contact.department)
        //XCTAssertEqual(result["SGWS_Roles__c"] as! String, contact.functionRole)
        XCTAssertEqual(result["SGWS_Preferred_Name__c"] as! String, contact.preferredName)
        XCTAssertEqual(result["SGWS_Contact_Hours__c"] as! String, contact.contactHours)
        //XCTAssertEqual(result["SGWS_Preferred_Communication_Method__c"] as! String, contact.preferredCommunicationMethod)
        XCTAssertEqual(result["SGWS_Notes__c"] as! String, contact.sgwsNotes)
        XCTAssertEqual(result["SGWS_Child_1_Name__c"] as! String, contact.child1Name)
        //XCTAssertEqual(result["SGWS_Child_1_Birthday__c"] as! String, contact.child1Birthday)
        XCTAssertEqual(result["SGWS_Child_2_Name__c"] as! String, contact.child2Name)
        //XCTAssertEqual(result["SGWS_Child_2_Birthday__c"] as! String, contact.child2Birthday)
        XCTAssertEqual(result["SGWS_Child_3_Name__c"] as! String, contact.child3Name)
        //XCTAssertEqual(result["SGWS_Child_3_Birthday__c"] as! String, contact.child3Birthday)
        XCTAssertEqual(result["SGWS_Child_4_Name__c"] as! String, contact.child4Name)
        //XCTAssertEqual(result["SGWS_Child_4_Birthday__c"] as! String, contact.child4Birthday)
        XCTAssertEqual(result["SGWS_Child_5_Name__c"] as! String, contact.child5Name)
        //XCTAssertEqual(result["SGWS_Child_5_Birthday__c"] as! String, contact.child5Birthday)
        //XCTAssertEqual(result["SGWS_Anniversary__c"] as! String, contact.anniversary)
        XCTAssertEqual(result["SGWS_Likes__c"] as! String, contact.likes)
        XCTAssertEqual(result["SGWS_Dislikes__c"] as! String, contact.dislikes)
        XCTAssertEqual(result["SGWS_Dislikes__c"] as! String, contact.dislikes)
        XCTAssertEqual(result["SGWS_Favorite_Activities__c"] as! String, contact.favouriteActivities)
        XCTAssertEqual(result["SGWS_Life_Events__c"] as! String, contact.lifeEvents)
        //XCTAssertEqual(result["SGWS_Life_Events_Date__c"] as! String, contact.lifeEventDate)
        XCTAssertEqual(result["SGWS_Other_Specification__c"] as! String, contact.otherSpecification)
        //XCTAssertEqual(result["SGWS_Contact_Classification__c"] as! String, contact.contactClassification)
        XCTAssertEqual(result["_soupEntryId"] as! Int, contact._soupEntryId)
        
    }
    
    //    func testGetInitials(){
    //        let contact = Contact(for: "mockup")
    //        XCTAssertEqual(contact.getIntials(name: "Daniel Brown"), "DB")
    //        XCTAssertEqual(contact.getIntials(name: "Justin Timber"), "JT")
    //        XCTAssertEqual(contact.getIntials(name: "Amber Heard"), "AH")
    //        XCTAssertEqual(contact.getIntials(name: "Devin Miller"), "DM")
    //        XCTAssertEqual(contact.getIntials(name: "Keaton Mckinneyr"), "KM")
    //        XCTAssertEqual(contact.getIntials(name: "James Bond"), "JB")
    //        XCTAssertEqual(contact.getIntials(name: "Rosh Jacob"), "RJ")
    //        XCTAssertNotEqual(contact.getIntials(name: "Rosh Jacob"), "JR")
    //    }
    
    func testSortByContactNameAscending() {
        let listOfMockContactData = MockContactDataProvider.getListOfMockContactObjects()
        var contactsArraySorted = ContactSortUtility.sortByContactNameAlphabetically(contactsListToBeSorted: listOfMockContactData, ascending: true)
        XCTAssertEqual(contactsArraySorted[0].name, "contactTest")
        XCTAssertEqual(contactsArraySorted[1].name, "mockContactTest")
        XCTAssertEqual(contactsArraySorted[2].name, "test1")
    }
    
    func testSortByContactNameDescending() {
        let listOfMockContactData = MockContactDataProvider.getListOfMockContactObjects()
        var contactsArraySorted = ContactSortUtility.sortByContactNameAlphabetically(contactsListToBeSorted: listOfMockContactData, ascending: false)
        XCTAssertEqual(contactsArraySorted[0].name, "test1")
        XCTAssertEqual(contactsArraySorted[1].name, "mockContactTest")
        XCTAssertEqual(contactsArraySorted[2].name, "contactTest")
    }
    
    //Account ID search
    func testContactSearchBySearchBarQuery1() {
        var listOfMockContactData = MockContactDataProvider.getListOfMockContactObjects()
        let contactArrayAfterSearch = ContactSortUtility.searchContactBySearchBarQuery(contactsForLoggedUser: listOfMockContactData, searchText: "AAG")
        if(contactArrayAfterSearch.count != 1) {
            XCTFail()
        }
        
        let desiredContact: Contact = contactArrayAfterSearch[0]
        if(desiredContact.accountId != "001m000000cHLa7AAG") {
            XCTFail()
        }
        
        listOfMockContactData.removeAll()
    }
    
    //Contact Name search
    func testContactSearchBySearchBarQuery2() {
        var listOfMockContactData = MockContactDataProvider.getListOfMockContactObjects()
        let contactArrayAfterSearch = ContactSortUtility.searchContactBySearchBarQuery(contactsForLoggedUser: listOfMockContactData, searchText: "Test")
        if(contactArrayAfterSearch.count != 3){
            XCTFail()
        }
        listOfMockContactData.removeAll()
    }
    
    //Test setBuyingPower
    //    func testSetBuyingPowerFalse() {
    //        let obj = ContactClassificationTableViewCell()
    //        obj.setBuyingPower(value: false)
    //        XCTAssertEqual(obj.buyingPower, false)
    //    }
    //
    //Test getContactsData in SearchForContactTableViewCell
    //    func testGetContactData() {
    //        let obj = SearchForContactTableViewCell()
    //        let contactAfterFiltered = obj.getContactsData(searchStr: "Becky")
    //        if contactAfterFiltered.count != 1 {
    //            XCTFail()
    //        }
    //    }
    
    func testdisplayLocationItemCellContent(){
        let contact = ContactMenuTableTableViewCell()
        let index = IndexPath()
        XCTAssertNotNil(contact.displayLocationItemCellContent(indexPath: index, placeHolderText: ""))
    }
    
    //PrimaryFunctionTableViewCell
    func testPrimarytextFieldShouldReturn(){
        let primary = PrimaryFunctionTableViewCell()
        let textField = UITextField()
        XCTAssertNotNil(primary.textFieldShouldReturn(textField))
    }
    
    //NameTableViewCell
    func testNametextFieldShouldReturn(){
        let primary = NameTableViewCell()
        let textField = UITextField()
        XCTAssertNotNil(primary.textFieldShouldReturn(textField))
    }
    
    //SchedulerComponent
    func testConvenienceInit(){
        let schedule = SchedulerComponent.init()
        XCTAssertNotNil(schedule)
    }
    
    //ContactMenuViewController
    func testViewDidDisappear(){
        let contact = ContactMenuViewController()
        XCTAssertNotNil(contact.viewDidDisappear(true))
        XCTAssertNotNil(contact.didReceiveMemoryWarning())
    }
    
    func testTableViewTitleForHeaderInSection(){
        let contact = ContactMenuViewController()
        let table =  UITableView()
        XCTAssertNotNil(contact.tableView(table, titleForHeaderInSection: 1))
    }
    
    func testSearchBarTextDidChange(){
        let contact = ContactMenuViewController()
        let search = UISearchBar()
        XCTAssertNotNil(contact.searchBar(search, textDidChange: "hello"))
        XCTAssertNotNil(contact.searchBar(search, textDidChange: ""))
    }
    
    func testSearchBarSearchButtonClicked(){
        let contact = ContactMenuViewController()
        let search = UISearchBar()
        XCTAssertNotNil(contact.searchBarSearchButtonClicked(search))
    }
    
    //DateFieldTableViewCell
    func testDateTextFieldShouldReturn(){
        let date = DateFieldTableViewCell()
        let text = UITextField()
        XCTAssertNotNil(date.textFieldShouldReturn(text))
    }
    
    func testSortContactData(){
        let contact = ContactListViewController()
        XCTAssertNotNil(contact.sortContactData(searchString: "a"))
    }
    
    func testHomeViewCycle(){
        let home = HomeViewController()
        XCTAssertNotNil(home.viewWillDisappear(true))
    }
    
    //SearchForContactTableViewCell
    func testTextFieldShouldReturn(){
        let contact = SearchForContactTableViewCell()
        let text = UITextField()
        XCTAssertNotNil(contact.textFieldShouldReturn(text))
    }
    
    func testContactsViewControllerClearAllMenu(){
        let contact = ContactsViewController()
        XCTAssertNotNil(contact.clearAllMenu())
    }
    
    func testContactListDetailsViewControllerClearAllMenu(){
        let contact = ContactListDetailsViewController()
        XCTAssertNotNil(contact.clearAllMenu())
    }
    
    func testCreateContactToSoup() {
        _ = VisitSchedulerViewModel().createNewContactToSoup(object:MockContactDataProvider.mockTestContact1())
    }
    
    func testContactViewModel() {
        let contactViewModel = ContactsViewModel()
        _ = contactViewModel.userVieModel
        _ = contactViewModel.contactsWithBuyingPower(forAccount: "001m000000cHLa7AAG")
        _ = contactViewModel.contactsForSG(forAccount: "001m000000cHLa7AAG")
        _ = contactViewModel.globalContacts()
        _ = contactViewModel.sgwsEmployeeContacts()
        _ = contactViewModel.contacts(forAccount: "001m000000cHLa7AAG")
        _ = contactViewModel.accountsForContacts()
        _ = contactViewModel.activeAccountsForContacts()
        _ = contactViewModel.linkedAccountsForContact(with: "xxxAAW")
        _ = contactViewModel.contactIdForACR(with: "xxxAAW")
        _ = contactViewModel.createNewContactToSoup(object: MockContactDataProvider.mockTestContact1())
        _ = contactViewModel.editNewContactToSoup(object: MockContactDataProvider.mockTestContact3())
    }
    
    func testSyncContactWithServer() {
        let contactViewModel = ContactsViewModel()
        let expectation = XCTestExpectation(description: "contacts sync")
        contactViewModel.syncContactWithServer{ error in
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
        
        let expectation1 = XCTestExpectation(description: "ACR sync")
        contactViewModel.syncACRwithServer{ error in
            expectation1.fulfill()
        }
        wait(for: [expectation1], timeout: 10.0)
    }
    
}
