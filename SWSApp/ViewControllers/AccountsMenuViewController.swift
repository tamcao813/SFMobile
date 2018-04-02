//
//  AccountsMenuController.swift
//  SWSApp
//
//  Created by r.a.jantakal on 28/03/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation
import UIKit
import DropDown

class AccountsMenuViewController: UIViewController {

    let kHeaderSectionTag: Int = 6900;
    var expandedSectionHeaderNumber: Int = -1
    var expandedSectionHeader: UITableViewHeaderFooterView!
    var sectionItems: Array<Any> = []
    var sectionNames: Array<Any> = []
    
    let dropDownMenu = DropDown()
    let placeHolderName = "Select item"
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar : UISearchBar!
    
    //Used to do for the Drop down Arrow during Relaod
    var selectedSection = -1
    
    //MARK: - ViewLifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.customizeSearchBar()
        self.customizeDropDown()
        
        sectionNames = ["Past Due", "Action Items", "Status", "Premise" , "Single/Multi locations" ,"Channel", "Sub-Channel" ,"License Type"];
        
        sectionItems = [ ["YES", "NO"],[],
                         ["Active", "Inactive","Suspended"],
                         ["ON","OFF"], ["Single","Multi"],[],[],["W","L","B","N"]];
        
        self.tableView!.tableFooterView = UIView()
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
                        searchVW.backgroundColor = UIColor.white//init(red: 228/255, green: 228/255, blue: 230/255, alpha: 1.0)
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
        searchTextField.placeholder = "Search Field Text"
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
        
        FilterMenuModel.city = ""
        
        tableView.reloadData()
    }
    
    //Clickable items color after clicking table view cell
    func customizeDropDown() {
        let appearance = DropDown.appearance()
        appearance.cellHeight = 60
        appearance.backgroundColor = UIColor(white: 1, alpha: 1)
        appearance.selectionBackgroundColor = UIColor(red: 0.6494, green: 0.8155, blue: 1.0, alpha: 0.2)
        appearance.cornerRadius = 10
        appearance.shadowColor = UIColor(white: 0.6, alpha: 1)
        appearance.shadowOpacity = 0.9
        appearance.shadowRadius = 25
        appearance.animationduration = 0.25
        appearance.textColor = .darkGray
    }
    
    //Used to check which section header was clicked
    @objc func sectionHeaderWasTouched(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
        
        let headerView = sender.view as! UITableViewHeaderFooterView
        let section    = headerView.tag
        let eImageView = headerView.viewWithTag(kHeaderSectionTag + section) as? UIImageView
        
        self.selectedSection = section
        
        if (self.expandedSectionHeaderNumber == -1) {
            self.expandedSectionHeaderNumber = section
            tableViewExpandSection(section, imageView: eImageView!)
        } else {
            if (self.expandedSectionHeaderNumber == section) {
                tableViewCollapeSection(section, imageView: eImageView!)
            } else {
                let cImageView = self.view.viewWithTag(kHeaderSectionTag + self.expandedSectionHeaderNumber) as? UIImageView
                tableViewCollapeSection(self.expandedSectionHeaderNumber, imageView: cImageView!)
                tableViewExpandSection(section, imageView: eImageView!)
            }
        }
    }
    
    //Used to dismiss Dropdown menu
    func tableViewCollapeSection(_ section: Int, imageView: UIImageView) {
        let sectionData = self.sectionItems[section] as! NSArray
        
        self.selectedSection = -1
        
        self.expandedSectionHeaderNumber = -1;
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
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.tableView.reloadData()
            }
        }
    }
    
    //Used to show Dropdown menu
    func tableViewExpandSection(_ section: Int, imageView: UIImageView) {
        let sectionData = self.sectionItems[section] as! NSArray
        
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
    
    //Dropdown Multi selection option clicked and is assigned to model class
    func tableViewCellClickedMultipleSelection(indexPath : IndexPath , currentCell : UITableViewCell){
        
        //Used for MultiSelect in the Dropdown
        /* dropDownMenu.multiSelectionAction = { [weak self] (indices, items) in
         let itemsSelected = items.joined(separator: ",")
         
         if(indexPath.section == 0){
         if(indexPath.row == 0){
         (currentCell as! FilterTableViewCell).filterLabel.text = itemsSelected
         self?.local_pastDue = (currentCell as! FilterTableViewCell).filterLabel.text!
         }
         } else if(indexPath.section == 1){
         switch(indexPath.row){
         case 0:
         (currentCell as! FilterTableViewCell).filterLabel.text = itemsSelected
         self?.local_status = (currentCell as! FilterTableViewCell).filterLabel.text!
         case 1:
         (currentCell as! FilterTableViewCell).filterLabel.text = itemsSelected
         self?.local_premise = (currentCell as! FilterTableViewCell).filterLabel.text!
         case 2:
         (currentCell as! FilterTableViewCell).filterLabel.text = itemsSelected
         self?.local_locations = (currentCell as! FilterTableViewCell).filterLabel.text!
         case 3:
         (currentCell as! FilterTableViewCell).filterLabel.text = itemsSelected
         self?.local_channel = (currentCell as! FilterTableViewCell).filterLabel.text!
         case 4:
         (currentCell as! FilterTableViewCell).filterLabel.text = itemsSelected
         self?.local_subChannel = (currentCell as! FilterTableViewCell).filterLabel.text!
         case 5:
         (currentCell as! FilterTableViewCell).filterLabel.text = itemsSelected
         self?.local_licenseType = (currentCell as! FilterTableViewCell).filterLabel.text!
         default:
         break
         }
         }
         } */
        
    }
    
    //Dropdown Single selection option clicked and is assigned to model class
    func tableViewCellClickedSingleSelection(indexPath : IndexPath){
        
        //dropDownMenu.selectionAction = { [weak self] (index, item) in
            // check the section and row.. and accordingly set the selected/edited value to respective class variable
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
            
                switch indexPath.row {
                    case 0:
                        FilterMenuModel.statusIsActive = "YES"
                        FilterMenuModel.statusIsInActive = "NO"
                        FilterMenuModel.statusIsSuspended = "NO"
                    case 1:
                        FilterMenuModel.statusIsActive = "NO"
                        FilterMenuModel.statusIsInActive = "YES"
                        FilterMenuModel.statusIsSuspended = "NO"
                    case 2:
                        FilterMenuModel.statusIsActive = "NO"
                        FilterMenuModel.statusIsInActive = "NO"
                        FilterMenuModel.statusIsSuspended = "YES"
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
    
    //Used to show dropdown options fkor the selected Cells
    func showDropDownOptionsInCell(indexPath : IndexPath, currentCell: UITableViewCell){
        //Get rowID as string from indexpath of section and row
        let rowId = String(indexPath.section) + String(indexPath.row)
        currentCell.tag = Int(rowId)!
        switch currentCell.tag {
        case 00:
            dropDownMenu.dataSource = ["Yes", "No"]
            dropDownMenu.show()
        case 01:
            dropDownMenu.dataSource = ["Yes", "No"]
            dropDownMenu.show()
        case 10:
            dropDownMenu.dataSource = ["Active", "Inactive", "Suspended"]
            dropDownMenu.show()
        case 11:
            dropDownMenu.dataSource = ["On", "Off"]
            dropDownMenu.show()
        case 12:
            dropDownMenu.dataSource = ["Single", "Multi"]
            dropDownMenu.show()
        case 15:
            dropDownMenu.dataSource = ["W", "L", "B", "N"]
            dropDownMenu.show()
        default:
            break
        }
    }
    
    //MARK:- IBAction Methods
    
    //Filters the account list according to filter selection
    @IBAction func submitButton(_ sender: Any) {
        self.clearFilterModelData()
    }
    
    //Clears all the filter selection
    @IBAction func clearButton(_ sender: Any) {
        self.clearFilterModelData()
    }
}

//MARK:- TableView DataSource Methods
extension AccountsMenuViewController : UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if sectionNames.count > 0 {
            tableView.backgroundView = nil
            return sectionNames.count
        } else {
            let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: view.bounds.size.height))
            messageLabel.text = "Retrieving data.\nPlease wait."
            messageLabel.numberOfLines = 0;
            messageLabel.textAlignment = .center;
            messageLabel.font = UIFont(name: "Ubuntu", size: 20.0)!
            messageLabel.sizeToFit()
            self.tableView.backgroundView = messageLabel;
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.expandedSectionHeaderNumber == section) {
            let arrayOfItems = self.sectionItems[section] as! NSArray
            return arrayOfItems.count;
        }else {
            return 0;
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70;
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (self.sectionNames.count > 0) {
            return self.sectionNames[section] as? String
        }
        return ""
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0;
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        //recast your view as a UITableViewHeaderFooterView
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        header.contentView.backgroundColor = UIColor.white//colorWithHexString(hexStr: "#408000")
        //header.textLabel?.textColor = UIColor.black
        
        if let viewWithTag = self.view.viewWithTag(kHeaderSectionTag + section) {
            viewWithTag.removeFromSuperview()
        }
        let headerFrame = self.view.frame.size
        
        let theImageView = UIImageView(frame: CGRect(x: headerFrame.width - 40, y: 13, width: 15, height: 18));

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
        
        var cell1 : UITableViewCell?
        
        if indexPath.section <= 7{
            
            cell1 = tableView.dequeueReusableCell(withIdentifier: "customCell1", for: indexPath) as! AccountsMenuTableTableViewCell
            
            if(indexPath.section == 0) {
                
                (cell1 as? AccountsMenuTableTableViewCell)?.displayCellContent(sectionContent: sectionItems as NSArray, indexPath: indexPath, placeHolderText: placeHolderName)
                
            } else if(indexPath.section == 1){
                
                (cell1 as! AccountsMenuTableTableViewCell).displayCellContent(sectionContent: sectionItems as NSArray, indexPath: indexPath, placeHolderText: placeHolderName)
                
            }else if(indexPath.section == 2){
                
                (cell1 as! AccountsMenuTableTableViewCell).displayCellContent(sectionContent: sectionItems as NSArray, indexPath: indexPath, placeHolderText: placeHolderName)
                
            }else if(indexPath.section == 3){
                
                (cell1 as! AccountsMenuTableTableViewCell).displayCellContent(sectionContent: sectionItems as NSArray, indexPath: indexPath, placeHolderText: placeHolderName)
                
            }else if(indexPath.section == 4){
                
                (cell1 as! AccountsMenuTableTableViewCell).displayCellContent(sectionContent: sectionItems as NSArray, indexPath: indexPath, placeHolderText: placeHolderName)
                
            }else if(indexPath.section == 5){
                
                (cell1 as! AccountsMenuTableTableViewCell).displayCellContent(sectionContent: sectionItems as NSArray, indexPath: indexPath, placeHolderText: placeHolderName)
                
            }else if(indexPath.section == 6){
                
                (cell1 as! AccountsMenuTableTableViewCell).displayCellContent(sectionContent: sectionItems as NSArray, indexPath: indexPath, placeHolderText: placeHolderName)
                
            }else if(indexPath.section == 7){
                
                (cell1 as! AccountsMenuTableTableViewCell).displayCellContent(sectionContent: sectionItems as NSArray, indexPath: indexPath, placeHolderText: placeHolderName)
            }
            
        }else{
        
            if(indexPath.section == 8){
                
                cell1 = tableView.dequeueReusableCell(withIdentifier: "customCell2", for: indexPath) as! AccountsMenuTableTableViewCell
                (cell1 as? AccountsMenuTableTableViewCell)?.displayLocationItemCellContent(indexPath: indexPath, placeHolderText: "Zip Code or City")
            }
        }
        
        return cell1!
    }
}

//MARK:- TableView Delegate Methods
extension AccountsMenuViewController : UITableViewDelegate{

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //tableView.deselectRow(at: indexPath, animated: true)
        self.view.endEditing(true)
       // let filterIndexPath = tableView.indexPathForSelectedRow
       // let currentCell = tableView.cellForRow(at: filterIndexPath!) as! AccountsMenuTableTableViewCell//tableView.cellForRow(at: filterIndexPath!) as! FilterTableViewCell
       // dropDownMenu.anchorView = (currentCell ).filterLabel//dropDownImageView
       // dropDownMenu.direction = .bottom
        /*if indexPath.section == 2{
        
            currentCell = tableView.cellForRow(at: filterIndexPath!) as! AccountsMenuTableTableViewCell
        
        }else{
            currentCell = tableView.cellForRow(at: filterIndexPath!) as! AccountsMenuTableTableViewCell
        
            dropDownMenu.anchorView = (currentCell as! AccountsMenuTableTableViewCell).filterLabel//dropDownImageView
            dropDownMenu.direction = .bottom
        
            //Used for Multi selection in the DropDown
            //self.tableViewCellClickedMultipleSelection(indexPath: indexPath, currentCell: currentCell!)
            
            //Used for Single selection in the DropDown
            self.tableViewCellClickedSingleSelection(indexPath: indexPath, currentCell: currentCell!)
            
        } */
        
        
        //Used for Single selection in the DropDown
        self.tableViewCellClickedSingleSelection(indexPath: indexPath)

        tableView.deselectRow(at: indexPath, animated: true)

        //self.showDropDownOptionsInCell(indexPath: indexPath, currentCell: currentCell!)
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
        //self.tableViewBottomConstraint.constant = 216 // height of the keyboard
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
        if searchText.count == 0{
            searchBar.perform(#selector(resignFirstResponder), with: nil, afterDelay: 0.1)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.perform(#selector(resignFirstResponder), with: nil, afterDelay: 0.1)
    }
}



