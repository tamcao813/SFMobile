//
//  AccountsSummaryOpportunityCell.swift
//  SWSApp
//
//  Created by chandana on 21/06/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class AccountsSummaryOpportunityCell: UITableViewCell,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableHeightConstraint: NSLayoutConstraint!
//    @IBOutlet weak var SubheadingLabel: UILabel!
      var opportunityList = [Opportunity]()
    var selectedOpportunitiesFromDB = [OpportunityWorkorder]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.tableView.register(UINib(nibName: "SourceTopSellerTableViewCell", bundle: nil), forCellReuseIdentifier: "TopSellerCell")
        self.tableView.register(UINib(nibName: "SourceUndersoldTableviewCell", bundle: nil), forCellReuseIdentifier: "underSoldTableViewCell")
        self.tableView.register(UINib(nibName: "InsightsUnsoldTableViewCell", bundle: nil), forCellReuseIdentifier: "unsoldTableViewCell")
   
    }
    
    func displayCellContent(selectedOpportunityList:[Opportunity]) {
        
        opportunityList = selectedOpportunityList
       self.tableHeightConstraint.constant = CGFloat(opportunityList.count * 60)
     
        self.tableView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return opportunityList.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        selectedOpportunitiesFromDB = OpportunityViewModel().globalOpportunityWorkorder()
            
        selectedOpportunitiesFromDB = selectedOpportunitiesFromDB.filter( { $0.workOrder == (PlanVisitManager.sharedInstance.visit?.Id)!} )
        
        let currentOpportunity:Opportunity = opportunityList[indexPath.row]
        let thisOppur = selectedOpportunitiesFromDB.filter( { $0.opportunityId ==  currentOpportunity.id } )
        var outcomeValue = "--"
        if thisOppur.count > 0 {
            outcomeValue = thisOppur[0].outcome
        }
        switch currentOpportunity.source {
        case "What's Hot/What's Not":
            let cell = tableView.dequeueReusableCell(withIdentifier: "TopSellerCell", for: indexPath) as! AccountsSourceTopSellerTableViewCell
            
            cell.productNameLabel.text = currentOpportunity.productName
            cell.sourceLabel.text = currentOpportunity.source
            cell.r12Label.text = currentOpportunity.R12
            cell.r6TrendLabel.text = currentOpportunity.R6Trend
            cell.r3TrendLabel.text = currentOpportunity.R3Trend
            cell.commitAmtLabel.text = currentOpportunity.commit
            cell.outcomeLabel.text = outcomeValue
            return cell
            
        case "Undersold":
            let cell = tableView.dequeueReusableCell(withIdentifier: "underSoldTableViewCell", for: indexPath) as! AccountsUndersoldTableViewCell
            cell.productNameLabel.text = currentOpportunity.productName
            cell.sourceLabel.text = currentOpportunity.source
            cell.accLabel.text = currentOpportunity.acct
            cell.segmentLabel.text = currentOpportunity.segment
            cell.gapLabel.text = currentOpportunity.gap
            cell.commitAmtLabel.text = currentOpportunity.commit
            cell.outcomeLabel.text = outcomeValue
            return cell
            
        case "Unsold":
            let cell = tableView.dequeueReusableCell(withIdentifier: "unsoldTableViewCell", for: indexPath) as! AccountsUnsoldTableViewCell
            cell.productNameLabel.text = currentOpportunity.productName
            cell.sourceLabel.text = currentOpportunity.source
            cell.unsoldPeriodLabel.text = "Unsold Period\n" + currentOpportunity.unsoldPeriodDays
            cell.commitAmtLabel.text = currentOpportunity.commit
            cell.outcomeLabel.text = outcomeValue
            return cell
            
        default:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "TopSellerCell", for: indexPath) as! AccountsSourceTopSellerTableViewCell
            cell.productNameLabel.text = currentOpportunity.productName
            cell.sourceLabel.text = currentOpportunity.source
            cell.r12Label.text = currentOpportunity.R12
            cell.r6TrendLabel.text = currentOpportunity.R6Trend
            cell.r3TrendLabel.text = currentOpportunity.R3Trend
            cell.commitAmtLabel.text = currentOpportunity.commit
            cell.outcomeLabel.text = outcomeValue
            return cell
            
        }
    }
        
        
        
    }

