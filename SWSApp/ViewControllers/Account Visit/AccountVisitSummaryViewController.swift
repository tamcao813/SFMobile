//
//  AccountVisitSummaryViewController.swift
//  Acoount Visit
//
//  Created by maco on 19/04/18.
//  Copyright © 2018 maco. All rights reserved.
//

import UIKit

protocol NavigateToContactsDelegate {
    func navigateTheScreenToContactsInPersistantMenu(data : LoadThePersistantMenuScreen)
    
    func navigateToAccountScreen()
}

class AccountVisitSummaryViewController: UIViewController {
    
    var visitObject: Visit?
    var accountObject: Account?
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var editVisitButtonHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var startVisitButtonHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var editVisitButton: UIButton!
    @IBOutlet weak var startVisitButton: UIButton!
    @IBOutlet weak var deleteVisitButton: UIButton!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var visitStatus: AccountVisitStatus?
//    var visitObject : Visit?
    var delegate : NavigateToContactsDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let accounts = AccountsViewModel().accountsForLoggedUser
        if let accountId = visitObject?.accountId {
            for account in accounts {
                if account.account_Id == accountId {
                    accountObject = account
                    break
                }
            }
        }
        UICustomizations()
        initializingXIBs()
        refactoringUIOnApplicationStatusBasis()
         self.getStartDateAndEndTime()
    }
    
    func UICustomizations(){
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        self.tableView.estimatedRowHeight = 100
        if visitObject?.status == "Schedule" || visitObject?.status == "Scheduled"{
            visitStatus = .scheduled
        }else if visitObject?.status == "InProgress" || visitObject?.status == "In-Progress"{
            visitStatus = .inProgress
        }else if visitObject?.status == "Completed"{
            visitStatus = .completed
        }else if visitObject?.status == "Planned"{
            visitStatus = .planned
        }
        statusLabel.text = visitObject?.status
        tableView.reloadData()
        let image = #imageLiteral(resourceName: "delete").withRenderingMode(.alwaysTemplate)
        deleteVisitButton.setImage(image, for: .normal)
        deleteVisitButton.tintColor = UIColor(hexString: "#4287C2")
        deleteVisitButton.setTitle("    Delete", for: .normal)
    }
    
    func getStartDateAndEndTime() {
        
        let dateFormatter = DateFormatter()
        var startTime = ""
        var endTime = ""
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.zzz+zzzz" //Your date format
        let date = dateFormatter.date(from: (visitObject?.startDate)!) //according t
        if date != nil {
            dateFormatter.dateFormat = "MMM" //Your date format
            let month = dateFormatter.string(from: date!)
            monthLabel.text = month
            dateFormatter.dateFormat = "dd" //Your date format
            let day = dateFormatter.string(from: date!)
            dayLabel.text = day
            dateFormatter.dateFormat = "H" //Your date format
            startTime = dateFormatter.string(from: date!)
        }

        
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.zzz+zzzz" //Your date format
        let endDate = dateFormatter1.date(from: (visitObject?.endDate)!) //according t
        
        if endDate != nil {
            dateFormatter1.dateFormat = "H a" //Your date format
            dateFormatter1.amSymbol = "AM"
            dateFormatter1.pmSymbol = "PM"
            endTime = dateFormatter1.string(from: endDate!)
        }

        timeLabel.text = startTime + "-" + endTime
        
    }
    
    func initializingXIBs(){
        self.tableView.register(UINib(nibName: "LocationTableViewCell", bundle: nil), forCellReuseIdentifier: "LocationTableViewCell")
        self.tableView.register(UINib(nibName: "HeadSubHeadTableViewCell", bundle: nil), forCellReuseIdentifier: "HeadSubHeadTableViewCell")
        self.tableView.register(UINib(nibName: "AssociatedContactsTableViewCell", bundle: nil), forCellReuseIdentifier: "AssociatedContactsTableViewCell")
        self.tableView.register(UINib(nibName: "UnorderedListTableViewCell", bundle: nil), forCellReuseIdentifier: "UnorderedListTableViewCell")
        self.tableView.register(UINib(nibName: "ButtonTableViewCell", bundle: nil), forCellReuseIdentifier: "ButtonTableViewCell")
    }
    
    func refactoringUIOnApplicationStatusBasis(){
        switch visitStatus {
        case .scheduled?:
            editVisitButtonHeightConstraint.constant = 40
            startVisitButtonHeightConstraint.constant = 40
            editVisitButton.setTitle("Edit Visit", for: .normal)
            startVisitButton.setTitle("Start Visit", for: .normal)
            deleteVisitButton.isHidden = false
        case .inProgress?:
            editVisitButtonHeightConstraint.constant = 0
            startVisitButtonHeightConstraint.constant = 40
            startVisitButton.setTitle("Continue Visit", for: .normal)
            deleteVisitButton.isHidden = true
        case .completed?:
            editVisitButtonHeightConstraint.constant = 40
            startVisitButtonHeightConstraint.constant = 0
            editVisitButton.setTitle("Edit Notes", for: .normal)
            deleteVisitButton.isHidden = true
        case .planned?:
            editVisitButtonHeightConstraint.constant = 40
            startVisitButtonHeightConstraint.constant = 40
            editVisitButton.setTitle("Edit Visit", for: .normal)
            startVisitButton.setTitle("Start Visit", for: .normal)
            deleteVisitButton.isHidden = false
        default:
            break
        }
    }
    
    @IBAction func startOrContinueVisitButtonTapped(_ sender: UIButton){
        if visitStatus == .scheduled  || visitStatus == .planned || visitStatus == .inProgress{
            let storyboard: UIStoryboard = UIStoryboard(name: "DuringVisit", bundle: nil)
            let vc: DuringVisitsViewController = storyboard.instantiateViewController(withIdentifier: "DuringVisitsViewControllerID") as! DuringVisitsViewController
            (vc as DuringVisitsViewController).modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            self.present(vc, animated: true, completion: nil)
            (vc as DuringVisitsViewController).delegate = self
        }else{
            
            let storyboard: UIStoryboard = UIStoryboard(name: "PlanVisitEditableScreen", bundle: nil)
            let vc: SelectOpportunitiesViewController = storyboard.instantiateViewController(withIdentifier: "SelectOpportunitiesViewControllerID") as! SelectOpportunitiesViewController
            (vc as SelectOpportunitiesViewController).modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            self.present(vc, animated: true, completion: nil)

        }
    }
    
    @IBAction func editVisitOrNotesButtonTapped(_ sender: UIButton){
        switch visitStatus {
        case .scheduled?:
            PlanVistManager.sharedInstance.editPlanVisit = true
            let storyboard = UIStoryboard(name: "PlanVisitEditableScreen", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier :"PlanVisitViewControllerID")
            viewController.modalPresentationStyle = .overCurrentContext
            self.present(viewController, animated: true)
        case .inProgress?:
            print("In progress")
        case .completed?:
            let storyboard = UIStoryboard(name: "PlanVisitEditableScreen", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier :"EditAgendaNoteID") as? EditAgendaNoteViewController
            viewController?.editNotesText = (self.visitObject?.description)!
            viewController?.modalPresentationStyle = .overCurrentContext
            self.present(viewController!, animated: true)
        case .planned?:
            PlanVistManager.sharedInstance.editPlanVisit = true
            let storyboard = UIStoryboard(name: "PlanVisitEditableScreen", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier :"PlanVisitViewControllerID")
            viewController.modalPresentationStyle = .overCurrentContext
            self.present(viewController, animated: true)
        default:
            break
        }
    }
    
    @IBAction func closeButtonTapped(_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    
}

//MARK:- NavigateToContacts Delegate
extension AccountVisitSummaryViewController : NavigateToAccountVisitSummaryDelegate , NavigateToAccountAccountVisitSummaryDelegate{
    
    func NavigateToAccountVisitSummary(data: LoadThePersistantMenuScreen) {
        self.dismiss(animated: true, completion: nil)
        delegate?.navigateTheScreenToContactsInPersistantMenu(data: data)
        
    }
    
    func navigateToAccountVisitSummaryScreen() {
        self.dismiss(animated: true, completion: nil)
        delegate?.navigateToAccountScreen()
    }
}


extension AccountVisitSummaryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        switch visitStatus {
        case .scheduled?:
            return 2
        case .inProgress?,.planned?,.completed?:
            return 5
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch visitStatus {
        case .scheduled?:
            switch section {
            case 0:
                return 50
            case 1:
                return 0
            default:
                return 0
            }
        case .inProgress?,.planned?,.completed?:
            switch section {
            case 0:
                return 50
            case 1:
                return 30            
            default:
                return 0
            }
            return 5
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UINib(nibName: "AccountVisitSectionHeaderView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as? AccountVisitSectionHeaderView
        footerView?.headerLabel.text = ""
        return footerView
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UINib(nibName: "AccountVisitSectionHeaderView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as? AccountVisitSectionHeaderView
        switch visitStatus {
        case .scheduled?:
            switch section {
            case 0:
                headerView?.headerLabel.text = "Location"
            default:
                break
            }
        case .inProgress?:
            switch section {
            case 0:
                headerView?.headerLabel.text = "Location"
            case 1:
                headerView?.headerLabel.text = "Associated Contacts"
            default:
                break
            }
        case .completed?:
            switch section {
            case 0:
                headerView?.headerLabel.text = "Location"
            case 1:
                headerView?.headerLabel.text = "Associated Contacts"
            default:
                break
            }
        case .planned?:
            switch section {
            case 0:
                headerView?.headerLabel.text = "Location"
            case 1:
                headerView?.headerLabel.text = "Associated Contacts"
            default:
                break
            }
        default:
            break
        }
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch visitStatus {
        case .scheduled?:
            switch indexPath.section {
            case 0:
                return getLocationCell()
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "ButtonTableViewCell") as? ButtonTableViewCell
                cell?.delegate = self
                return cell!
            default:
                return UITableViewCell()
            }
        case .inProgress?,.completed?,.planned?:
            switch indexPath.section {
            case 0:
                return getLocationCell()
            case 1:
                return getConatactCell()
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: "HeadSubHeadTableViewCell") as? HeadSubHeadTableViewCell
                cell?.headingLabel.text = "Service Purposes"
                cell?.SubheadingLabel.text = visitObject?.sgwsVisitPurpose
                return cell!
            case 3:
                let cell = tableView.dequeueReusableCell(withIdentifier: "HeadSubHeadTableViewCell") as? HeadSubHeadTableViewCell
                cell?.headingLabel.text = "Agenda Notes"
                cell?.SubheadingLabel.text = visitObject?.sgwsAgendaNotes
                return cell!
            case 4:
                let cell = tableView.dequeueReusableCell(withIdentifier: "ButtonTableViewCell") as? ButtonTableViewCell
                cell?.delegate = self
                return cell!
            default:
                return UITableViewCell()
            }
        default:
            return UITableViewCell()
        }
    }
    
    func getLocationCell() -> LocationTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationTableViewCell") as? LocationTableViewCell
        cell?.delegate = self
        cell?.account = accountObject
        cell?.displayCellContent()
        return cell!
    }
    
    func getConatactCell() -> AssociatedContactsTableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "AssociatedContactsTableViewCell") as? AssociatedContactsTableViewCell
        
        if let contactId = visitObject?.contactId, contactId != "" {
            cell?.containerHeightConstraint.constant = 100
            cell?.containerView.isHidden = false
            cell?.displayCellContent(visit: visitObject!)
        }else{
            cell?.containerHeightConstraint.constant = 0
            cell?.containerView.isHidden = true            
        }
        return cell!
    }
}

extension AccountVisitSummaryViewController: ButtonTableViewCellDelegate {
    func accountStrategyButtonTapped() {
        
    }
}
