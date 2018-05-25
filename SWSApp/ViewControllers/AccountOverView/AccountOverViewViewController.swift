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
    
    var upcomingVisit = [PlanVisit]()
    var upcomingVisitArrayToDisplay = [PlanVisit]()
    
    var pastVisit = [PlanVisit]()
    var pastVisitArrayToDisplay = [PlanVisit]()
    
    var upcomingActionItem = [ActionItem]()
    var upcomingActionItemArrayToDisplay = [ActionItem]()
    
    var pastActionItem = [ActionItem]()
    var pastActionItemArrayToDisplay = [ActionItem]()
    
    
   
    
    var accountId : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        upcomingActivitiesTableView.delegate = self
        upcomingActivitiesTableView.dataSource = self
        pastActivitiesTableView.delegate =  self
        pastActivitiesTableView.dataSource = self
        
        
        upcomingActivitiesTableView.rowHeight = UITableViewAutomaticDimension;
        upcomingActivitiesTableView.estimatedRowHeight = 100
        upcomingActivitiesTableView.tableFooterView = UIView()
        
        self.accountId = account?.account_Id
        
        
        //creating upcomingvisit array according to accountId
        upcomingVisit = visitModel.visitsForUserTwoWeeksUpcoming()
        for accVisit in upcomingVisit {
            
            if(accVisit.accountId ==  accountId) {
                upcomingVisitArrayToDisplay.append(accVisit)
            }
        }
        
        //creating upcoming action item array according to accountId
        upcomingActionItem = actionItemModel.actionItemForUserTwoWeeksUpcoming()
        for accAction in upcomingActionItem{
            
            if (accAction.accountId == accountId){
                
                upcomingActionItemArrayToDisplay.append(accAction)
            }
            
        }
        
        
        //creating pastvisit array according to accountId
        pastVisit = visitModel.visitsForUserOneWeeksPast()
        for accVisit in pastVisit {
            
            if(accVisit.accountId ==  accountId) {
                pastVisitArrayToDisplay.append(accVisit)
            }
        }
        
        //creating past action item array according to accountId
        pastActionItem = actionItemModel.actionItemForUserOneWeeksPast()
        for accAction in pastActionItem{
            
            if (accAction.accountId == accountId){
                
                pastActionItemArrayToDisplay.append(accAction)
            }
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    
        
    
    
    func getDayFromVisit(dateToConvert:String)-> String  {
        //Getting Today, Tomorrow, Yesterday
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000+0000"
        let date = dateFormatter.date(from: dateToConvert)
        //Gtting time and date
        let getTime = DateTimeUtility.convertUtcDatetoReadableDate(dateStringfromAccountNotes: dateToConvert)
        var dateTime = getTime.components(separatedBy: " ")
        if calendar.isDateInToday(date!){
            
            return  "Today at " + dateTime[1]
        }
        else if calendar.isDateInTomorrow(date!)
        {
            
            return  "Tomorrow at " + dateTime[1]
            
        }else if calendar.isDateInYesterday(date!)
        {
            
            return  "Yesterday at " + dateTime[1]
        }
        
        dateFormatter.dateFormat = "MM-dd-yyyy h:mma"
        let timeStamp = dateFormatter.string(from: date!)
        return timeStamp
    }
    
    
    
    
    // MARK: - TableView Functions
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // upcoming table view ...
        if tableView.tag == 1 {
            
            if section == 0 {
                return upcomingVisitArrayToDisplay.count
            }
            else
            {
                return upcomingActionItemArrayToDisplay.count
            }
            // past table view....
        }else {
            
            if section == 0 {
                return pastVisitArrayToDisplay.count
            }
            else
            {
                return pastActionItemArrayToDisplay.count
            }
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:UpComingVisitTableViewCell = upcomingActivitiesTableView.dequeueReusableCell(withIdentifier: "upcomingVisitCell") as! UpComingVisitTableViewCell
        
        // Upcoming Activities Table
        if tableView.tag == 1{
            
            if indexPath.section == 0{
                //Visit Cell
                cell.UpComingActivities_TitleLabel.text = upcomingVisitArrayToDisplay[indexPath.row].sgwsVisitPurpose
                cell.UpComingActivities_DetailsLabel.text = upcomingVisitArrayToDisplay[indexPath.row].sgwsAgendaNotes
                cell.UpComingActivities_TimeLabel.text = getDayFromVisit(dateToConvert: upcomingVisitArrayToDisplay[indexPath.row].startDate)
                cell.UpComingActivities_Image.image = UIImage(named: "Bell")
                return cell
                
            }else{
                //Action Cell
                cell.UpComingActivities_TitleLabel.text = upcomingActionItemArrayToDisplay[indexPath.row].subject
                cell.UpComingActivities_DetailsLabel.text = upcomingActionItemArrayToDisplay[indexPath.row].description
                cell.UpComingActivities_TimeLabel.text = upcomingActionItemArrayToDisplay[indexPath.row].activityDate
                cell.UpComingActivities_Image.image = UIImage(named: "Small Status Critical")
                
                return cell
                
            }
            
            // Past activities table
        }else {
            
            if indexPath.section == 0{
                //past Visit Cell
                cell.UpComingActivities_TitleLabel.text = pastVisitArrayToDisplay[indexPath.row].sgwsVisitPurpose
                cell.UpComingActivities_DetailsLabel.text = pastVisitArrayToDisplay[indexPath.row].sgwsAgendaNotes
                cell.UpComingActivities_TimeLabel.text = getDayFromVisit(dateToConvert: pastVisitArrayToDisplay[indexPath.row].startDate)
                cell.UpComingActivities_Image.image = UIImage(named: "Bell")
                return cell
            }else{
                //past Action Cell
                cell.UpComingActivities_TitleLabel.text = pastActionItemArrayToDisplay[indexPath.row].subject
                cell.UpComingActivities_DetailsLabel.text = pastActionItemArrayToDisplay[indexPath.row].description
                cell.UpComingActivities_TimeLabel.text = pastActionItemArrayToDisplay[indexPath.row].activityDate
                cell.UpComingActivities_Image.image = UIImage(named: "Small Status Critical")
                return cell
                
            }
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            return 50
        }
        return 0
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
