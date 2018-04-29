//
//  AccountVisitViewController.swift
//  SWSApp
//
//  Created by Krishna, Kamya on 4/24/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class AccountVisitViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let accountStoryboard = UIStoryboard.init(name: "AccountVisit", bundle: nil)
        let accountVisitsVC = accountStoryboard.instantiateViewController(withIdentifier: "AccountVisitListViewController") as? AccountVisitListViewController
        self.addChildViewController(accountVisitsVC!)
        accountVisitsVC?.view.frame = CGRect(x: 0, y: 0, width: self.containerView.frame.size.width, height: self.containerView.frame.size.height)
        self.containerView.addSubview((accountVisitsVC?.view)!)
        accountVisitsVC?.didMove(toParentViewController: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
