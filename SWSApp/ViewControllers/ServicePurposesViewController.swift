//
//  ServicePurposesViewController.swift
//  SWSApp
//
//  Created by vipin.vijay on 26/04/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation

class ServicePurposesViewController: UIViewController {
    
    var tableViewRowDetails = ["Price Change"," License and Credit Status Issue"," In-Store Promotion","Payment Pick-up","Order and Delivery Issue"," Pick-up/Return","Policy Change"," A/R, Credit Management","Point of Sale","Store/Display Setup","Sample and Tasting","Sample and Tasting","Sample and Tasting","Sample and Tasting","Sample and Tasting"]
    @IBOutlet weak var collectionView : UICollectionView?
    
    //MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ServicePurposesViewController")
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
        return 1 //used to display the TectView in the Last Cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return tableViewRowDetails.count + 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell1 : UICollectionViewCell?
        
        if indexPath.row == tableViewRowDetails.count {
            cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "editAccountStrategyNotesCell", for: indexPath) as! EditAccountStrategyCollectionViewCell
            (cell1 as! EditAccountStrategyCollectionViewCell).bottomView?.layer.borderColor = UIColor.lightGray.cgColor
        }else{
            
            cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "editAccountStrategyCell", for: indexPath) as! EditAccountStrategyCollectionViewCell
            (cell1 as! EditAccountStrategyCollectionViewCell).centerLabel?.text = tableViewRowDetails[indexPath.row]

        }
        return cell1!
    }
}

//MARK:- UICollectionView Delegate
extension ServicePurposesViewController : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
        
        let cell = collectionView.cellForItem(at: indexPath)
        if cell?.isSelected == true {
            cell?.layer.borderWidth = 3.0
            cell?.layer.borderColor = UIColor(red: 66/255, green: 135/255, blue: 194/255, alpha: 1.0).cgColor
        }
        else {
            cell?.layer.borderWidth = 3.0
            cell?.layer.borderColor = UIColor.clear.cgColor
        }
    }
}

//MARK:- UICollectionView DelegateFlowLayout
extension ServicePurposesViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == tableViewRowDetails.count {
            return CGSize(width: self.view.frame.size.width/1.0, height: 319);
        } else {
            return CGSize(width: self.view.frame.size.width/1.1, height: 75);
        }
    }
}

