//
//  ContactMenuViewController.swift
//  SWSApp
//
//  Created by Thillaiganesh, C. on 21/04/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation
import UIKit

protocol SearchContactByEnteredTextDelegate: class {
    func sortContactData(searchString: String)
    func filteringContact(filtering: Bool)
    func  performContactFilterOperation(searchString: String)
}

class ContactMenuViewController: UIViewController {

    let kHeaderSectionTag: Int = 7900;
    var expandedSectionHeaderNumber: Int = 0
    var expandedSectionHeader: UITableViewHeaderFooterView!
    weak var searchByEnteredTextDelegate: SearchContactByEnteredTextDelegate?
    
    let filterClass = ContactFilter()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar : UISearchBar!
    
    //Used for selected section in TableView
    var selectedSection = 0
    
    var contactForLoggedUserFiltered = [Account]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.customizeSearchBar()
        
        self.tableView!.tableFooterView = UIView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadFuncRoles()
    }

    func loadFuncRoles() {
        if let contactData = ContactsViewModel().globalContacts() as [Contact]? {
            
            var functionRoles = filterClass.sectionItems[0] as! [String]
            
            for contactObject in contactData {
                
                let accountsListWithContactId = AccountContactRelationUtility.getAccountByFilterByContactId(contactId: contactObject.contactId)
                for acrObject in accountsListWithContactId {
                    if acrObject.roles != ""{
                        if !(functionRoles.contains(acrObject.roles)){
                            functionRoles.append(acrObject.roles)
                        }
                    }
                }
                
            }
            
            if functionRoles.count > 0{
                filterClass.sectionItems[0] = functionRoles
            }
            
        }
        
        print(filterClass.sectionItems)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.addSearchIconInSearchBar()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.clearFilterModelData(clearcontactsOnMyRoute: false)
        
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
        searchTextField.attributedPlaceholder = NSAttributedString(string:"Name, Account, ID", attributes: [NSAttributedStringKey.font: UIFont(name: "Ubuntu", size: 18)!])
        searchTextField.rightView = imageView
        searchTextField.rightViewMode = UITextFieldViewMode.always
    }

    func relaodFilter(){
        loadFuncRoles()
        
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.tableView.reloadData()
        }
    }
    
    //Used to Clear the Model Data
    func clearFilterModelData(clearcontactsOnMyRoute: Bool){
        
        ContactFilterMenuModel.allRole = ""
        ContactFilterMenuModel.functionRoles = [String]()
        
        ContactFilterMenuModel.allBuyingPower = ""
        ContactFilterMenuModel.buyingPower = ""
        ContactFilterMenuModel.nobuyingPower = ""
        
//        ContactFilterMenuModel.comingFromDetailsScreen = ""
        
        if searchBar != nil{
            searchBar.text = ""
        }
        
        //Used to Clear the Expanded section of ContactFilter Option
        selectedSection = -1
        self.expandedSectionHeaderNumber = -1

        if self.expandedSectionHeaderNumber != -1{
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
            self.tableView.reloadData()
        }
        
        if selectedSection >= 3{
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
        }
    }
    
    //Dropdown Single selection option clicked and is assigned to model class
    func tableViewCellClickedSingleSelection(indexPath : IndexPath, arrayContent : Array<Any>) {
        
        switch indexPath.section {
        case 0:
            roleCellClickedSingleSelection(indexPath, arrayContent: arrayContent)
        case 1:
            buyingPowerCellClickedSingleSelection(indexPath)
        default:
            break
        }
        
        tableView.reloadData()
        
    }
    
    func roleCellClickedSingleSelection(_ indexPath: IndexPath, arrayContent : Array<Any>) {
        switch indexPath.row {
            
        case 0:
            if ContactFilterMenuModel.allRole == "YES"{
                ContactFilterMenuModel.allRole = "NO"
            }
            else {
                ContactFilterMenuModel.allRole = "YES"
            }
        default:
            let titleContent = arrayContent[indexPath.section] as? NSArray
            if let index = ContactFilterMenuModel.functionRoles.index(of: (titleContent![indexPath.row] as? String)!) {
                ContactFilterMenuModel.functionRoles.remove(at: index)
            }
            else {
                ContactFilterMenuModel.functionRoles.append((titleContent![indexPath.row] as? String)!)
            }
            break
        }
        
    }

    func buyingPowerCellClickedSingleSelection(_ indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            if ContactFilterMenuModel.allBuyingPower == "YES"{
                ContactFilterMenuModel.allBuyingPower = "NO"
            }
            else {
                ContactFilterMenuModel.allBuyingPower = "YES"
            }
        case 1:
            if ContactFilterMenuModel.buyingPower == "YES"{
                ContactFilterMenuModel.buyingPower = "NO"
            }
            else {
                ContactFilterMenuModel.buyingPower = "YES"
            }
        case 2:
            if ContactFilterMenuModel.nobuyingPower == "YES"{
                ContactFilterMenuModel.nobuyingPower = "NO"
            }
            else {
                ContactFilterMenuModel.nobuyingPower = "YES"
            }
        default:
            break
        }
    }
    
    //Data to pass for Respective Cell Class
    func passDataToTableViewCell(cell : UITableViewCell, indexPath : IndexPath){
        (cell as? ContactMenuTableTableViewCell)?.displayCellContent(sectionContent: filterClass.sectionItems as NSArray, indexPath: indexPath)
        
    }
    
    func resetEnteredDataAndContactList(){
        searchBar.perform(#selector(resignFirstResponder), with: nil, afterDelay: 0.1)
        
        self.searchByEnteredTextDelegate?.filteringContact(filtering: false)
        self.clearFilterModelData(clearcontactsOnMyRoute: false)
        ContactFilterMenuModel.comingFromDetailsScreen = ""

    }
    
    private func isValidUserInputAtSearchFilterPanel()->Bool{
        var validInput = false
        if(searchBar.text!.count > 0 || (ContactFilterMenuModel.allRole == "YES" || ContactFilterMenuModel.functionRoles.count > 0) ||
            (ContactFilterMenuModel.allBuyingPower == "YES" || ContactFilterMenuModel.buyingPower == "YES" || ContactFilterMenuModel.nobuyingPower == "YES" /*ContactFilterMenuModel.buyerFlags.count > 0*/))
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
        //Apply logic for filter selection performed in ContactFilter screen to ContactFilter List screen
        // validate user input and then proceed for filtering and search
        if(isValidUserInputAtSearchFilterPanel() == true)
        {
            self.searchByEnteredTextDelegate?.filteringContact(filtering: true)
            searchByEnteredTextDelegate?.performContactFilterOperation(searchString: searchBar.text!)
        }
        else
        {
            //reset the table view data to main array
            self.searchByEnteredTextDelegate?.filteringContact(filtering: false)
            
            print(" Not ValidUserInputAtSearchFilterPanel")
        }
        self.tableView.setContentOffset(CGPoint.zero, animated: false)
    }
    
    //Clears all the filter selection
    @IBAction func clearButton(_ sender: Any) {
        self.clearFilterModelData(clearcontactsOnMyRoute: true)
        self.searchByEnteredTextDelegate?.filteringContact(filtering: false)

    }

}

//MARK:- TableView DataSource Methods
extension ContactMenuViewController : UITableViewDataSource{
    
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
        if section == 3{
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
        
        if indexPath.section <= 2{
            
            cell = tableView.dequeueReusableCell(withIdentifier: ContactFilterCell, for: indexPath) as! ContactMenuTableTableViewCell
            cell?.selectionStyle = .none
            
            self.passDataToTableViewCell(cell: cell!, indexPath: indexPath)
            
        }else{
            
            //Used to display location view (If Required in future)
            if(indexPath.section == 3){
                
                cell = tableView.dequeueReusableCell(withIdentifier: ContacLocationCell, for: indexPath) as! ContactMenuTableTableViewCell
                (cell as? ContactMenuTableTableViewCell)?.displayLocationItemCellContent(indexPath: indexPath, placeHolderText: "Zip Code or City")
            }
        }
        
        return cell!
    }
}

//MARK:- TableView Delegate Methods
extension ContactMenuViewController : UITableViewDelegate{
    
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
extension ContactMenuViewController : UISearchBarDelegate{
    
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
         self.searchByEnteredTextDelegate?.sortContactData(searchString: searchText)
         }*/
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.perform(#selector(resignFirstResponder), with: nil, afterDelay: 0.1)
    }
}
