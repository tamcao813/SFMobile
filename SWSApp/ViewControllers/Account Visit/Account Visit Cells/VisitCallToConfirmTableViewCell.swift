//
//  VisitCallToConfirmTableViewCell.swift
//  SWSApp
//
//  Created by vipin.vijay on 23/05/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

protocol appointmentStatusDelegate {
    func appointmentStatusUpdate(sender: Bool)
}

class VisitCallToConfirmTableViewCell: UITableViewCell {
    
    @IBOutlet weak var appontmentControl: UISegmentedControl!
    var delegate: appointmentStatusDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        
    }
    
    @IBAction func confirmToCall(sender: UISegmentedControl) {
        
        if (sender.selectedSegmentIndex == 0)
        {
            delegate?.appointmentStatusUpdate(sender: true)
        }
        else
        {
            delegate?.appointmentStatusUpdate(sender: false)
        }
    }
    
}
