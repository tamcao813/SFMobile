//
//  TestTableViewController.swift
//  SWSApp
//
//  Created by maria.min-hui.yu on 3/21/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit
import SalesforceSDKCore
import SalesforceSwiftSDK
import PromiseKit
import SmartStore
import SmartSync

class TestTableViewController: UITableViewController {

    let dataAry = ["SyncDown Account", "SYNCUP Account", "SYNCDOWNDELTA", "SYNCUPDELTA", "SYNCJOIN"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataAry.count
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let option = dataAry[indexPath.row]
        
        let userid = "E2" //need to get userid after the user logs in
        
        switch option {
            case "SYNCDOWN" :
            DataSync.SyncDownAccount(userid: userid)
        case "SYNCUP":
            print("SYNCUP")
        case "SYNCDOWNDELTA":
            print("SYNCDOWNDELTA")
        case "SYNCUPDELTA":
            print("SYNCUPDELTA")
        case "SYNCJOIN":
            print("SYNCJOIN")
        default:
            print("default")
        }
        
        //let SmartStoreViewController = SFSmartStoreInspectorViewController.init(store:  SFSmartStore.sharedStore(withName: smartstoreName) as! SFSmartStore)
        //present(SmartStoreViewController, animated: true, completion: nil)
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        cell.textLabel?.text = dataAry[indexPath.row]

        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        
        return cell
    }

}
