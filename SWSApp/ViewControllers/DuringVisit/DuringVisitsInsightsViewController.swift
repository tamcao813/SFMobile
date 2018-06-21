//
//  DuringVisitsInsightsViewController.swift
//  SWSApp
//
//  Created by r.a.jantakal on 27/04/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation
import UIKit
import IQKeyboardManagerSwift


class DuringVisitsInsightsViewController : UIViewController,SourceTableCellDelegate,InsightsUndersoldSourceTableCellDelegate,InsightsSourceUnsoldTableCellDelegate{
 
    func updateDataFromTopSellerCellTextfield(_ index: Int,commit: String) {
        opportunityList[index].commit = commit
        DuringVisitsInsightsViewController.modifiedCommitOpportunitiesList.append(opportunityList[index])
    }
    
    func updateDataFromTopSellerCellButton(_index: Int, outcome: String) {
       // var modifiedOutcomeObject : NSDictionary?
        let modifiedOutcomeObject = NSMutableDictionary()
        modifiedOutcomeObject.setValue(opportunityList[_index].id, forKey: "Id")
        modifiedOutcomeObject.setValue(outcome, forKey: "SGWS_Outcome__c")
        DuringVisitsInsightsViewController.modifiedOutcomeWorkOrderList.append(modifiedOutcomeObject)
    }
    
    
    func updateDataFromUnsoldTableCellTextField(_ index: Int,commit: String) {
        opportunityList[index].commit = commit
        DuringVisitsInsightsViewController.modifiedCommitOpportunitiesList.append(opportunityList[index])
    }
    
    func updateDataFromUnsoldTableCellButtton(_index: Int, outcome: String) {
       // var modifiedOutcomeObject : NSDictionary?
        let modifiedOutcomeObject = NSMutableDictionary()
        modifiedOutcomeObject.setValue(opportunityList[_index].id, forKey: "Id")
        modifiedOutcomeObject.setValue(outcome, forKey: "SGWS_Outcome__c")
        DuringVisitsInsightsViewController.modifiedOutcomeWorkOrderList.append(modifiedOutcomeObject)
    }
    

    func updateDataFromUndersoldTableCellTextfield(_ index: Int,commit: String) {
        opportunityList[index].commit = commit
        DuringVisitsInsightsViewController.modifiedCommitOpportunitiesList.append(opportunityList[index])
    }
    
    func updateDataFromUndersoldTableCellButton(index: Int, outcome: String) {
     
        let modifiedOutcomeObject = NSMutableDictionary()
        modifiedOutcomeObject.setValue(opportunityList[index].id, forKey: "Id")
        modifiedOutcomeObject.setValue(outcome, forKey: "SGWS_Outcome__c")
        DuringVisitsInsightsViewController.modifiedOutcomeWorkOrderList.append(modifiedOutcomeObject)
    }
    

    @IBOutlet weak var insightsTableViewController : UITableView?
    @IBOutlet weak var accNameLbl : UILabel?
    @IBOutlet weak var pinCodeLbl : UILabel?
    @IBOutlet weak var accAddressLbl : UILabel?
    var visitInformation :WorkOrderUserObject?
    var opportunityList = [Opportunity]()
    var accountObject: Account?
    var pickListValuesForOpportunities = [String]()
    var collectionViewRowDetails : NSMutableArray?
    
    static var modifiedCommitOpportunitiesList = [Opportunity]()
    static var modifiedOutcomeWorkOrderList = [NSDictionary]()
   //
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        IQKeyboardManager.shared.enable = true
        self.fetchAccountDetails()
        
        accNameLbl?.text = accountObject?.accountName
        pinCodeLbl?.text = accountObject?.accountNumber
        accAddressLbl?.text = getFullAccountAddress()
        opportunityList = OpportunitySortUtility().opportunityFor(forAccount: (PlanVisitManager.sharedInstance.visit?.accountId)!)
        let plistPath = Bundle.main.path(forResource: "Insights", ofType: ".plist", inDirectory: nil)
        let dictionary = NSMutableDictionary(contentsOfFile: plistPath!)
        collectionViewRowDetails = dictionary!["New item"] as? NSMutableArray
        
        let outcomePicklistValues = PlistMap.sharedInstance.getPicklist(fieldname: "outcomePicklistValue")
        for plistOption in outcomePicklistValues {
            pickListValuesForOpportunities.append(plistOption.value)
        }
        
        insightsTableViewController?.contentInsetAdjustmentBehavior = .never
    }
    
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DuringVisitsInsightsViewController.modifiedCommitOpportunitiesList = [Opportunity]()
        DuringVisitsInsightsViewController.modifiedOutcomeWorkOrderList = [NSDictionary]()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    
    //Fetch the from Accounts View Model
    func fetchAccountDetails(){
        if let accountId = visitInformation?.accountId {
            let accountsArray = AccountsViewModel().accountsForLoggedUser()
            accountObject = accountsArray.filter({$0.account_Id == accountId }).first
        }
    }
    
    
    func getFullAccountAddress()->String {
        
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
        
        return fullAddress
    }
  

}

//MARK:- TableView Delegate Methods
extension DuringVisitsInsightsViewController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK:- TableView DataSource Methods
extension DuringVisitsInsightsViewController : UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return opportunityList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let currentOpportunity:Opportunity = opportunityList[indexPath.row]
        switch currentOpportunity.source {
        case "What's Hot","Top Seller":
             let cell = tableView.dequeueReusableCell(withIdentifier: "insightsTopSellerTableViewCell", for: indexPath) as! InsightsSourceTopSellerTableViewCell
             
            cell.productNameLabel.text = currentOpportunity.productName
            cell.sourceLabel.text = currentOpportunity.source
            cell.r12Label.text = currentOpportunity.R12
            cell.r6TrendLabel.text = currentOpportunity.R6Trend
            cell.r3TrendLabel.text = currentOpportunity.R3Trend
            cell.commitAmtTextFiels.text = currentOpportunity.commit
            cell.cellDelegate = self
            cell.commitAmtTextFiels.tag = indexPath.row
            cell.outcomeButton.tag = indexPath.row
            cell.dropDown.dataSource = pickListValuesForOpportunities
            return cell
            
        case "Undersold":
            let cell = tableView.dequeueReusableCell(withIdentifier: "insightsUnderSoldTableViewCell", for: indexPath) as! InsightsSourceUnderSoldTableViewCell
            cell.productNameLabel.text = currentOpportunity.productName
            cell.sourceLabel.text = currentOpportunity.source
            cell.accLabel.text = currentOpportunity.acct
            cell.segmentLabel.text = currentOpportunity.segment
            cell.gapLabel.text = currentOpportunity.gap
            cell.commitAmtTextFiels.text = currentOpportunity.commit
            cell.commitAmtTextFiels.tag = indexPath.row
            cell.outcomeButton.tag = indexPath.row
            cell.cellDelegate = self
            cell.dropDown.dataSource = pickListValuesForOpportunities
            return cell
            
        case "Unsold":
            let cell = tableView.dequeueReusableCell(withIdentifier: "insightsUnsoldTableViewCell", for: indexPath) as! InsightsSourceUnsoldTableViewCell
            cell.productNameLabel.text = currentOpportunity.productName
            cell.sourceLabel.text = currentOpportunity.source
            cell.unsoldPeriodLabel.text = "Unsold Period\n" + currentOpportunity.unsoldPeriodDays
            cell.commitAmtTextFiels.text = currentOpportunity.commit
            cell.commitAmtTextFiels.tag = indexPath.row
            cell.outcomeButton.tag = indexPath.row
            cell.cellDelegate = self
            cell.dropDown.dataSource = pickListValuesForOpportunities
            return cell
            
        default:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "insightsTopSellerTableViewCell", for: indexPath) as! InsightsSourceTopSellerTableViewCell
            cell.productNameLabel.text = currentOpportunity.productName
            cell.sourceLabel.text = currentOpportunity.source
            cell.r12Label.text = currentOpportunity.acct
            cell.r6TrendLabel.text = currentOpportunity.segment
            cell.r3TrendLabel.text = currentOpportunity.gap
            cell.commitAmtTextFiels.text = currentOpportunity.commit
            cell.commitAmtTextFiels.tag = indexPath.row
            cell.outcomeButton.tag = indexPath.row
            cell.cellDelegate = self
            cell.dropDown.dataSource = pickListValuesForOpportunities
            return cell
            
        }
    }
}


