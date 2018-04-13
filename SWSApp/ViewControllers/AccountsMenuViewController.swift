//
//  AccountsMenuController.swift
//  SWSApp
//
//  Created by r.a.jantakal on 28/03/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation
import UIKit

protocol SearchByEnteredTextDelegate: class
{
    func sortAccountsData(searchString: String)
    func filtering(filtering: Bool)
    //
    func  performFilterOperation(searchString: String)
}


class AccountsMenuViewController: UIViewController {
    
    let kHeaderSectionTag: Int = 6900;
    var expandedSectionHeaderNumber: Int = -1
    var expandedSectionHeader: UITableViewHeaderFooterView!
    weak var searchByEnteredTextDelegate: SearchByEnteredTextDelegate?
    
    let filterClass = Filter()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar : UISearchBar!
    
    //Used to do for the Drop down Arrow during TableviewReload
    var selectedSection = -1
    
     var accountsForLoggedUserFiltered = [Account]()
    
    //MARK: - ViewLifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.customizeSearchBar()
        
        self.tableView!.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let accountViewModel = AccountsViewModel()
        accountsForLoggedUserFiltered = AccountSortUtility.sortByAccountNameAlphabetically(accountsListToBeSorted:accountViewModel.accountsForLoggedUser, ascending: true)
        print(accountsForLoggedUserFiltered.count)
        
        
        var channelData = [String]()
        var subChannelData = [String]()
        
        for item in accountsForLoggedUserFiltered{
            
            let channel = item.channelTD
            let subchannel = item.subChannelTD
            
            print(channel)
            print(subchannel)
            
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
                
                filterClass.sectionItems.insert(channelData, at: 5)
                filterClass.sectionItems.insert(subChannelData, at: 6)
                
            }
        }else{
            
            filterClass.sectionItems.insert([], at: 5)
            filterClass.sectionItems.insert([], at: 6)
        }
        
        print(filterClass.sectionItems)
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
    
    //Used to Clear the Model Data
    func clearFilterModelData(){
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
       
        
        if tableView != nil{
        tableView.reloadData()
        }
        
    }
    
    //Used to check which section header was clicked
    @objc func sectionHeaderWasTouched(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
        
        let headerView = sender.view as! UITableViewHeaderFooterView
        let section    = headerView.tag
        let eImageView = headerView.viewWithTag(kHeaderSectionTag + section) as? UIImageView
        
        self.selectedSection = section
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            self.tableView.reloadData()
        }
        
        if selectedSection == 6{
            
            if FilterMenuModel.channel == ""{
                
                print("Your Channel is not Selected")
            }else{
                
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
            
        }else{
            
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
        }
    }
    
    //Dropdown Single selection option clicked and is assigned to model class
    func tableViewCellClickedSingleSelection(indexPath : IndexPath , arrayContent : Array<Any>) {
        
        switch indexPath.section {
        case 0:
            
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
        case 2:
            
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
        case 3:
            
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
        case 4:
            
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
            
        case 5:
            
            //switch indexPath.row {
            //case 0:
            
            let channelData = filterClass.sectionItems[indexPath.section] as! [String]
            if channelData[0] != ""{
                let arrayData : [String] = arrayContent[indexPath.section] as! [String]
                FilterMenuModel.channelIndex = indexPath.row
                FilterMenuModel.channel = arrayData[indexPath.row]
            }
            
            //default:
            //    break
            //}
            
        case 6:
            
            //switch indexPath.row {
            //case 0:
            
            let channelData = filterClass.sectionItems[indexPath.section] as! [String]
            if channelData[0] != ""{
                let arrayData : [String] = [arrayContent[indexPath.section] as! String]
                FilterMenuModel.subChannelIndex = indexPath.row
                FilterMenuModel.subChannel = arrayData[indexPath.row]
            }
            //default:
            //    break
            //}
            
        case 7:
            
            switch indexPath.row {
            case 0:
                FilterMenuModel.licenseW = "YES"
                FilterMenuModel.licenseL = "NO"
                FilterMenuModel.licenseB = "NO"
                FilterMenuModel.licenseN = "NO"
            case 1:
                FilterMenuModel.licenseW = "NO"
                FilterMenuModel.licenseL = "YES"
                FilterMenuModel.licenseB = "NO"
                FilterMenuModel.licenseN = "NO"
            case 2:
                FilterMenuModel.licenseW = "NO"
                FilterMenuModel.licenseL = "NO"
                FilterMenuModel.licenseB = "YES"
                FilterMenuModel.licenseN = "NO"
            case 3:
                FilterMenuModel.licenseW = "NO"
                FilterMenuModel.licenseL = "NO"
                FilterMenuModel.licenseB = "NO"
                FilterMenuModel.licenseN = "YES"
            default:
                break
            }
        default:
            break
        }
        
        tableView.reloadData()
        
    }
    
    //Data to pass for Respective Cell Class
    func passDataToTableViewCell(cell : UITableViewCell, indexPath : IndexPath){
        (cell as? AccountsMenuTableTableViewCell)?.displayCellContent(sectionContent: filterClass.sectionItems as NSArray, indexPath: indexPath)
        
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
            print(" Not ValidUserInputAtSearchFilterPanel")
        }
    }
    
    private func isValidUserInputAtSearchFilterPanel()->Bool
    {
        var validInput = false
        if(searchBar.text!.count > 0 || FilterMenuModel.pastDueNo != "" || FilterMenuModel.pastDueYes != "" || FilterMenuModel.premiseOn != "" || FilterMenuModel.premiseOff != "" || FilterMenuModel.licenseB != "" || FilterMenuModel.licenseL != "" || FilterMenuModel.licenseN != "" || FilterMenuModel.licenseW != "" || FilterMenuModel.singleSelected != "" || FilterMenuModel.multiSelected != "" || FilterMenuModel.channel != "" || FilterMenuModel.subChannel != "")
        {
            print("ValidUserInputAtSearchFilterPanel")
            validInput = true
        }
        
        return validInput
    }
    
    //Clears all the filter selection
    @IBAction func clearButton(_ sender: Any) {
        self.clearFilterModelData()
        self.searchByEnteredTextDelegate?.filtering(filtering: false)
    }
    
    func resetEnteredDataAndAccountList()
    {
        searchBar.perform(#selector(resignFirstResponder), with: nil, afterDelay: 0.1)
        self.clearFilterModelData()
        self.searchByEnteredTextDelegate?.filtering(filtering: false)
    }
}

//MARK:- TableView DataSource Methods
extension AccountsMenuViewController : UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if filterClass.sectionNames.count > 0 {
            tableView.backgroundView = nil
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
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        header.contentView.backgroundColor = UIColor.white
        
        if let viewWithTag = self.view.viewWithTag(kHeaderSectionTag + section) {
            viewWithTag.removeFromSuperview()
        }
        let headerFrame = self.view.frame.size
        
        //view.frame.size.height = 45
        //view.layer.borderWidth = 1
        //view.layer.cornerRadius = 5
        //view.layer.borderColor = UIColor.init(red: 158/255, green: 158/255, blue: 158/255, alpha: 1.0).cgColor
        
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
        headerTapGesture.addTarget(self, action: #selector(AccountsMenuViewController.sectionHeaderWasTouched(_:)))
        header.addGestureRecognizer(headerTapGesture)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell : UITableViewCell?
        
        if indexPath.section <= 7{
            
            cell = tableView.dequeueReusableCell(withIdentifier: filterCell, for: indexPath) as! AccountsMenuTableTableViewCell
            cell?.selectionStyle = .none
            
            if(indexPath.section == 0) {
                
                self.passDataToTableViewCell(cell: cell!, indexPath: indexPath)
                
            } else if(indexPath.section == 1){
                
                self.passDataToTableViewCell(cell: cell!, indexPath: indexPath)
                
            }else if(indexPath.section == 2){
                
                self.passDataToTableViewCell(cell: cell!, indexPath: indexPath)
                
            }else if(indexPath.section == 3){
                
                self.passDataToTableViewCell(cell: cell!, indexPath: indexPath)
                
            }else if(indexPath.section == 4){
                
                self.passDataToTableViewCell(cell: cell!, indexPath: indexPath)
                
            }else if(indexPath.section == 5){
                
                self.passDataToTableViewCell(cell: cell!, indexPath: indexPath)
                
            }else if(indexPath.section == 6){
                
                self.passDataToTableViewCell(cell: cell!, indexPath: indexPath)
                
            }else if(indexPath.section == 7){
                
                self.passDataToTableViewCell(cell: cell!, indexPath: indexPath)
                
            }
            
        }else{
            
            //Used to display location view (If Required in future)
            if(indexPath.section == 8){
                
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
        
        self.tableViewCellClickedSingleSelection(indexPath: indexPath , arrayContent : filterClass.sectionItems)
        
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



