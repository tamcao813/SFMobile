//
//  WeekCollectionHeaderView.swift
//  MonthCalendar
//
//  Created by vipin.vijay on 11/05/18.
//  Copyright © 2018 vipin.vijay. All rights reserved.
//

import UIKit

class WeekCollectionHeaderView: UICollectionReusableView {
    @IBOutlet weak var weekStack: UIStackView!
    let weekArr = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    let weekArrWithoutWeekEnds = ["Mon", "Tue", "Wed", "Thu", "Fri"]
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        for i in 0..<weekArr.count {
            let label = UILabel()
            label.text = weekArr[i]
            label.textColor = UIColor.black
            label.font = UIFont.boldSystemFont(ofSize: 16.0)
            label.textAlignment = .center
            weekStack.addArrangedSubview(label)
        }
    }
    
    /// Adding weeks without weekends to UIStackView
    
    func withoutWeekends() {
        for subUIView in self.weekStack.subviews as! [UILabel] {
            subUIView.removeFromSuperview()
        }
        for i in 0..<weekArrWithoutWeekEnds.count {
            let label = UILabel()
            label.text = weekArrWithoutWeekEnds[i]
            label.textColor = UIColor.black
            label.font = UIFont.boldSystemFont(ofSize: 16.0)
            label.textAlignment = .center
            weekStack.addArrangedSubview(label)
        }
    }
    
    /// Adding weeks with weekends to UIStackView
    
    func withWeekends() {
        for subUIView in self.weekStack.subviews as! [UILabel] {
            subUIView.removeFromSuperview()
        }
        for i in 0..<weekArr.count {
            let label = UILabel()
            label.text = weekArr[i]
            label.textColor = UIColor.black
            label.font = UIFont.boldSystemFont(ofSize: 16.0)
            label.textAlignment = .center
            weekStack.addArrangedSubview(label)
        }
    }
}
