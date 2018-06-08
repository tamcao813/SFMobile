//
//  NotificationFilterViewController.swift
//  SWSApp
//
//  Created by manu.a.gupta on 31/05/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

protocol NotificationSearchButtonTappedDelegate {
    func performFilterOperation(searchText : UISearchBar)
    func clearFilter()
}

class NotificationFilterViewController: UIViewController {
    
    let kHeaderSectionTag: Int = 6900;
    var expandedSectionHeaderNumber: Int = -1
    var expandedSectionHeader: UITableViewHeaderFooterView!
    
    //Used for selected section in TableView
    var selectedSection = -1
    var delegate : NotificationSearchButtonTappedDelegate?
    let notification = NotificationFilter()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar : UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.customizeSearchBar()
        DispatchQueue.main.async {
            self.addSearchIconInSearchBar()
        }
        self.tableView!.tableFooterView = UIView()
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
        searchTextField.textAlignment = NSTextAlignment.left
        let image:UIImage = UIImage(named: "searchIcon")!
        let imageView:UIImageView = UIImageView.init(image: image)
        self.view.bringSubview(toFront : imageView)
        searchTextField.leftView = nil
        
        //Added attributedPlaceholder with ubuntu font
        searchTextField.attributedPlaceholder = NSAttributedString(string:"Search", attributes: [NSAttributedStringKey.font: UIFont(name: "Ubuntu", size: 18)!])
        searchTextField.rightView = imageView
        searchTextField.rightViewMode = UITextFieldViewMode.always
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
        let sectionData = notification.sectionItems[section] as! NSArray
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
        
        let sectionData = notification.sectionItems[section] as! NSArray
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
        (cell as? NotificationFilterTableViewCell)?.displayCellContent(sectionContent: notification.sectionItems as NSArray, indexPath: indexPath)
    }
    
    //Dropdown Single selection option clicked and is assigned to model class
    func tableViewCellClickedSingleSelection(indexPath : IndexPath , arrayContent : Array<Any>) {
        
        switch indexPath.section {
        case 0:
            self.performNotificatonTypeOpetation(indexPath: indexPath)
        case 1:
            self.performNotificationSubheadOpetation(indexPath: indexPath)
        default:
            break
        }
        tableView.reloadData()
    }
    
    func performNotificatonTypeOpetation(indexPath: IndexPath){
        
        switch indexPath.row {
        case 0:
            if NotificationFilterModel.isLicenseExpiration == "NO"{
                NotificationFilterModel.isLicenseExpiration = "YES"
            }else{
                NotificationFilterModel.isLicenseExpiration = "NO"
            }
        case 1:
            if NotificationFilterModel.isContactBirthday == "NO"{
                NotificationFilterModel.isContactBirthday = "YES"
            }else{
                NotificationFilterModel.isContactBirthday = "NO"
            }
        default:
            break
        }
    }
    
    func performNotificationSubheadOpetation(indexPath: IndexPath){
        
        switch indexPath.row {
        case 0:
            if NotificationFilterModel.isRead == "NO"{
                NotificationFilterModel.isRead = "YES"
            }else{
                NotificationFilterModel.isRead = "NO"
            }
        case 1:
            if NotificationFilterModel.isUnread == "NO"{
                NotificationFilterModel.isUnread = "YES"
            }else{
                NotificationFilterModel.isUnread = "NO"
            }
        default:
            break
        }
    }
    
    func clearActionItemFilterModel(){
        NotificationFilterModel.isLicenseExpiration = "No"
        NotificationFilterModel.isContactBirthday = "No"
        
        NotificationFilterModel.isRead = "No"
        NotificationFilterModel.isUnread = "No"
        selectedSection = -1
        if self.expandedSectionHeaderNumber != -1{
            let cImageView = self.view.viewWithTag(kHeaderSectionTag + self.expandedSectionHeaderNumber) as? UIImageView
            tableViewCollapeSection(self.expandedSectionHeaderNumber, imageView: cImageView!)
        }
        
        searchBar.text = ""
        NotificationFilterModel.filterApplied = false
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
extension NotificationFilterViewController : UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if notification.sectionNames.count > 0 {
            tableView.backgroundView = nil
            return notification.sectionNames.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.expandedSectionHeaderNumber == section) {
            let arrayOfItems = notification.sectionItems[section] as! NSArray
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
        myLabel.text = notification.sectionNames[section] as? String
        
        let headerView = UIView()
        headerView.addSubview(myLabel)
        
        return headerView;
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (notification.sectionNames.count > 0) {
            return notification.sectionNames[section] as? String
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationFilterTableViewCell", for: indexPath) as! NotificationFilterTableViewCell
        cell.selectionStyle = .none
        self.passDataToTableViewCell(cell: cell, indexPath: indexPath)
        
        return cell
    }
}

//MARK:- TableView Delegate Methods
extension NotificationFilterViewController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.view.endEditing(true)
        self.tableViewCellClickedSingleSelection(indexPath: indexPath , arrayContent : notification.sectionItems)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK:- UISearchBar Delegate Methods
extension NotificationFilterViewController : UISearchBarDelegate{
    
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
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.perform(#selector(resignFirstResponder), with: nil, afterDelay: 0.1)
    }
}

