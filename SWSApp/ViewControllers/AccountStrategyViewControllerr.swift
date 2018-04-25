//
//  AccountStrategyViewControllerr.swift
//  SWSApp
//
//  Created by r.a.jantakal on 23/04/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation
import UIKit

class AccountStrategyViewController : UIViewController{
    
    var tableViewRowDetails : NSMutableArray?
    
    @IBOutlet weak var collectionView : UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Account Strategy Screen Loaded")
        
        let plistPath = Bundle.main.path(forResource: "AccountStrategy", ofType: ".plist", inDirectory: nil)
        let dictionary = NSMutableDictionary(contentsOfFile: plistPath!)
        tableViewRowDetails = dictionary!["New item"] as? NSMutableArray
        
        print(dictionary!)
        
        
//        if let flowLayout: UICollectionViewFlowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout{
//            flowLayout.estimatedItemSize = CGSize(width: 1, height: 100)
//
//        }
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
    
    @IBAction func editButtonClicked(sender : UIButton){
        
        
    }
}

//MARK:- UICollectionView DataSource
extension AccountStrategyViewController : UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return (tableViewRowDetails?.count)!
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let tableData = tableViewRowDetails![section] as! NSDictionary
        let tableContent = tableData["answers"] as! NSMutableArray
        return tableContent.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView{
        
        if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "accountStrategyHeaderCell", for: indexPath) as? AccountStrategyCollectionReusableView{
            sectionHeader.displayHeaderViewData(data: tableViewRowDetails!, indexPath: indexPath)
            return sectionHeader
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == (tableViewRowDetails?.count)! - 1 {
            
            let tableData = tableViewRowDetails![indexPath.section] as! NSMutableDictionary
            let tableContent = tableData["answers"] as! NSMutableArray
            let questions = tableContent[indexPath.row] as! NSMutableDictionary
            
            //let constraintRect = CGSize(width: self.view.frame.size.width, height: CGFloat.greatestFiniteMagnitude)
            let data = (questions["answerText"] as! String)
            
            let attString = NSAttributedString(string: data, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 20.0)])
            let dynamicSize: CGRect = attString.boundingRect(with: CGSize(width: self.collectionView!.bounds.size.width, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, context: nil)
            
            return dynamicSize.size
        }

        return CGSize(width: (self.collectionView?.frame.size.width)!, height: 30)
        
        //let bounds = data
        //let boundingBox = data.boundingRectWithSize(constraintRect, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont(name: Constants.strings.fontName, size: 30)!], context: nil)
        //return CGSizeMake(boundingBox.width, boundingBox.height); //(width,hight)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let tableData = tableViewRowDetails![indexPath.section] as! NSMutableDictionary
        let tableContent = tableData["answers"] as! NSMutableArray
        let questions = tableContent[indexPath.row] as! NSMutableDictionary
        
        let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "accountStrategyCell", for: indexPath) as! AccountStrategyCollectionViewCell
         //cell1.contentView.systemLayoutSizeFitting(UILayoutFittingExpandedSize)
        cell1.displayCellData(data: questions , indexPath: indexPath)
        //cell1.contentView.systemLayoutSizeFitting(UILayoutFittingExpandedSize)

        return cell1
        
    }
}


