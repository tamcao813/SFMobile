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
        
       getDayFromDate()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Function to get today, tomorrow , yesterday from date
    
    func getDayFromDate()  {

        let calendar = Calendar.current

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000+0000"
        let date = dateFormatter.date(from: visitArray[1].startDate)
        
        print("yesterday \(calendar.isDateInYesterday(date!))")
        print("Today \(calendar.isDateInToday(date!))")
        print("Tomorrow \(calendar.isDateInTomorrow(date!))")
        print("InWeekend \(calendar.isDateInWeekend(date!))")
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
            
            //Getting Today, Tomorrow, Yesterday
            let calendar = Calendar.current
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000+0000"
            let date = dateFormatter.date(from: visitArray[indexPath.row].startDate)
            
            //Gtting time and date
            let getTime = DateTimeUtility.convertUtcDatetoReadableDate(dateStringfromAccountNotes: visitArray[indexPath.row].startDate)
            var dateTime = getTime.components(separatedBy: " ")
        
            
            if calendar.isDateInToday(date!){
                
            upComingActivitiesCell.UpComingActivities_TimeLabel.text = "Today at " + dateTime[1]
                 return upComingActivitiesCell
                
            }
            else if calendar.isDateInTomorrow(date!)
            {
                upComingActivitiesCell.UpComingActivities_TimeLabel.text = "Tomorrow at " + dateTime[1]
                return upComingActivitiesCell
                
            }else if calendar.isDateInYesterday(date!)
            {
                upComingActivitiesCell.UpComingActivities_TimeLabel.text = "Yesterday at " + dateTime[1]
                return upComingActivitiesCell
            }
            
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
    
   
    
}
