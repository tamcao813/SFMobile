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
    let actionItemModel = AccountsActionItemViewModel()
    
    var actionItemToDisplay = [ActionItem]()
    var actionItemArray = [ActionItem]()
    
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
        
        //creating visit array according to accountId
        visitToDisplay = visitModel.visitsForUser()
        for accVisit in visitToDisplay {
            
            if(accVisit.accountId ==  accountId) {
                visitArray.append(accVisit)
            }
        }
        
        //creating action item array according to accountId
        actionItemToDisplay = actionItemModel.getAcctionItemForUser()
        for accAction in actionItemToDisplay{
            
            if (accAction.accountId == accountId){
                
                actionItemArray.append(accAction)
            }
            
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    /*
     
     
     //Getting Today, Tomorrow, Yesterday
     let calendar = Calendar.current
     let dateFormatter = DateFormatter()
     dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000+0000"
     let date = dateFormatter.date(from: visitArray[indexPath.row].startDate)
     
     //Gtting time and date
     let getTime = DateTimeUtility.convertUtcDatetoReadableDate(dateStringfromAccountNotes: visitArray[indexPath.row].startDate)
     var dateTime = getTime.components(separatedBy: " ")
     
     
     if calendar.isDateInToday(date!){
     
     upcomingCell.UpComingActivities_TimeLabel.text = "Today at " + dateTime[1]
     return upcomingCell
     
     }
     else if calendar.isDateInTomorrow(date!)
     {
     upcomingCell.UpComingActivities_TimeLabel.text = "Tomorrow at " + dateTime[1]
     return upcomingCell
     
     }else if calendar.isDateInYesterday(date!)
     {
     upcomingCell.UpComingActivities_TimeLabel.text = "Yesterday at " + dateTime[1]
     return upcomingCell
     }
     
     return upcomingCell
     }
    
     
     
     */
    
   
    
    // MARK: - TableView Functions
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
       return visitArray.count
        }
        else
        {
        return actionItemArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let upcomingCell:UpComingVisitTableViewCell = upcomingActivitiesTableView.dequeueReusableCell(withIdentifier: "upcomingVisitCell") as! UpComingVisitTableViewCell
         // Upcoming Activities Table
        if tableView.tag == 1{
            
            if indexPath.section == 0{
            //Visit Cell
            upcomingCell.UpComingActivities_TitleLabel.text = visitArray[indexPath.row].sgwsVisitPurpose
            upcomingCell.UpComingActivities_DetailsLabel.text = visitArray[indexPath.row].description
            upcomingCell.UpComingActivities_TimeLabel.text = DateTimeUtility.convertUtcDatetoReadableDate(dateStringfromAccountNotes: visitArray[indexPath.row].startDate)
                return upcomingCell
            }else{
                
                upcomingCell.UpComingActivities_TitleLabel.text = actionItemArray[indexPath.row].subject
                upcomingCell.UpComingActivities_DetailsLabel.text = actionItemArray[indexPath.row].description
                upcomingCell.UpComingActivities_TimeLabel.text = DateTimeUtility.convertUtcDatetoReadableDate(dateStringfromAccountNotes: actionItemArray[indexPath.row].activityDate)
                
                return upcomingCell
                
            }
            
         // Past activities table
        }else {
            
            let pastActivitiesCell:PastVisitTableViewCell = pastActivitiesTableView.dequeueReusableCell(withIdentifier: "pastVisitCell") as! PastVisitTableViewCell
            
            pastActivitiesCell.PastActivities_TitleLabel.text = "Today is Jeanna Smith’s Birthday"
            pastActivitiesCell.PastActivities_DetailLabel.text = "Two line description perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium."
            pastActivitiesCell.PastActivities_TimeLabel.text = " 2 Hours Ago"
            
            return pastActivitiesCell
            
        }
        
        }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return  150
        }else{
        return  150
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        
        if tableView.tag == 1{
            if section == 0{
                
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
            
        }
        else
        {
            if section == 0{
                
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
        return nil
    }
    
   
    
}
