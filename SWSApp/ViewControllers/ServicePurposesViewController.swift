//
//  ServicePurposesViewController.swift
//  SWSApp
//
//  Created by vipin.vijay on 26/04/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation
import SmartSync

class ServicePurposesViewController: UIViewController {
    
    @IBOutlet weak var collectionView : UICollectionView?
    @IBOutlet weak var textView : UITextView?
    var tableViewRowDetails : NSMutableArray?
    var selectedValuesList = [String]()
    var count = 0
    var planVist:PlanVisit? = PlanVisit(for: "")
    let visitViewModel = VisitSchedulerViewModel()
    var selectedPurposesValuesList = [String]()
    var selectedPurposes = [Int]()
    
    //MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //STATEMACHINE:If you com tho this Screen its in Planned state
        PlanVistManager.sharedInstance.visit?.status = "Scheduled"
        print("ServicePurposesViewController")
        
        let plistPath = Bundle.main.path(forResource: "ServicePurposes", ofType: ".plist", inDirectory: nil)
        let dictionary = NSMutableDictionary(contentsOfFile: plistPath!)
        tableViewRowDetails = dictionary!["New item"] as? NSMutableArray
        
        if !PlistMap.sharedInstance.getPicklist(fieldname: "AccountVisitPurpose").isEmpty {
            self.createPlistForSevicePurpose()
        }
        
        var planArray = PlanVistManager.sharedInstance.sgwsVisitPurpose.components(separatedBy: ";")
        for var i in (0..<readServicePurposePList().count)
        {
            for var j in (0..<planArray.count)
            {
                if ((readServicePurposePList()[i] as! Dictionary<String, String>)["value"] == planArray[j])
                {
                    selectedPurposes.append(i)
                }
            }
        }
        
        for _ in 0...readServicePurposePList().count {
            selectedValuesList.append("false")
        }
        
        for var i in (0..<selectedValuesList.count) {
            for var j in (0..<selectedPurposes.count) {
                if (selectedPurposes[j] == i) {
                    selectedValuesList[i] = "true"
                }
            }
            
        }
        
        print(dictionary!)
    }
    
    // MARK:- Custom Methods
    
    //Read Plist For Service Purposes
    
    func readServicePurposePList() -> NSArray {
        
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let path = documentDirectory.appending("/SevicePurpose.plist")
        let array = NSArray(contentsOfFile: path)
        return array!
        
    }
    
    // Create PList For Service Purposes
    
    func createPlistForSevicePurpose() {
        
        let fileManager = FileManager.default
        
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let path = documentDirectory.appending("/SevicePurpose.plist")
        
        if(!fileManager.fileExists(atPath: path)){
            
            var tempArr = [Dictionary<String, String>]()
            for object in PlistMap.sharedInstance.getPicklist(fieldname: "AccountVisitPurpose") {
                let populatedDictionary = ["label": object.label, "value": object.value]
                tempArr.append(populatedDictionary)
            }
            
            let isWritten = (tempArr as NSArray).write(toFile: path, atomically: true)
            print("is the file created: \(isWritten)")
            
        } else {
            print("file exists")
        }
    }
    
    // MARK:- IBAction
    
    @IBAction func closeVC(sender: UIButton) {
        if selectedValuesList.contains("true") {
            //do something
            let uiAlertController = UIAlertController(// create new instance alert  controller
                title: "Alert",
                message: "Any changes will not be saved. Are you sure you want to close?",
                preferredStyle:.alert)
            
            uiAlertController.addAction(// add Custom action on Event is Cancel
                UIAlertAction.init(title: "Yes", style: .default, handler: { (UIAlertAction) in
                    uiAlertController.dismiss(animated: true, completion: nil)
                     NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshAccountList"), object:nil)
                    self.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
                }))
            uiAlertController.addAction(// add Custom action on Event is Cancel
                UIAlertAction.init(title: "No", style: .default, handler: { (UIAlertAction) in
                    uiAlertController.dismiss(animated: true, completion: nil)
                }))
            self.present(uiAlertController, animated: true, completion: nil)
        } else {
             NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshAccountList"), object:nil)
            self.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func backVC(sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func saveAndClose(sender: UIButton) {
       
        
        if((PlanVistManager.sharedInstance.visit?.Id) != nil){
            
            PlanVistManager.sharedInstance.visit?.status = "Planned"
            
            //Take Purpose List
            let stringRepresentation = selectedPurposesValuesList.joined(separator: ";")
            PlanVistManager.sharedInstance.sgwsVisitPurpose = stringRepresentation
           // PlanVistManager.sharedInstance.sgwsAgendaNotes =
            let status = PlanVistManager.sharedInstance.editAndSaveVisit()
            print(status)
            
        }
        
        self.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}


//MARK:- UICollectionView DataSource
extension ServicePurposesViewController : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return (tableViewRowDetails?.count)! //used to display the TectView in the Last Cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        let tableData = tableViewRowDetails![section] as! NSMutableDictionary
        let headerTxt = (tableData["headerText"] as! String)
        if section == 4 {
            return CGSize(width: self.view.frame.size.width, height: 150);
        } else {
            if headerTxt.isEmpty {
                return CGSize(width: view.frame.width, height: 40)
            }
            return CGSize(width: view.frame.width, height: 90)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if section == 3 {
            return CGSize(width: self.view.frame.size.width, height: 50);
        } else {
            return CGSize(width: 0, height: 0);
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView{
        
        switch kind {
            
        case UICollectionElementKindSectionHeader:
            
            if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "planVisitHeaderCell", for: indexPath) as? UICollectionReusableView {
                
                if indexPath.section == 4 {
                    
                    let label:UILabel = sectionHeader.viewWithTag(200) as! UILabel
                    label.text = "Service Purposes"
                    
                    let subLabel:UILabel = sectionHeader.viewWithTag(201) as! UILabel
                    subLabel.text = "Select all that apply."
                    
                    sectionHeader.backgroundColor = UIColor.clear
                    label.frame.origin.y = 60
                    subLabel.frame.origin.y = 90
                } else {
                    
                    let label:UILabel = sectionHeader.viewWithTag(200) as! UILabel
                    let tableData = tableViewRowDetails![indexPath.section] as! NSMutableDictionary
                    label.text = (tableData["headerText"] as! String)
                    
                    let subLabel:UILabel = sectionHeader.viewWithTag(201) as! UILabel
                    subLabel.text = (tableData["subHeader"] as! String)
                    let headerTxt = (tableData["headerText"] as! String)
                    if headerTxt.isEmpty {subLabel.frame.origin.y = 10 }
                }
                
                return sectionHeader
            }
            
        case UICollectionElementKindSectionFooter:
            
            if let sectionFooter = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "planVisitFooterCell", for: indexPath) as? UICollectionReusableView {
                print("footer");
                
                return sectionFooter
            }
            
        default:
            assert(false, "Unexpected element kind")
        }
        
        return UICollectionReusableView()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        //        return collectionViewRowDetails.count + 1
        
        let tableData = tableViewRowDetails![section] as! NSDictionary
        let tableContent = tableData["answers"] as! NSMutableArray
        if section == 4 {
            if (readServicePurposePList().count != 0) {
                return readServicePurposePList().count + 1
            }
            return 0
        } else {
            return tableContent.count
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell1 : UICollectionViewCell?
        
        if indexPath.section == 4 {
            if indexPath.row == readServicePurposePList().count {
                cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "editAccountStrategyNotesCell", for: indexPath) as! EditAccountStrategyCollectionViewCell
                (cell1 as! EditAccountStrategyCollectionViewCell).bottomView?.layer.borderColor = UIColor.lightGray.cgColor
                
                //PlanVistManager.sharedInstance.sgwsAgendaNotes = ((cell1 as! EditAccountStrategyCollectionViewCell).textView?.text)!
                
            } else {
                cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "editAccountStrategyCell", for: indexPath) as! EditAccountStrategyCollectionViewCell
                (cell1 as! EditAccountStrategyCollectionViewCell).centerLabel?.text = (readServicePurposePList()[indexPath.row] as! Dictionary<String, String>)["value"]
                cell1?.layer.borderWidth = 3.0
                if selectedValuesList[indexPath.row] == "true" {
                    cell1?.layer.borderColor = UIColor(red: 66/255, green: 135/255, blue: 194/255, alpha: 1.0).cgColor
                    (cell1 as! EditAccountStrategyCollectionViewCell).selectedIcon?.isHidden = false
                } else {
                    cell1?.layer.borderColor = UIColor.clear.cgColor
                    (cell1 as! EditAccountStrategyCollectionViewCell).selectedIcon?.isHidden = true
                }
            }
        } else {
            
            cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "planVisitCell", for: indexPath) as! EditAccountStrategyCollectionViewCell
            let label:UILabel = cell1!.viewWithTag(300) as! UILabel
            let tableData = tableViewRowDetails![indexPath.section] as! NSMutableDictionary
            let tableContent = tableData["answers"] as! NSMutableArray
            label.text = " • " + (tableContent[indexPath.row] as! String)
        }
        
        return cell1!
    }
}

//MARK:- UICollectionView Delegate
extension ServicePurposesViewController : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
        if indexPath.section == 4 {
            if indexPath.row == readServicePurposePList().count {
                print("last Cell")
                
            } else {
                
                let cell = collectionView.cellForItem(at: indexPath) as! EditAccountStrategyCollectionViewCell
                cell.layer.borderWidth = 3.0
                if selectedValuesList[indexPath.row] == "true" {
                    cell.layer.borderColor = UIColor.clear.cgColor
                    selectedValuesList[indexPath.row] = "false"
                    selectedPurposesValuesList = selectedPurposesValuesList.filter{$0 != (cell.centerLabel?.text)!}
                    cell.selectedIcon?.isHidden = true
                }
                else {
                    cell.layer.borderColor = UIColor(red: 66/255, green: 135/255, blue: 194/255, alpha: 1.0).cgColor
                    selectedPurposesValuesList.append((cell.centerLabel?.text)!)
                    selectedValuesList[indexPath.row] = "true"
                    cell.selectedIcon?.isHidden = false
                }
            }

        }
    }
}

//MARK:- UICollectionView DelegateFlowLayout
extension ServicePurposesViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 4 {
            //            let tableData = tableViewRowDetails![indexPath.section] as! NSDictionary
            //            let tableContent = tableData["answers"] as! NSMutableArray
            if indexPath.row == readServicePurposePList().count {
                return CGSize(width: self.view.frame.size.width, height: 319);
            } else {
                return CGSize(width: self.view.frame.size.width/1.03, height: 75);
            }
        } else {
            return CGSize(width: self.view.frame.size.width/1.0, height: 35);
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if section == 4 {
            return 10.0
        } else {
            return 0.0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if section == 4 {
            return 10.0
        } else {
            return 0.0
        }
    }
    
}
