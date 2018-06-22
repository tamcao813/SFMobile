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
    
    @IBOutlet weak var insightsTableViewController : UITableView?
    @IBOutlet weak var accNameLbl : UILabel?
    @IBOutlet weak var pinCodeLbl : UILabel?
    @IBOutlet weak var accAddressLbl : UILabel?
    
    var visitInformation :WorkOrderUserObject?
    var opportunityList = [Opportunity]()
    var accountObject: Account?
    var pickListValuesForOpportunities = [String]()
    var collectionViewRowDetails : NSMutableArray?
    var pickerOptions = [[String:Any]]()

    
    static var modifiedCommitOpportunitiesList = [Opportunity]()
    static var modifiedOutcomeWorkOrderList = [NSDictionary]()
    
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
        
        let opts = PlistMap.sharedInstance.readPList(plist: "/Opportunity.plist")
        pickerOptions = opts as! [[String : Any]]
        for pickerOption in pickerOptions {
            
            if let value = pickerOption["value"] as?  String {
                pickListValuesForOpportunities.append(value)

            }
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
    
    //MARK:-
    //Update the data from Top Sellers TextField
    func updateDataFromTopSellerCellTextfield(_ index: Int,commit: String) {
        opportunityList[index].commit = commit
        DuringVisitsInsightsViewController.modifiedCommitOpportunitiesList.append(opportunityList[index])
    }
    
    //Update the data from Top Sellers Button Action
    func updateDataFromTopSellerCellButton(_index: Int, outcome: String) {
       // var modifiedOutcomeObject : NSDictionary?
        let modifiedOutcomeObject = NSMutableDictionary()
        modifiedOutcomeObject.setValue(opportunityList[_index].id, forKey: "Id")
        modifiedOutcomeObject.setValue(outcome, forKey: "SGWS_Outcome__c")
        DuringVisitsInsightsViewController.modifiedOutcomeWorkOrderList.append(modifiedOutcomeObject)
    }
    
    //Update the data from Unsold TextField
    func updateDataFromUnsoldTableCellTextField(_ index: Int,commit: String) {
        opportunityList[index].commit = commit
        DuringVisitsInsightsViewController.modifiedCommitOpportunitiesList.append(opportunityList[index])
    }
    
    //Update the data from Unsold Button Action
    func updateDataFromUnsoldTableCellButtton(_index: Int, outcome: String) {
       // var modifiedOutcomeObject : NSDictionary?
        let modifiedOutcomeObject = NSMutableDictionary()
        modifiedOutcomeObject.setValue(opportunityList[_index].id, forKey: "Id")
        modifiedOutcomeObject.setValue(outcome, forKey: "SGWS_Outcome__c")
        DuringVisitsInsightsViewController.modifiedOutcomeWorkOrderList.append(modifiedOutcomeObject)
    }
    
    //Update the data from Undersold Textfield
    func updateDataFromUndersoldTableCellTextfield(_ index: Int,commit: String) {
        opportunityList[index].commit = commit
        DuringVisitsInsightsViewController.modifiedCommitOpportunitiesList.append(opportunityList[index])
    }
    
    //Update the data from Undersold Button Action
    func updateDataFromUndersoldTableCellButton(index: Int, outcome: String) {
     
        let modifiedOutcomeObject = NSMutableDictionary()
        modifiedOutcomeObject.setValue(opportunityList[index].id, forKey: "Id")
        modifiedOutcomeObject.setValue(outcome, forKey: "SGWS_Outcome__c")
        DuringVisitsInsightsViewController.modifiedOutcomeWorkOrderList.append(modifiedOutcomeObject)
    }
    
    //Used to Reload the TableView Data
    func sortAndRelaodTable() {
        opportunityList =  OpportunitySortUtility().opportunitySort(opportunityList)
        insightsTableViewController?.reloadData()
    }
    
    //Fetch the from Accounts View Model
    func fetchAccountDetails(){
        if let accountId = visitInformation?.accountId {
            let accountsArray = AccountsViewModel().accountsForLoggedUser()
            accountObject = accountsArray.filter({$0.account_Id == accountId }).first
        }
    }
    
    //Get Full account Address from Account Object
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
    
    //MARK:- IBActions Methods
    //Sort By Product Name
    @IBAction func productNameButtonCLicked(sender : UIButton){
        
        if OpportunitiesFilterMenuModel.isAscendingProductName == "YES" {
            OpportunitiesFilterMenuModel.isAscendingProductName = "NO"
        }
        else {
            OpportunitiesFilterMenuModel.isAscendingProductName = "YES"
        }
        OpportunitiesFilterMenuModel.isAscendingSource = ""
        OpportunitiesFilterMenuModel.isAscendingPYCMSold = ""
        OpportunitiesFilterMenuModel.isAscendingCommit = ""
        OpportunitiesFilterMenuModel.isAscendingSold = ""
        OpportunitiesFilterMenuModel.isAscendingMonth = ""
        OpportunitiesFilterMenuModel.isAscendingStatus = ""
        
        sortAndRelaodTable()
    }
    
    //Sort By Source
    @IBAction func sourceButtonCLicked(sender : UIButton){
        if OpportunitiesFilterMenuModel.isAscendingSource == "YES" {
            OpportunitiesFilterMenuModel.isAscendingSource = "NO"
        }
        else {
            OpportunitiesFilterMenuModel.isAscendingSource = "YES"
        }
        OpportunitiesFilterMenuModel.isAscendingProductName = ""
        OpportunitiesFilterMenuModel.isAscendingPYCMSold = ""
        OpportunitiesFilterMenuModel.isAscendingCommit = ""
        OpportunitiesFilterMenuModel.isAscendingSold = ""
        OpportunitiesFilterMenuModel.isAscendingMonth = ""
        OpportunitiesFilterMenuModel.isAscendingStatus = ""
        
        sortAndRelaodTable()
    }
    
    @IBAction func commitAmtButtonCLicked(sender : UIButton){
     
        
    }
    
    @IBAction func outcomeButtonCLicked(sender : UIButton){
        
        
    }
    
    @IBAction func accountsDetailsButtonClicked(sender : UIButton){
        DispatchQueue.main.async {
            AlertUtilities.showAlertMessageWithTwoActionsAndHandler("Any changes will not be saved", errorMessage: "Are you sure you want to close?", errorAlertActionTitle: "Yes", errorAlertActionTitle2: "No", viewControllerUsed: self, action1: {
                FilterMenuModel.selectedAccountId = (self.accountObject?.account_Id)!
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "navigateToAccountScreen"), object:nil)
                self.dismiss(animated: false, completion: nil)
            }){
                
            }
        }
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
        return 95
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
            cell.unsoldPeriodLabel.text = currentOpportunity.unsoldPeriodDays
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


