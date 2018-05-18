//
//  AccountVisitListViewController.swift
//  SWSApp
//
//  Created by Krishna, Kamya on 4/23/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit
import DropDown

class AccountVisitListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var tableViewDataArray : [Visit]?
    var addNewDropDown = DropDown()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.refreshAccountVisitList), name: NSNotification.Name("refreshAccountVisitList"), object: nil)

        getTheDataFromDB()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        customizedUI()
        initializingXIBs()
    }
    
    @objc func refreshAccountVisitList(){
        getTheDataFromDB()
    }
    
    func getTheDataFromDB(){
        tableViewDataArray = [Visit]()
        let visitArray = VisitsViewModel()
        tableViewDataArray = visitArray.visitsForUser()
        tableViewDataArray = tableViewDataArray?.sorted(by: { $0.lastModifiedDate < $1.lastModifiedDate })
        DispatchQueue.main.async {
            UIView.performWithoutAnimation({() -> Void in
                self.tableView.reloadData()
            })
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("refreshAccountVisitList"), object: nil)
    }
    
    func customizedUI(){
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        self.tableView.estimatedRowHeight = 100
        self.tableView.allowsSelection = true
        self.tableView.allowsMultipleSelectionDuringEditing = true
    }
    
    func initializingXIBs(){
        //self.tableView.register(UINib(nibName: "AccountVisitListTableViewCell", bundle: nil), forCellReuseIdentifier: "AccountVisitListTableViewCell")
    }
    
    @IBAction func newVisitButtonTapped(_ sender: UIButton){
        addNewDropDown.anchorView = sender
        addNewDropDown.bottomOffset = CGPoint(x: (((sender.frame.size.width) - 100)-((sender.frame.size.width)/6.0)), y :( addNewDropDown.anchorView?.plainView.bounds.height)!)
        
        addNewDropDown.backgroundColor = UIColor.white
        
        let dropDownItem1 = NSLocalizedString("Visit", comment: "Visit")
        let dropDownItem2 = NSLocalizedString("Event", comment: "Event")
        
        addNewDropDown.dataSource = [dropDownItem1, dropDownItem2]
        self.addNewDropDown.textFont = UIFont(name: "Ubuntu", size: 13)!
        self.addNewDropDown.textColor = UIColor.gray
        
        addNewDropDown.show()
        
        addNewDropDown.selectionAction = {(index: Int, item: String) in
            switch index {
            case 0:
                print(index)
                
                let createVisitViewController = UIStoryboard(name: "AccountVisit", bundle: nil).instantiateViewController(withIdentifier :"CreateNewVisitViewController") as! CreateNewVisitViewController
                createVisitViewController.isEditingMode = false
                
                //Reset the PlanVistManager
                PlanVistManager.sharedInstance.visit = nil
                DispatchQueue.main.async {
                    self.present(createVisitViewController, animated: true)
                }
                
            case 1:
                print(index)
                print("Create Event")
                
                
                
           
            default:
                break
            }
        }
    }
}

extension AccountVisitListViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0{
            return 50
        }
        return 210
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewDataArray!.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60.0;
    }
    
    // custom header for the section
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
        let headerCell:AccountVisitListTableViewCell = tableView.dequeueReusableCell(withIdentifier: "newVisitCell") as! AccountVisitListTableViewCell
        return headerCell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell?
        if indexPath.row == 0{
            
            cell = tableView.dequeueReusableCell(withIdentifier: "AccountVisitListHeaderTableViewCell") as? AccountVisitListTableViewCell
            cell?.selectionStyle = .none
            
        }else{
            
            cell = tableView.dequeueReusableCell(withIdentifier: "AccountVisitListTableViewCell") as? AccountVisitListTableViewCell
            cell?.selectionStyle = .none
            //cell?.delegate = self as! SwipeTableViewCellDelegate
            let celldata = tableViewDataArray![indexPath.row]
            (cell as! AccountVisitListTableViewCell).displayCellData(data: celldata)
        }
        
        return cell!
    }
    
    //MARK:- Table view on Swipe EDIT and DELETE actions
//    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
//
//        guard orientation == .right else { return nil }
//
//        let editAction = SwipeAction(style: .default, title: "Edit") {action, indexPath in
//            let accountStoryboard = UIStoryboard.init(name: "AccountVisit", bundle: nil)
//            let accountVisitsVC = accountStoryboard.instantiateViewController(withIdentifier: "AccountVisitSummaryViewController") as? AccountVisitSummaryViewController
//
//            let data : Visit = self.tableViewDataArray![indexPath.row]
//
//            if data.status == "Scheduled"{
//                accountVisitsVC?.visitStatus = .scheduled
//            }else if data.status  == "Completed"{
//                accountVisitsVC?.visitStatus = .completed
//            }else {
//                accountVisitsVC?.visitStatus = .inProgress
//            }
//            accountVisitsVC?.modalPresentationStyle = .overCurrentContext
//            self.present(accountVisitsVC!, animated: true, completion: nil)
//        }
//
//        editAction.hidesWhenSelected = true
//        editAction.image = UIImage(named:"editIcon")
//        editAction.backgroundColor = UIColor(named:"InitialsBackground")
//
//        let deleteAction = SwipeAction(style: .default, title: "Delete") {action, indexPath in
//            let cell = tableView.cellForRow(at: indexPath) as! AccountVisitListTableViewCell
//            let closure: (UIAlertAction) -> Void = { _ in cell.hideSwipe(animated: true) }
//            let alert = UIAlertController(title: "Visit Delete", message: StringConstants.deleteConfirmation, preferredStyle: UIAlertControllerStyle.alert)
//            let continueAction = UIAlertAction(title: "Delete", style: .default , handler: closure)
//            alert.addAction(continueAction)
//            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: closure))
//            self.present(alert, animated: true, completion: nil)
//
//
//        }
//        deleteAction.image = #imageLiteral(resourceName: "deletX")
//        deleteAction.backgroundColor = UIColor(named:"InitialsBackground")
//        return [deleteAction, editAction]
//    }
    
//    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeTableOptions {
//        var options = SwipeTableOptions()
//        //options.expansionStyle = .
//        options.transitionStyle = .border
//        return options
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row > 0{
            let accountStoryboard = UIStoryboard.init(name: "AccountVisit", bundle: nil)
            let accountVisitsVC = accountStoryboard.instantiateViewController(withIdentifier: "AccountVisitSummaryViewController") as? AccountVisitSummaryViewController
            let data : Visit = tableViewDataArray![indexPath.row]
            PlanVistManager.sharedInstance.visit = tableViewDataArray![indexPath.row]
            (accountVisitsVC)?.delegate = self
            accountVisitsVC?.visitId = tableViewDataArray![indexPath.row].Id
            DispatchQueue.main.async {
                self.present(accountVisitsVC!, animated: true, completion: nil)
            }
        }
    }
}

//MARK:- NavigateToContacts Delegate
extension AccountVisitListViewController : NavigateToContactsDelegate{
    func navigateToVisitListing() {        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    //Send a notification to Parent VC to load respective VC
    func navigateTheScreenToContactsInPersistantMenu(data: LoadThePersistantMenuScreen) {        
        if data == .contacts{
            ContactFilterMenuModel.comingFromDetailsScreen = ""
            if let visit = PlanVistManager.sharedInstance.visit{
            ContactsGlobal.accountId = visit.accountId
            }
            // Added this line so that Contact detail view is not launched for this scenario.
            ContactFilterMenuModel.selectedContactId = ""
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showAllContacts"), object:nil)
        }else {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "loadMoreScreens"), object:data.rawValue)
        }
    }
    
    func navigateToAccountScreen() {
        // Added this line so that Account detail view is not launched for this scenario.
        FilterMenuModel.selectedAccountId = ""
         NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showAllAccounts"), object:nil)
    }
}

enum AccountVisitStatus : String {
    case scheduled
    case inProgress
    case completed
    case planned
}
