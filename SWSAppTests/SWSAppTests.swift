//
//  SWSAppTests.swift
//  SWSAppTests
//
//  Created by maria.min-hui.yu on 3/21/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import XCTest
@testable import SWSApp

class SWSAppTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testValidDate(){
        let validate = Validations()
        XCTAssertTrue(validate.isValidDate(dateString: "04-23-2018"))
        XCTAssertFalse(validate.isValidDate(dateString: "23-04-2018"))
    }
    
    func testValidateEmail(){
        let validate = Validations()
        XCTAssertTrue(validate.isValidEmail(testStr: "abc@gmail.com"))
    }
    
    func testPhoneNumnber(){
        let validate = Validations()
        XCTAssertEqual(validate.validatePhoneNumber(phoneNumber: "(541) 754-3010"),"(541) 754-3010")
    }
    
    func testremoveSpecialCharsFromString(){
        let validObj = Validations()
        let result = validObj.removeSpecialCharsFromString(text: "#12334")
        XCTAssertEqual(result, "12334")
    }
    
    func testPhoneTable(){
        let validate = String()
        XCTAssertFalse(validate.isPhone())
    }
    
    func testRandomNumberGen(){
        let val = CreateNoteViewController()
        let ran = val.generateRandomIDForNotes()
        XCTAssertEqual(ran, ran)
    }
    
    func testAccountViewInitFrame(){
        
        let rect = CGRect(x: 0, y: 0, width: 100, height: 100)
        
        let test = AccountView.init(frame: rect)
        XCTAssertNotNil(test)
    }
    
    func testAccountViewInit(){
        
        let test = AccountView.init()
        XCTAssertNotNil(test)
    }
    
    func testDropShadow(){
        
        let color = UIColor.white
        let size = CGSize(width: 10, height: 20)
        
        let test = UIView()
        XCTAssertNotNil(test.dropShadow(color: color, offSet: size))
        
    }
    
    func testDropShadowTableView(){
        
        let color = UIColor.white
        let size = CGSize(width: 10, height: 20)
        
        let test = UITableView()
        XCTAssertNotNil(test.dropShadowTableView(color: color, offSet: size))
    }
    
    func testAddPickerView(){
        let text = UITextField()
        let test = ContactClassificationTableViewCell()
        XCTAssertNotNil(test.addPickerView(textField: text))
        
    }
    
    //StrategyQAViewModel
    
    func testFetchStrategy(){
        let strategy = "Competition Is About The Same"
        let test = StrategyQAViewModel()
        test.syncStrategyWithServer{error in
            
        }
        _ = test.editStrategyQALocally(fields: ["":""])
        
        
        let expectation = XCTestExpectation(description: "resyncStrategyAnswers")
        test.syncStrategyQuestionsWithServer{error in
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
        
        
        //completion handler test case
        let expectation1 = XCTestExpectation(description: "resyncStrategyAnswers")
        test.syncStrategyAnswersWithServer{ error in
            expectation1.fulfill()
        }
        wait(for: [expectation1], timeout: 10.0)
        //
        XCTAssertNotNil(test.fetchStrategy(acc: strategy))
    }
    
    //AccountTableViewCell
    
    func testSetSelected(){
        let test = AccountTableViewCell()
        let select = true
        let animation = true
        XCTAssertNotNil(test.setSelected(select, animated: animation))
        XCTAssertNotNil(test.setSelected(false, animated: animation))
    }
    
    //Extension
    
    func testIsPhoneNumber(){
        let test = String()
        XCTAssertFalse(test.isPhoneNumber)
    }
    
    func testShake(){
        let test = UIView()
        XCTAssertNotNil(test.shake())
    }
    
    func testAddPaddingLeft(){
        let test = UITextField()
        let val: CGFloat = 2.0
        XCTAssertNotNil(test.addPaddingLeft(val))
    }
    
    //SearchForContactTableViewCell
    
    func testGetContactsData(){
        let contact = "Aryton Senna"
        let test = SearchForContactTableViewCell()
        XCTAssertNotNil(test.getContactsData(searchStr: contact))
    }
    
    //AccountContactRelation
    
    func testAccountContactRelationToJson(){
        let accountContactRelationFields: [String: Any] = ["Id": "", "SGWS_Account__c": "", "SGWS_Contact__c": "", "Name": "", "SGWS_Account_Site_Number__c": "", "SGWS_isActive__c": "", "SGWS_Buying_Power__c": "", "SGWS_Roles__c": ""]
        
        let test = AccountContactRelation.init(json: accountContactRelationFields)
        XCTAssertNotNil(test.toJson())
    }
    
    //Contact
    
    func testContactToJson(){
        
        let contactFields: [String: Any] = ["Id": "", "Name": " ", "FirstName": "", "LastName": "", "Phone": "", "Email": "", "Birthdate": "","SGWS_Buying_Power__c": "false","AccountId": "", "Account.SWS_Account_Site__c": "","SGWS_Account_Site_Number__c": "","Title": "","Department": "","SGWS_Preferred_Name__c": "","SGWS_Contact_Hours__c": "","SGWS_Notes__c": "", "LastModifiedBy.Name": "","SGWS_AppModified_DateTime__c": "","SGWS_Child_1_Name__c": "","SGWS_Child_1_Birthday__c": "","SGWS_Child_2_Name__c": "","SGWS_Child_2_Birthday__c": "","SGWS_Child_3_Name__c": "","SGWS_Child_3_Birthday__c": "","SGWS_Child_4_Name__c": "","SGWS_Child_4_Birthday__c": "","SGWS_Child_5_Name__c": "","SGWS_Child_5_Birthday__c": "","SGWS_Anniversary__c": "","SGWS_Likes__c": "","SGWS_Dislikes__c": "","SGWS_Favorite_Activities__c": "","SGWS_Life_Events__c": "","SGWS_Life_Events_Date__c": "","Fax": "","SGWS_Other_Specification__c": "","SGWS_Roles__c": "","SGWS_Preferred_Communication_Method__c": "", "SGWS_Contact_Classification__c": ""]
        
        let test = Contact.init(withAry: contactFields)
        XCTAssertNotNil(test.toJson())
        
    }
    
    //PhoneTableViewCell
    
    func testDisplayCellContent(){
        let test = PhoneTableViewCell()
        XCTAssertNotNil(test.displayCellContent())
    }
    
    //String+PartString
    
    func testUnescapeXMLCharacter(){
        let exString = "Aryton Senna"
        let test = String()
        XCTAssertNotNil(test.unescapeXMLCharacter(stringValue: exString))
    }
    
    func testStripped(){
        let test = String()
        XCTAssertNotNil(test.stripped)
    }
    
    //Validations
    
    func testGetInitials(){
        let testVal = Validations()
        XCTAssertEqual(testVal.getIntials(name: "Daniel Brown"), "DB")
        XCTAssertEqual(testVal.getIntials(name: "Justin Timber"), "JT")
        XCTAssertNotEqual(testVal.getIntials(name: "Rosh Jacob"), "JR")
    }
    
    // MARK: - Tests for ViewWillDisappear()
    //ObjectivesViewController
    
    func testObjectivesViewControllerViewWillDisappear(){
        let test = ObjectivesViewController()
        XCTAssertNotNil(test.viewWillDisappear(true))
    }
    
    //ActionItemsViewController
    
    func testActionItemsViewControllerViewWillDisappear(){
        let test = ActionItemsViewController()
        XCTAssertNotNil(test.viewWillDisappear(true))
    }
    
    //InsightsViewController
    
    func testInsightsViewControllerViewWillDisappear(){
        let test = InsightsViewController()
        XCTAssertNotNil(test.viewWillDisappear(true))
    }
    
    //NotificationsViewController
    
    func testNotificationsViewControllerViewWillDisappear(){
        let test = NotificationsViewController()
        XCTAssertNotNil(test.viewWillDisappear(true))
    }
    
    //ReportsViewController
    
    func testReportsViewControllerViewWillDisappear(){
        let test = ReportsViewController()
        XCTAssertNotNil(test.viewWillDisappear(true))
        XCTAssertNotNil(test.viewWillAppear(true))
    }
    
    //OpportunitiesViewController
    
    func testOpportunitiesViewControllerViewWillDisappear(){
        let test = OpportunitiesViewController()
        XCTAssertNotNil(test.viewWillDisappear(true))
    }
    
    //SelectOpportunitiesViewController
    
    func testSelectOpportunitiesViewControllerViewDidDisappear(){
        let test = SelectOpportunitiesViewController()
        XCTAssertNotNil(test.viewDidDisappear(true))
    }
    
    func testCloseVC(){
        let opp = SelectOpportunitiesViewController()
        let button = UIButton()
        XCTAssertNotNil(opp.closeVC(sender: button))
    }
    
    func testSaveAndClose(){
        let opp = SelectOpportunitiesViewController()
        let button = UIButton()
        XCTAssertNotNil(opp.saveAndClose(sender: button))
    }
    
    func testAccountListViewLifeCycle(){
        let account = AccountsListViewController()
        XCTAssertNotNil(account.viewWillDisappear(true))
    }
    
    //WREventCell
    
    func testWREventCellBackgroundColorHighlighted(){
        let test = WREventCell()
        XCTAssertNotNil(test.backgroundColorHighlighted(true))
    }
    
    func testWREventCellTextColorHighlighted(){
        let test = WREventCell()
        XCTAssertNotNil(test.textColorHighlighted(true))
    }
    
    func testWREventCellBorderColor(){
        let test = WREventCell()
        XCTAssertNotNil(test.borderColor())
    }
    
    //UIColorExtension.swift
    
    func testUIColorExtensionConvenienceInit(){
        let test = UIColor.init(hex: 1)
        XCTAssertNotNil(test)
    }
    
    func testUIColorExtensionConvenienceInit2(){
        let test = UIColor.init(hex: 2, a: 2.0)
        XCTAssertNotNil(test)
    }
    
    func testUIColorExtensionConvenienceInit3(){
        let test = UIColor.init(r: 1, g: 2, b: 1)
        XCTAssertNotNil(test)
    }
    
    func testUIColorExtensionConvenienceInit4(){
        let test = UIColor.init(r: 1, g: 2, b: 1, a: 1.0)
        XCTAssertNotNil(test)
    }
    
    //ContactTableViewCell
    
    func testContactTableViewCellSetSelected(){
        let bVal = true
        let test = ContactTableViewCell()
        XCTAssertNotNil(test.setSelected(true, animated: bVal))
    }
    
    //HeadSubHeadTableViewCell
    
    func testHeadSubHeadTableViewCellAwakeFromNib(){
        let test = HeadSubHeadTableViewCell()
        XCTAssertNotNil(test.awakeFromNib())
    }
    
    func testHeadSubHeadTableViewCellDisplayCellContent(){
        let test = HeadSubHeadTableViewCell()
        XCTAssertNotNil(test.displayCellCOntent())
    }
    
    //UnorderedListTableViewCell test
    
    func testAwakeFromNib(){
        
        let test = UnorderedListTableViewCell()
        XCTAssertNotNil(test.awakeFromNib())
    }
    
    //ContactVisitLinkTableViewCell test
    
    func testAwakeFromNib2(){
        
        let test = ContactVisitLinkTableViewCell()
        XCTAssertNotNil(test.awakeFromNib())
        
    }
    
    //AccountTableViewCell
    
    func testAwakeFromNib3() {
        
        let test =  AccountTableViewCell()
        XCTAssertNotNil(test.awakeFromNib())
    }
    
    //AccountsUnsoldTableViewCell
    func testAwakeFromNib4() {
        
        let test = AccountsUnsoldTableViewCell()
        XCTAssertNotNil(test.awakeFromNib())
        
    }
    
    //AccountsSourceTopSellerTableViewCell
    func testAwakeFromNib5() {

        let test = AccountsSourceTopSellerTableViewCell()
        XCTAssertNotNil(test.awakeFromNib())
        
    }
    
    //InsightsSourceUnsoldTableViewCell
//    func testAwakeFromNib6() {
//        
//        let test = InsightsSourceUnsoldTableViewCell()
//        XCTAssertNotNil(test.awakeFromNib())
//        
//    }
    
    //AssociateTableViewCell
//    func testAwakeFromNib7() {
//        
//        let test = AssociateTableViewCell()
//        XCTAssertNotNil(test.awakeFromNib())
//    }
//    
    //NSObjectExtension
    
    func testNSObjectClassName(){
        let test = NSObject()
        XCTAssertNotNil(test.className)
    }
    
    //Extension
    
    func testExtensionBorderWidth(){
        let test = UIView()
        XCTAssertNotNil(test.borderWidth)
    }
    
    func testExtensionBorderColor(){
        let test = UIView()
        XCTAssertNotNil(test.borderColor)
    }
    
    //AccountDetailTabViewController
    
    func testAccountDetailTabViewControllerDidReceiveMemoryWarning(){
        let test = AccountDetailTabViewController()
        XCTAssertNotNil(test.didReceiveMemoryWarning())
    }
    
    //ContactsViewController
    
    func testContactsViewControllerViewWillDisappear(){
        let test = ContactsViewController()
        XCTAssertNotNil(test.viewWillDisappear(true))
    }
    
    func testContactsViewControllerTestPList(){
        let test = ContactsViewController()
        XCTAssertNotNil(test.testPlist())
    }
    
    //DuringVisitsViewController
    
    func testDuringVisitsViewControllerViewWillDisappear(){
        let test = DuringVisitsViewController()
        XCTAssertNotNil(test.viewWillDisappear(true))
    }
    
    func testDuringVisitsViewControllerViewDidAppear(){
        let test = DuringVisitsViewController()
        XCTAssertNotNil(test.viewDidAppear(true))
    }
    
    //CalendarViewController
    
    func testCalendarViewControllerDidReceiveMemoryWarning(){
        let test = CalendarViewController()
        XCTAssertNotNil(test.didReceiveMemoryWarning())
        
        let obj = CalendarListViewController()
        XCTAssertNotNil(obj.viewWillDisappear(true))
    }
    
    //CalendarMenuViewController
    
    func testCalendarMenuViewControllerDidReceiveMemoryWarning(){
        let test = CalendarMenuViewController()
        XCTAssertNotNil(test.didReceiveMemoryWarning())
    }
    
    //EmailTableViewCell
    
    func testEmailTableViewCellDisplayCellContent(){
        let test = EmailTableViewCell()
        XCTAssertNotNil(test.displayCellContent())
    }
    
    //ContactHoursTableViewCell
    
    func testContactHoursTableViewCellDisplayCellContent(){
        let test = ContactHoursTableViewCell()
        XCTAssertNotNil(test.displayCellContent())
    }
    
    //OpportunitiesViewController
    
    func testOpportunitiesViewControllerViewWillAppear(){
        let test = OpportunitiesViewController()
        XCTAssertNotNil(test.viewWillAppear(true))
    }
    
    func testOpportunitiesViewControllerViewDidLoad(){
        let test = OpportunitiesViewController()
        XCTAssertNotNil(test.viewDidLoad())
    }
    
    func testOpportunitiesViewControllerViewDidAppear(){
        let test = OpportunitiesViewController()
        XCTAssertNotNil(test.viewDidAppear(true))
    }
    
    //PhoneTableViewCell
    
    func testPhoneTableViewCellTextFieldDelegates(){
        let test = PhoneTableViewCell()
        let temp = UITextField()
        XCTAssertTrue(test.textFieldShouldReturn(temp))
        XCTAssertNotNil(test.textFieldDidBeginEditing(temp))
    }
    
    //ContactClassificationTableViewCell
    
    func testContactClassificationTableViewCellNumberOfComponents(){
        let test = ContactClassificationTableViewCell()
        let temp = UIPickerView()
        XCTAssertNotNil(test.numberOfComponents(in: temp))
    }
    
    func testContactClassificationTableViewCellPickerView(){
        let test = ContactClassificationTableViewCell()
        let temp = UIPickerView()
        XCTAssertNotNil(test.pickerView(temp, numberOfRowsInComponent: 2))
    }
    
    func testContactClassificationTableViewCellPickerView3(){
        let test = ContactClassificationTableViewCell()
        let temp = UIPickerView()
        XCTAssertNotNil(test.pickerView(temp, didSelectRow: 0, inComponent: 0))
    }
    
    func testTextFieldShouldReturn(){
        let test = ContactClassificationTableViewCell()
        let temp = UITextField()
        XCTAssertTrue(test.textFieldShouldReturn(temp))
    }
    
    func testTextFieldDidBeginEditing(){
        let test = ContactClassificationTableViewCell()
        let temp = UITextField()
        XCTAssertNotNil(test.textFieldDidBeginEditing(temp))
    }
    
    //FamilyTableViewCell
    func testFamilyTableViewCellTextFieldShouldReturn(){
        let test = FamilyTableViewCell()
        let temp = UITextField()
        XCTAssertTrue(test.textFieldShouldReturn(temp))
    }
    
    //NameTableViewCell
    func testNameTableViewCellTextFieldShouldReturn(){
        let test = NameTableViewCell()
        let temp = UITextField()
        XCTAssertTrue(test.textFieldShouldReturn(temp))
    }
    
    //PrimaryFunctionTableViewCell
    func testPrimaryFunctionTableViewCellTextFieldShouldReturn(){
        let test = PrimaryFunctionTableViewCell()
        let temp = UITextField()
        XCTAssertTrue(test.textFieldShouldReturn(temp))
    }
    
    //DateFieldTableViewCell
    func testdateFieldTableViewCellTextFieldShouldReturn(){
        let test = DateFieldTableViewCell()
        let temp = UITextField()
        XCTAssertTrue(test.textFieldShouldReturn(temp))
    }
    
    //EditAccountStrategyCollectionViewCell
    func testEditStrategyTextViewDidBeginEditing(){
        let test = EditAccountStrategyCollectionViewCell()
        let temp = UITextView()
        XCTAssertNotNil(test.textViewDidBeginEditing(temp))
    }
    
    //DateTimeUtility
    func testInitDate(){
        let date = Date()
        XCTAssertNotNil(date.age)
    }
    
    func testSet(){
        let date = Date()
        XCTAssertNotNil(date.set())
    }
    
    func testendOfDay(){
        let date = Date()
        XCTAssertNotNil(date.endOfDay)
    }
    
    func testHoursBetween(){
        let dateT = Date()
        let date =  Date.hoursBetween(start: dateT, end: dateT)
        XCTAssertNotNil(date)
    }
    
    //ContactHoursTableViewCell
    func testContactTextFieldShouldReturn(){
        let test = ContactHoursTableViewCell()
        let textField = UITextField()
        XCTAssertTrue(test.textFieldShouldReturn(textField))
    }
    
    func testContactHoursTextFieldDidBeginEditing(){
        let test = ContactHoursTableViewCell()
        let temp = UITextField()
        XCTAssertNotNil(test.textFieldDidBeginEditing(temp))
    }
    
    //DropdownTableViewCell
    func testDropTextFieldShouldReturn(){
        let test = DropdownTableViewCell()
        let textField = UITextField()
        XCTAssertTrue(test.textFieldShouldReturn(textField))
    }
    
    //EmailTableViewCell
    func testEmailTextFieldShouldReturn(){
        let test = EmailTableViewCell()
        let textField = UITextField()
        XCTAssertTrue(test.textFieldShouldReturn(textField))
    }
    
    func testGenerateIdForEntry(){
        let randomId = AlertUtilities.generateRandomIDForNewEntry()
        XCTAssertNotNil(randomId)
    }
    
    func testTunescapeXMLCharacter(){
        
        let textField = "name"
        
        let test = String()
        XCTAssertNotNil(test.unescapeXMLCharacter(stringValue: textField))
        XCTAssertEqual(test.unescapeXMLCharacter(stringValue: ""), "")
        XCTAssertEqual(test.unescapeXMLCharacter(stringValue: "&#39;"), "'")
        XCTAssertEqual(test.unescapeXMLCharacter(stringValue: "&amp;"), "&")
        XCTAssertEqual(test.unescapeXMLCharacter(stringValue: "&#38;"), "\"")
        XCTAssertEqual(test.unescapeXMLCharacter(stringValue: "&#34;"), "\"")
        XCTAssertEqual(test.unescapeXMLCharacter(stringValue: "&#60;"), "<")
        XCTAssertEqual(test.unescapeXMLCharacter(stringValue: "&#62;"), "'")
        XCTAssertEqual(test.unescapeXMLCharacter(stringValue: "&#169;"), "©")
        XCTAssertEqual(test.unescapeXMLCharacter(stringValue: "&quot;"), "\"")
    }
    
    //MARK:- WR Tests
    
    //WRTodayBackground
    
    func testWRTodayBackgroundInit(){
        
        let rect = CGRect(x: 0, y: 0, width: 100, height: 100)
        
        let test = WRTodayBackground.init(frame: rect)
        XCTAssertNotNil(test)
    }
    
    //WRRowHeaderBackground
    
    func testWRRowHeaderBackground(){
        
        let rect = CGRect(x: 0, y: 0, width: 100, height: 100)
        
        let test = WRRowHeaderBackground.init(frame: rect)
        XCTAssertNotNil(test)
    }
    
    //WRGridLine
    
    func testWRGridLine(){
        
        let rect = CGRect(x: 0, y: 0, width: 100, height: 100)
        
        let test = WRGridLine.init(frame: rect)
        XCTAssertNotNil(test)
        
    }
    
    //WRColumnHeaderBackground
    
    func testWRColumnHeaderBackground(){
        
        let rect = CGRect(x: 0, y: 0, width: 100, height: 100)
        
        let test = WRColumnHeaderBackground.init(frame: rect)
        XCTAssertNotNil(test)
        
    }
    
    //WRCornerHeader
    
    func testWRCornerHeader(){
        
        let rect = CGRect(x: 0, y: 0, width: 100, height: 100)
        
        let test = WRCornerHeader.init(frame: rect)
        XCTAssertNotNil(test)
        
    }
    
    func testWRCurrentTimeGridline(){
        
        let rect = CGRect(x: 0, y: 0, width: 100, height: 100)
        
        let test = WRCurrentTimeGridline.init(frame: rect)
        XCTAssertNotNil(test)
    }
    
    //WRCurrentTimeIndicator
    
    func testWRCurrentTimeIndicator(){
        
        let rect = CGRect(x: 0, y: 0, width: 100, height: 100)
        
        let test = WRCurrentTimeIndicator.init(frame: rect)
        XCTAssertNotNil(test)
    }
    
    //Scheduler Component
    func testSchedulerComponentInit(){
        
        let rect = CGRect(x: 0, y: 0, width: 100, height: 100)
        
        let test = SchedulerComponent.init(frame: rect)
        XCTAssertNotNil(test)
    }
    
    //DateTimeUtility
    
    func testconvertUtcDatetoReadableDate(){
        let date =  DateTimeUtility.convertUtcDatetoReadableDate(dateStringfromAccountNotes: "")
        XCTAssertNotNil(date, "")
    }
    
    func testconvertUtcDatetoReadableDateLikeStrategy(){
        let date = DateTimeUtility.convertUtcDatetoReadableDateLikeStrategy(dateString: "")
        XCTAssertNotNil(date, "")
    }
    
    func testgetEEEEMMMdFormattedDateString(){
        let time = Date()
        let date = DateTimeUtility.getEEEEMMMdFormattedDateString(date: time)
        XCTAssertNotNil(date, date)
    }
    
    func testgetDateFromyyyyMMddTimeFormattedDateString(){
        let date = DateTimeUtility.getDDMMYYYFormattedDateString(dateStringfromAccountObject: "")
        XCTAssertNotNil(date)
    }
    
    func testConvertUtcDatetoReadableDateMMDDYYYY(){
        let date = DateTimeUtility.convertUtcDatetoReadableDateMMDDYYYY(dateString: "")
        XCTAssertNotNil(date)
    }
    
    func testIsWeekend() {
        _ = DateTimeUtility.isWeekend(date: Date())
    }
    
    func testGetDateFromStringFormat() {
        _ = DateTimeUtility.getDateFromStringFormat(dateStr: "17-7-201")
        
    }
    
    func testGetDayForVisitCurrentWeek() {
        let accCtr = AccountOverViewViewController()
        _ = accCtr.getDayForVisitCurrentWeek(dateToConvert: "2018-07-16T00:00:00.000+0000")
        _ = accCtr.getDayForVisitCurrentWeek(dateToConvert: "2018-07-17T00:00:00.000+0000")
        _ = accCtr.getDayForVisitCurrentWeek(dateToConvert: "2018-07-18T00:00:00.000+0000")
        _ = accCtr.getDayForVisitCurrentWeek(dateToConvert: "2018-07-19T00:00:00.000+0000")
        _ = accCtr.getDayForVisitCurrentWeek(dateToConvert: "2018-07-20T00:00:00.000+0000")
        _ = accCtr.getDayForVisitCurrentWeek(dateToConvert: "2018-07-21T00:00:00.000+0000")
        _ = accCtr.getDayForVisitCurrentWeek(dateToConvert: "2018-07-22T00:00:00.000+0000")
        _ = accCtr.getDayForVisitCurrentWeek(dateToConvert: "2018-07-23T00:00:00.000+0000")
        
    }
    
    func testGetDayFromActionItem() {
        let accCtr = AccountOverViewViewController()
        _ = accCtr.getDayFromActionItem(dateToConvert: "2018-07-20")
        _ = accCtr.getDayFromActionItem(dateToConvert: "2018-07-21")
        _ = accCtr.getDayFromActionItem(dateToConvert: "2018-07-22")
        _ = accCtr.getDayFromActionItem(dateToConvert: "2018-07-23")
        _ = accCtr.getDayFromActionItem(dateToConvert: "2018-07-24")
        _ = accCtr.getDayFromActionItem(dateToConvert: "2018-07-25")
        _ = accCtr.getDayFromActionItem(dateToConvert: "2018-07-26")
        _ = accCtr.getDayFromActionItem(dateToConvert: "2018-07-27")
        _ = accCtr.getDayFromActionItem(dateToConvert: "2018-07-28")
        _ = accCtr.getDayFromActionItem(dateToConvert: "2018-07-29")
        _ = accCtr.getDayFromActionItem(dateToConvert: "2018-07-30")
        
    }
    
    func testGetDayFromVisit() {
        let accCtr = AccountOverViewViewController()
        _ = accCtr.getDayFromVisit(dateToConvert: "2018-07-20T00:00:00.000+0000")
        _ = accCtr.getDayFromVisit(dateToConvert: "2018-07-21T00:00:00.000+0000")
        _ = accCtr.getDayFromVisit(dateToConvert: "2018-07-22T00:00:00.000+0000")
        _ = accCtr.getDayFromVisit(dateToConvert: "2018-07-23T00:00:00.000+0000")
        _ = accCtr.getDayFromVisit(dateToConvert: "2018-07-24T00:00:00.000+0000")
        _ = accCtr.getDayFromVisit(dateToConvert: "2018-07-25T00:00:00.000+0000")
        _ = accCtr.getDayFromVisit(dateToConvert: "2018-07-26T00:00:00.000+0000")
        _ = accCtr.getDayFromVisit(dateToConvert: "2018-07-27T00:00:00.000+0000")
        _ = accCtr.getDayFromVisit(dateToConvert: "2018-07-28T00:00:00.000+0000")
        _ = accCtr.getDayFromVisit(dateToConvert: "2018-07-29T00:00:00.000+0000")
        _ = accCtr.getDayFromVisit(dateToConvert: "2018-07-30T00:00:00.000+0000")
        
    }
    
    func testNavigateTheScreenToContactsInPersistantMenu() {
        let dayHomeCalendar = DayHomeCalendarViewController()
        dayHomeCalendar.navigateTheScreenToContactsInPersistantMenu(data: LoadThePersistantMenuScreen.contacts)

        dayHomeCalendar.navigateTheScreenToActionItemsInPersistantMenu(data: LoadThePersistantMenuScreen.actionItems)
        dayHomeCalendar.navigateToVisitListing()
        dayHomeCalendar.navigateToAccountScreen()
    }

    func testDisableEmojis() {
        let test = AlertUtilities.disableEmojis(text: "abc")
        XCTAssertTrue(test)
        let test1 = AlertUtilities.disableEmojis(text: "Ω")
        XCTAssertEqual(test1, false)
    }
    
    func testInsightsSourceUnsoldTableViewCell() {
        let insightsSOurceCell = InsightsSourceUnsoldTableViewCell()
        //insightsSOurceCell.awakeFromNib()
        insightsSOurceCell.showDropDownMenu(sender: UIButton())
    }
    
    //InsightsSourceUnsoldTableViewCell
    func testInsightsSourceUnsoldDropDown(){
        let ins = InsightsSourceUnsoldTableViewCell()
        let temp = UIButton()
        XCTAssertNotNil(ins.showDropDownMenu(sender: temp))
    }
    
    //AppDelegate
    func testAppDelegate(){
        let app = AppDelegate()
        XCTAssertNotNil(app.resetLaunchandResyncConfiguration())
    }
    
    //CalendarListViewController
//    func testCalendarListViewController(){
//        let cal = CalendarListViewController()
//        XCTAssertNotNil(cal.viewWillDisappear(true))
//        
//        XCTAssertNotNil(cal.navigateToVisitListing())
//        
//        let temp2 = LoadThePersistantMenuScreen.actionItems
//        XCTAssertNotNil(cal.navigateTheScreenToActionItemsInPersistantMenu(data: temp2))
//        
//        let temp3 = LoadThePersistantMenuScreen.contacts
//        XCTAssertNotNil(cal.navigateTheScreenToContactsInPersistantMenu(data: temp3))
//        
//        XCTAssertNotNil(cal.navigateToAccountScreen())
//        XCTAssertNotNil(cal.arrayFetch())
//        
//    }
    
    //StoreDispatcher
    func testStoreDispatcher(){
        let sd = StoreDispatcher()
        XCTAssertNotNil(sd.registerSoups())
        
    }
    
}
