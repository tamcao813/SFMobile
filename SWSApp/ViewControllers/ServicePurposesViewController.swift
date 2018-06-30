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
    @IBOutlet weak var seperatorLabel: UILabel!
    @IBOutlet weak var bottomView: UIView!
    
    var tableViewRowDetails : NSMutableArray?
    var selectedValuesList = [String]()
    var count = 0
    var planVist:PlanVisit? = PlanVisit(for: "")
    let visitViewModel = VisitSchedulerViewModel()
    var selectedPurposesValuesList = [String]()
    var selectedPurposes = [Int]()
    var plistDict:[String:String] = ["Login":StringConstants.accountVisitPurposePlist]

    
    var accountObject: Account?
    
    //MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //STATEMACHINE:If you com tho this Screen its in Planned state
        PlanVisitManager.sharedInstance.visit?.status = "Scheduled"
        print("ServicePurposesViewController")
        topShadow(seperatorView: seperatorLabel)
        
        if !(PlanVisitManager.sharedInstance.visit?.sgwsVisitPurpose.isEmpty)! {
            selectedPurposesValuesList = (PlanVisitManager.sharedInstance.visit?.sgwsVisitPurpose.components(separatedBy: ";"))!
        }
        
        var planArray = PlanVisitManager.sharedInstance.visit?.sgwsVisitPurpose.components(separatedBy: ";")
        
        if(PlistMap.sharedInstance.readPList(plist: plistDict["Login"]!) != nil){
        for i in (0..<PlistMap.sharedInstance.readPList(plist: plistDict["Login"]!).count)
        {
            for j in (0..<planArray!.count)
            {
                if ((PlistMap.sharedInstance.readPList(plist: plistDict["Login"]!)[i] as! Dictionary<String, Any>)["value"] as? String == planArray![j])
                {
                    selectedPurposes.append(i)
                }
            }
        }
        }
        for _ in 0...PlistMap.sharedInstance.readPList(plist: plistDict["Login"]!).count {
            selectedValuesList.append("false")
        }
        
        for i in (0..<selectedValuesList.count) {
            for j in (0..<selectedPurposes.count) {
                if (selectedPurposes[j] == i) {
                    selectedValuesList[i] = "true"
                }
            }
            
        }
        
        StrategyNotes.isStrategyText = "NO"
        
        //Used to get the Account id of the user
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)

    }
    
    // MARK:- Custom Function
    
    func topShadow(seperatorView:UIView) {
        
        let shadowSize : CGFloat = 5.0
        let shadowPath = UIBezierPath(rect: CGRect(x: -shadowSize / 2,
                                                   y: -shadowSize / 2,
                                                   width: seperatorView.frame.size.width + shadowSize,
                                                   height: seperatorView.frame.size.height + shadowSize))
        seperatorView.layer.masksToBounds = false
        seperatorView.layer.shadowColor = UIColor.darkGray.cgColor
        seperatorView.layer.shadowOffset = CGSize(width: 0.0, height: -5.0)
        seperatorView.layer.shadowOpacity = 0.1
        seperatorView.layer.shadowPath = shadowPath.cgPath
    }
    

    // MARK:- IBAction
    
    @IBAction func closeVC(sender: UIButton) {
        
        if((PlanVisitManager.sharedInstance.visit?.Id) != nil){
            
            PlanVisitManager.sharedInstance.visit?.status = "Planned"
        }
        
        if selectedValuesList.contains("true") {
            //do something
            let uiAlertController = UIAlertController(// create new instance alert  controller
                title: "Alert",
                message: "Any changes will not be saved. Are you sure you want to close?",
                preferredStyle:.alert)
            
            uiAlertController.addAction(// add Custom action on Event is Cancel
                UIAlertAction.init(title: "Yes", style: .default, handler: { (UIAlertAction) in
                    uiAlertController.dismiss(animated: true, completion: nil)
                   DispatchQueue.main.async {
                    self.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
                    }
                }))
            uiAlertController.addAction(// add Custom action on Event is Cancel
                UIAlertAction.init(title: "No", style: .default, handler: { (UIAlertAction) in
                    DispatchQueue.main.async {
                        uiAlertController.dismiss(animated: true, completion: nil)
                    }
                }))
            self.present(uiAlertController, animated: true, completion: nil)
        } else {
           DispatchQueue.main.async {            self.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
            }
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshAccountVisitList"), object:nil)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshVisitEventList"), object:nil)
    }
    
    @IBAction func backVC(sender: UIButton) {
        DispatchQueue.main.async {
            self.dismiss(animated: true)
        }
    }
    
    @IBAction func saveAndClose(sender: UIButton) {
       
        VisitModelForUIAPI.isEditMode = true
        
        if((PlanVisitManager.sharedInstance.visit?.Id) != nil){
            
            PlanVisitManager.sharedInstance.visit?.status = "Planned"
            
            //Take Purpose List
            let stringRepresentation = selectedPurposesValuesList.joined(separator: ";")
            PlanVisitManager.sharedInstance.visit?.sgwsVisitPurpose = stringRepresentation
           // PlanVisitManager.sharedInstance.sgwsAgendaNotes =
            let status = PlanVisitManager.sharedInstance.editAndSaveVisit()
            if let row = GlobalWorkOrderArray.workOrderArray.index(where: {$0.Id == PlanVisitManager.sharedInstance.visit?.Id}) {
                GlobalWorkOrderArray.workOrderArray[row] = PlanVisitManager.sharedInstance.visit!
            }
            print(status)
        }
        
        DispatchQueue.main.async{
            self.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
            
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshAccountVisitList"), object:nil)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshVisitEventList"), object:nil)
    }
    
    
    @IBAction func loadStrategyScreen(sender : UIButton){
        
        let accountId = PlanVisitManager.sharedInstance.visit?.accountId
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Strategy", bundle: nil)
        let vc: AccountStrategyViewController = storyboard.instantiateViewController(withIdentifier: "AccountStrategyViewControllerID") as! AccountStrategyViewController
        StrategyScreenLoadFrom.isLoadFromStrategy = "1"
        
        AccountId.selectedAccountId = accountId!
        
        (vc as AccountStrategyViewController).modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        DispatchQueue.main.async{
            self.present(vc, animated: true, completion: nil)
        }
        
    }
    
}


//MARK:- UICollectionView DataSource
extension ServicePurposesViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {

            return CGSize(width: self.view.frame.size.width, height: 150);

    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView{

        switch kind {

        case UICollectionElementKindSectionHeader:

            if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "planVisitHeaderCell", for: indexPath) as? UICollectionReusableView {

                    let label:UILabel = sectionHeader.viewWithTag(200) as! UILabel
                    label.text = "Service Purposes"

                    let subLabel:UILabel = sectionHeader.viewWithTag(201) as! UILabel
                    subLabel.text = "Select all that apply."

                    sectionHeader.backgroundColor = UIColor.clear
                    label.frame.origin.y = 60
                    subLabel.frame.origin.y = 90

                return sectionHeader
            }

        default:
            assert(false, "Unexpected element kind")
        }

        return UICollectionReusableView()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return PlistMap.sharedInstance.readPList(plist: plistDict["Login"]!).count + 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell1 : UICollectionViewCell?
        
            if indexPath.row == PlistMap.sharedInstance.readPList(plist: plistDict["Login"]!).count {
                cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "editAccountStrategyNotesCell", for: indexPath) as! EditAccountStrategyCollectionViewCell
                (cell1 as! EditAccountStrategyCollectionViewCell).bottomView?.layer.borderColor = UIColor.lightGray.cgColor
                if !(PlanVisitManager.sharedInstance.visit?.sgwsAgendaNotes.isEmpty)! {
                    (cell1 as! EditAccountStrategyCollectionViewCell).textView?.text = PlanVisitManager.sharedInstance.visit?.sgwsAgendaNotes
                }
                
            } else {
                cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "editAccountStrategyCell", for: indexPath) as! EditAccountStrategyCollectionViewCell

                let dict = PlistMap.sharedInstance.readPList(plist: plistDict["Login"]!)[indexPath.row] as! Dictionary<String, Any>
                
                if let valueString = dict["value"] as? String {
                      (cell1 as! EditAccountStrategyCollectionViewCell).centerLabel?.text = valueString
                }
                
                cell1?.layer.borderWidth = 3.0
                if selectedValuesList[indexPath.row] == "true" {
                    cell1?.layer.borderColor = UIColor(red: 66/255, green: 135/255, blue: 194/255, alpha: 1.0).cgColor
                    (cell1 as! EditAccountStrategyCollectionViewCell).selectedIcon?.isHidden = false
                } else {
                    cell1?.layer.borderColor = UIColor.clear.cgColor
                    (cell1 as! EditAccountStrategyCollectionViewCell).selectedIcon?.isHidden = true
                }
            }
        
        return cell1!
    }
}

//MARK:- UICollectionView Delegate
extension ServicePurposesViewController : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
        //if indexPath.section == 4 {
            if indexPath.row == PlistMap.sharedInstance.readPList(plist: plistDict["Login"]!).count {
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

//MARK:- UICollectionView DelegateFlowLayout
extension ServicePurposesViewController : UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

            if indexPath.row == PlistMap.sharedInstance.readPList(plist: plistDict["Login"]!).count {
                return CGSize(width: self.view.frame.size.width, height: 319);
            } else {
                return CGSize(width: self.view.frame.size.width/1.03, height: 75);
            }
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 10.0

    }

    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 10.0
    }

}

