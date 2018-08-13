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
    var buyingPower = true
    
    override func awakeFromNib() {
        super.awakeFromNib()
        noButton.isEnabled = true
        yesButton.isEnabled = true
        questionLabel.text = "Does this contact have buying power?"
    }
    
    func setBuyingPower(value: Bool) {
        buyingPower = value
        toggleFlag()
    }
    
    func toggleFlag(){
        if buyingPower {
            yes()
        }else{
            no()
        }
    }
    
    @IBAction func yesButtonTapped(_ sender: UIButton){
        yes()
        delegate.buyingPowerChanged(buyingPower: true)
    }
    
    @IBAction func noButtonTapped(_ sender: UIButton){
        no()
        delegate.buyingPowerChanged(buyingPower: false)
    }
    
    func yes(){
        DispatchQueue.main.async {
            self.yesButton.setTitleColor(.white, for: .normal)
            self.yesButton.backgroundColor = UIColor(fromHexValue: "#4187c2")
            self.noButton.setTitleColor(.lightGray, for: .normal)
            self.noButton.backgroundColor = .white
        }
    }
    
    func no(){
        DispatchQueue.main.async {
            self.yesButton.setTitleColor(.lightGray, for: .normal)
            self.yesButton.backgroundColor = .white
            self.noButton.setTitleColor(.white, for: .normal)
            self.noButton.backgroundColor = UIColor(fromHexValue: "#4187c2")
        }
    }
}

