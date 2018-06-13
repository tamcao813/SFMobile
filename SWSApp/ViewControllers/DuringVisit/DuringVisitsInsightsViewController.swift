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
    
    @IBOutlet weak var insightsTableView : UITableView?
    @IBOutlet weak var accountNameLbl : UILabel?
    @IBOutlet weak var pincodeLabel : UILabel?
    @IBOutlet weak var addressLbl : UILabel?

    
    var collectionViewRowDetails : NSMutableArray?
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        accountNameLbl?.text = "NY account update"
        pincodeLabel?.text = "1782877822"
        addressLbl?.text = "California"
        
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




