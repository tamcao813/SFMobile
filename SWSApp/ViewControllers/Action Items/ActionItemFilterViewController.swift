//
//  ActionItemFilterViewController.swift
//  SWSApp
//
//  Created by manu.a.gupta on 21/05/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

protocol ActionItemSearchButtonTappedDelegate {
    func performFilterOperation(searchText : UISearchBar)
    func clearFilter()
}

class ActionItemFilterViewController: UIViewController {
    
    let kHeaderSectionTag: Int = 6900;
    var expandedSectionHeaderNumber: Int = -1
    var expandedSectionHeader: UITableViewHeaderFooterView!
    //Used for selected section in TableView
    var selectedSection = -1
    var delegate : ActionItemSearchButtonTappedDelegate?
    
    var isManager: Bool = false
    var consultantAry = [Consultant]()
    var sectionData = [[Any]]()
    var accountsForLoggedUserFiltered = [Account]()
    var sectionNames = [String]()
    @IBOutlet weak var buttonsBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar : UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.customizeSearchBar()
        consultantAry = UserViewModel().consultants
        consultantAry = consultantAry.sorted { $0.name < $1.name }
        
        isManager = consultantAry.count > 0
        sectionNames = ActionItemFilter().sectionNames(isManager: isManager)
        sectionData = ActionItemFilter().sectionItems
        
        if isManager, !ActionItemFilterModel.fromAccount {
            sectionData.insert(consultantAry, at:  sectionData.count)
            ActionItemFilter().sectionItems = sectionData
        }
        
        if ActionItemFilterModel.fromAccount {
            buttonsBottomConstraint.constant = 0
        }else{
            buttonsBottomConstraint.constant = 63
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.async {
            self.addSearchIconInSearchBar()
        }
    }

    //MARK:-
    //Used to customize the search bar background
    func customizeSearchBar(){
        self.searchBar.layer.borderWidth = 1.0
        self.searchBar.layer.borderColor = UIColor.init(red: 158/255, green: 158/255, blue: 158/255, alpha: 1.0).cgColor
        self.searchBar.layer.cornerRadius = 4.0
        self.searchBar.backgroundImage = UIImage()
        let subViews = self.searchBar.subviews
        
        if subViews.count > 0{
            for vw in subViews{
                for searchVW in vw.subviews{
                    if searchVW is UITextField{
                        searchVW.backgroundColor = UIColor.white
                    }
                }
            }
        }
    }
    
    //Used to add search icon in the Search Bar
    func addSearchIconInSearchBar(){
        let searchTextField:UITextField = searchBar.subviews[0].subviews.last as! UITextField
        searchTextField.layer.cornerRadius = 15
        //searchTextField.frame = CGRect(x: 10, y: 10, width: 20, height: 20)
        searchTextField.textAlignment = NSTextAlignment.left
        let image:UIImage = UIImage(named: "searchIcon")!
        let imageView:UIImageView = UIImageView.init(image: image)
        self.view.bringSubview(toFront : imageView)
        searchTextField.leftView = nil
        //Added attributedPlaceholder with ubuntu font
        searchTextField.attributedPlaceholder = NSAttributedString(string:"Search", attributes: [NSAttributedStringKey.font: UIFont(name: "Ubuntu", size: 18)!])
        searchTextField.rightView = imageView
        searchTextField.rightViewMode = UITextFieldViewMode.always
        
        //self.view.bringSubview(toFront: searchTextField)
    }
    
    //Used to check which section header was clicked
    @objc func sectionHeaderWasTouched(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
        
        let headerView = sender.view //as! UITableViewHeaderFooterView
        let section    = headerView?.tag
        let eImageView = headerView?.viewWithTag(kHeaderSectionTag + section!) as? UIImageView
        
        self.selectedSection = section!        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            self.tableView.reloadData()
        }
        self.sectionHeaderOperation(section: section!, eImageView: eImageView)
    }
    
    func sectionHeaderOperation(section : Int , eImageView : UIImageView?){
        
        if (self.expandedSectionHeaderNumber == -1) {
            self.expandedSectionHeaderNumber = section
            tableViewExpandSection(section, imageView: eImageView!)
        } else {
            if (self.expandedSectionHeaderNumber == section) {
                tableViewCollapeSection(section, imageView: eImageView!)
                //If expanded section is clicked make this below variable to -1 so that arrow mark will be down
                self.selectedSection = -1
            } else {
                let cImageView = self.view.viewWithTag(kHeaderSectionTag + self.expandedSectionHeaderNumber) as? UIImageView
                tableViewCollapeSection(self.expandedSectionHeaderNumber, imageView: cImageView!)
                tableViewExpandSection(section, imageView: eImageView!)
            }
        }
    }
    
    //Used to dismiss Dropdown menu
    func tableViewCollapeSection(_ section: Int, imageView: UIImageView) {
        self.expandedSectionHeaderNumber = -1
        if (sectionData.count == 0) {
            return;
        } else {
            UIView.animate(withDuration: 0.4, animations: {
                imageView.transform = CGAffineTransform(rotationAngle: (0.0 * CGFloat(Double.pi)) / 180.0)
            })
            var indexesPath = [IndexPath]()
            
            for i in 0 ..< sectionData[section].count {
                let index = IndexPath(row: i, section: section)
                indexesPath.append(index)
            }
            
            self.tableView!.beginUpdates()
            self.tableView!.deleteRows(at: indexesPath, with: UITableViewRowAnimation.fade)
            self.tableView!.endUpdates()
        }
    }
    
    //Used to show Dropdown menu
    func tableViewExpandSection(_ section: Int, imageView: UIImageView) {
        if (sectionData.count == 0) {
            self.expandedSectionHeaderNumber = -1;
            return;
        } else {
            UIView.animate(withDuration: 0.4, animations: {
                imageView.transform = CGAffineTransform(rotationAngle: (180.0 * CGFloat(Double.pi)) / 180.0)
            })
            var indexesPath = [IndexPath]()
            for i in 0 ..< sectionData[section].count {
                let index = IndexPath(row: i, section: section)
                indexesPath.append(index)
            }
            self.expandedSectionHeaderNumber = section
            self.tableView!.beginUpdates()
            self.tableView!.insertRows(at: indexesPath, with: UITableViewRowAnimation.fade)
            self.tableView!.endUpdates()
        }
    }
    
    func performSelectConsultantOperation(indexPath : IndexPath) {
        ActionItemFilterModel.selectedConsultant = consultantAry[indexPath.row]
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.currentSelectedUserId = consultantAry[indexPath.row].id
    }
    
    //Data to pass for Respective Cell Class
    func passDataToTableViewCell(cell : UITableViewCell, indexPath : IndexPath){
        (cell as? ActionItemFilterTableViewCell)?.displayCellContent(sectionContent: sectionData as NSArray, indexPath: indexPath)
        
    }
    
    //Dropdown Single selection option clicked and is assigned to model class
    func tableViewCellClickedSingleSelection(indexPath : IndexPath , arrayContent : Array<Any>) {
        
        switch indexPath.section {
        case 0:
            self.performActionStatusOpetation(indexPath: indexPath)
        case 1:
            self.performActionTypeOpetation(indexPath: indexPath)
        case 2:
            self.performPastDueOpetation(indexPath: indexPath)
        case 3:
            self.performSelectConsultantOperation(indexPath: indexPath)
        default:
            break
        }
        tableView.reloadData()
    }
    
    func performActionStatusOpetation(indexPath: IndexPath){
        
        switch indexPath.row {
        case 0:
            if ActionItemFilterModel.isComplete == "NO"{
                ActionItemFilterModel.isComplete = "YES"
            }else{
                ActionItemFilterModel.isComplete = "NO"
            }
        case 1:
            if ActionItemFilterModel.isOpen == "NO"{
                ActionItemFilterModel.isOpen = "YES"
            }else{
                ActionItemFilterModel.isOpen = "NO"
            }
        case 2:
            if ActionItemFilterModel.isOverdue == "NO"{
                ActionItemFilterModel.isOverdue = "YES"
            }else{
                ActionItemFilterModel.isOverdue = "NO"
            }
        default:
            break
        }
    }
    
    func performActionTypeOpetation(indexPath: IndexPath){
        
        switch indexPath.row {
        case 0:
            if ActionItemFilterModel.isUrgent == "NO"{
                ActionItemFilterModel.isUrgent = "YES"
            }else{
                ActionItemFilterModel.isUrgent = "NO"
            }
        case 1:
            if ActionItemFilterModel.isNotUrgent == "NO"{
                ActionItemFilterModel.isNotUrgent = "YES"
            }else{
                ActionItemFilterModel.isNotUrgent = "NO"
            }
        default:
        break
        }
    }
    
    func performPastDueOpetation(indexPath: IndexPath){
        
        switch indexPath.row {
        case 0:
            if ActionItemFilterModel.dueYes == "NO"{
                ActionItemFilterModel.dueYes = "YES"
            }else{
                ActionItemFilterModel.dueYes = "NO"
            }
        case 1:
            if ActionItemFilterModel.dueNo == "NO"{
                ActionItemFilterModel.dueNo = "YES"
            }else{
                ActionItemFilterModel.dueNo = "NO"
            }
        default:
            break
        }
    }

    func clearActionItemFilterModel(){
        ActionItemFilterModel.isComplete = "NO"
        ActionItemFilterModel.isOpen = "NO"
        ActionItemFilterModel.isOverdue = "NO"
        
        ActionItemFilterModel.isUrgent = "NO"
        ActionItemFilterModel.isNotUrgent = "NO"
        
        ActionItemFilterModel.dueYes = "NO"
        ActionItemFilterModel.dueNo = "NO"
        
        searchBar.text = ""
        ActionItemFilterModel.filterApplied = false        
        //Used to Clear the Expanded section of Filter Option
        selectedSection = -1
        if self.expandedSectionHeaderNumber != -1{
            let cImageView = self.view.viewWithTag(kHeaderSectionTag + self.expandedSectionHeaderNumber) as? UIImageView
            tableViewCollapeSection(self.expandedSectionHeaderNumber, imageView: cImageView!)
        }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.currentSelectedUserId = (appDelegate.loggedInUser?.userId)!
        ActionItemFilterModel.selectedConsultant = nil
        tableView.reloadData()
    }
    
    
    //MARK:- Button Actions
    @IBAction func clearButtonTapped(_ sender: UIButton){
        self.clearActionItemFilterModel()
        delegate?.clearFilter()
    }
    
    @IBAction func submitButtonTapped(_ sender: UIButton){
        delegate?.performFilterOperation(searchText: searchBar)
    }
}

//MARK:- TableView DataSource Methods
extension ActionItemFilterViewController : UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if sectionNames.count > 0 {
            tableView.backgroundView = nil
            return sectionNames.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.expandedSectionHeaderNumber == section) {
            let arrayOfItems = sectionData[section]
            return arrayOfItems.count;
        }else {
            return 0;
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50;
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let myLabel = UILabel()
        myLabel.frame = CGRect(x: 15, y: 18, width: tableView.frame.size.width, height: 20)
        myLabel.font = UIFont(name:"Ubuntu", size: 18.0)
        myLabel.text = sectionNames[section]
        
        let headerView = UIView()
        headerView.addSubview(myLabel)
        
        return headerView;
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (sectionNames.count > 0) {
            return sectionNames[section]
        }
        return ""
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0;
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view
        header.backgroundColor = UIColor.white
        
        if let viewWithTag = self.view.viewWithTag(kHeaderSectionTag + section) {
            viewWithTag.removeFromSuperview()
        }
        let headerFrame = self.view.frame.size
        let theImageView = UIImageView(frame: CGRect(x: headerFrame.width - 75, y: 18, width: 15, height: 18));
        
        if self.selectedSection == section{
            theImageView.image = UIImage(named: "dropUp")
        }else{
            theImageView.image = UIImage(named: "dropDown")
        }
        
        
        theImageView.tag = kHeaderSectionTag + section
        header.addSubview(theImageView)
        
        // make headers touchable
        header.tag = section
        let headerTapGesture = UITapGestureRecognizer()
        headerTapGesture.addTarget(self, action: #selector(ActionItemFilterViewController.sectionHeaderWasTouched(_:)))
        header.addGestureRecognizer(headerTapGesture)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: filterCell, for: indexPath) as! ActionItemFilterTableViewCell
        cell.selectionStyle = .none
        
        self.passDataToTableViewCell(cell: cell, indexPath: indexPath)
        
        return cell
    }
}

//MARK:- TableView Delegate Methods
extension ActionItemFilterViewController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.view.endEditing(true)
        self.tableViewCellClickedSingleSelection(indexPath: indexPath , arrayContent : sectionData)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK:- UISearchBar Delegate Methods
extension ActionItemFilterViewController : UISearchBarDelegate{
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        if searchText.count == 0{
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.perform(#selector(resignFirstResponder), with: nil, afterDelay: 0.1)
    }
}
