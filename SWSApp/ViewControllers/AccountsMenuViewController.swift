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

class AccountsMenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let kHeaderSectionTag: Int = 6900; 
    var filterModelView: FilterViewModel?
    var local_pastDue: String = ""
    var local_status: String = ""
    var local_premise: String = ""
    var local_locations: String = ""
    var local_channel: String = ""
    var local_subChannel: String = ""
    var local_licenseType: String = ""
    var local_city: String = ""
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar : UISearchBar!
    @IBOutlet weak var searchView : UIView!
    
    //Filters the account list according to filter selection
    @IBAction func submitButton(_ sender: Any) {
        filterModelView = FilterViewModel()
        // Get values from UI and set to model
        filterModelView?.pastDue = local_pastDue
        filterModelView?.status = local_status
        filterModelView?.premise = local_premise
        filterModelView?.locations = local_locations
        filterModelView?.channel = local_channel
        filterModelView?.subChannel = local_subChannel
        filterModelView?.licenseType = local_licenseType
        filterModelView?.city = local_city
    }
    
    //Clears all the filter selection
    @IBAction func clearButton(_ sender: Any) {
        filterModelView?.pastDue = ""
        filterModelView?.status = ""
        filterModelView?.premise = ""
        filterModelView?.locations = ""
        filterModelView?.channel = ""
        filterModelView?.subChannel = ""
        filterModelView?.licenseType = ""
        filterModelView?.city = ""
        tableView.reloadData()
    }
    
    var expandedSectionHeaderNumber: Int = -1
    var expandedSectionHeader: UITableViewHeaderFooterView!
    var sectionItems: Array<Any> = []
    var sectionNames: Array<Any> = []
    
    let dropDownMenu = DropDown()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Used to clear Searchbar background
        searchBar.layer.backgroundColor = UIColor.clear.cgColor
        
        searchView.layer.cornerRadius = 3
        searchView.layer.borderWidth = 1
        searchView.layer.borderColor = UIColor.lightGray.cgColor
        searchView.layer.opacity = 70
        
        sectionNames = [ "Action Items", "Account Type", "Location" ];
        sectionItems = [ ["Past Due", "Open Issues"],
                         ["Status", "Premise","Single / Multiple Locations","Channels","Sub-Channel","License Type"],
                         ["Location"]
        ];
        self.tableView!.tableFooterView = UIView()
        customizeDropDown(self)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        let searchTextField:UITextField = searchBar.subviews[0].subviews.last as! UITextField
        searchTextField.layer.cornerRadius = 50
        searchTextField.textAlignment = NSTextAlignment.left
        
        //searchTextField.backgroundColor = UIColor.red
        
        let image:UIImage = UIImage(named: "dropDown")!
        let imageView:UIImageView = UIImageView.init(image: image)
        imageView.backgroundColor = UIColor.red
        searchTextField.leftView = nil
        searchTextField.placeholder = "Search Field Text"
        searchTextField.rightView = imageView
        searchTextField.rightViewMode = UITextFieldViewMode.always
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Tableview Methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if sectionNames.count > 0 {
            tableView.backgroundView = nil
            return sectionNames.count
        } else {
            let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: view.bounds.size.height))
            messageLabel.text = "Retrieving data.\nPlease wait."
            messageLabel.numberOfLines = 0;
            messageLabel.textAlignment = .center;
            messageLabel.font = UIFont(name: "HelveticaNeue", size: 20.0)!
            messageLabel.sizeToFit()
            self.tableView.backgroundView = messageLabel;
        }
        return 0
    }
    func customizeDropDown(_ sender: AnyObject) {
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.expandedSectionHeaderNumber == section) {
            let arrayOfItems = self.sectionItems[section] as! NSArray
            return arrayOfItems.count;
        }
        else {
            return 0;
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (self.sectionNames.count != 0) {
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
        //header.contentView.backgroundColor = UIColor.colorWithHexString(hexStr: "#408000")
        //header.textLabel?.textColor = UIColor.black
        
        if let viewWithTag = self.view.viewWithTag(kHeaderSectionTag + section) {
            viewWithTag.removeFromSuperview()
        }
        let headerFrame = self.view.frame.size
        let theImageView = UIImageView(frame: CGRect(x: headerFrame.width - 32, y: 13, width: 15, height: 18));
        theImageView.image = UIImage(named: "dropDown")
        theImageView.tag = kHeaderSectionTag + section
        header.addSubview(theImageView)
        
        // make headers touchable
        header.tag = section
        let headerTapGesture = UITapGestureRecognizer()
        headerTapGesture.addTarget(self, action: #selector(AccountsMenuViewController.sectionHeaderWasTouched(_:)))
        header.addGestureRecognizer(headerTapGesture)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.section == 0) {
            let cell1 = tableView.dequeueReusableCell(withIdentifier: "customCell1", for: indexPath) as! FilterTableViewCell
            cell1.filterLabel.layer.borderColor = UIColor.gray.cgColor
            if(indexPath.row == 0) {
                cell1.titleLabel.text = "Past Due"
            } else {
                cell1.titleLabel.text = "Open Issues"
            }
            return cell1
        } else if(indexPath.section == 1){
            let cell1 = tableView.dequeueReusableCell(withIdentifier: "customCell1", for: indexPath) as! FilterTableViewCell
            cell1.filterLabel.layer.borderColor = UIColor.gray.cgColor
            
            let filterImageView = UIImageView(frame: CGRect(x: 1060, y: 13, width: 15, height: 20))
            filterImageView.image = UIImage(named: "dropDown")
            cell1.filterLabel.addSubview(filterImageView)
            
            if(indexPath.row == 0){
                cell1.titleLabel.text = "Status"
            } else if(indexPath.row == 1){
                cell1.titleLabel.text = "Premise"
            } else if(indexPath.row == 2){
                cell1.titleLabel.text = "Single / Multi Locations"
            } else if(indexPath.row == 3){
                cell1.titleLabel.text = "Channel"
            } else if(indexPath.row == 4){
                cell1.titleLabel.text = "Sub-Channel"
            } else if(indexPath.row == 5){
                cell1.titleLabel.text = "License Type"
            }
            return cell1
        }
        else if(indexPath.section == 2){
            let cell2 = tableView.dequeueReusableCell(withIdentifier: "customCell2", for: indexPath) as! LocationTableViewCell
            cell2.locationLabel.text = "Location"
            cell2.locationField.placeholder = "Zip Code or City"
            return cell2
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //tableView.deselectRow(at: indexPath, animated: true)
        
        let filterIndexPath = tableView.indexPathForSelectedRow
        let currentCell : UITableViewCell?//tableView.cellForRow(at: filterIndexPath!) as! FilterTableViewCell
        
        if indexPath.section == 2{
            
            currentCell = tableView.cellForRow(at: filterIndexPath!) as! LocationTableViewCell
            
            //            dropDownMenu.anchorView = (currentCell as! FilterTableViewCell).filterLabel
            //            dropDownMenu.direction = .bottom
            
        }else{
            currentCell = tableView.cellForRow(at: filterIndexPath!) as! FilterTableViewCell
            
            dropDownMenu.anchorView = (currentCell as! FilterTableViewCell).filterLabel//dropDownImageView
            dropDownMenu.direction = .bottom
            dropDownMenu.multiSelectionAction = { [weak self] (indices, items) in
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
            }
        }
        
        //Get rowID as string from indexpath of section and row
        let rowId = String(indexPath.section) + String(indexPath.row)
        currentCell?.tag = Int(rowId)!
        switch currentCell?.tag {
        case 00?:
            dropDownMenu.dataSource = ["Yes", "No"]
            dropDownMenu.show()
        case 10?:
            dropDownMenu.dataSource = ["Active", "Inactive", "Suspended"]
            dropDownMenu.show()
        case 11?:
            dropDownMenu.dataSource = ["On", "Off"]
            dropDownMenu.show()
        case 12?:
            dropDownMenu.dataSource = ["Single", "Multi"]
            dropDownMenu.show()
        case 15?:
            dropDownMenu.dataSource = ["W", "L", "B", "N"]
            dropDownMenu.show()
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 2{
            return 125
        }
        return 90;
    }
    
    // MARK: - Expand / Collapse Metho@objc ds
    
    @objc func sectionHeaderWasTouched(_ sender: UITapGestureRecognizer) {
        let headerView = sender.view as! UITableViewHeaderFooterView
        let section    = headerView.tag
        let eImageView = headerView.viewWithTag(kHeaderSectionTag + section) as? UIImageView
        
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
    
    func tableViewCollapeSection(_ section: Int, imageView: UIImageView) {
        let sectionData = self.sectionItems[section] as! NSArray
        
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
        }
    }
    
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
}

class FilterTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var filterLabel: UILabel!
    @IBOutlet weak var dropDownImageView : UIImageView!
}

class LocationTableViewCell: UITableViewCell {
    @IBOutlet weak var locationField: UITextField!
    @IBOutlet weak var locationLabel: UILabel!
}



