//
//  OpportunitiesListViewController.swift
//  SWSApp
//
//  Created by Thillaiganesh, C. on 31/05/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class OpportunitiesListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

//MARK:- TableView DataSource Methods
extension OpportunitiesListViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:OpportunitiesListTableViewCell = tableView.dequeueReusableCell(withIdentifier: "opportunitiesListTableViewCell", for: indexPath) as! OpportunitiesListTableViewCell
        cell.selectionStyle = .none
        return cell
    }
    
}

//MARK:- TableView Delegate Methods
extension OpportunitiesListViewController : UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
}
