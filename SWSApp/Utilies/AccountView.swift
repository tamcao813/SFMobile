//
//  AccountView.swift
//  SWSApp
//
//  Created by vipin.vijay on 24/04/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation

class AccountView: UIView {
    
    @IBOutlet var view:UIView!
    @IBOutlet weak var accountLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Bundle.main.loadNibNamed("AccountView", owner: self, options: nil)
        self.view.frame = frame
        self.addSubview(view)
        self.view.layer.borderWidth = 1
        self.view.layer.borderColor = UIColor(red:204/255, green:204/255, blue:204/255, alpha: 1).cgColor

    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    
    @IBAction func closeView(sender: UIButton) {
        self.removeFromSuperview()
        NotificationCenter.default.post(name: Notification.Name("CLOSEACCOUNTVIEW"), object: nil)

    }
}

