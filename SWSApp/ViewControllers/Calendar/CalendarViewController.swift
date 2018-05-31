//
//  CalendarViewController.swift
//  SWSApp
//
//  Created by Thillaiganesh, C. on 11/05/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController {

    var calendarListVC: CalendarListViewController?
    var filterMenuVC: CalendarMenuViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        filterMenuVC?.searchByEnteredTextDelegate = calendarListVC
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "CalendarSegue") {
            calendarListVC = segue.destination as? CalendarListViewController
        }
        
        if(segue.identifier == "CalendarQueryFilter")
        {
            filterMenuVC = segue.destination as? CalendarMenuViewController
        }
    }
    
}
