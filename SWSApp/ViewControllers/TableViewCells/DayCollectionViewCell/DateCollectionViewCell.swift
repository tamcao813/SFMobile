//
//  DateCollectionViewCell.swift
//  MonthCalendar
//
//  Created by vipin.vijay on 11/05/18.
//  Copyright © 2018 vipin.vijay. All rights reserved.
//

import UIKit
protocol actionDelegate {
    func onVisitButtonTap(sender: UIButton, visit:WREvent)
}


class DateCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var moreButton: UIButton!
    
    var delegate: actionDelegate?
    
    override func draw(_ rect: CGRect) { //Your code should go here.
        super.draw(rect)
        dateLabel.padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        self.layer.borderWidth = 0.6
        self.layer.borderColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1.0).cgColor
    }
    
    @IBAction func navigateToPlanSummary(sender: EventButton) {
        delegate?.onVisitButtonTap(sender: sender, visit: sender.visit)
    }
}
