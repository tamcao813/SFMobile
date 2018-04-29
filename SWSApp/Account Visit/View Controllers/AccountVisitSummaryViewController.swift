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
}

class AccountVisitSummaryViewController: UIViewController {
    
    var scheduledHeadingArray = ["Location","Account Situation","Goals","Challenges"]
    var inprogressHeadingArray = ["Location","Associated Contacts","Opportunities Selected","Service Purposes","Agenda Notes","Account Situation","Goals","Challenges"]
    
    var subHeadingArray = ["Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s.","Lorem Ipsum is simply dummy text of the printing and typesetting industry.","Lorem Ipsum is simply dummy tevarof the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged."]
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
        default:
            break
        }
    }
    
    @IBAction func startOrContinueVisitButtonTapped(_ sender: UIButton){
        if visitStatus == .scheduled {
            print("Yes")
            
            let storyboard: UIStoryboard = UIStoryboard(name: "DuringVisit", bundle: nil)
            let vc: DuringVisitsViewController = storyboard.instantiateViewController(withIdentifier: "DuringVisitsViewControllerID") as! DuringVisitsViewController
            (vc as DuringVisitsViewController).modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            self.present(vc, animated: true, completion: nil)
            (vc as DuringVisitsViewController).delegate = self
            
        }else{
            
        }
    }
    
    @IBAction func editVisitOrNotesButtonTapped(_ sender: UIButton){
        if visitStatus == .completed {
            
        }else{
            
        }
    }
    
    @IBAction func closeButtonTapped(_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
}

//MARK:- NavigateToContacts Delegate
extension AccountVisitSummaryViewController : NavigateToAccountVisitSummaryDelegate{
    
    func NavigateToAccountVisitSummary(data: LoadThePersistantMenuScreen) {
        self.dismiss(animated: true, completion: nil)
        delegate?.navigateTheScreenToContactsInPersistantMenu(data: data)
        
    }
}


extension AccountVisitSummaryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        switch visitStatus {
        case .scheduled?:
            return scheduledHeadingArray.count
        case .inProgress?, .completed?:
            return inprogressHeadingArray.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch visitStatus {
        case .scheduled?:
            return 1
        case .inProgress?, .completed?:
            switch section {
            case 0:
                return 1
            case 1:
                return 2
            case 2:
                return opportunitiesArray.count
            case 3:
                return servicePurposeArray.count
            case 4:
                return 1
            case 5 ... 7:
                return 1
            default:
                return 0
            }
        default:
            return 0
        }
    }
    
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
            headerView?.headerLabel.text = scheduledHeadingArray[section]
        case .inProgress?:
            headerView?.headerLabel.text = inprogressHeadingArray[section]
        case .completed?:
            headerView?.headerLabel.text = inprogressHeadingArray[section]
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
                return cell!
            case 1 ... 3:
                let cell = tableView.dequeueReusableCell(withIdentifier: "HeadSubHeadTableViewCell") as? HeadSubHeadTableViewCell
                cell?.SubheadingLabel.text = subHeadingArray[indexPath.section - 1]
                return cell!
            default:
                return UITableViewCell()
            }
        case .inProgress?, .completed?:
            switch indexPath.section {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "LocationTableViewCell") as? LocationTableViewCell
                return cell!
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "AssociatedContactsTableViewCell") as? AssociatedContactsTableViewCell
                return cell!
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: "UnorderedListTableViewCell") as?
                    UnorderedListTableViewCell
                cell?.listItemLabel.text = opportunitiesArray[indexPath.row]
                cell?.listSymbol.image = #imageLiteral(resourceName: "Notify Me Check")
                return cell!
            case 3:
                let cell = tableView.dequeueReusableCell(withIdentifier: "UnorderedListTableViewCell") as?
                    UnorderedListTableViewCell
                cell?.listItemLabel.text = servicePurposeArray[indexPath.row]
                cell?.listSymbol.image = #imageLiteral(resourceName: "bullet")
                return cell!
            case 4:
                let cell = tableView.dequeueReusableCell(withIdentifier: "HeadSubHeadTableViewCell") as? HeadSubHeadTableViewCell
                cell?.SubheadingLabel.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
                return cell!
            case 5 ... 7:
                let cell = tableView.dequeueReusableCell(withIdentifier: "HeadSubHeadTableViewCell") as? HeadSubHeadTableViewCell
                cell?.SubheadingLabel.text = subHeadingArray[indexPath.section - 5]
                return cell!
            default:
                return UITableViewCell()
            }
        default:
            return UITableViewCell()
        }
    }
}

