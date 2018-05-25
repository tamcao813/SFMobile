//
//  EventButton.swift
//  MonthCalendar
//
//  Created by vipin.vijay on 13/05/18.
//  Copyright © 2018 vipin.vijay. All rights reserved.
//

import UIKit

@IBDesignable class EventButton: UIButton {
    
    var visit: WREvent!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInit()
    }
    
    override func prepareForInterfaceBuilder() {
        sharedInit()
    }
    
    func sharedInit() {
        // Common logic goes here
        self.backgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1.0)
        borderColor(value: .random())
    }
    
    func borderColor(value: UIColor) {
        let lineView = UIView(frame: CGRect(x: 1, y: 0, width: 4, height: self.frame.size.height))
        lineView.backgroundColor = value
        self.addSubview(lineView)

    }
}
