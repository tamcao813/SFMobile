//
//  ServicePurposesViewController.swift
//  SWSApp
//
//  Created by vipin.vijay on 26/04/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation

class ServicePurposesViewController: UIViewController {
    
    var collectionViewRowDetails = [["Price Change","false"],[" License and Credit Status Issue","false"],[" In-Store Promotion","false"],["Payment Pick-up","false"],["Order and Delivery Issue","false"],[" Pick-up/Return","Policy Change","false"],[" A/R, Credit Management","false"],["Point of Sale","false"],["Store/Display Setup","false"],["Sample and Tasting","false"],["Sample and Tasting","false"],["Sample and Tasting","false"],["Sample and Tasting","false"],["Sample and Tasting","false"]]
    
    @IBOutlet weak var collectionView : UICollectionView?
    var tableViewRowDetails : NSMutableArray?
    var count = 0
    
    //MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ServicePurposesViewController")
        
        let plistPath = Bundle.main.path(forResource: "ServicePurposes", ofType: ".plist", inDirectory: nil)
        let dictionary = NSMutableDictionary(contentsOfFile: plistPath!)
        tableViewRowDetails = dictionary!["New item"] as? NSMutableArray
        
        print(dictionary!)
    }
    
    // MARK:- IBAction
    
    @IBAction func backVC(sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func saveAndClose(sender: UIButton) {
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
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView{
        
        if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "planVisitHeaderCell", for: indexPath) as? UICollectionReusableView{
            
            let label:UILabel = sectionHeader.viewWithTag(200) as! UILabel
            let tableData = tableViewRowDetails![indexPath.section] as! NSMutableDictionary
            label.text = (tableData["headerText"] as! String)
            
            let subLabel:UILabel = sectionHeader.viewWithTag(201) as! UILabel
            subLabel.text = (tableData["subHeader"] as! String)
            let headerTxt = (tableData["headerText"] as! String)
            if headerTxt.isEmpty {subLabel.frame.origin.y = 10 }
            
            if indexPath.section == 4 {
                sectionHeader.backgroundColor = UIColor.clear
                label.frame.origin.y = 60
                subLabel.frame.origin.y = 90
            }
            
            return sectionHeader
        }
        
        return UICollectionReusableView()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

//        return collectionViewRowDetails.count + 1
        
        let tableData = tableViewRowDetails![section] as! NSDictionary
        let tableContent = tableData["answers"] as! NSMutableArray
        if section == 4 {
            return tableContent.count + 1
        } else {
            return tableContent.count
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell1 : UICollectionViewCell?
        
        print("section", indexPath.section)
        
        if indexPath.section == 4 {
            let tableData = tableViewRowDetails![indexPath.section] as! NSDictionary
            let tableContent = tableData["answers"] as! NSMutableArray
            if indexPath.row == tableContent.count {
                cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "editAccountStrategyNotesCell", for: indexPath) as! EditAccountStrategyCollectionViewCell
                (cell1 as! EditAccountStrategyCollectionViewCell).bottomView?.layer.borderColor = UIColor.lightGray.cgColor
            } else {
                cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "editAccountStrategyCell", for: indexPath) as! EditAccountStrategyCollectionViewCell
                (cell1 as! EditAccountStrategyCollectionViewCell).centerLabel?.text = collectionViewRowDetails[indexPath.row][0]
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
        if indexPath.row != collectionViewRowDetails.count {
            let cell = collectionView.cellForItem(at: indexPath) as! EditAccountStrategyCollectionViewCell
            cell.layer.borderWidth = 3.0
            if collectionViewRowDetails[indexPath.row][1] == "true" {
                cell.layer.borderColor = UIColor.clear.cgColor
                collectionViewRowDetails[indexPath.row][1] = "false"
                cell.selectedIcon?.isHidden = true
            }
            else {
                cell.layer.borderColor = UIColor(red: 66/255, green: 135/255, blue: 194/255, alpha: 1.0).cgColor
                collectionViewRowDetails[indexPath.row][1] = "true"
                cell.selectedIcon?.isHidden = false
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
            let tableData = tableViewRowDetails![indexPath.section] as! NSDictionary
            let tableContent = tableData["answers"] as! NSMutableArray
            if indexPath.row == tableContent.count {
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

