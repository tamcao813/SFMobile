//
//  HomeViewController.swift
//  SWSApp
//
//  Created by shilpa.a.kulkarni on 26/03/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit
import SmartStore
import SmartSync

struct GlobalWorkOrderArray {
    static var workOrderArray  =  [WorkOrderUserObject]()
}

class HomeViewController: UIViewController {
    
    let userViewModel = UserViewModel()
    var loggerInUser: User?
    
    @IBOutlet weak var scollView : UIScrollView?
    
    //MARK: - ViewLifeCycle Methods
    override func viewDidLoad() {
        loggerInUser = userViewModel.loggedInUser
        GlobalWorkOrderArray.workOrderArray = StoreDispatcher.shared.fetchVisits()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("Home VC will appear")
        
        //        registerSyncLogSoup()

        //for soup testing
//                let SmartStoreViewController = SFSmartStoreInspectorViewController.init(store:  SFSmartStore.sharedStore(withName: StoreDispatcher.SFADB) as! SFSmartStore)
//                present(SmartStoreViewController, animated: true, completion: nil)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("Home VC will disappear")
    }
    
    //Scroll Tableview Content to Top
    func scrollToTop(){
        DispatchQueue.main.async {
            self.scollView?.setContentOffset(CGPoint.zero, animated: true)
        }
    }
}

