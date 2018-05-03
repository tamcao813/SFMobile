//
//  ToggleTableViewCell.swift
//  SWSApp
//
//  Created by manu.a.gupta on 26/04/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit
protocol ToggleTableViewCellDelegate: NSObjectProtocol {
    func buyingPowerChanged(buyingPower: Bool)
}

class ToggleTableViewCell: UITableViewCell {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    weak var delegate: ToggleTableViewCellDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        questionLabel.text = "Does this contact have buying power?"
    }
    
    @IBAction func yesButtonTapped(_ sender: UIButton){
        yesButton.setTitleColor(.white, for: .normal)
        yesButton.backgroundColor = UIColor(fromHexValue: "#4187c2")
        noButton.setTitleColor(.lightGray, for: .normal)
        noButton.backgroundColor = .white
        delegate.buyingPowerChanged(buyingPower: true)
    }
    
    @IBAction func noButtonTapped(_ sender: UIButton){
        yesButton.setTitleColor(.lightGray, for: .normal)
        yesButton.backgroundColor = .white
        noButton.setTitleColor(.white, for: .normal)
        noButton.backgroundColor = UIColor(fromHexValue: "#4187c2")
        delegate.buyingPowerChanged(buyingPower: false)
    }
}
