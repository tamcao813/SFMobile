//
//  DuringVisitsTopics.swift
//  SWSApp
//
//  Created by r.a.jantakal on 26/04/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation
import UIKit

protocol NavigateToVisitSummaryScreenDelegate {
    func navigateToVisitSummaryScreen()
}

class  DuringVisitsTopicsViewController : UIViewController {
    
    @IBOutlet weak var collectionView : UICollectionView?
    
    var visitObject : WorkOrderUserObject?
    var accountObject: Account?
    var collectionViewRowDetails : NSMutableArray?
    var delegate : NavigateToVisitSummaryScreenDelegate?
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewRowDetails = NSMutableArray()
        fetchAccountDetails()
       
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
        
        let visitNotes = visitObject?.description
        let displayDataDict = NSMutableDictionary()
        displayDataDict.setValue("Visit Notes", forKey: "headerText")
        displayDataDict.setValue(visitNotes, forKey: "notesText")
        mainArray.add(displayDataDict)
        
        //let strategyDictionary = NSMutableDictionary()
        //strategyDictionary.setValue("Account Strategy", forKey: "headerText")
        //strategyDictionary.setValue("Load the Account Strategy", forKey: "subHeader")
        //mainArray.add(strategyDictionary)
        
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

    //Fetch the from Accounts View Model
    func fetchAccountDetails(){
        if let accountId = visitObject?.accountId {
            let accountsArray = GlobalWorkOrderArray.accountArray
            for account in accountsArray{
                if account.account_Id == accountId {
                    accountObject = account
                }
            }
        }
    }
    
    //Covert the String to Dictionart
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
            
        }
        
//        else if indexPath.section == 2{
//            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "duringVisitCell", for: indexPath) as! DuringVisitsTopicsCollectionViewCell
//            (cell as! DuringVisitsTopicsCollectionViewCell).delegate = self
//
//        }
        
        else if indexPath.section >= 2{
            
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
        FilterMenuModel.selectedAccountId = (accountObject?.account_Id)!
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showAllAccounts"), object:nil)
        if indexPath.section == 0{
            DispatchQueue.main.async {
                AlertUtilities.showAlertMessageWithTwoActionsAndHandler("Any changes will not be saved", errorMessage: "Are you sure you want to close?", errorAlertActionTitle: "Yes", errorAlertActionTitle2: "No", viewControllerUsed: self, action1: {
                    FilterMenuModel.selectedAccountId = (self.accountObject?.account_Id)!
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "navigateToAccountScreen"), object:nil)
                    self.dismiss(animated: false, completion: nil)
                }){

                }
            }
        }
    }
}

//MARK:- UICollectionView Delegate
extension DuringVisitsTopicsViewController : UICollectionViewDelegateFlowLayout{
    
    //Used for Collection view Cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1{
            return CGSize(width: collectionView.frame.size.width, height: 250)
            
        }else if indexPath.section >= 2{//used to change the height of cell Dynamically
            let tableData = collectionViewRowDetails![indexPath.section] as! NSMutableDictionary
            let tableContent = tableData["answers"] as! NSMutableArray
            let questions = tableContent[indexPath.row] as! NSMutableDictionary
            let data = (questions["answerText"] as! String)
            
            let approximateWidthOfContent = view.frame.width
            // x is the width of the logo in the left
            let size = CGSize(width: approximateWidthOfContent, height: CGFloat.greatestFiniteMagnitude)
            //1000 is the large arbitrary values which should be taken in case of very high amount of content
            let attributes = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16.0)]
            let estimatedFrame = NSString(string: data).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
            return CGSize(width: (self.collectionView?.frame.size.width)!, height: estimatedFrame.height)
        }
        return CGSize(width: collectionView.frame.size.width, height: 100)
    }
    
    //Used to set width and height of HeaderView
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        //Used to display header for last cell only
        if section >= 2{
            return CGSize(width: collectionView.frame.size.width  , height: 50)
        }
        return CGSize(width: 0.0, height: 0.0)
    }
}

//MARK:- NavigateToStrategyFromDuringVisits Delegate
extension DuringVisitsTopicsViewController : NavigateToStrategyFromDuringVisitsDelegate{
    
    func navigateToStrategyScreen() {
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Strategy", bundle: nil)
        let vc: AccountStrategyViewController = storyboard.instantiateViewController(withIdentifier: "AccountStrategyViewControllerID") as! AccountStrategyViewController
        StrategyScreenLoadFrom.isLoadFromStrategy = "1"
        
        AccountId.selectedAccountId = (accountObject?.account_Id)!
        
        (vc as AccountStrategyViewController).modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.present(vc, animated: true, completion: nil)
        
    }
}






