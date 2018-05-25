//
//  ButtonTableViewCell.swift
//  SWSApp
//
//  Created by manu.a.gupta on 07/05/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

protocol ButtonTableViewCellDelegate: NSObjectProtocol {
    func accountStrategyButtonTapped()
}

class ButtonTableViewCell: UITableViewCell {

    weak var delegate: ButtonTableViewCellDelegate!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func accountStrategyButtonTapped(_ sender: UIButton){
        delegate.accountStrategyButtonTapped()
    }
    
}
