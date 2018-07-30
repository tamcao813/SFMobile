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
    
    
    func testTableViewDidDeselectRowAt(){
        let account = AccountsMenuViewController()
        let index = IndexPath()
        let tableView = UITableView()
        XCTAssertNotNil(account.tableView(tableView, didDeselectRowAt: index))
    }
    
    func testTextFieldDidEndEditing(){
        let account = AccountsMenuTableTableViewCell()
        let textField = UITextField()
        XCTAssertNotNil(account.textFieldDidEndEditing(textField))
    }
    
    func testViewModel(){
        let account = AccountsViewController()
        XCTAssertNotNil(account.viewWillDisappear(true))
    }
    
    //CustomerHeaderTableViewCell
    func testSetSelectedCustomerHeaderTableViewCell(){
        let custom = CustomerHeaderTableViewCell()
        XCTAssertNotNil(custom.setSelected(true, animated: true))
    }
    
    //ParentViewController
    func testDidReceiveMemoryWarning(){
        let parent = ParentViewController()
        XCTAssertNotNil(parent.didReceiveMemoryWarning())
    }
    
    //EditAccountStrategyViewController
    func testMemoryWarning(){
        let strategy =  EditAccountStrategyViewController()
        XCTAssertNotNil(strategy.didReceiveMemoryWarning())
    }
    
    func testCloseAcion(){
        let account = AccountView()
        XCTAssertNotNil(account.closeAction((Any).self))
    }
    
    //AssociateTableViewCell
    func testAssociateSetSelected(){
        let associate = AssociateTableViewCell()
        XCTAssertNotNil(associate.setSelected(false, animated: false))
    }
    
    //AccountDetailsViewController
    func testDismissEditNote() {
        let accountDetailsObj = AccountDetailsViewController()
        XCTAssertNotNil(accountDetailsObj.dismissEditNote())
        XCTAssertNotNil(accountDetailsObj.displayAccountNotes())
        XCTAssertNotNil(accountDetailsObj.noteCreated())
    }
    
    func testAccountsDidReceiveMemoryWarning(){
        let account = AccountsMenuViewController()
        XCTAssertNotNil(account.didReceiveMemoryWarning())
    }
    
    func testSearchBarSearchButtonClicked(){
        let account = AccountsMenuViewController()
        let search = UISearchBar()
        XCTAssertNotNil(account.searchBarSearchButtonClicked(search))
    }
    
    func testForegroundBackground() {
        
        let appInstace = UIApplication.shared.delegate!
        appInstace.applicationWillEnterForeground!(UIApplication.shared)
        appInstace.applicationDidEnterBackground!(UIApplication.shared)
        appInstace.applicationWillResignActive!(UIApplication.shared)
        appInstace.applicationWillTerminate!(UIApplication.shared)
        
    }
    
    //ActionItemViewController
    func testActionItemViewControllerViewWillAppear(){
        let appear = ActionItemsViewController()
        XCTAssertNotNil(appear.viewWillAppear(true))
    }
    
    func testActionItemViewControllerViewWillDisappear(){
        let disAppear = ActionItemsViewController()
        XCTAssertNotNil(disAppear.viewWillDisappear(true))
    }
    
    //ActionItemModalTableViewCell
    
    func testActionItemModalTableViewCellAwakeFromNib(){
        let awake = ActionItemModalTableViewCell()
        XCTAssertNotNil(awake.awakeFromNib())
    }
    
    //ActionItemTitleTableViewCell
    
    func testTextFieldShouldReturnActionItem(){
        let actionitem = ActionItemTitleTableViewCell()
        let textField = UITextField()
        XCTAssertNotNil(actionitem.textFieldShouldReturn(textField))
    }
    func testSortCalendarData(){
        let calendarObj = CalendarListViewController()
        XCTAssertNotNil(calendarObj.sortCalendarData(searchString: "Blender"))
    }
    //DayHomeCalendarViewController
    func testTapDate(){
        let calendar = DayHomeCalendarViewController()
        let date = Date()
        XCTAssertNotNil(calendar.tap(date: date))
    }
    
    //CalendarMonthViewController
    
    func testCalendarMonthViewController(){
        let cal = CalendarMonthViewController()
        XCTAssertNotNil(cal.didReceiveMemoryWarning())
    }
    
    func testNavigateTheScreenToContacts() {
        let calendarObj = CalendarMonthViewController()
        let temp = LoadThePersistantMenuScreen.contacts
        let temp1 = LoadThePersistantMenuScreen.actionItems
        XCTAssertNotNil(calendarObj.navigateTheScreenToContactsInPersistantMenu(data: temp))
        XCTAssertNotNil(calendarObj.navigateTheScreenToContactsInPersistantMenu(data: temp1))
        XCTAssertNotNil(calendarObj.navigateTheScreenToActionItemsInPersistantMenu(data: temp1))
        XCTAssertNotNil(calendarObj.navigateToAccountScreen())
        XCTAssertNotNil(calendarObj.navigateToVisitListing())
    }
    
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
    
    func testSearchBarButtonClickedContactMenuVC(){
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
    func testTextFieldShouldReturnSearchForContact(){
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
    
    func testSafelyLimitedTo() {
        let str :String = "1234566777"
        let invalidPhoneNum = "Welcome"
        _ = str.safelyLimitedTo(length: 3)
        _ = str.safelyLimitedTo(length: str.count)
        _ = str.isPhoneNumber
        _ = invalidPhoneNum.isPhoneNumber
        
    }
    
    func testCornerRadius() {
        let view = UIView()
        view.cornerRadius = 10
        view.borderWidth = 10
        view.borderColor = UIColor.red
        view.shadowRadius = 10
        view.shake()
        view.dropShadow()
        view.backgroundColor = UIColor(hexString: "#4287C2FF")
    }
    
    func testUITextFieldExtension() {
        let textField = UITextField()
        textField.text = "1272772727272"
        _ = textField.maxLength
        textField.maxLength = 10
        textField.fix(textField: textField)
        
    }
    
    func testNotesRandomNumberGen(){
        let cnote = CreateNoteViewController()
        let randomId = cnote.generateRandomIDForNotes()
        XCTAssertNotNil(randomId)
    }
    
    func testEditNoteFunc(){
        let enote = EditNoteViewController()
        XCTAssertNotNil(enote.displayAccountNotes())
        XCTAssertNotNil(enote.noteCreated())
        XCTAssertNotNil(enote.navigateToNotesSection())
        XCTAssertNotNil(enote.dismissEditNote())
    }
    
    func testNoteViewFunc(){
        let note = NotesViewController()
        XCTAssertNotNil(note.dismissEditNote())
        XCTAssertNotNil(note.noteCreated())
        XCTAssertNotNil(note.navigateToNotesSection())
    }
    
    //EditNoteViewController
    func testNotesDelegate(){
        let notesObj = EditNoteViewController()
        XCTAssertNotNil(notesObj.displayAccountNotes())
        XCTAssertNotNil(notesObj.noteCreated())
        XCTAssertNotNil(notesObj.navigateToNotesSection())
        XCTAssertNotNil(notesObj.dismissEditNote())
    }
    
    //NotesViewController
    func testNotesNavigateDelegate()  {
        let noteObj = NotesViewController()
        XCTAssertNotNil(noteObj.navigateToNotesSection())
        XCTAssertNotNil(noteObj.noteCreated())
        XCTAssertNotNil(noteObj.dismissEditNote())
    }
    
    func generateRandomIDForNotes()->String  {
        //  Make a variable equal to a random number....
        let randomNum:UInt32 = arc4random_uniform(99999999) // range is 0 to 99
        // convert the UInt32 to some other  types
        let someString:String = String(randomNum)
        return someString
    }
    
    //NotificationsViewController
    
    func testNotificationsViewControllerViewWillAppear(){
        let appear = NotificationsViewController()
        XCTAssertNotNil(appear.viewWillAppear(true))
    }
    
    //NotificationModalTableViewCell
    
    func testNotificationModalTableViewCellAwakeFromNib(){
        let awake = NotificationModalTableViewCell()
        XCTAssertNotNil(awake.awakeFromNib())
    }
    
    func testconvertToDictionary(){
        let visit = DuringVisitsTopicsViewController()
        XCTAssertNil(visit.convertToDictionary(text: "Hello"))
    }
    
    func testNavigateToVisitSummaryScreen(){
        let visit = AccountVisitSummaryViewController()
        XCTAssertNotNil(visit.navigateToVisitSummaryScreen())
    }
    
    func testRefresh(){
        let visit = DuringVisitsViewController()
        XCTAssertNotNil(visit.refreshStrategyScreenToLoadNewData())
    }
    
    func testEeventViewDidLoad(){
        let event = EventSummaryViewController()
        XCTAssertNotNil(event.viewDidLoad())
    }
    
    //ButtonTableViewCell
    func testButtonTableViewCellAwakeFromNib(){
        let button =  ButtonTableViewCell()
        XCTAssertNotNil(button.awakeFromNib())
    }
    
    func testButtonTableViewCellSetSelected(){
        let button =  ButtonTableViewCell()
        XCTAssertNotNil(button.setSelected(true, animated: true))
    }
    
    //InsightsSourceUnderSoldTableViewCell
    func testInsightsUnderSoldAwakeFromNib(){
        let insights = InsightsSourceUnderSoldTableViewCell()
        XCTAssertNotNil(insights.awakeFromNib())
    }
    
    func testInsightsUnderSoldShowDropDownMenu(){
        let insights = InsightsSourceUnderSoldTableViewCell()
        let button = UIButton()
        XCTAssertNotNil(insights.showDropDownMenu(sender: button))
    }
    
    //InsightsSourceTopSellerTableViewCell
    
    func testInsightsTopSellerAwakeFromNib(){
        let insights = InsightsSourceTopSellerTableViewCell()
        XCTAssertNotNil(insights.awakeFromNib())
    }
    
    func testInsightsTopSellerShowDropDownMenu(){
        let insights = InsightsSourceTopSellerTableViewCell()
        let button = UIButton()
        XCTAssertNotNil(insights.showDropDownMenu(sender: button))
    }
    
    //AccountsUndersoldTableViewCell
    func testAccountAwakeFromNib(){
        let undersold = AccountsUndersoldTableViewCell()
        XCTAssertNotNil(undersold.awakeFromNib())
    }
    
    //TitleDepartmentTableViewCell
    func testTextFieldShouldReturnTitleDepartmentTableViewCell(){
        let title = TitleDepartmentTableViewCell()
        let textField = UITextField()
        XCTAssertNotNil(title.textFieldShouldReturn(textField))
    }
    
    //DuringVisitsInsightsViewController
    func testProductNameButtonCLicked(){
        let visit = DuringVisitsInsightsViewController()
        let button = UIButton()
        XCTAssertNotNil(visit.productNameButtonCLicked(sender: button))
    }
    
    func testSourceButtonClicked(){
        let visit = DuringVisitsInsightsViewController()
        let button = UIButton()
        XCTAssertNotNil(visit.sourceButtonCLicked(sender: button))
    }
    
    func testCommitAmtButtonCLicked(){
        let visit = DuringVisitsInsightsViewController()
        let button = UIButton()
        XCTAssertNotNil(visit.commitAmtButtonCLicked(sender: button))
    }
    
    func testOutcomeButtonCLicked(){
        let visit = DuringVisitsInsightsViewController()
        let button = UIButton()
        XCTAssertNotNil(visit.outcomeButtonCLicked(sender: button))
    }
    
    func testAccountOverViewViewController(){
        let acc = AccountOverViewViewController()
        let temp = LoadThePersistantMenuScreen.chatter
        XCTAssertNotNil(acc.navigateTheScreenToActionItemsInPersistantMenu(data: temp))
        XCTAssertNotNil(acc.navigateToVisitListing())
        let temp2 = LoadThePersistantMenuScreen.contacts
        XCTAssertNotNil(acc.navigateTheScreenToContactsInPersistantMenu(data: temp2))
        XCTAssertNotNil(acc.navigateToAccountScreen())
    }
    
    //CalendarFilter, Filter, AccountVisitListFilter
    
    func testFilterSectionNames(){
        let calfil = CalendarFilter()
        XCTAssertNotNil(calfil.sectionNames(isManager: false))
        XCTAssertNotNil(calfil.sectionNames(isManager: true))
        
        let fil = Filter()
        XCTAssertNotNil(fil.sectionNames(isManager: false))
        XCTAssertNotNil(fil.sectionNames(isManager: true))
        
        let filt = AccountVisitListFilter()
        XCTAssertNotNil(filt.sectionNames(isManager: false))
        XCTAssertNotNil(filt.sectionNames(isManager: true))
    }
    
    
}
