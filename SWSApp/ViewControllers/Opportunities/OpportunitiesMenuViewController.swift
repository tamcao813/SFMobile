//
//  OpportunitiesMenuViewController.swift
//  SWSApp
//
//  Created by Thillaiganesh, C. on 31/05/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

protocol SearchOpportunitiesByEnteredTextDelegate: class {
    func sortOpportunitiesData(searchString: String)
    func filteringOpportunities(filtering: Bool)
    func  performOpportunitiesFilterOperation(searchString: String)
}

class OpportunitiesMenuViewController: UIViewController {

    let kHeaderSectionTag: Int = 9900;
    var expandedSectionHeaderNumber: Int = 0
    var expandedSectionHeader: UITableViewHeaderFooterView!
    weak var searchByEnteredTextDelegate: SearchOpportunitiesByEnteredTextDelegate?
    
    let filterClass = OpportunitiesFilter()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar : UISearchBar!
    
    //Used for selected section in TableView
    var selectedSection = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.clearFilterModelData()
        
        self.customizeSearchBar()
        
        self.tableView!.tableFooterView = UIView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.clearFilterModelData()
        self.addSearchIconInSearchBar()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        searchTextField.leftView = nil
        //Added attributedPlaceholder with ubuntu font
        searchTextField.attributedPlaceholder = NSAttributedString(string:"Product Name, ID", attributes: [NSAttributedStringKey.font: UIFont(name: "Ubuntu", size: 18)!])
        searchTextField.rightView = imageView
        searchTextField.rightViewMode = UITextFieldViewMode.always
    }
    
    //Used to Clear the Model Data
    func clearFilterModelData(){
        
        OpportunitiesFilterMenuModel.searchText = ""
        
        OpportunitiesFilterMenuModel.viewByCaseDecimal = "YES"
        OpportunitiesFilterMenuModel.viewBy9L = "NO"
        
        OpportunitiesFilterMenuModel.statusClosed = "NO"
        OpportunitiesFilterMenuModel.statusClosedWon = "NO"
        OpportunitiesFilterMenuModel.statusOpen = "NO"
        OpportunitiesFilterMenuModel.statusPlanned = "NO"
        
        OpportunitiesFilterMenuModel.sourceOverview = "NO"
        OpportunitiesFilterMenuModel.sourceTopSellers = "NO"
        OpportunitiesFilterMenuModel.sourceUndersold = "NO"
        OpportunitiesFilterMenuModel.sourceHotNot = "NO"
        OpportunitiesFilterMenuModel.sourceUnsold = "NO"
        
        OpportunitiesFilterMenuModel.objective9L = "NO"
        OpportunitiesFilterMenuModel.objectiveACS = "NO"
        OpportunitiesFilterMenuModel.objectiveDecimal = "NO"
        OpportunitiesFilterMenuModel.objectivePOD = "NO"
        OpportunitiesFilterMenuModel.objectiveRevenue = "NO"
        
        OpportunitiesFilterMenuModel.isAscendingProductName = ""
        OpportunitiesFilterMenuModel.isAscendingSource = ""
        OpportunitiesFilterMenuModel.isAscendingPYCMSold = ""
        OpportunitiesFilterMenuModel.isAscendingCommit = ""
        OpportunitiesFilterMenuModel.isAscendingSold = ""
        OpportunitiesFilterMenuModel.isAscendingMonth = ""
        OpportunitiesFilterMenuModel.isAscendingStatus = ""

        if searchBar != nil{
            searchBar.text = ""
        }
        
        //Used to Clear the Expanded section of ContactFilter Option
        selectedSection = 0
        self.expandedSectionHeaderNumber = 0
        
        if self.expandedSectionHeaderNumber != -1 {
            if self.expandedSectionHeaderNumber == 0 {
                
            }
            else {
                let cImageView = self.view.viewWithTag(kHeaderSectionTag + self.expandedSectionHeaderNumber) as? UIImageView
                if cImageView != nil {
                    tableViewCollapeSection(self.expandedSectionHeaderNumber, imageView: cImageView!)
                }
            }
        }
        
        if tableView != nil{
            tableView.reloadData()
        }
        
    }
    
    //Used to check which section header was clicked
    @objc func sectionHeaderWasTouched(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
        
        let headerView = sender.view
        let section    = headerView?.tag
        let eImageView = headerView?.viewWithTag(kHeaderSectionTag + section!) as? UIImageView
        
        self.selectedSection = section!
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
//            self.tableView.reloadData()
        }
        
        if selectedSection >= 5 {
            print("Your Channel is not Selected")
        }else{
            self.sectionHeaderOperation(section: section!, eImageView: eImageView)
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
                
                self.tableView!.scrollToRow(at: IndexPath(row: NSNotFound, section: section), at: .none, animated: false)
            } else {
                let cImageView = self.view.viewWithTag(kHeaderSectionTag + self.expandedSectionHeaderNumber) as? UIImageView
                tableViewCollapeSection(self.expandedSectionHeaderNumber, imageView: cImageView!)
                tableViewExpandSection(section, imageView: eImageView!)
            }
        }
    }
    
    //Used to dismiss Dropdown menu
    func tableViewCollapeSection(_ section: Int, imageView: UIImageView) {
        let sectionData = filterClass.sectionItems[section] as! NSArray
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
        
        let sectionData = filterClass.sectionItems[section] as! NSArray
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
            
            self.tableView!.scrollToRow(at: IndexPath(row: NSNotFound, section: section), at: .top, animated: false)
        }
    }
    
    //Dropdown Single selection option clicked and is assigned to model class
    func tableViewCellClickedSingleSelection(indexPath : IndexPath, arrayContent : Array<Any>) {
        
        switch indexPath.section {
        case 0:
            opportunitiesViewByCellClickedSingleSelection(indexPath)
            
        case 1:
            opportunitiesStatusCellClickedMultiSelection(indexPath)
            
        case 2:
            opportunitiesSourceCellClickedMultiSelection(indexPath)
            
        case 3:
            opportunitiesObjectiveCellClickedMultiSelection(indexPath)
            
        default:
            break
            
        }
        
        tableView.reloadData()
        
    }
    
    func opportunitiesViewByCellClickedSingleSelection(_ indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            if OpportunitiesFilterMenuModel.viewBy9L == "YES" {
                OpportunitiesFilterMenuModel.viewBy9L = "NO"
                OpportunitiesFilterMenuModel.viewByCaseDecimal = "YES"
            }
            else {
                OpportunitiesFilterMenuModel.viewBy9L = "YES"
                OpportunitiesFilterMenuModel.viewByCaseDecimal = "NO"
            }
            
        case 1:
            if OpportunitiesFilterMenuModel.viewByCaseDecimal == "YES" {
                OpportunitiesFilterMenuModel.viewByCaseDecimal = "NO"
                OpportunitiesFilterMenuModel.viewBy9L = "YES"
            }
            else {
                OpportunitiesFilterMenuModel.viewByCaseDecimal = "YES"
                OpportunitiesFilterMenuModel.viewBy9L = "NO"
            }

        default:
            break
        }
        
    }
    
    func opportunitiesStatusCellClickedMultiSelection(_ indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            if OpportunitiesFilterMenuModel.statusClosed == "YES" {
                OpportunitiesFilterMenuModel.statusClosed = "NO"
            }
            else {
                OpportunitiesFilterMenuModel.statusClosed = "YES"
            }
            
        case 1:
            if OpportunitiesFilterMenuModel.statusClosedWon == "YES" {
                OpportunitiesFilterMenuModel.statusClosedWon = "NO"
            }
            else {
                OpportunitiesFilterMenuModel.statusClosedWon = "YES"
            }
            
        case 2:
            if OpportunitiesFilterMenuModel.statusOpen == "YES" {
                OpportunitiesFilterMenuModel.statusOpen = "NO"
            }
            else {
                OpportunitiesFilterMenuModel.statusOpen = "YES"
            }
            
        case 3:
            if OpportunitiesFilterMenuModel.statusPlanned == "YES" {
                OpportunitiesFilterMenuModel.statusPlanned = "NO"
            }
            else {
                OpportunitiesFilterMenuModel.statusPlanned = "YES"
            }
            
        default:
            break
        }
        
    }
    
    func opportunitiesSourceCellClickedMultiSelection(_ indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            if OpportunitiesFilterMenuModel.sourceOverview == "YES" {
                OpportunitiesFilterMenuModel.sourceOverview = "NO"
            }
            else {
                OpportunitiesFilterMenuModel.sourceOverview = "YES"
            }
            
        case 1:
            if OpportunitiesFilterMenuModel.sourceTopSellers == "YES" {
                OpportunitiesFilterMenuModel.sourceTopSellers = "NO"
            }
            else {
                OpportunitiesFilterMenuModel.sourceTopSellers = "YES"
            }
            
        case 2:
            if OpportunitiesFilterMenuModel.sourceUndersold == "YES" {
                OpportunitiesFilterMenuModel.sourceUndersold = "NO"
            }
            else {
                OpportunitiesFilterMenuModel.sourceUndersold = "YES"
            }
            
        case 3:
            if OpportunitiesFilterMenuModel.sourceHotNot == "YES" {
                OpportunitiesFilterMenuModel.sourceHotNot = "NO"
            }
            else {
                OpportunitiesFilterMenuModel.sourceHotNot = "YES"
            }
            
        case 4:
            if OpportunitiesFilterMenuModel.sourceUnsold == "YES" {
                OpportunitiesFilterMenuModel.sourceUnsold = "NO"
            }
            else {
                OpportunitiesFilterMenuModel.sourceUnsold = "YES"
            }
            
        default:
            break
        }
        
    }

    func opportunitiesObjectiveCellClickedMultiSelection(_ indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            if OpportunitiesFilterMenuModel.objective9L == "YES" {
                OpportunitiesFilterMenuModel.objective9L = "NO"
            }
            else {
                OpportunitiesFilterMenuModel.objective9L = "YES"
            }
            
        case 1:
            if OpportunitiesFilterMenuModel.objectiveACS == "YES" {
                OpportunitiesFilterMenuModel.objectiveACS = "NO"
            }
            else {
                OpportunitiesFilterMenuModel.objectiveACS = "YES"
            }
            
        case 2:
            if OpportunitiesFilterMenuModel.objectiveDecimal == "YES" {
                OpportunitiesFilterMenuModel.objectiveDecimal = "NO"
            }
            else {
                OpportunitiesFilterMenuModel.objectiveDecimal = "YES"
            }
            
        case 3:
            if OpportunitiesFilterMenuModel.objectivePOD == "YES" {
                OpportunitiesFilterMenuModel.objectivePOD = "NO"
            }
            else {
                OpportunitiesFilterMenuModel.objectivePOD = "YES"
            }
            
        case 4:
            if OpportunitiesFilterMenuModel.objectiveRevenue == "YES" {
                OpportunitiesFilterMenuModel.objectiveRevenue = "NO"
            }
            else {
                OpportunitiesFilterMenuModel.objectiveRevenue = "YES"
            }
            
        default:
            break
        }
        
    }

    //Data to pass for Respective Cell Class
    func passDataToTableViewCell(cell : UITableViewCell, indexPath : IndexPath){
        (cell as? OpportunitiesMenuTableViewCell)?.displayCellContent(sectionContent: filterClass.sectionItems as NSArray, indexPath: indexPath)
        
    }
    
    func resetEnteredDataAndOpportunitiesList(){
        searchBar.perform(#selector(resignFirstResponder), with: nil, afterDelay: 0.1)
        
//        self.searchByEnteredTextDelegate?.filteringCalendar(filtering: false)
    }
    
    private func isValidUserInputAtSearchFilterPanel()->Bool{
        var validInput = false
        if(searchBar.text!.count > 0 ||
            (OpportunitiesFilterMenuModel.viewByCaseDecimal == "YES" || OpportunitiesFilterMenuModel.viewBy9L == "YES"))
        {
            validInput = true
        }
        
        return validInput
    }

    //MARK:- IBAction Methods
    
    //Filters the account list according to filter selection
    @IBAction func submitButton(_ sender: Any) {
        if(isValidUserInputAtSearchFilterPanel() == true)
        {
            OpportunitiesFilterMenuModel.searchText = searchBar.text!
            
            searchByEnteredTextDelegate?.performOpportunitiesFilterOperation(searchString: searchBar.text!)
        }
        else
        {
            //reset the table view data to main array
            self.searchByEnteredTextDelegate?.filteringOpportunities(filtering: false)
        }
        let _:[String: String] = ["SearchStr": searchBar.text!]
        self.tableView.setContentOffset(CGPoint.zero, animated: false)
    }
    
    //Clears all the filter selection
    @IBAction func clearButton(_ sender: Any) {
        self.clearFilterModelData()
        self.searchByEnteredTextDelegate?.filteringOpportunities(filtering: false)
        let _:[String: String] = ["SearchStr": searchBar.text!]
    }
    
}

//MARK:- TableView DataSource Methods
extension OpportunitiesMenuViewController : UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if filterClass.sectionNames.count > 0 {
            return filterClass.sectionNames.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.expandedSectionHeaderNumber == section) {
            let arrayOfItems = filterClass.sectionItems[section] as! NSArray
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
        myLabel.text = filterClass.sectionNames[section] as? String
        
        let headerView = UIView()
        headerView.addSubview(myLabel)
        
        return headerView;
    }
    
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (filterClass.sectionNames.count > 0) {
            return filterClass.sectionNames[section] as? String
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
        
        //As Action Item is in Sprint 2, Dropdown icon is set to DownArrow
        if section == 3 {
            theImageView.image = UIImage(named: "dropDown")
        }
        
        
        theImageView.tag = kHeaderSectionTag + section
        header.addSubview(theImageView)
        
        // make headers touchable
        header.tag = section
        let headerTapGesture = UITapGestureRecognizer()
        headerTapGesture.addTarget(self, action: #selector(AccountsMenuViewController.sectionHeaderWasTouched(_:)))
        header.addGestureRecognizer(headerTapGesture)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell : UITableViewCell?
        
        cell = tableView.dequeueReusableCell(withIdentifier: OpportunitiesFilterCell, for: indexPath) as! OpportunitiesMenuTableViewCell
        cell?.selectionStyle = .none
        
        self.passDataToTableViewCell(cell: cell!, indexPath: indexPath)
        
        return cell!
    }
}

//MARK:- TableView Delegate Methods
extension OpportunitiesMenuViewController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.view.endEditing(true)
        
        self.tableViewCellClickedSingleSelection(indexPath: indexPath , arrayContent : filterClass.sectionItems)
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK:- UISearchBar Delegate Methods
extension OpportunitiesMenuViewController : UISearchBarDelegate{
    
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
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.perform(#selector(resignFirstResponder), with: nil, afterDelay: 0.1)
    }
}
