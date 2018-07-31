//
//  OpportunitySortUtilityTests.swift
//  SWSAppTests
//
//  Created by Krishna, Kamya on 7/30/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import XCTest
@testable import SWSApp

class OpportunitySortUtilityTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
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
    
    func testSearchOpportunityBySearchBarQuery() {
        let OpportunityFields: [String : Any] = [ "Id": "1", "AccountId": "2", "SGWS_Source__c": "TopSeller", "SGWS_PYCM_Sold__c": "10", "SGWS_Commit__c": "0.1", "SGWS_Sold__c": "1000", "SGWS_Month_Active__c": "June", "StageName": "Seller", "SGWS_R12__c": "1.0", "SGWS_R6_Trend__c": "2.0", "SGWS_R3_Trend__c": "3.0", "SGWS_Acct__c": "188", "SGWS_Segment__c": "Talent", "SGWS_Gap__c": "100", "SGWS_Sales_Trend__c": "Sales", "SGWS_Order_Size__c": "19", "SGWS_Order_Frequency__c": "100", "SGWS_Unsold_Period_Days__c": "100"]
        
        let opport = Opportunity.init(json: OpportunityFields)
        opport.accountId = "001i000001IUjJCAA1"
        OpportunitiesFilterMenuModel.statusOpen = "Closed"
        opport.status = "Closed"
        _ =  OpportunitySortUtility().searchOpportunityBySearchBarQuery(opportunityToSearch: [opport], searchText: "test")
        
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
    
    func testOpportunityFor(){
        let obj = OpportunitySortUtility()
        let result = obj.opportunityFor(forAccount: "0060t00000AbqZnAAJ")
        XCTAssertEqual(result.count, 0)
    }
    
}
