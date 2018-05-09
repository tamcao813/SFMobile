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
    
    var visitObject : Visit?
    var accountObject: Account?
    var collectionViewRowDetails : NSMutableArray?
    
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewRowDetails = NSMutableArray()
        fetchAccountDetails()
        //let plistPath = Bundle.main.path(forResource: "DuringVisitTopics", ofType: ".plist", inDirectory: nil)
        //let dictionary = NSMutableDictionary(contentsOfFile: plistPath!)
        //collectionViewRowDetails = dictionary!["New item"] as? NSMutableArray
        
        //print(dictionary!)
    }
    
    func fetchAccountDetails(){
        if let accountId = visitObject?.accountId {
            let accountsArray = AccountsViewModel().accountsForLoggedUser
            for account in accountsArray{
                if account.account_Id == accountId {
                    accountObject = account
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let mainArray = NSMutableArray()
        
        let addressDict = NSMutableDictionary()
        addressDict.setValue(accountObject?.accountName, forKey: "storeName")
        addressDict.setValue(accountObject?.accountNumber, forKey: "accountNumber")
        //addressDict.setValue("", forKey: "headerText")
        
        var fullAddress = ""
        if let shippingStreet = accountObject?.shippingStreet, let shippingCity = accountObject?.shippingCity , let shippingState = accountObject?.shippingState, let shippingPostalCode = accountObject?.shippingPostalCode{
            // latitudeDouble and longitudeDouble are non-optional in here
            if shippingStreet == "" && shippingCity == "" && shippingState == "" && shippingPostalCode == "" {
                fullAddress = "\(shippingStreet) \(shippingCity) \(shippingState) \(shippingPostalCode)"
            }else{
                if (shippingStreet != "" || shippingCity != "") {
                    if (shippingState != "" || shippingPostalCode != "") {
                        fullAddress = "\(shippingStreet) \(shippingCity), \(shippingState) \(shippingPostalCode)"
                    }else{
                        fullAddress = "\(shippingStreet) \(shippingCity) \(shippingState) \(shippingPostalCode)"
                    }
                }else{
                    fullAddress = "\(shippingStreet) \(shippingCity) \(shippingState) \(shippingPostalCode)"
                }
            }
        }
        addressDict.setValue(fullAddress, forKey: "storeAddress")
        mainArray.add(addressDict)
        
//        addressLabel?.text = fullAddress
        
//        if let address = accountObject.accountBillingAddress {
//
//            if address != ""{
//                let data = self.convertToDictionary(text: address)
//
//                let street = data!["street"] as? String ?? ""
//    //            guard let street = data!["street"] as? String else{
//    //                return
//    //            }
//                let city = data!["city"] as? String ?? ""
//    //            guard let city = data!["city"] as? String else{
//    //                return
//    //            }
//                let postalCode = data!["postalCode"] as? String ?? ""
//    //            guard let postalCode = data!["postalCode"] as? String else {
//    //                return
//    //            }
//                let addressString = street + " " + city + " " + postalCode
//
//
//            }
//        }

        let visitNotes = visitObject?.description
        let displayDataDict = NSMutableDictionary()
        displayDataDict.setValue("Visit Notes", forKey: "headerText")
        displayDataDict.setValue(visitNotes, forKey: "notesText")
        mainArray.add(displayDataDict)
        
        let agendaNotes = visitObject?.sgwsAgendaNotes
        let agentDict = NSMutableDictionary()
        agentDict.setValue("Agenda Notes", forKey: "headerText")
        agentDict.setValue("", forKey: "subHeader")
        let agentArray = NSMutableArray()
        let agentAnswerDict = NSMutableDictionary()
        agentAnswerDict.setValue(agendaNotes, forKey: "answerText")
        agentArray.add(agentAnswerDict)
        agentDict.setValue(agentArray, forKey: "answers")
        mainArray.add(agentDict)
        
        collectionViewRowDetails = mainArray
        print(mainArray)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        
    }
    
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
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
        
        let cellData = collectionViewRowDetails![indexPath.section] as! NSDictionary
        
        if indexPath.section == 0{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "duringVisitCell1", for: indexPath) as! DuringVisitsTopicsCollectionViewCell
            (cell as! DuringVisitsTopicsCollectionViewCell).displayAddressCellData(data: cellData)
            
        }else if indexPath.section == 1{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "duringVisitCell2", for: indexPath) as! DuringVisitsTopicsCollectionViewCell
            (cell as! DuringVisitsTopicsCollectionViewCell).displayNotesCellData(data: cellData)
            
        }else if indexPath.section >= 2{
            
            let tableData = collectionViewRowDetails![indexPath.section] as! NSMutableDictionary
            let tableContent = tableData["answers"] as! NSMutableArray
            let answers = tableContent[indexPath.row] as! NSMutableDictionary
            
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "duringVisitCell3", for: indexPath) as! DuringVisitsTopicsCollectionViewCell
            
            (cell as! DuringVisitsTopicsCollectionViewCell).displayCellData(data: answers , indexPath : indexPath)
        }
        
        return cell!
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        FilterMenuModel.comingFromDetailsScreen = "YES"
        //FilterMenuModel.selectedAccountId = <Populate the account id>
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showAllAccounts"), object:nil)
        
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





