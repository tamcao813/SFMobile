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
    
    var scheduledArray = [["title":"Goals","desc":"Lorem Ipsum is simply dummy text of the printing and typesetting industry."],
                                  ["title":"Success Metrics","desc":"Lorem Ipsum is simply dummy text of the printing and typesetting industry."],
                                  ["title":"Challenges","desc":"Lorem Ipsum is simply dummy text of the printing and typesetting industry."]]
    var buyingMotives = [["title":"Task Buying Motive","desc":"Lorem Ipsum is simply dummy text of the printing and typesetting industry."],
                         ["title":"Perosnal Buying Motive","desc":"Lorem Ipsum is simply dummy text of the printing and typesetting industry."]]
    
    var inprogressHeadingArray = ["Location","Associated Contacts","Opportunities Selected","Service Purposes","Agenda Notes","Account Situation","Goals","Challenges"]
    
    var opportunitiesArray = ["Manage Returns","Delivery Fulfillnt","POS"]
    var servicePurposeArray = ["Point of sale","Store/Display Setup","Sample and Tasting"]
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var editVisitButtonHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var startVisitButtonHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var editVisitButton: UIButton!
    @IBOutlet weak var startVisitButton: UIButton!
    @IBOutlet weak var deleteVisitButton: UIButton!
    
    var visitStatus: AccountVisitStatus?
    
    var delegate : NavigateToContactsDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UICustomizations()
        initializingXIBs()
        refactoringUIOnApplicationStatusBasis()
    }
    
    func UICustomizations(){
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        self.tableView.estimatedRowHeight = 100
        switch visitStatus {
        case .scheduled?:
            statusLabel.text = "Scheduled"
        case .inProgress?:
            statusLabel.text = "In Progress"
        case .completed?:
            statusLabel.text = "Completed"
        case .planned?:
            statusLabel.text = "Planned"
        default:
            break
        }
        let image = #imageLiteral(resourceName: "delete").withRenderingMode(.alwaysTemplate)
        deleteVisitButton.setImage(image, for: .normal)
        deleteVisitButton.tintColor = UIColor(hexString: "#4287C2")
        deleteVisitButton.setTitle("    Delete", for: .normal)
    }
    
    func initializingXIBs(){
        self.tableView.register(UINib(nibName: "LocationTableViewCell", bundle: nil), forCellReuseIdentifier: "LocationTableViewCell")
        self.tableView.register(UINib(nibName: "HeadSubHeadTableViewCell", bundle: nil), forCellReuseIdentifier: "HeadSubHeadTableViewCell")
        self.tableView.register(UINib(nibName: "AssociatedContactsTableViewCell", bundle: nil), forCellReuseIdentifier: "AssociatedContactsTableViewCell")
        self.tableView.register(UINib(nibName: "UnorderedListTableViewCell", bundle: nil), forCellReuseIdentifier: "UnorderedListTableViewCell")
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
        if visitStatus == .scheduled  || visitStatus == .planned{
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
        if visitStatus == .completed {
            
        }else{
            
            PlanVistManager.sharedInstance.editPlanVisit = true
            let storyboard = UIStoryboard(name: "PlanVisitEditableScreen", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier :"PlanVisitViewControllerID")
            viewController.modalPresentationStyle = .overCurrentContext
            self.present(viewController, animated: true)
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
            return 3
        case .inProgress?, .completed?:
            return inprogressHeadingArray.count
        case .planned?:
            return inprogressHeadingArray.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch visitStatus {
        case .scheduled?:
            switch section {
            case 0:
                return 1
            case 1:
                return scheduledArray.count
            case 2:
                return buyingMotives.count
            default:
                return 0
            }
        default:
            return 0
        }
    }

            
//        case .inProgress?, .completed?:
//
//            case 1:
//                return 2
//            case 2:
//                return opportunitiesArray.count
//            case 3:
//                return servicePurposeArray.count
//            case 4:
//                return 1
//            case 5 ... 7:
//                return 1
//            default:
//                return 0
//            }
//        case .planned?:
//            return 1
//        default:
//            return 0
//        }
//    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 50
        }else{
            return 30
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
            case 1:
                headerView?.headerLabel.text = "Account Strategy"
            case 2:
                headerView?.headerLabel.text = "Buying Motives"
            default:
                break
            }
//        case .inProgress?:
//            headerView?.headerLabel.text = inprogressHeadingArray[section]
//        case .completed?:
//            headerView?.headerLabel.text = inprogressHeadingArray[section]
//        case .planned?:
//            headerView?.headerLabel.text = inprogressHeadingArray[section]
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
                let cell = tableView.dequeueReusableCell(withIdentifier: "LocationTableViewCell") as? LocationTableViewCell
                cell?.delegate = self                
                return cell!
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "HeadSubHeadTableViewCell") as? HeadSubHeadTableViewCell
                cell?.headingLabel.text = scheduledArray[indexPath.row]["title"]
                cell?.SubheadingLabel.text = scheduledArray[indexPath.row]["desc"]
                return cell!
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: "HeadSubHeadTableViewCell") as? HeadSubHeadTableViewCell
                cell?.headingLabel.text = buyingMotives[indexPath.row]["title"]
                cell?.SubheadingLabel.text = buyingMotives[indexPath.row]["desc"]
                return cell!
            default:
                return UITableViewCell()
            }
//        case .inProgress?, .completed?:
//            switch indexPath.section {
//            case 0:
//                let cell = tableView.dequeueReusableCell(withIdentifier: "LocationTableViewCell") as? LocationTableViewCell
//                cell?.delegate = self
//                return cell!
//            case 1:
//                let cell = tableView.dequeueReusableCell(withIdentifier: "AssociatedContactsTableViewCell") as? AssociatedContactsTableViewCell
//                return cell!
//            case 2:
//                let cell = tableView.dequeueReusableCell(withIdentifier: "UnorderedListTableViewCell") as?
//                    UnorderedListTableViewCell
//                cell?.listItemLabel.text = opportunitiesArray[indexPath.row]
//                cell?.listSymbol.image = #imageLiteral(resourceName: "Notify Me Check")
//                return cell!
//            case 3:
//                let cell = tableView.dequeueReusableCell(withIdentifier: "UnorderedListTableViewCell") as?
//                    UnorderedListTableViewCell
//                cell?.listItemLabel.text = servicePurposeArray[indexPath.row]
//                cell?.listSymbol.image = #imageLiteral(resourceName: "bullet")
//                return cell!
//            case 4:
//                let cell = tableView.dequeueReusableCell(withIdentifier: "HeadSubHeadTableViewCell") as? HeadSubHeadTableViewCell
//                cell?.SubheadingLabel.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
//                return cell!
//            case 5 ... 7:
//                let cell = tableView.dequeueReusableCell(withIdentifier: "HeadSubHeadTableViewCell") as? HeadSubHeadTableViewCell
////                cell?.SubheadingLabel.text = subHeadingArray[indexPath.section - 5]
//                return cell!
//            default:
//                return UITableViewCell()
//            }
//        case .planned?:
//            switch indexPath.section {
//            case 0:
//                let cell = tableView.dequeueReusableCell(withIdentifier: "LocationTableViewCell") as? LocationTableViewCell
//                cell?.delegate = self
//                return cell!
//            case 1 ... 3:
//                let cell = tableView.dequeueReusableCell(withIdentifier: "HeadSubHeadTableViewCell") as? HeadSubHeadTableViewCell
////                cell?.SubheadingLabel.text = subHeadingArray[indexPath.section - 1]
//                return cell!
//            default:
//                return UITableViewCell()
//            }
        default:
            return UITableViewCell()
        }
    }
}

