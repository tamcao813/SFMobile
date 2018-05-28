//
//  CalendarMenuViewController.swift
//  SWSApp
//
//  Created by Thillaiganesh, C. on 11/05/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

protocol SearchCalendarByEnteredTextDelegate: class {
    func sortCalendarData(searchString: String)
    func filteringCalendar(filtering: Bool)
    func  performCalendarFilterOperation(searchString: String)
}

class CalendarMenuViewController: UIViewController {

    let kHeaderSectionTag: Int = 8900;
    var expandedSectionHeaderNumber: Int = 0
    var expandedSectionHeader: UITableViewHeaderFooterView!
    weak var searchByEnteredTextDelegate: SearchCalendarByEnteredTextDelegate?
    
    let filterClass = CalendarFilter()
    
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
        searchTextField.attributedPlaceholder = NSAttributedString(string:"Name, Account, ID", attributes: [NSAttributedStringKey.font: UIFont(name: "Ubuntu", size: 18)!])
        searchTextField.rightView = imageView
        searchTextField.rightViewMode = UITextFieldViewMode.always
    }

    //Used to Clear the Model Data
    func clearFilterModelData(){
        
        CalendarFilterMenuModel.searchText = ""

        CalendarFilterMenuModel.visitsType = "YES"
        CalendarFilterMenuModel.eventsType = "YES"
        
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
            calendarCellClickedSingleSelection(indexPath)
            
        default:
            break
            
        }
        
        tableView.reloadData()
        
    }
    
    func calendarCellClickedSingleSelection(_ indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            if CalendarFilterMenuModel.visitsType == "YES" {
                CalendarFilterMenuModel.visitsType = "NO"
            }
            else {
                CalendarFilterMenuModel.visitsType = "YES"
            }

        case 1:
            if CalendarFilterMenuModel.eventsType == "YES" {
                CalendarFilterMenuModel.eventsType = "NO"
            }
            else {
                CalendarFilterMenuModel.eventsType = "YES"
            }

        default:
            break
        }
        
    }
    
    //Data to pass for Respective Cell Class
    func passDataToTableViewCell(cell : UITableViewCell, indexPath : IndexPath){
        (cell as? CalendarMenuTableTableViewCell)?.displayCellContent(sectionContent: filterClass.sectionItems as NSArray, indexPath: indexPath)
        
    }
    
    func resetEnteredDataAndCalendarList(){
        searchBar.perform(#selector(resignFirstResponder), with: nil, afterDelay: 0.1)
        
        self.searchByEnteredTextDelegate?.filteringCalendar(filtering: false)
    }
    
    private func isValidUserInputAtSearchFilterPanel()->Bool{
        var validInput = false
        if(searchBar.text!.count > 0 ||
            (CalendarFilterMenuModel.visitsType == "NO" || CalendarFilterMenuModel.eventsType == "NO"))
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
            CalendarFilterMenuModel.searchText = searchBar.text!

            self.searchByEnteredTextDelegate?.filteringCalendar(filtering: true)
            searchByEnteredTextDelegate?.performCalendarFilterOperation(searchString: searchBar.text!)
            
        }
        else
        {
            //reset the table view data to main array
            self.searchByEnteredTextDelegate?.filteringCalendar(filtering: false)
        }
        let searchDict:[String: String] = ["SearchStr": searchBar.text!]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "EVENT_FILTER"), object: nil, userInfo: searchDict)
        self.tableView.setContentOffset(CGPoint.zero, animated: false)
    }
    
    //Clears all the filter selection
    @IBAction func clearButton(_ sender: Any) {
        self.clearFilterModelData()
        self.searchByEnteredTextDelegate?.filteringCalendar(filtering: false)
        let searchDict:[String: String] = ["SearchStr": searchBar.text!]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "EVENT_FILTER"), object: nil, userInfo: searchDict)
    }
    
}

//MARK:- TableView DataSource Methods
extension CalendarMenuViewController : UITableViewDataSource{
    
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
        
        cell = tableView.dequeueReusableCell(withIdentifier: CalendarFilterCell, for: indexPath) as! CalendarMenuTableTableViewCell
        cell?.selectionStyle = .none
        
        self.passDataToTableViewCell(cell: cell!, indexPath: indexPath)

        return cell!
    }
}

//MARK:- TableView Delegate Methods
extension CalendarMenuViewController : UITableViewDelegate{
    
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
extension CalendarMenuViewController : UISearchBarDelegate{
    
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
