//
//  VisitLocationTableViewCell.swift
//  SWSApp
//
//  Created by vipin.vijay on 23/05/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

protocol locationDelegate {
    func onLocationUpdate(sender: String)
}

class VisitLocationTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var locationTxtFld: UITextField!
    var delegate: locationDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        delegate?.onLocationUpdate(sender: textField.text!)
        return true;
    }
    
}
