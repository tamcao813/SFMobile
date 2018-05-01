//
//  AccountStrategyViewController.swift
//  SWSApp
//
//  Created by r.a.jantakal on 23/04/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation
import UIKit
//import IQKeyboardManagerSwift

class EditAccountStrategyViewController: UIViewController {
    
    var tableViewRowDetails : NSMutableArray?
    
    @IBOutlet weak var collectionView : UICollectionView?
    
    var textViewWidth = 0.0
    var collectionViewWidth = 0.0
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        IQKeyboardManager.sharedManager().enable = true
        
        if self.view.frame.size.width == 1112.0{
            textViewWidth = 1105
            collectionViewWidth = 525
        }else if self.view.frame.size.width == 1024.0{
            textViewWidth = 1015
            collectionViewWidth = 480
        }else if self.view.frame.size.width == 1366.0{
            textViewWidth = 1360
            collectionViewWidth = 650
        }
        
        let plistPath = Bundle.main.path(forResource: "EditAccountStrategy", ofType: ".plist", inDirectory: nil)
        let dictionary = NSMutableDictionary(contentsOfFile: plistPath!)
        tableViewRowDetails = dictionary!["New item"] as? NSMutableArray
        
        print(dictionary!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- Button Actions
    @IBAction func saveButtonAction(sender : UIButton){
        print("Save button Clicked")
        
        
    }
    
    @IBAction func cancelButtonAction(sender : UIButton){
        print("Cancel button Clicked")
        
        
    }
    
    @IBAction func closeButtonAction(sender : UIButton){
        print("Close button Clicked")
        
        self.dismiss(animated: true, completion: nil)
        
    }
}


//MARK:- UICollectionView DataSource
extension EditAccountStrategyViewController : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return (tableViewRowDetails?.count)! + 1 //used to display the TectView in the Last Cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView{
        
        if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "editAccountStrategyHeaderCell", for: indexPath) as? EditAccountStrategyCollectionReusableView{
            
            if  indexPath.section < (tableViewRowDetails?.count)! {
                sectionHeader.displayHeaderViewData(data: tableViewRowDetails!, indexPath: indexPath)
                return sectionHeader
            }
            sectionHeader.isHidden = true
            return sectionHeader
        }
        
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section < (tableViewRowDetails?.count)!{
            let tableData = tableViewRowDetails![section] as! NSDictionary
            let tableContent = tableData["answers"] as! NSMutableArray
            return tableContent.count
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell1 : UICollectionViewCell?
        
        if indexPath.section == tableViewRowDetails?.count{
            cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "editAccountStrategyNotesCell", for: indexPath) as! EditAccountStrategyCollectionViewCell
            (cell1 as! EditAccountStrategyCollectionViewCell).bottomView?.layer.borderColor = UIColor.lightGray.cgColor
        }else{
            let tableData = tableViewRowDetails![indexPath.section] as! NSMutableDictionary
            let tableContent = tableData["answers"] as! NSMutableArray
            let questions = tableContent[indexPath.row] as! NSMutableDictionary
            
            cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "editAccountStrategyCell", for: indexPath) as! EditAccountStrategyCollectionViewCell
            (cell1 as! EditAccountStrategyCollectionViewCell).displayCellData(data: questions)
        }
        return cell1!
    }
}

//MARK:- UICollectionView Delegate
extension EditAccountStrategyViewController : UICollectionViewDelegate , UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
        
        if indexPath.section < (tableViewRowDetails?.count)!{
            
            let tableData = tableViewRowDetails![indexPath.section] as! NSMutableDictionary
            let tableContent = tableData["answers"] as! NSMutableArray
            
            let questions = tableContent[indexPath.row] as! NSMutableDictionary
            
            //Used for Single selection = 1 or Multiselection = 2
            if (tableData["selectionType"] as! String) == "1"{
                for setData in tableContent{
                    let data = setData as! NSMutableDictionary
                    data.setValue("NO", forKey: "isSelected")
                }
                questions.setValue("YES", forKey: "isSelected")
            }else{
                if (questions["isSelected"] as! String) == "NO"{
                    questions.setValue("YES", forKey: "isSelected")
                }else{
                    questions.setValue("NO", forKey: "isSelected")
                }
            }
            collectionView.reloadData()
        }
    }
    
    //Used for Collection view Cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == tableViewRowDetails?.count{
            return CGSize(width: textViewWidth, height: 410)
        }
        return CGSize(width: collectionViewWidth, height: 70)
    }
    
    //Used to set width and height of HeaderView
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == tableViewRowDetails?.count{
            return CGSize(width: 0.0  , height: 30.0)
        }
        return CGSize(width: 50.0, height: 110)
    }
}


