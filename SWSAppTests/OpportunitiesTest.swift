//
//  OpportunitiesTest.swift
//  SWSAppTests
//
//  Created by Krishna, Kamya on 7/26/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import XCTest
import SmartSync
@testable import SWSApp

class OpportunitiesTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testinitOpportunity() {
        let opport = Opportunity.init(for: "")
        XCTAssertEqual(opport.id, "" )
        XCTAssertEqual(opport.source, "" )
        XCTAssertEqual(opport.PYCMSold, "" )
        XCTAssertEqual(opport.commit, "" )
        XCTAssertEqual(opport.sold, "" )
        XCTAssertEqual(opport.monthActive, "" )
        XCTAssertEqual(opport.status, "" )
        XCTAssertEqual(opport.R6Trend, "" )
        XCTAssertEqual(opport.R3Trend, "" )
        XCTAssertEqual(opport.acct, "" )
        XCTAssertEqual(opport.segment, "" )
        XCTAssertEqual(opport.gap, "" )
        XCTAssertEqual(opport.salesTrend, "" )
        XCTAssertEqual(opport.orderSize, "" )
        XCTAssertEqual(opport.orderFrequency, "" )
        XCTAssertEqual(opport.unsoldPeriodDays, "" )
        XCTAssertEqual(opport.objectiveNames, "" )
        XCTAssertEqual(opport.objectiveTypes, "" )
        XCTAssertEqual(opport.productName, "" )
        XCTAssertEqual(opport.productID, "" )
        XCTAssertEqual(opport.itemBottlesPerCase, 1.0)
        XCTAssertEqual(opport.itemSize, 0.0)
        XCTAssertEqual(opport.brand, "" )
        XCTAssertEqual(opport.PYCMSold9L, "" )
        XCTAssertEqual(opport.commit9L, "" )
        XCTAssertEqual(opport.sold9L, "" )
        
    }
    
    func testInitJsonopportunity() {
        
        let OpportunityFields: [String : Any] = [ "Id": "", "AccountId": "", "SGWS_Source__c": "", "SGWS_PYCM_Sold__c": "", "SGWS_Commit__c": "", "SGWS_Sold__c": "", "SGWS_Month_Active__c": "", "StageName": "", "SGWS_R12__c": "", "SGWS_R6_Trend__c": "", "SGWS_R3_Trend__c": "", "SGWS_Acct__c": "", "SGWS_Segment__c": "", "SGWS_Gap__c": "", "SGWS_Sales_Trend__c": "", "SGWS_Order_Size__c": "", "SGWS_Order_Frequency__c": "", "SGWS_Unsold_Period_Days__c": ""]
        
        let opport = Opportunity.init(json: OpportunityFields)
        XCTAssertEqual(opport.id, OpportunityFields["Id"] as! String)
        XCTAssertEqual(opport.accountId, OpportunityFields["AccountId"] as! String)
        XCTAssertEqual(opport.source, OpportunityFields["SGWS_Source__c"] as! String)
        XCTAssertEqual(opport.PYCMSold, OpportunityFields["SGWS_PYCM_Sold__c"] as! String)
        XCTAssertEqual(opport.commit, OpportunityFields["SGWS_Commit__c"] as! String)
        XCTAssertEqual(opport.sold, OpportunityFields["SGWS_Sold__c"] as! String)
        XCTAssertEqual(opport.monthActive, OpportunityFields["SGWS_Month_Active__c"] as! String)
        XCTAssertEqual(opport.status, OpportunityFields["StageName"] as! String)
        XCTAssertEqual(opport.R12, OpportunityFields["SGWS_R12__c"] as! String)
        XCTAssertEqual(opport.R6Trend, OpportunityFields["SGWS_R6_Trend__c"] as! String)
        XCTAssertEqual(opport.R3Trend, OpportunityFields["SGWS_R3_Trend__c"] as! String)
        XCTAssertEqual(opport.acct, OpportunityFields["SGWS_Acct__c"] as! String)
        XCTAssertEqual(opport.segment, OpportunityFields["SGWS_Segment__c"] as! String)
        XCTAssertEqual(opport.gap, OpportunityFields["SGWS_Gap__c"] as! String)
        XCTAssertEqual(opport.salesTrend, OpportunityFields["SGWS_Sales_Trend__c"] as! String)
        XCTAssertEqual(opport.orderSize, OpportunityFields["SGWS_Order_Size__c"] as! String)
        XCTAssertEqual(opport.orderFrequency, OpportunityFields["SGWS_Order_Frequency__c"] as! String)
        XCTAssertEqual(opport.unsoldPeriodDays, OpportunityFields["SGWS_Unsold_Period_Days__c"] as! String)
        XCTAssertEqual(opport.objectiveNames, "")
        XCTAssertEqual(opport.objectiveTypes, "")
        XCTAssertEqual(opport.productName, "")
        XCTAssertEqual(opport.productID, "")
        XCTAssertEqual(opport.itemBottlesPerCase, 1.0)
        XCTAssertEqual(opport.itemSize, 0.0 )
        XCTAssertEqual(opport.brand, "")
        XCTAssertEqual(opport.PYCMSold9L, "")
        XCTAssertEqual(opport.commit9L, "")
        XCTAssertEqual(opport.sold9L, "")
        
    }
    
    func testOpportunityCInit(){
        let opportunityFields: [Any] = [ "Id", "OwnerId", "AccountId", "SGWS_Source__c", "SGWS_PYCM_Sold__c", "SGWS_Commit__c", "SGWS_Sold__c", "SGWS_Month_Active__c", "StageName", "SGWS_R12__c", "SGWS_R6_Trend__c", "SGWS_R3_Trend__c", "SGWS_Acct__c", "SGWS_Segment__c", "SGWS_Gap__c", "SGWS_Sales_Trend__c", "SGWS_Order_Size__c", "SGWS_Order_Frequency__c", "SGWS_Unsold_Period_Days__c",  "Opportunity_Objective_Junction__r", "OpportunityLineItems" ]
        let opportunity = Opportunity.init(withAry: opportunityFields)
        XCTAssertNotNil(opportunity)
    }
    
    func testOpportunityDidReceiveMemoryWarning(){
        let opportunity = OpportunitiesViewController()
        XCTAssertNotNil(opportunity.didReceiveMemoryWarning())
    }
    
    //OpportunitiesMenuViewController
    func testDidReceiveMemoryWarning(){
        let opportunity = OpportunitiesMenuViewController()
        XCTAssertNotNil(opportunity.didReceiveMemoryWarning())
    }
    
    //OpportunitiesListViewCell
    
    func testOpportunityListtAwakeNib(){
        let opportunity = OpportunitiesListViewCell()
        XCTAssertNotNil(opportunity.awakeFromNib())
    }
    
    func testOpportunityListSetSelected(){
        let opportunity = OpportunitiesListViewCell()
        XCTAssertNotNil(opportunity.setSelected(true, animated: true))
    }
    
    //OpportunitiesListTableViewCell
    
    func testOpportunityListTableAwakeNib(){
        let opportunity = OpportunitiesListTableViewCell()
        XCTAssertNotNil(opportunity.awakeFromNib())
    }
    
    func testOpportunityListTableSetSelected(){
        let opportunity = OpportunitiesListTableViewCell()
        XCTAssertNotNil(opportunity.setSelected(true, animated: true))
    }
    
    func testProcessOpportunity() {
        let OpportunityFields: [String : Any] = [ "Id": "1", "AccountId": "2", "SGWS_Source__c": "TopSeller", "SGWS_PYCM_Sold__c": "10", "SGWS_Commit__c": "0.1", "SGWS_Sold__c": "1000", "SGWS_Month_Active__c": "June", "StageName": "Seller", "SGWS_R12__c": "1.0", "SGWS_R6_Trend__c": "2.0", "SGWS_R3_Trend__c": "3.0", "SGWS_Acct__c": "188", "SGWS_Segment__c": "Talent", "SGWS_Gap__c": "100", "SGWS_Sales_Trend__c": "Sales", "SGWS_Order_Size__c": "19", "SGWS_Order_Frequency__c": "100", "SGWS_Unsold_Period_Days__c": "100"]
        
        let opport = Opportunity.init(json: OpportunityFields)
        opport.processOpportunity(OpportunityFields)
    }
    
    func testValueAfterConversionToLiters() {
        
        let OpportunityFields: [String : Any] = [ "Id": "1", "AccountId": "2", "SGWS_Source__c": "TopSeller", "SGWS_PYCM_Sold__c": "10", "SGWS_Commit__c": "0.1", "SGWS_Sold__c": "1000", "SGWS_Month_Active__c": "June", "StageName": "Seller", "SGWS_R12__c": "1.0", "SGWS_R6_Trend__c": "2.0", "SGWS_R3_Trend__c": "3.0", "SGWS_Acct__c": "188", "SGWS_Segment__c": "Talent", "SGWS_Gap__c": "100", "SGWS_Sales_Trend__c": "Sales", "SGWS_Order_Size__c": "19", "SGWS_Order_Frequency__c": "100", "SGWS_Unsold_Period_Days__c": "100"]
        
        let opport = Opportunity.init(json: OpportunityFields)
        _ =  opport.valueAfterConversionToLiters("10 ML")
        _ =  opport.valueAfterConversionToLiters("10 L")
        _ =  opport.valueAfterConversionToLiters("")
        _ =  opport.valueAfterConversionToLiters("0.0")
    }
    
    func testValueAfter9Lcalculation() {
        let OpportunityFields: [String : Any] = [ "Id": "1", "AccountId": "2", "SGWS_Source__c": "TopSeller", "SGWS_PYCM_Sold__c": "10", "SGWS_Commit__c": "0.1", "SGWS_Sold__c": "1000", "SGWS_Month_Active__c": "June", "StageName": "Seller", "SGWS_R12__c": "1.0", "SGWS_R6_Trend__c": "2.0", "SGWS_R3_Trend__c": "3.0", "SGWS_Acct__c": "188", "SGWS_Segment__c": "Talent", "SGWS_Gap__c": "100", "SGWS_Sales_Trend__c": "Sales", "SGWS_Order_Size__c": "19", "SGWS_Order_Frequency__c": "100", "SGWS_Unsold_Period_Days__c": "100"]
        
        let opport = Opportunity.init(json: OpportunityFields)
        _ = opport.valueAfter9Lcalculation("19.092")
        
    }
    
    func testValueAfterConversionToString() {
        let OpportunityFields: [String : Any] = [ "Id": "1", "AccountId": "2", "SGWS_Source__c": "TopSeller", "SGWS_PYCM_Sold__c": "10", "SGWS_Commit__c": "0.1", "SGWS_Sold__c": "1000", "SGWS_Month_Active__c": "", "StageName": "Seller", "SGWS_R12__c": "1.0", "SGWS_R6_Trend__c": "2.0", "SGWS_R3_Trend__c": "3.0", "SGWS_Acct__c": "188", "SGWS_Segment__c": "Talent", "SGWS_Gap__c": "100", "SGWS_Sales_Trend__c": "Sales", "SGWS_Order_Size__c": "19", "SGWS_Order_Frequency__c": "100", "SGWS_Unsold_Period_Days__c": "100"]
        let opport = Opportunity.init(json: OpportunityFields)
        _ = opport.valueAfterConversionToString(OpportunityFields, key: "SGWS_Month_Active__c")
        _ = opport.valueAfterConversionToString(OpportunityFields, key: "June")
        _ = opport.valueAfterConversionToString(OpportunityFields, key: "07")
        _ = opport.valueAfterConversionToString(OpportunityFields, key: "7.00")
        _ = opport.valueAfterConversionToString(OpportunityFields, key: "")
        
    }
    
    func testProcessOpportunityLineItems () {
        let OpportunityFields: [String : Any] = [ "Product2Id": "", "Name": "Sample Product", "SGWS_CORP_ITEM_BOTTLES_PER_CASE__c": "0", "SGWS_CORP_ITEM_SIZE__c": "10", "SGWS_Corp_Brand__c": " "]
        let opport = Opportunity.init(json: OpportunityFields)
        opport.processOpportunityLineItems(OpportunityFields)
        XCTAssertEqual(opport.productID, "")
        
    }
    
    func testOpportunityObjectiveInit(){
        let opportunity = OpportunityObjective.init(for: "")
        XCTAssertEqual(opportunity.recordId, "")
        XCTAssertEqual(opportunity.OpportunityId, "")
        XCTAssertEqual(opportunity.ObjectiveName, "")
        XCTAssertEqual(opportunity.ObjectiveType, "")
    }
    
    
    //To be tested
    
    func testOpportunityObjectiveJsonInit(){
        
        let objectiveStr = "{\"attributes\":{\"type\":\"SGWS_Objectives__c\",\"url\":\"/services/data/v42.0/sobjects/SGWS_Objectives__c/a4v0t0000007ovsAAA\"},\"Name\":\"TestObjectives\",\"SGWS_Select_Objective_Type__c\":\"Decimal Case\"}"
        let opportunityStr = "{\"attributes\":{\"type\":\"Opportunity\",\"url\":\"/services/data/v42.0/sobjects/Opportunity/0060t00000AdDH4AAN\"},\"Id\":\"0060t00000AdDH4AAN\"}"
        
        let opportunityObjectiveFields: [String:Any] = [ "Id":"a4w0t000000CcfwAAC", "SGWS_Opportunity__r":opportunityStr, "SGWS_Objectives__r": objectiveStr]
        
        let opportunity = OpportunityObjective.init(json: opportunityObjectiveFields)
        XCTAssertEqual(opportunity.recordId, opportunityObjectiveFields["Id"] as! String)
        XCTAssertEqual(opportunity.OpportunityId, opportunity.OpportunityId)
        //XCTAssertEqual(opportunity.ObjectiveName, "")
        //XCTAssertEqual(opportunity.ObjectiveType, "")
    }
    
    func testEditCommitToSoup() {
        _ = StoreDispatcher.shared.editOpportunityCommitToSoup(fieldsToUpload: ["id":"0060t00000AdAveAAF","SGWS_Commit__c":"0.1"])
        
    }
    
    func testFilterOpportunityByFilterByStatus() {
        
        var opp = [Opportunity]()
        
        let opport1 = Opportunity.init(json: ["":""])
        opport1.status = "Open"
        OpportunitiesFilterMenuModel.statusOpen = "YES"
        opp.append(opport1)
        
        let opport2 = Opportunity.init(json: ["":""])
        opport2.status = "Planned"
        OpportunitiesFilterMenuModel.statusPlanned = "YES"
        opp.append(opport2)
        
        let opport3 = Opportunity.init(json: ["":""])
        opport3.status = "Closed Won"
        OpportunitiesFilterMenuModel.statusClosedWon = "YES"
        opp.append(opport3)
        
        let opport4 = Opportunity.init(json: ["":""])
        opport4.status = "Closed"
        OpportunitiesFilterMenuModel.statusClosed = "YES"
        opp.append(opport4)
        
        _ = OpportunitySortUtility.filterOpportunityByFilterByStatus(opportunityToBeFiltered: opp)
        
    }
    
    func testFilterOpportunityByFilterBySource() {
        
        var opp = [Opportunity]()
        
        let opport1 = Opportunity.init(json: ["":""])
        opport1.source = "Top Sellers"
        OpportunitiesFilterMenuModel.sourceTopSellers = "YES"
        opp.append(opport1)
        
        let opport2 = Opportunity.init(json: ["":""])
        opport2.source = "Unsold"
        OpportunitiesFilterMenuModel.sourceUnsold = "YES"
        opp.append(opport2)
        
        let opport3 = Opportunity.init(json: ["":""])
        opport3.source = "Book Of Business"
        OpportunitiesFilterMenuModel.sourceOverview = "YES"
        opp.append(opport3)
        
        let opport4 = Opportunity.init(json: ["":""])
        opport4.source = "What's Hot/What's Not"
        OpportunitiesFilterMenuModel.sourceHotNot = "YES"
        opp.append(opport4)
        
        let opport5 = Opportunity.init(json: ["":""])
        opport5.source = "Undersold"
        OpportunitiesFilterMenuModel.sourceUndersold = "YES"
        opp.append(opport5)
        
        _ = OpportunitySortUtility.filterOpportunityByFilterBySource(opportunityToBeFiltered: opp)
        
    }
    
    func testFilterOpportunityByFilterByObjective() {
        
        var opp = [Opportunity]()
        
        let opport1 = Opportunity.init(json: ["":""])
        opport1.objectiveTypes = "9L"
        OpportunitiesFilterMenuModel.objective9L = "YES"
        opp.append(opport1)
        
        let opport2 = Opportunity.init(json: ["":""])
        opport2.objectiveTypes = "Decimal"
        OpportunitiesFilterMenuModel.objectiveDecimal = "YES"
        opp.append(opport2)
        
        let opport3 = Opportunity.init(json: ["":""])
        opport3.objectiveTypes = "Revenue"
        OpportunitiesFilterMenuModel.objectiveRevenue = "YES"
        opp.append(opport3)
        
        let opport4 = Opportunity.init(json: ["":""])
        opport4.objectiveTypes = "ACS"
        OpportunitiesFilterMenuModel.objectiveACS = "YES"
        opp.append(opport4)
        
        let opport5 = Opportunity.init(json: ["":""])
        opport5.objectiveTypes = "POD"
        OpportunitiesFilterMenuModel.objectivePOD = "YES"
        opp.append(opport5)
        
        _ = OpportunitySortUtility.filterOpportunityByFilterByObjective(opportunityToBeFiltered: opp)
        
    }
    
    func testFilterOpportunityByFilterBySearchText() {
        
        var opp = [Opportunity]()
        
        let opport1 = Opportunity.init(json: ["":""])
        opport1.productName = "Product1"
        opp.append(opport1)
        
        let opport2 = Opportunity.init(json: ["":""])
        opport2.productName = "Abc"
        opp.append(opport2)
        
        _ = OpportunitySortUtility.filterOpportunityByFilterBySearchText(opportunityToBeFiltered: opp, searchText: "product")
        
    }
    
    func testOpportunityRemoveDuplicates() {
        
        var opp = [Opportunity]()
        
        let opport1 = Opportunity.init(json: ["":""])
        opport1.id = "1324"
        opp.append(opport1)
        
        let opport2 = Opportunity.init(json: ["":""])
        opport2.id = "1122"
        opp.append(opport2)
        
        let obj = OpportunitySortUtility()
        _ = obj.opportunityRemoveDuplicates(opp)
        
    }
    
    func getRandomId() -> String {
        
        //  Make a variable equal to a random number....
        let randomNum:UInt32 = arc4random_uniform(99999999) // range is 0 to 99
        // convert the UInt32 to some other  types
        let someString:String = String(randomNum)
        
        return someString
    }
    
    func testEditOpportunityOutcome() {
        
        let attributeDict = ["type":"WorkOrder"]
        let addNewDict: [String:Any] = [
            PlanVisit.planVisitFields[0]: "0WO0t000000L1LQGA0",
            PlanVisit.planVisitFields[1]: "",
            PlanVisit.planVisitFields[2]: "001i000001IUjJCAA1",
            PlanVisit.planVisitFields[3]: false,
            PlanVisit.planVisitFields[4]: "2018-07-17T08:30:00.000+0000",
            PlanVisit.planVisitFields[5]: "2018-07-17T11:30:00.000+0000",
            PlanVisit.planVisitFields[6]: "Sample and Tasting",
            PlanVisit.planVisitFields[7]: "",
            PlanVisit.planVisitFields[8]: "",
            PlanVisit.planVisitFields[9]: "Planned",
            PlanVisit.planVisitFields[10]:"2018-07-17T12:13:33.000+0000",
            PlanVisit.planVisitFields[11]: "",
            PlanVisit.planVisitFields[12]:"0120t0000008cMEAAY",
            PlanVisit.planVisitFields[13]:"47",
            PlanVisit.planVisitFields[14]:"",
            PlanVisit.planVisitFields[15]:"False",
            PlanVisit.planVisitFields[21]:"0.0",
            PlanVisit.planVisitFields[22]:"0.0",
            PlanVisit.planVisitFields[23]:"",
            PlanVisit.planVisitFields[24]:"0.0",
            PlanVisit.planVisitFields[25]:"0.0",
            PlanVisit.planVisitFields[26]:"",
            
            kSyncTargetLocal:true,
            kSyncTargetLocallyCreated:true,
            kSyncTargetLocallyUpdated:false,
            kSyncTargetLocallyDeleted:false,
            "attributes":attributeDict]
        
        _ = VisitSchedulerViewModel().editVisitToSoup(fields: addNewDict)
        
        _ = StoreDispatcher.shared.editOpportunityOutcomeToSoup(fieldsToUpload: [
            "Id": "0060t00000AdAveAAF",
            "SGWS_Outcome__c": "10",
            "SGWS_Work_Order__c":  "0WO0t000000L1LQGA0"])
        
        _ = StoreDispatcher.shared.editOpportunityOutcomeToSoup(fieldsToUpload: [
            "Id": "",
            "SGWS_Outcome__c": "10",
            "SGWS_Work_Order__c":  "0WO0t000000L1LQGA0"])
        
        
        _ = StoreDispatcher.shared.editOpportunityOutcomeToSoup(fieldsToUpload: [
            "Id": "0060t00000AdAveAAF",
            "SGWS_Outcome__c": "10",
            "SGWS_Work_Order__c":  ""])
        
        _ = StoreDispatcher.shared.editOpportunityOutcomeToSoup(fieldsToUpload: [
            "Id": "17828728",
            "SGWS_Outcome__c": "10",
            "SGWS_Work_Order__c":  "367376783"])
        
    }
    
    func testSearchOpportunityBySearchBarQuery() {
        let OpportunityFields: [String : Any] = [ "Id": "1", "AccountId": "2", "SGWS_Source__c": "TopSeller", "SGWS_PYCM_Sold__c": "10", "SGWS_Commit__c": "0.1", "SGWS_Sold__c": "1000", "SGWS_Month_Active__c": "June", "StageName": "Seller", "SGWS_R12__c": "1.0", "SGWS_R6_Trend__c": "2.0", "SGWS_R3_Trend__c": "3.0", "SGWS_Acct__c": "188", "SGWS_Segment__c": "Talent", "SGWS_Gap__c": "100", "SGWS_Sales_Trend__c": "Sales", "SGWS_Order_Size__c": "19", "SGWS_Order_Frequency__c": "100", "SGWS_Unsold_Period_Days__c": "100"]
        
        let opport = Opportunity.init(json: OpportunityFields)
        opport.accountId = "001i000001IUjJCAA1"
        OpportunitiesFilterMenuModel.statusOpen = "Closed"
        opport.status = "Closed"
        _ =  OpportunitySortUtility().searchOpportunityBySearchBarQuery(opportunityToSearch: [opport], searchText: "test")
        
    }
    
    func testCreateNewOpportunityWorkorderLocally() {
        let attributeDict = ["type":"SGWS_Opportunity_WorkOrder__c"]
        let addNewDict: [String:Any] = [
            OpportunityWorkorder.opportunityWorkorderFields[0]: getRandomId(),
            OpportunityWorkorder.opportunityWorkorderFields[1]: "0060t00000AdAveAAF",
            OpportunityWorkorder.opportunityWorkorderFields[2]: getRandomId(),
            OpportunityWorkorder.opportunityWorkorderFields[3]: "",
            "attributes":attributeDict]
        
        _ = StoreDispatcher.shared.createNewOpportunityWorkorderLocally(fieldsToUpload: addNewDict)
        _ = StoreDispatcher.shared.deleteOpportunityWorkorderLocally(fieldsToUpload: addNewDict)
        let opportunityViewModel = OpportunityViewModel()
        _ = opportunityViewModel.createNewOpportunityWorkorderLocally(fields: addNewDict)
    }
    
    func testDeleteOpportunityWorkorderLocally() {
        
    }
    
    func testOpportunityFor(){
        let obj = OpportunitySortUtility()
        let result = obj.opportunityFor(forAccount: "0060t00000AbqZnAAJ")
        XCTAssertEqual(result.count, 0)
    }
    
    func testSyncOpportunitysWithServer() {
        let oppoObj = OpportunityViewModel()
        let expectation = XCTestExpectation(description: "resync opportunity")
        oppoObj.syncOpportunitysWithServer{ error in
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
}
