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
    @IBOutlet weak var lblLastModifiedDate : UILabel?
    @IBOutlet weak var lblNoData : UILabel?
    
    let strategyQAViewModel = StrategyQAViewModel()
    let strategyQuestionsViewModel = StrategyQuestionsViewModel()
    let strategyAnswersViewModel = StrategyAnswersViewModel()
    
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Account Strategy Screen Loaded")
        
        //let plistPath = Bundle.main.path(forResource: "AccountStrategy", ofType: ".plist", inDirectory: nil)
        //let dictionary = NSMutableDictionary(contentsOfFile: plistPath!)
        //tableViewRowDetails = dictionary!["New item"] as? NSMutableArray
        //print(dictionary!)
        
        
        let data = strategyQAViewModel.getStrategyQuestionAnswer()
        
        let tableViewData = NSMutableArray()
        var dict : NSMutableDictionary!
        
        var headerCheck = false
        
        //Write a func to get header Count
        for header in self.getHeader(){
            
            for queAndAns in data{
                
                dict = NSMutableDictionary()
                
                //execute only for account situation (headers only)
                if queAndAns.SGWS_Question__r_SGWS_Question_Type__c != header {
                    continue
                }
                
                //Used to keep Header only once
                for q in tableViewData{
                    
                    let dictionary = q as! NSDictionary
                  //  print(dictionary)
                    
                    let header = dictionary["header"] as? String
                    
                    if queAndAns.SGWS_Question__r_SGWS_Question_Type__c == header{
                        
                        headerCheck = true
                        
                    }
                }
                
                //Prevent the Subheader inserting Again
                //DIDNT WORK OUT
                
                if !headerCheck{
                    dict.setValue(queAndAns.SGWS_Question__r_SGWS_Question_Type__c, forKey: "header") //Main Header
                }else{
                    dict.setValue("", forKey: "header")
                }
                
                headerCheck = false
                
                dict.setValue(queAndAns.SGWS_Question__r_SGWS_Question_Sub_Type__c, forKey: "subHeader")    //Added Subheader
                dict.setValue(queAndAns.Id, forKey: "id")
                
                let answerArray = NSMutableArray()
                
                let answerListArray = queAndAns.SGWS_Answer_Description_List__c.components(separatedBy: ",")
                
                if answerListArray.count > 0 {
                    
                    for ans in answerListArray{
                        
                        let answerDict = NSMutableDictionary()
                        answerDict.setValue(ans, forKey: "answerText")
                        
                        answerArray.add(answerDict)
                    }
                }
                dict.setValue(answerArray, forKey: "answers") //Added Answers for Subheader
                
                tableViewData.add(dict)
                
            }
        }
        
     //   print(tableViewData)
        
        
        let modifiedArray = NSMutableArray()
        
        for subHeaders in self.getSubHeader(){
            
            //Get the Subheader filtered in a loop
            let namePredicate = NSPredicate(format: "subHeader = %@",subHeaders);
            
            let filteredArray = tableViewData.filter { namePredicate.evaluate(with: $0) };
            
         //   print(filteredArray)
            
            let newArray = NSMutableArray()
            for item in filteredArray{
                let tempDict = item as! NSMutableDictionary
                let ary = tempDict["answers"] as! NSMutableArray
                
                for data in ary{
                    let dic = data as! NSMutableDictionary
                    newArray.add(dic)
                    
                }
            }
            let dictionary = NSMutableDictionary()
            dictionary.setValue(newArray, forKey: "answers")
            
            let data1 = filteredArray[0] as! NSMutableDictionary
            let head1 = data1["header"] as! String
            let subHead1 = data1["subHeader"] as! String
            
            dictionary.setValue(head1, forKey: "header")
            dictionary.setValue(subHead1, forKey: "subHeader")
            
            modifiedArray.add(dictionary)
            
        }
        
     //   print(modifiedArray)
        
        
        
        //
        //       // let modofiedArray = NSMutableArray()
        //
        //        for item in tableViewRowDetails! {
        //
        //            let modifiedDictionary = NSMutableDictionary()
        //
        //            let dict = item as! NSMutableDictionary
        //            let header = dict["header"] as! String
        //            let subHeader = dict["subHeader"] as! String
        //            let answerArray = dict["answers"] as? NSMutableArray
        //
        //            modifiedDictionary.setValue(header, forKey: "header")
        //            modifiedDictionary.setValue(subHeader, forKey: "subHeader")
        //
        //
        //
        //            if tableViewData.count > 1{
        //
        //
        //
        //            }
        //                for data in tableViewData{
        //
        //                    let newDict = data as! NSMutableDictionary
        //                    let newHeader = newDict["subHeader"] as! String
        //                    let newAnswerArray = newDict["answers"] as? NSMutableArray
        //
        //                    if subHeader == newHeader{
        //
        //                        for answerItems in (newAnswerArray)!{
        //
        //                            let newData = answerItems as! NSMutableDictionary
        //                            answerArray?.add(newData)
        //                        }
        //                        modifiedDictionary.setValue(answerArray, forKey: "answers")
        //                        modofiedArray.add(modifiedDictionary)
        //                    }else{
        //                        break
        //                    }
        //                }
        //
        //
        //
        //
        //
        //        }
        
        
        
        
        
        
        
        let strategyNotes = data.last?.SGWS_Notes__c
        
        if strategyNotes != ""{
            let dict = NSMutableDictionary()
            dict.setValue("Account Strategy Notes", forKey: "header")
            dict.setValue("", forKey: "subHeader")
            let notesArray = NSMutableArray()
            let notesAnswerDict = NSMutableDictionary()
            notesAnswerDict.setValue(strategyNotes!, forKey: "answerText")
            notesArray.add(notesAnswerDict)
            dict.setValue(notesArray, forKey: "answers")
            modifiedArray.add(dict)
        }
        
        
        
        tableViewRowDetails = modifiedArray
        
        
        
        
        //Hide the Label
        if tableViewRowDetails!.count > 0 {
            self.lblNoData?.isHidden = true
        }else{
            self.lblNoData?.isHidden = false
        }
        
        
        
        
        
        
        //for item in data{
        
        //  let dict = NSMutableDictionary()
        //  let answerArray = NSMutableArray()
        
        //            if dict.count > 0{
        //
        //                let values = dict.allValues
        //
        //            }
        
        
        //            if tableViewData.count > 0 {
        //
        //                for item1 in tableViewData{
        //
        //                    let dict = item1 as! NSMutableDictionary
        //
        //                    if(dict["headerText"] == item.SGWS_Question__r_SGWS_Question_Type__c){
        //
        //
        //                    }else{
        //
        //
        //                    }
        //                }
        //            }
        
        
        //
        //            if (tableViewData.contains(["headerText" : item.SGWS_Question__r_SGWS_Question_Type__c])) {
        //
        //                dict.setValue("", forKey: "headerText")
        //
        //                if (tableViewData.contains(["subHeader": item.SGWS_Question__r_SGWS_Question_Sub_Type__c])) {
        //
        //                    dict.setValue("", forKey: "subHeader")
        //
        //                }else{
        //                    dict.setValue(item.SGWS_Question__r_SGWS_Question_Sub_Type__c, forKey: "subHeader")
        //
        //                }
        //
        //                //need a for loop for Answers
        //
        //
        //
        //
        //
        //                dict.setValue(item.Id, forKey: "id")
        //                //answerArray.add(item.SGWS_Answer__c)
        //
        //            }else{
        //
        //                dict.setValue(item.SGWS_Question__r_SGWS_Question_Type__c, forKey: "headerText")
        //
        //
        //                if (tableViewData.contains(["subHeader" : item.SGWS_Question__r_SGWS_Question_Sub_Type__c])) {
        //
        //                    dict.setValue("", forKey: "subHeader")
        //
        //                }else{
        //                    dict.setValue(item.SGWS_Question__r_SGWS_Question_Sub_Type__c, forKey: "subHeader")
        //
        //                }
        //
        //                //need a for loop for Answers
        //
        //
        //
        //
        //
        //                dict.setValue(item.Id, forKey: "id")
        //                //answerArray.add(item.SGWS_Answer__c)
        //
        //            }
        //
        //            //dict.setValue(answerArray, forKey: "answerArray")
        //            tableViewData.add(dict)
        //
        //        }
        //
        //
        
        
        
        
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
    
    func getHeader()-> [String]{
        var headerArray = [String]()
        
        //Get unique headernames once
        let data = strategyQAViewModel.getStrategyQuestionAnswer()
        for questionHeaders in data{
            
            let que = questionHeaders.SGWS_Question__r_SGWS_Question_Type__c
            if que != "" {
                if !(headerArray.contains(que)){
                    headerArray.append(que)
                }
            }
        }
        //print(headerArray)
        return headerArray
    }
    
    func getSubHeader()-> [String]{
        var subHeaderArray = [String]()
        
        //Get unique headernames once
        let data = strategyQAViewModel.getStrategyQuestionAnswer()
        for questionHeaders in data{
            
            let que = questionHeaders.SGWS_Question__r_SGWS_Question_Sub_Type__c
            if que != "" {
                if !(subHeaderArray.contains(que)){
                    subHeaderArray.append(que)
                }
            }
        }
       // print(subHeaderArray)
        return subHeaderArray
    }
    
    
    //MARK:- Button Actions
    @IBAction func editButtonClicked(sender : UIButton){
        
        
    }
}

//MARK:- UICollectionView DataSource
extension AccountStrategyViewController : UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return (tableViewRowDetails?.count)!
        //return 0
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
        
        if indexPath.section == (tableViewRowDetails?.count)! - 1 {//Used to make the Additional notes Dynamic
            
            let tableData = tableViewRowDetails![indexPath.section] as! NSMutableDictionary
            let tableContent = tableData["answers"] as! NSMutableArray
            let questions = tableContent[indexPath.row] as! NSMutableDictionary
            
            //let constraintRect = CGSize(width: self.view.frame.size.width, height: CGFloat.greatestFiniteMagnitude)
            let data = (questions["answerText"] as! String)
            
            let attString = NSAttributedString(string: data, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16.0)])
            let dynamicSize: CGRect = attString.boundingRect(with: CGSize(width: self.collectionView!.bounds.size.width, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, context: NSStringDrawingContext.init())
            
            return dynamicSize.size
        }
        
        return CGSize(width: (self.collectionView?.frame.size.width)!, height: 25)
        
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
        cell1.displayCellData(data: questions , indexPath: indexPath, arrayData: tableViewRowDetails!)
        //cell1.contentView.systemLayoutSizeFitting(UILayoutFittingExpandedSize)
        
        return cell1
        
    }
    
    //Used to set width and height of HeaderView
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: collectionView.frame.size.width, height: 75)
    }
}


