//
//  AccountVisitListFilterViewController.swift
//  SWSApp
//
//  Created by r.a.jantakal on 25/05/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation

protocol AccountVisitSearchButtonTappedDelegate {
    func performFilterOperation(searchText : UISearchBar)
    func clearFilter()
}

class AccountVisitListFilterViewController : UIViewController{
    
    let kHeaderSectionTag: Int = 6900;
    var expandedSectionHeaderNumber: Int = -1
    var expandedSectionHeader: UITableViewHeaderFooterView!
    //Used for selected section in TableView
    var selectedSection = -1
    var delegate : AccountVisitSearchButtonTappedDelegate?
    let accountVisit = AccountVisitListFilter()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar : UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.customizeSearchBar()
        self.tableView!.tableFooterView = UIView()
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
        
        self.sectionHeaderOperation(section: section!, eImageView: eImageView)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            self.tableView.reloadData()
        }
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
        let sectionData = accountVisit.sectionItems[section] as! NSArray
        self.expandedSectionHeaderNumber = -1
        
        if (sectionData.count == 0) {
            return;
        } else {
            UIView.animate(withDuration: 0.4, animations: {
                imageView.transform = CGAffineTransform(rotationAngle: (0.0 * CGFloat(Double.pi)) / 180.0)
            })
            var indexesPath = [IndexPath]()
            for i in 0 ..< sectionData.count {
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
        
        let sectionData = accountVisit.sectionItems[section] as! NSArray
        if (sectionData.count == 0) {
            self.expandedSectionHeaderNumber = -1;
            return;
        } else {
            UIView.animate(withDuration: 0.4, animations: {
                imageView.transform = CGAffineTransform(rotationAngle: (180.0 * CGFloat(Double.pi)) / 180.0)
            })
            var indexesPath = [IndexPath]()
            for i in 0 ..< sectionData.count {
                let index = IndexPath(row: i, section: section)
                indexesPath.append(index)
            }
            self.expandedSectionHeaderNumber = section
            self.tableView!.beginUpdates()
            self.tableView!.insertRows(at: indexesPath, with: UITableViewRowAnimation.fade)
            self.tableView!.endUpdates()
        }
    }
    
    //Data to pass for Respective Cell Class
    func passDataToTableViewCell(cell : UITableViewCell, indexPath : IndexPath){
        (cell as? AccountVisitListFilterTableViewCell)?.displayCellContent(sectionContent: accountVisit.sectionItems as NSArray, indexPath: indexPath)
    }
    
    //Dropdown Single selection option clicked and is assigned to model class
    func tableViewCellClickedSingleSelection(indexPath : IndexPath , arrayContent : Array<Any>) {
        
        switch indexPath.section {
        case 0:
            self.performTypeOperation(indexPath: indexPath)
            
        case 1:
            self.performDateRangeOperation(indexPath: indexPath)
            
        case 2:
            self.performStatusOperation(indexPath: indexPath)
            
        case 3:
            self.performPastVisitsOperation(indexPath: indexPath)
            
        default:
            break
        }
        tableView.reloadData()
    }
    
    func performTypeOperation(indexPath: IndexPath){
        
        switch indexPath.row {
        case 0:
            if AccountVisitListFilterModel.isTypeVisit == "NO"{
                AccountVisitListFilterModel.isTypeVisit = "YES"
            }else{
                AccountVisitListFilterModel.isTypeVisit = "NO"
            }
        case 1:
            if AccountVisitListFilterModel.isTypeEvent == "NO"{
                AccountVisitListFilterModel.isTypeEvent = "YES"
            }else{
                AccountVisitListFilterModel.isTypeEvent = "NO"
            }
        default:
            break
        }
    }
    
    func performDateRangeOperation(indexPath: IndexPath){
        
        switch indexPath.row {
        case 2:
            AccountVisitListFilterModel.isToday = "YES"
            AccountVisitListFilterModel.isTomorrow = "NO"
            AccountVisitListFilterModel.isThisWeek = "NO"
        case 3:
            AccountVisitListFilterModel.isToday = "NO"
            AccountVisitListFilterModel.isTomorrow = "YES"
            AccountVisitListFilterModel.isThisWeek = "NO"
        case 4:
            AccountVisitListFilterModel.isToday = "NO"
            AccountVisitListFilterModel.isTomorrow = "NO"
            AccountVisitListFilterModel.isThisWeek = "YES"
        default:
            break
        }
    }
    
    func performStatusOperation(indexPath: IndexPath){
        
        switch indexPath.row {
        case 0:
            if AccountVisitListFilterModel.isStatusScheduled == "NO"{
                AccountVisitListFilterModel.isStatusScheduled = "YES"
            }else{
                AccountVisitListFilterModel.isStatusScheduled = "NO"
            }
        case 1:
            if AccountVisitListFilterModel.isStatusPlanned == "NO"{
                AccountVisitListFilterModel.isStatusPlanned = "YES"
            }else{
                AccountVisitListFilterModel.isStatusPlanned = "NO"
            }
        case 2:
            if AccountVisitListFilterModel.isInProgress == "NO"{
                AccountVisitListFilterModel.isInProgress = "YES"
            }else{
                AccountVisitListFilterModel.isInProgress = "NO"
            }
        case 3:
            if AccountVisitListFilterModel.isComplete == "NO"{
                AccountVisitListFilterModel.isComplete = "YES"
            }else{
                AccountVisitListFilterModel.isComplete = "NO"
            }
        default:
            break
        }
    }
        
    func performPastVisitsOperation(indexPath: IndexPath){
        
        switch indexPath.row {
        case 0:
            if AccountVisitListFilterModel.isPastVisits == "NO"{
                AccountVisitListFilterModel.isPastVisits = "YES"
            }else{
                AccountVisitListFilterModel.isPastVisits = "NO"
            }
        default:
            break
        }
    }
    
    func clearAccountVisitFilterModel(){
        
        AccountVisitListFilterModel.isTypeVisit = "NO"
        AccountVisitListFilterModel.isTypeEvent = "NO"
        
        AccountVisitListFilterModel.isToday = "NO"
        AccountVisitListFilterModel.isTomorrow = "NO"
        AccountVisitListFilterModel.isThisWeek = "NO"
        
        AccountVisitListFilterModel.isStatusScheduled = "NO"
        AccountVisitListFilterModel.isStatusPlanned = "NO"
        AccountVisitListFilterModel.isInProgress = "NO"
        AccountVisitListFilterModel.isComplete = "NO"
        
        AccountVisitListFilterModel.isPastVisits = "NO"
        
        AccountVisitListFilterModel.filterApplied = false
        
        if searchBar != nil{
            searchBar.text = ""
        }
        //Used to Clear the Expanded section of Filter Option
        selectedSection = -1
        if self.expandedSectionHeaderNumber != -1{
            let cImageView = self.view.viewWithTag(kHeaderSectionTag + self.expandedSectionHeaderNumber) as? UIImageView
            tableViewCollapeSection(self.expandedSectionHeaderNumber, imageView: cImageView!)
        }
        
        delegate?.clearFilter()
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    //MARK:- Button Actions
    @IBAction func clearButtonTapped(_ sender: UIButton){
        self.clearAccountVisitFilterModel()
    }
    
    @IBAction func submitButtonTapped(_ sender: UIButton){
        delegate?.performFilterOperation(searchText: searchBar)
    }
}

//MARK:- TableView DataSource Methods
extension AccountVisitListFilterViewController : UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if accountVisit.sectionNames.count > 0 {
            tableView.backgroundView = nil
            return accountVisit.sectionNames.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.expandedSectionHeaderNumber == section) {
            let arrayOfItems = accountVisit.sectionItems[section] as! NSArray
            return arrayOfItems.count;
        }else {
            return 0;
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1{
            if indexPath.row == 0 || indexPath.row == 1{
                return 70
            }
        }
        return 50;
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let myLabel = UILabel()
        myLabel.frame = CGRect(x: 15, y: 18, width: tableView.frame.size.width, height: 20)
        myLabel.font = UIFont(name:"Ubuntu", size: 18.0)
        myLabel.text = accountVisit.sectionNames[section] as? String
        
        let headerView = UIView()
        headerView.addSubview(myLabel)
        
        return headerView;
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (accountVisit.sectionNames.count > 0) {
            return accountVisit.sectionNames[section] as? String
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
            print("UP")
        }else{
            theImageView.image = UIImage(named: "dropDown")
            print("Down")
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
        
        var cell : UITableViewCell?
        
        if indexPath.section == 1{
            if indexPath.row == 0{
                cell = tableView.dequeueReusableCell(withIdentifier: locationCell, for: indexPath) as! AccountVisitListFilterTableViewCell
                (cell as! AccountVisitListFilterTableViewCell).selectionStyle = .none
                (cell as! AccountVisitListFilterTableViewCell).lblTitle.text = "From"
                (cell as! AccountVisitListFilterTableViewCell).lblDate?.placeholder = "Start"
                
                
                
                
            }else if indexPath.row == 1{
                cell = tableView.dequeueReusableCell(withIdentifier: locationCell, for: indexPath) as! AccountVisitListFilterTableViewCell
                (cell as! AccountVisitListFilterTableViewCell).selectionStyle = .none
                (cell as! AccountVisitListFilterTableViewCell).lblTitle.text = "To"
                (cell as! AccountVisitListFilterTableViewCell).lblDate?.placeholder = "End"
                
                
                
                
            }else{
                cell = tableView.dequeueReusableCell(withIdentifier: filterCell, for: indexPath) as! AccountVisitListFilterTableViewCell
                cell?.selectionStyle = .none
                
                self.passDataToTableViewCell(cell: cell!, indexPath: indexPath)
                
            }
            return cell!
        }
        
        cell = tableView.dequeueReusableCell(withIdentifier: filterCell, for: indexPath) as! AccountVisitListFilterTableViewCell
        cell?.selectionStyle = .none
        
        self.passDataToTableViewCell(cell: cell!, indexPath: indexPath)
        
        return cell!
    }
}

//MARK:- TableView Delegate Methods
extension AccountVisitListFilterViewController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.view.endEditing(true)
        
        self.tableViewCellClickedSingleSelection(indexPath: indexPath , arrayContent : accountVisit.sectionItems)
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK:- UISearchBar Delegate Methods
extension AccountVisitListFilterViewController : UISearchBarDelegate{
    
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
        if searchText.count == 0
        {
            //self.searchByEnteredTextDelegate?.filtering(filtering: false)
            //searchBar.perform(#selector(resignFirstResponder), with: nil, afterDelay: 0.1)
        }/*
         else
         {
         self.searchByEnteredTextDelegate?.filtering(filtering: true)
         self.searchByEnteredTextDelegate?.sortAccountsData(searchString: searchText)
         }*/
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.perform(#selector(resignFirstResponder), with: nil, afterDelay: 0.1)
    }
}






