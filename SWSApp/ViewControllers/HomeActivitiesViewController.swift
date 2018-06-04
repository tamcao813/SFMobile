//
//  HomeActivitiesViewController.swift
//  SWSApp
//
//  Created by r.a.jantakal on 01/06/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation
import UIKit

class HomeActivitiesViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView : UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell1")
        return cell!
    }
}

class TableViewCell : UITableViewCell{
    
    
}
