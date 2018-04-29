//
//  DuringVisitsTopics.swift
//  SWSApp
//
//  Created by r.a.jantakal on 26/04/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation
import UIKit

class  DuringVisitsTopicsViewController : UIViewController {
    
    @IBOutlet weak var collectionView : UICollectionView?
    
    var collectionViewRowDetails : NSMutableArray?
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let plistPath = Bundle.main.path(forResource: "DuringVisitTopics", ofType: ".plist", inDirectory: nil)
        let dictionary = NSMutableDictionary(contentsOfFile: plistPath!)
        collectionViewRowDetails = dictionary!["New item"] as? NSMutableArray
        
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
    
    //MARK:-
    
    
    
    
    
    //MARK:- IBActions
}



//MARK:- UICollectionView DataSource
extension DuringVisitsTopicsViewController : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return (collectionViewRowDetails?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        //used to many cells under Account Strategy and Buying Motives
        if section >= 2{
            let tableData = collectionViewRowDetails![section] as! NSDictionary
            let tableContent = tableData["answers"] as! NSMutableArray
            return tableContent.count
        }
        return 1 //used to load only 1 cell for Address, Notes, Agenda
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView{
        
        if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "duringVisitHeaderCell", for: indexPath) as? DuringVisitsTopicsCollectionReusableView{
            
            sectionHeader.isHidden = true
            
            if indexPath.section >= 2{
                sectionHeader.isHidden = false
                sectionHeader.displayHeaderViewData(data: collectionViewRowDetails!, indexPath: indexPath)
            }
            
            return sectionHeader
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell : UICollectionViewCell?
        
        if indexPath.section == 0{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "duringVisitCell1", for: indexPath) as! DuringVisitsTopicsCollectionViewCell
            
            
        }else if indexPath.section == 1{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "duringVisitCell2", for: indexPath) as! DuringVisitsTopicsCollectionViewCell
            
            
        }else if indexPath.section >= 2{
            
            let tableData = collectionViewRowDetails![indexPath.section] as! NSMutableDictionary
            let tableContent = tableData["answers"] as! NSMutableArray
            let answers = tableContent[indexPath.row] as! NSMutableDictionary
            
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "duringVisitCell3", for: indexPath) as! DuringVisitsTopicsCollectionViewCell
            
            (cell as! DuringVisitsTopicsCollectionViewCell).displayCellData(data: answers , indexPath : indexPath)
        }
        
        return cell!
    }
}


//MARK:- UICollectionView Delegate
extension DuringVisitsTopicsViewController : UICollectionViewDelegateFlowLayout{
    
    //Used for Collection view Cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1{
            return CGSize(width: collectionView.frame.size.width, height: 360)
            
        }else if indexPath.section == 2{//used to change the height of cell Dynamically
            
            let tableData = collectionViewRowDetails![indexPath.section] as! NSMutableDictionary
            let tableContent = tableData["answers"] as! NSMutableArray
            let questions = tableContent[indexPath.row] as! NSMutableDictionary
            
            let data = (questions["answerText"] as! String)
            
            let attString = NSAttributedString(string: data, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15.0)])
            let dynamicSize: CGRect = attString.boundingRect(with: CGSize(width: self.collectionView!.bounds.size.width, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, context: nil)
            
            return dynamicSize.size
            
        } else if indexPath.section >= 3{
            return CGSize(width: collectionView.frame.size.width, height: 20)
        }
        return CGSize(width: collectionView.frame.size.width, height: 120)
    }
    
    //Used to set width and height of HeaderView
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        //Used to display header for last cell only
        if section >= 2{
            return CGSize(width: collectionView.frame.size.width  , height: 80)
        }
        return CGSize(width: 0.0, height: 0.0)
    }
    
}





