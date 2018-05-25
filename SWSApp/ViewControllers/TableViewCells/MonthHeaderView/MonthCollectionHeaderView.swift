//
//  MonthCollectionHeaderView.swift
//  MonthCalendar
//
//  Created by vipin.vijay on 11/05/18.
//  Copyright © 2018 vipin.vijay. All rights reserved.
//

import UIKit

protocol monthViewDelegate {
    func didChangeMonth(monthIndex: Int, year: Int)
}

class MonthCollectionHeaderView: UICollectionReusableView {
    
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var fwdButton: UIButton!
    
    var currentMonthIndex = 0
    var currentYear:Int = 0
    var delegate: monthViewDelegate?
    var counter:Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        currentMonthIndex = Calendar.current.component(.month, from: Date()) - 1
        currentYear = Calendar.current.component(.year, from: Date())
        monthLabel.text = DateFormatter().monthSymbols[currentMonthIndex] + " " + String(currentYear)

    }
    
    @IBAction func nextMonth(sender: UIButton) {
        print("next")
        currentMonthIndex += 1
        if currentMonthIndex > 11 {
            currentMonthIndex = 0
            currentYear += 1
        }
        monthLabel.text = DateFormatter().monthSymbols[currentMonthIndex] + " " + String(currentYear)
        delegate?.didChangeMonth(monthIndex: currentMonthIndex, year: currentYear)
        counter = counter + 1
        if counter == 3 {
            fwdButton.isHidden = true
        }
        backButton.isHidden = false
    }
    
    @IBAction func previousMonth(sender: UIButton) {
        print("previous")
        currentMonthIndex -= 1
         if currentMonthIndex < 0 {
            currentMonthIndex = 11
            currentYear -= 1
        }
        fwdButton.isHidden = false
        monthLabel.text = DateFormatter().monthSymbols[currentMonthIndex] + " " + String(currentYear)
        delegate?.didChangeMonth(monthIndex: currentMonthIndex, year: currentYear)
        counter = counter - 1
        if counter == -1 {
            backButton.isHidden = true
        }
    }
    
    func nextMonth() {
        currentMonthIndex += 1
        if currentMonthIndex > 11 {
            currentMonthIndex = 0
            currentYear += 1
        }
        backButton.isHidden = false

        monthLabel.text = DateFormatter().monthSymbols[currentMonthIndex] + " " + String(currentYear)
        delegate?.didChangeMonth(monthIndex: currentMonthIndex, year: currentYear)
    }
    
    func previousMonth() {
        currentMonthIndex -= 1
        if currentMonthIndex < 0 {
            currentMonthIndex = 11
            currentYear -= 1
        }
        monthLabel.text = DateFormatter().monthSymbols[currentMonthIndex] + " " + String(currentYear)
        delegate?.didChangeMonth(monthIndex: currentMonthIndex, year: currentYear)
    }
    
}
