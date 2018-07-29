
//  AccountsMenuController.swift
//  SWSApp
//
//  Created by r.a.jantakal on 28/03/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation
import UIKit

protocol SearchByEnteredTextDelegate: class {
    func sortAccountsData(searchString: String)
    func filtering(filtering: Bool)
    func performFilterOperation(searchString: String)
}

//Account Filter Menu options
enum AccountFilterMenuOptions : Int{
    case pastDue = 0
    case status = 1
    case premise = 2
    case singleMultiSelect = 3
    case channel = 4
    case subChannel = 5
    case licenseType = 6
    case myTeam = 7
}

class AccountsMenuViewController: UIViewController {
    
    let kHeaderSectionTag: Int = 6900;
    var expandedSectionHeaderNumber: Int = 1
    var expandedSectionHeader: UITableViewHeaderFooterView!
    weak var searchByEnteredTextDelegate: SearchByEnteredTextDelegate?
    lazy var filterClass = Filter()
    var sectionNames = [String]()
    var isManager: Bool = false
    var consultantAry = [Consultant]()
    var sectionData = [[Any]]()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar : UISearchBar!
    
    //Used for selected section in TableView
    var selectedSection = 1
    
    var accountsForLoggedUserFiltered = [Account]()
    
    //MARK: - ViewLifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.customizeSearchBar()
        self.tableView!.tableFooterView = UIView()
        self.addChannelAndSubchannelItems()
        
        //If isManager then add "My Team" and consultants
        consultantAry = UserViewModel().consultants
        consultantAry = consultantAry.sorted { $0.name < $1.name }
        
        isManager = consultantAry.count > 0
        sectionNames = filterClass.sectionNames(isManager: isManager)
        sectionData = filterClass.sectionItems
        
        if isManager {
            sectionData.insert(consultantAry, at: sectionData.count)
            filterClass.sectionItems = sectionData
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.addSearchIconInSearchBar()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.clearFilterModelData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.clearFilterModelData()
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
        searchTextField.attributedPlaceholder = NSAttributedString(string:"Search Field Text", attributes: [NSAttributedStringKey.font: UIFont(name: "Ubuntu", size: 18)!])
        searchTextField.rightView = imageView
        searchTextField.rightViewMode = UITextFieldViewMode.always
    }
    
    //Used to add Channels and Subchannels in Respective Sections
    func addChannelAndSubchannelItems(){
        
        let accountViewModel = AccountsViewModel()
        accountsForLoggedUserFiltered = AccountSortUtility.sortByAccountNameAlphabetically(accountsListToBeSorted:accountViewModel.accountsForLoggedUser(), ascending: true)
        
        var channelData = [String]()
        var subChannelData = [String]()
        
        for item in accountsForLoggedUserFiltered{
            let channel = item.channelTD
            let subchannel = item.subChannelTD
            
            if channel != "" {
                if subchannel != ""{
                    if !(channelData.contains(channel)){
                        channelData.append(channel)
                    }
                    if !(subChannelData.contains(subchannel)){
                        subChannelData.append(subchannel)
                    }
                }
            }
        }
        
        if channelData.count > 0 {
            if subChannelData.count > 0{
                filterClass.sectionItems.insert(channelData, at: AccountFilterMenuOptions.channel.rawValue)
                filterClass.sectionItems.insert([], at: AccountFilterMenuOptions.subChannel.rawValue)
            }
        }else{
            filterClass.sectionItems.insert([], at: AccountFilterMenuOptions.channel.rawValue)
            filterClass.sectionItems.insert([], at: AccountFilterMenuOptions.subChannel.rawValue)
        }
    }
    
    func clearFilterData(){
        if FilterMenuModel.comingFromDetailsScreen == "YES"{
            FilterMenuModel.comingFromDetailsScreen = "NO"
        }else{
            
            //reset to loggedInUser/Manager
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.currentSelectedUserId = (appDelegate.loggedInUser?.userId)!
            FilterMenuModel.selectedConsultant = nil
            
            FilterMenuModel.pastDueYes = ""
            FilterMenuModel.pastDueNo = ""
            
            FilterMenuModel.statusIsActive = ""
            FilterMenuModel.statusIsInActive = ""
            FilterMenuModel.statusIsSuspended = ""
            
            FilterMenuModel.premiseOn = ""
            FilterMenuModel.premiseOff = ""
            
            FilterMenuModel.singleSelected = ""
            FilterMenuModel.multiSelected = ""
            
            FilterMenuModel.licenseW = ""
            FilterMenuModel.licenseL = ""
            FilterMenuModel.licenseB = ""
            FilterMenuModel.licenseN = ""
            
            FilterMenuModel.channel = ""
            FilterMenuModel.subChannel = ""
            
            FilterMenuModel.city = ""
            
            if searchBar != nil{
                searchBar.text = ""
            }
            
            //Used to Clear the Expanded section of Filter Option
            selectedSection = -1
            if self.expandedSectionHeaderNumber != -1{
                let cImageView = self.view.viewWithTag(kHeaderSectionTag + self.expandedSectionHeaderNumber) as? UIImageView
                tableViewCollapeSection(self.expandedSectionHeaderNumber, imageView: cImageView!)
            }
            
            if tableView != nil{
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadAccountsData"), object:nil)
                tableView.reloadData()
            }
        }
    }

    
    //Used to Clear the Model Data
    func clearFilterModelData(){
        if FilterMenuModel.comingFromDetailsScreen == "YES"{
            FilterMenuModel.comingFromDetailsScreen = "NO"
        }else{
            
            //reset to loggedInUser/Manager
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.currentSelectedUserId = (appDelegate.loggedInUser?.userId)!
            FilterMenuModel.selectedConsultant = nil
            
            FilterMenuModel.pastDueYes = ""
            FilterMenuModel.pastDueNo = ""
            
            FilterMenuModel.statusIsActive = "YES"
            FilterMenuModel.statusIsInActive = ""
            FilterMenuModel.statusIsSuspended = ""
            
            FilterMenuModel.premiseOn = ""
            FilterMenuModel.premiseOff = ""
            
            FilterMenuModel.singleSelected = ""
            FilterMenuModel.multiSelected = ""
            
            FilterMenuModel.licenseW = ""
            FilterMenuModel.licenseL = ""
            FilterMenuModel.licenseB = ""
            FilterMenuModel.licenseN = ""
            
            FilterMenuModel.channel = ""
            FilterMenuModel.subChannel = ""
            
            FilterMenuModel.city = ""
            
            if searchBar != nil{
                searchBar.text = ""
            }
            
            //Used to Clear the Expanded section of Filter Option
            selectedSection = -1
            if self.expandedSectionHeaderNumber != 1{
                let cImageView = self.view.viewWithTag(kHeaderSectionTag + self.expandedSectionHeaderNumber) as? UIImageView
                 if self.expandedSectionHeaderNumber != -1 {
                    tableViewCollapeSection(self.expandedSectionHeaderNumber, imageView: cImageView!)
                }
            }
            
            if tableView != nil{
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadAccountsData"), object:nil)
                tableView.reloadData()
                if self.expandedSectionHeaderNumber != 1 {
                    if self.expandedSectionHeaderNumber != -1 {
                        tableViewCollapeSection(self.expandedSectionHeaderNumber, imageView: UIImageView(image: UIImage(named: "dropDown")))
                    }
                    self.sectionHeaderOperation(section: 1, eImageView: UIImageView(image: UIImage(named: "dropUp")))
                    
                }
            }
        }
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
        
        if selectedSection == 5{
            if FilterMenuModel.channel == ""{
                
            }else{
                self.sectionHeaderOperation(section: section!, eImageView: eImageView)
            }
        }else{
            self.sectionHeaderOperation(section: section!, eImageView: eImageView)
        }
    }
    
    //Perform Expansion and Collapsion based on Section Header Click
    func sectionHeaderOperation(section : Int , eImageView : UIImageView?){
        
        if (self.expandedSectionHeaderNumber == -1) {
            self.expandedSectionHeaderNumber = section
            tableViewExpandSection(section, imageView: eImageView!)
        } else {
            if (self.expandedSectionHeaderNumber == section) {
                tableViewCollapeSection(section, imageView: eImageView!)
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
    
    //Dropdown Single selection option clicked and is assigned to model class
    func tableViewCellClickedSingleSelection(indexPath : IndexPath , arrayContent : Array<Any>) {
        switch indexPath.section {
        case AccountFilterMenuOptions.pastDue.rawValue :
            self.performPastDueOperations(indexPath: indexPath)
        case AccountFilterMenuOptions.status.rawValue:
            self.performStatusOperation(indexPath: indexPath, arrayContent: arrayContent)
        case AccountFilterMenuOptions.premise.rawValue:
            self.performPremiseOperation(indexPath: indexPath)
        case AccountFilterMenuOptions.singleMultiSelect.rawValue:
            self.performSingleOrMultiSelection(indexPath: indexPath)
        case AccountFilterMenuOptions.channel.rawValue:
            self.performChannelOperation(indexPath: indexPath, arrayContent: arrayContent)
        case AccountFilterMenuOptions.subChannel.rawValue:
            self.performSubChannelOperation(indexPath: indexPath, arrayContent: arrayContent)
        case AccountFilterMenuOptions.licenseType.rawValue:
            self.performLicenseOperation(indexPath: indexPath)
        case AccountFilterMenuOptions.myTeam.rawValue:
            self.performSelectConsultantOperation(indexPath: indexPath)
        default:
            break
        }
        
        tableView.reloadData()
    }
    
    //PastDue operations
    func performPastDueOperations(indexPath : IndexPath){
        
        switch indexPath.row {
        case 0:
            FilterMenuModel.pastDueYes = "YES"
            FilterMenuModel.pastDueNo = "NO"
        case 1:
            FilterMenuModel.pastDueNo = "YES"
            FilterMenuModel.pastDueYes = "NO"
        default:
            break
        }
    }
    
    //Status Operations
    func performStatusOperation(indexPath : IndexPath , arrayContent : Array<Any>){
        
        let arrayData : [String] = arrayContent[indexPath.section] as! [String]
        
        switch indexPath.row {
        case 0:
            FilterMenuModel.statusIsActive = arrayData[indexPath.row]//"YES"
            FilterMenuModel.statusIsInActive = ""
            FilterMenuModel.statusIsSuspended = ""
        case 1:
            FilterMenuModel.statusIsActive = ""
            FilterMenuModel.statusIsInActive = arrayData[indexPath.row]//"YES"
            FilterMenuModel.statusIsSuspended = ""
        case 2:
            FilterMenuModel.statusIsActive = ""
            FilterMenuModel.statusIsInActive = ""
            FilterMenuModel.statusIsSuspended = arrayData[indexPath.row]//"YES"
        default:
            break
        }
    }
    
    //Premise Operations
    func performPremiseOperation(indexPath : IndexPath){
        switch indexPath.row {
        case 0:
            FilterMenuModel.premiseOn = "YES"
            FilterMenuModel.premiseOff = "NO"
        case 1:
            FilterMenuModel.premiseOn = "NO"
            FilterMenuModel.premiseOff = "YES"
        default:
            break
        }
    }
    
    //Single or multi selection
    func performSingleOrMultiSelection(indexPath : IndexPath){
        
        switch indexPath.row {
        case 0:
            FilterMenuModel.singleSelected = "YES"
            FilterMenuModel.multiSelected = "NO"
        case 1:
            FilterMenuModel.singleSelected = "NO"
            FilterMenuModel.multiSelected = "YES"
        default:
            break
        }
    }
    
    // Select Sub Channels
    
    func selectSubChannels(channelData:Array<String>, row: Int) {
        
        var subChannelData = [String]()
        
        for item in accountsForLoggedUserFiltered{
            let channel = item.channelTD
            let subchannel = item.subChannelTD
            
            if channel == channelData[row] {
                if subchannel != ""{
                    
                    if !(subChannelData.contains(subchannel)){
                        subChannelData.append(subchannel)
                    }
                }
            }
        }
        
        if channelData.count > 0 {
            if subChannelData.count > 0{
                
                filterClass.sectionItems.remove(at: AccountFilterMenuOptions.subChannel.rawValue)
                filterClass.sectionItems.insert(subChannelData, at: AccountFilterMenuOptions.subChannel.rawValue)
            }
        }else{
            filterClass.sectionItems.insert([], at: AccountFilterMenuOptions.subChannel.rawValue)
        }
        sectionData = filterClass.sectionItems
        
    }
    
    //Channel selection
    func performChannelOperation(indexPath : IndexPath, arrayContent : Array<Any>){
        
        FilterMenuModel.subChannelIndex = -1
        
        let channelData = sectionData[indexPath.section] as! [String]
        if channelData[0] != ""{
            let arrayData : [String] = arrayContent[indexPath.section] as! [String]
            FilterMenuModel.channelIndex = indexPath.row
            FilterMenuModel.channel = arrayData[indexPath.row]
        }
        self.selectSubChannels(channelData: channelData, row: indexPath.row)
    }
    
    //Subchannel Selection
    func performSubChannelOperation(indexPath : IndexPath, arrayContent : Array<Any>){
        
        let subchannelData = sectionData[indexPath.section] as! [String]
        if subchannelData[0] != ""{
            let arrayData : [String] = arrayContent[indexPath.section] as! [String]
            FilterMenuModel.subChannelIndex = indexPath.row
            FilterMenuModel.subChannel = arrayData[indexPath.row]
        }
    }
    
    //License Operation
    func performLicenseOperation(indexPath : IndexPath){
        
        switch indexPath.row {
        case 0:
            FilterMenuModel.licenseL = "YES"
            FilterMenuModel.licenseW = "NO"
            FilterMenuModel.licenseB = "NO"
            FilterMenuModel.licenseN = "NO"
        case 1:
            FilterMenuModel.licenseL = "NO"
            FilterMenuModel.licenseW = "YES"
            FilterMenuModel.licenseB = "NO"
            FilterMenuModel.licenseN = "NO"
        case 2:
            FilterMenuModel.licenseL = "NO"
            FilterMenuModel.licenseW = "NO"
            FilterMenuModel.licenseB = "YES"
            FilterMenuModel.licenseN = "NO"
        case 3:
            FilterMenuModel.licenseL = "NO"
            FilterMenuModel.licenseW = "NO"
            FilterMenuModel.licenseB = "NO"
            FilterMenuModel.licenseN = "YES"
        default:
            break
        }
    }
    
    //Perform filter for SalesConsultant
    func performSelectConsultantOperation(indexPath : IndexPath) {
        FilterMenuModel.selectedConsultant = consultantAry[indexPath.row]
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.currentSelectedUserId = consultantAry[indexPath.row].id
    }
    
    //Data to pass for Respective Cell Class
    func passDataToTableViewCell(cell : UITableViewCell, indexPath : IndexPath){
        (cell as? AccountsMenuTableTableViewCell)?.displayCellContent(sectionContent: sectionData as NSArray, indexPath: indexPath)
    }
    
    //Reset the values and clear the Filter Model
    func resetEnteredDataAndAccountList(){
        searchBar.perform(#selector(resignFirstResponder), with: nil, afterDelay: 0.1)
        
        if FilterMenuModel.comingFromDetailsScreen != "YES"{
            self.searchByEnteredTextDelegate?.filtering(filtering: false)
        }
        self.clearFilterModelData()
    }
    
    //Validation after selecting Submit
    private func isValidUserInputAtSearchFilterPanel()->Bool{
        var validInput = false
        if(searchBar.text!.count > 0 || FilterMenuModel.pastDueNo != "" || FilterMenuModel.pastDueYes != "" || FilterMenuModel.premiseOn != "" || FilterMenuModel.premiseOff != "" || FilterMenuModel.licenseB != "" || FilterMenuModel.licenseL != "" || FilterMenuModel.licenseN != "" || FilterMenuModel.licenseW != "" || FilterMenuModel.singleSelected != "" || FilterMenuModel.multiSelected != "" || FilterMenuModel.channel != "" || FilterMenuModel.subChannel != "" || FilterMenuModel.statusIsActive != "" || FilterMenuModel.statusIsInActive != "" || FilterMenuModel.statusIsSuspended != "" || FilterMenuModel.selectedConsultant != nil)
        {
            print("ValidUserInputAtSearchFilterPanel")
            validInput = true
        }
        
        return validInput
    }
    
    //MARK:- IBAction Methods
    
    //Filters the account list according to filter selection
    @IBAction func submitButton(_ sender: Any) {
        // step 1
        //Apply logic for filter selection performed in Filter screen to Filter List screen
        // validate user input and then proceed for filtering and search
        if(isValidUserInputAtSearchFilterPanel() == true)
        {
            self.searchByEnteredTextDelegate?.filtering(filtering: true)
            searchByEnteredTextDelegate?.performFilterOperation(searchString: searchBar.text!)
        }
        else
        {
            //reset the table view data to main array
            self.searchByEnteredTextDelegate?.filtering(filtering: false)
            
            print(" Not ValidUserInputAtSearchFilterPanel")
        }
    }
    
    //Clears all the filter selection
    @IBAction func clearButton(_ sender: Any) {
        self.clearFilterData()
        self.searchByEnteredTextDelegate?.filtering(filtering: false)
    }
}

//MARK:- TableView DataSource Methods
extension AccountsMenuViewController : UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if sectionNames.count > 0 {
            tableView.backgroundView = nil
            return sectionNames.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.expandedSectionHeaderNumber == section) {
            let arrayOfItems = sectionData[section]// as! NSArray
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
            print("UP")
        }else{
            theImageView.image = UIImage(named: "dropDown")
            print("Down")
        }
        
        //As Action Item is in Sprint 2, Dropdown icon is set to DownArrow
//        if section == 1{
//            theImageView.image = UIImage(named: "dropDown")
//        }
        
        //Used to check Subchannel Click action. if Channel is empty dont change the drop down icon
        if section == 5{
            if FilterMenuModel.channel == ""{
                theImageView.image = UIImage(named: "dropDown")
            }
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
        
        if indexPath.section <= 8{
            
            cell = tableView.dequeueReusableCell(withIdentifier: filterCell, for: indexPath) as! AccountsMenuTableTableViewCell
            cell?.selectionStyle = .none
            
            self.passDataToTableViewCell(cell: cell!, indexPath: indexPath)
            
        }else{
            //Used to display location view (If Required in future)
            if(indexPath.section == 9){ //This will have to take isManager into consideration
                
                cell = tableView.dequeueReusableCell(withIdentifier: locationCell, for: indexPath) as! AccountsMenuTableTableViewCell
                (cell as? AccountsMenuTableTableViewCell)?.displayLocationItemCellContent(indexPath: indexPath, placeHolderText: "Zip Code or City")
            }
        }
        
        return cell!
    }
}

//MARK:- TableView Delegate Methods
extension AccountsMenuViewController : UITableViewDelegate{
    
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
extension AccountsMenuViewController : UISearchBarDelegate{
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return AlertUtilities.disableEmojis(text: text)
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



