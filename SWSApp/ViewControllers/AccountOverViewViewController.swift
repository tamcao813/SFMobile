//
//  AccountOverViewViewController.swift
//  SWSApp
//
//  Created by shubham.e.shukla on 5/11/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class AccountOverViewViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    
    @IBOutlet weak var upcomingActivitiesTableView: UITableView!
    @IBOutlet weak var pastActivitiesTableView: UITableView!
    var account : Account?
    let visitModel = VisitSchedulerViewModel()
    var visitToDisplay = [PlanVisit]()
    var visitArray = [PlanVisit]()
    var accountId : String!
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        upcomingActivitiesTableView.delegate = self
        upcomingActivitiesTableView.dataSource = self
        pastActivitiesTableView.delegate =  self
        pastActivitiesTableView.dataSource = self
        
        self.accountId = account?.account_Id
        
        
        visitToDisplay = visitModel.visitsForUser()
        for accVisit in visitToDisplay {
            
            if(accVisit.accountId ==  accountId) {
                visitArray.append(accVisit)
            }
           
        }
        
       
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    // MARK: - TableView Functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return visitArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView.tag == 1{
            
            let upComingActivitiesCell:AccountOverView_UpComingTableViewCell = upcomingActivitiesTableView.dequeueReusableCell(withIdentifier: "upcomingActivitiesCell") as! AccountOverView_UpComingTableViewCell
            upComingActivitiesCell.UpComingActivities_TitleLabel.text = visitArray[indexPath.row].sgwsVisitPurpose
            upComingActivitiesCell.UpComingActivities_DetailsLabel.text = visitArray[indexPath.row].description
            upComingActivitiesCell.UpComingActivities_TimeLabel.text = DateTimeUtility.convertUtcDatetoReadableDate(dateStringfromAccountNotes: visitArray[indexPath.row].startDate)
            return upComingActivitiesCell
            
            
        }
        else
        {
            
            let pastActivitiesCell:AccountOverView_PastActivitiesTableViewCell = pastActivitiesTableView.dequeueReusableCell(withIdentifier: "pastActivitiesCell") as! AccountOverView_PastActivitiesTableViewCell
            pastActivitiesCell.PastActivities_TitleLabel.text = "Today is Jeanna Smith’s Birthday"
            pastActivitiesCell.PastActivities_DetailLabel.text = "Two line description perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium."
            pastActivitiesCell.PastActivities_TimeLabel.text = " 2 Hours Ago"
            
            
            return pastActivitiesCell
            
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  150
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        
        
        if tableView.tag == 1{
            
            let frame = upcomingActivitiesTableView.frame
            let sectionLabel = UILabel.init(frame: CGRect(x: 12, y: 5, width: 300, height: 50))
            sectionLabel.text = "Upcoming Activities"
            sectionLabel.textColor = UIColor.black
            sectionLabel.font = UIFont(name: "Ubuntu-Medium", size: 25)
            
            let headerView = UIView.init(frame: CGRect(x: 0, y: 0, width:frame.width , height:frame.height ))
            headerView.backgroundColor = UIColor.white
            headerView.addSubview(sectionLabel)
            return headerView;
            
            
        }
        else
        {
            
            let frame = upcomingActivitiesTableView.frame
            let sectionLabel = UILabel.init(frame: CGRect(x: 12, y: 5, width: 300, height: 50))
            sectionLabel.text = "Past Activities"
            sectionLabel.textColor = UIColor.black
            sectionLabel.font = UIFont(name: "Ubuntu-Medium", size: 25)
            
            let headerView = UIView.init(frame: CGRect(x: 0, y: 0, width:frame.width , height:frame.height ))
            headerView.backgroundColor = UIColor.white
            headerView.addSubview(sectionLabel)
            return headerView;
            
            
        }
        
        
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
