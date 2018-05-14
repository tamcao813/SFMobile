//
//  DuringVisitsInsightsViewController.swift
//  SWSApp
//
//  Created by r.a.jantakal on 27/04/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation
import UIKit


class DuringVisitsInsightsViewController : UIViewController{
    
    @IBOutlet weak var collectionView : UICollectionView?
    
    var collectionViewRowDetails : NSMutableArray?
    
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let plistPath = Bundle.main.path(forResource: "Insights", ofType: ".plist", inDirectory: nil)
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
    
}


//MARK:- UICollectionView DataSource
extension DuringVisitsInsightsViewController : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return (collectionViewRowDetails?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let tableData = collectionViewRowDetails![section] as! NSDictionary
        let tableContent = tableData["answers"] as! NSMutableArray
        return tableContent.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView{
        
        if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "duringVisitInsightsHeaderCell", for: indexPath) as? DuringVisitsInsightsCollectionReusableView{
            
            sectionHeader.displayHeaderViewData(data: collectionViewRowDetails!, indexPath: indexPath)
            return sectionHeader
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let tableData = collectionViewRowDetails![indexPath.section] as! NSMutableDictionary
        let tableContent = tableData["answers"] as! NSMutableArray
        let answers = tableContent[indexPath.row] as! NSMutableDictionary
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "duringVisitInsightsCell", for: indexPath) as! DuringVisitsInsightsCollectionViewCell
        cell.displayCellData(data: answers , indexPath : indexPath)
        
        return cell
    }
}

//MARK:- UICollectionView Delegate
extension DuringVisitsInsightsViewController : UICollectionViewDelegateFlowLayout{
    
    //Used for Collection view Cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.size.width, height: 100)
    }
    
    //Used to set width and height of HeaderView
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: collectionView.frame.size.width  , height: 125)
    }
}





