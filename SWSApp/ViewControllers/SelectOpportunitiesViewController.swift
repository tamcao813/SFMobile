//
//  SelectOpportunitiesViewController.swift
//  SWSApp
//
//  Created by vipin.vijay on 26/04/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation
import SwipeCellKit
import SmartSync

class SelectOpportunitiesViewController: UIViewController {
    @IBOutlet weak var opportunitiesListView: UITableView!
    @IBOutlet weak var seperatorLabel: UILabel!
    var opportunityAccountId: String?
    var opportunityList = [Opportunity]()
    var selectedOpportunitiesList = [Opportunity]()
    var unselectedOpportunityList = [Opportunity]()
    var initialselectedOpportunityList = [Opportunity]()

    var selectedOpportunitiesFromDB = [OpportunityWorkorder]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        opportunityList = OpportunitySortUtility().opportunityFor(forAccount: (PlanVisitManager.sharedInstance.visit?.accountId)!)
        //Do not show  the closed opportunities
        opportunityList = opportunityList.filter{($0.status != "Closed") && ($0.status != "Closed Won")}
        
        topShadow(seperatorView: seperatorLabel)
        selectedOpportunitiesFromDB = OpportunityViewModel().globalOpportunityWorkorder()
        if selectedOpportunitiesFromDB.count > 0 {
            
            selectedOpportunitiesFromDB = selectedOpportunitiesFromDB.filter( { $0.workOrder == (PlanVisitManager.sharedInstance.visit?.Id)!} )
            if selectedOpportunitiesFromDB.count > 0 {
                
                for obj in selectedOpportunitiesFromDB {
                    
                    selectedOpportunitiesList.append(contentsOf: opportunityList.filter( { $0.id == obj.opportunityId } ))
                }
                initialselectedOpportunityList = selectedOpportunitiesList
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("Plan VC will disappear")
        PlanVisitManager.sharedInstance.editPlanVisit = false
        
    }
    
    // MARK:- Custom Function
    
    func topShadow(seperatorView:UIView) {
        
        let shadowSize : CGFloat = 1.0
        let shadowPath = UIBezierPath(rect: CGRect(x: -shadowSize / 2,
                                                   y: -shadowSize / 2,
                                                   width: seperatorView.frame.size.width + shadowSize,
                                                   height: seperatorView.frame.size.height + shadowSize))
        seperatorView.layer.masksToBounds = false
        seperatorView.layer.shadowColor = UIColor.darkGray.cgColor
        seperatorView.layer.shadowOffset = CGSize(width: 0.0, height: -5.0)
        seperatorView.layer.shadowOpacity = 0.1
        seperatorView.layer.shadowPath = shadowPath.cgPath
    }
    
    // MARK:- IBAction
    
    @IBAction func closeVC(sender: UIButton) {
        //STATEMACHINE:No State Change
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshAccountVisitList"), object:nil)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshVisitEventList"), object:nil)
        DispatchQueue.main.async {
            self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func backVC(sender: UIButton) {
        //STATEMACHINE:No State Change
        DispatchQueue.main.async {
            self.dismiss(animated: true)
        }
    }
    
    @IBAction func nextVC(_ sender: Any) {
        
        // TBD to insert data into SGWS_Opportunity_WorkOrder__c
        let attributeDict = ["type":"SGWS_Opportunity_WorkOrder__c"]
        
        let visitId = (PlanVisitManager.sharedInstance.visit?.Id) ?? ""
        
        if self.unselectedOpportunityList.count > 0 {
            for opportunity in self.unselectedOpportunityList {
                let addNewDict: [String:Any] = [
                    OpportunityWorkorder.opportunityWorkorderFields[0]: getRandomId(),
                    OpportunityWorkorder.opportunityWorkorderFields[1]: opportunity.id,
                    OpportunityWorkorder.opportunityWorkorderFields[2]: visitId ,
                    OpportunityWorkorder.opportunityWorkorderFields[3]: "",
                    "attributes":attributeDict]
                _ = StoreDispatcher.shared.deleteOpportunityWorkorderLocally(fieldsToUpload: addNewDict)
            }
        }
        if self.selectedOpportunitiesList.count > 0 {
            for opportunity in self.selectedOpportunitiesList {
                let addNewDict: [String:Any] = [
                    OpportunityWorkorder.opportunityWorkorderFields[0]: getRandomId(),
                    OpportunityWorkorder.opportunityWorkorderFields[1]: opportunity.id,
                    OpportunityWorkorder.opportunityWorkorderFields[2]: visitId ,
                    OpportunityWorkorder.opportunityWorkorderFields[3]: "",
                    "attributes":attributeDict]
                if doesExistInDeleted(checkDict: addNewDict) {
                    
                }
                else {
                    if doesOppurtunitySelected(selectedOppurtunityId: opportunity.id) {
                        
                    }
                    else {
                        _ = OpportunityViewModel().createNewOpportunityWorkorderLocally(fields: addNewDict)
                    }
                }
            }
        }
        
    }

    func doesExistInDeleted(checkDict: [String:Any]) -> Bool {
        
        for  singleOpportunityWorkorder in self.unselectedOpportunityList {
            if singleOpportunityWorkorder.id.isEmpty {
                continue
            }

            let opportunityDicId = checkDict["SGWS_Opportunity__c"] as? String ?? ""
            if opportunityDicId.isEmpty {
                continue
            }
            
            //Search ID
            if(opportunityDicId == singleOpportunityWorkorder.id) {
                return true
            }
        }
        return false
    }
    
    func doesOppurtunitySelected(selectedOppurtunityId: String) -> Bool {
        
        let checkArray = initialselectedOpportunityList.filter( { $0.id == selectedOppurtunityId } )
        if checkArray.count > 0 {
            return true
        }
        return false
    }
    
    func getRandomId() -> String {
        
        //  Make a variable equal to a random number....
        let randomNum:UInt32 = arc4random_uniform(99999999) // range is 0 to 99
        // convert the UInt32 to some other  types
        let someString:String = String(randomNum)
        print("random Id for Opput_workorder  is \(someString)")

        return someString
    }

    @IBAction func saveAndClose(sender: UIButton) {
        //STATEMACHINE:If you com tho this Screen its in Planned state
        PlanVisitManager.sharedInstance.visit?.status = "Planned"
        _ = PlanVisitManager.sharedInstance.editAndSaveVisit()
        DispatchQueue.main.async {
            self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func loadStrategyScreen(sender : UIButton){
        
        let accountId = PlanVisitManager.sharedInstance.visit?.accountId
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Strategy", bundle: nil)
        let vc: AccountStrategyViewController = storyboard.instantiateViewController(withIdentifier: "AccountStrategyViewControllerID") as! AccountStrategyViewController
        StrategyScreenLoadFrom.isLoadFromStrategy = "1"
        
        AccountId.selectedAccountId = accountId!
        
        (vc as AccountStrategyViewController).modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        DispatchQueue.main.async {
            self.present(vc, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func loadInsightsScreen(sender:UIButton) {
        
    }
    
    //MARK:- Sort Button Actions
    @IBAction func actionSortProductName(_ sender: Any) {
        
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
    
    @IBAction func actionSortSource(_ sender: Any) {
        
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
    
    @IBAction func actionSortPYCMSold(_ sender: Any) {
        
        if OpportunitiesFilterMenuModel.isAscendingPYCMSold == "YES" {
            OpportunitiesFilterMenuModel.isAscendingPYCMSold = "NO"
        }
        else {
            OpportunitiesFilterMenuModel.isAscendingPYCMSold = "YES"
        }
        OpportunitiesFilterMenuModel.isAscendingProductName = ""
        OpportunitiesFilterMenuModel.isAscendingSource = ""
        OpportunitiesFilterMenuModel.isAscendingCommit = ""
        OpportunitiesFilterMenuModel.isAscendingSold = ""
        OpportunitiesFilterMenuModel.isAscendingMonth = ""
        OpportunitiesFilterMenuModel.isAscendingStatus = ""
        
        sortAndRelaodTable()
    }
    
    @IBAction func actionSortCommit(_ sender: Any) {
        
        if OpportunitiesFilterMenuModel.isAscendingCommit == "YES" {
            OpportunitiesFilterMenuModel.isAscendingCommit = "NO"
        }
        else {
            OpportunitiesFilterMenuModel.isAscendingCommit = "YES"
        }
        OpportunitiesFilterMenuModel.isAscendingProductName = ""
        OpportunitiesFilterMenuModel.isAscendingSource = ""
        OpportunitiesFilterMenuModel.isAscendingPYCMSold = ""
        OpportunitiesFilterMenuModel.isAscendingSold = ""
        OpportunitiesFilterMenuModel.isAscendingMonth = ""
        OpportunitiesFilterMenuModel.isAscendingStatus = ""
        
        sortAndRelaodTable()
    }
    
    @IBAction func actionSortSold(_ sender: Any) {
        
        if OpportunitiesFilterMenuModel.isAscendingSold == "YES" {
            OpportunitiesFilterMenuModel.isAscendingSold = "NO"
        }
        else {
            OpportunitiesFilterMenuModel.isAscendingSold = "YES"
        }
        OpportunitiesFilterMenuModel.isAscendingProductName = ""
        OpportunitiesFilterMenuModel.isAscendingSource = ""
        OpportunitiesFilterMenuModel.isAscendingPYCMSold = ""
        OpportunitiesFilterMenuModel.isAscendingCommit = ""
        OpportunitiesFilterMenuModel.isAscendingMonth = ""
        OpportunitiesFilterMenuModel.isAscendingStatus = ""
        
        sortAndRelaodTable()
    }
    

    
    @IBAction func actionSortStatus(_ sender: Any) {
        
        if OpportunitiesFilterMenuModel.isAscendingStatus == "YES" {
            OpportunitiesFilterMenuModel.isAscendingStatus = "NO"
        }
        else {
            OpportunitiesFilterMenuModel.isAscendingStatus = "YES"
        }
        OpportunitiesFilterMenuModel.isAscendingProductName = ""
        OpportunitiesFilterMenuModel.isAscendingSource = ""
        OpportunitiesFilterMenuModel.isAscendingPYCMSold = ""
        OpportunitiesFilterMenuModel.isAscendingCommit = ""
        OpportunitiesFilterMenuModel.isAscendingSold = ""
        OpportunitiesFilterMenuModel.isAscendingMonth = ""
        
        sortAndRelaodTable()
    }
    
    func sortAndRelaodTable() {
        
        opportunityList =  OpportunitySortUtility().opportunitySort(opportunityList)
        
        opportunitiesListView.reloadData()
    }
    
}
//MARK:- TableView DataSource Methods
extension SelectOpportunitiesViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return opportunityList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            return 0
        }
        return 8
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView:UIView = UIView()
        headerView.backgroundColor = UIColor.white
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "opportunitiesListViewCell", for: indexPath) as? OpportunitiesListViewCell
        cell?.selectionStyle = .none

        var bSelected: Bool = false
        if selectedOpportunitiesList.contains(where: {($0.id == opportunityList[indexPath.section].id)}) {
            
            bSelected = true
        }
        cell?.displayCellContent(opportunityList[indexPath.section], withSelection: bSelected)
        return cell ?? UITableViewCell()
    }
}


//MARK:- TableView Delegate Methods
extension SelectOpportunitiesViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if self.selectedOpportunitiesList.contains(where: {($0.id == opportunityList[indexPath.section].id)}) {
            self.selectedOpportunitiesList = self.selectedOpportunitiesList.filter(){$0.id != opportunityList[indexPath.section].id}
            self.unselectedOpportunityList.append(opportunityList[indexPath.section])
        }
        else {
            self.selectedOpportunitiesList.append(opportunityList[indexPath.section])
            self.unselectedOpportunityList = self.unselectedOpportunityList.filter(){$0.id != opportunityList[indexPath.section].id}
        }
        self.opportunitiesListView.reloadData()
    }

}
