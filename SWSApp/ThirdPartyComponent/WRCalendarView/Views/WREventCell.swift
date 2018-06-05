//
//  WREventCell.swift
//  Pods
//
//  Created by wayfinder on 2017. 4. 30..
//
//

import UIKit

class WREventCell: UICollectionViewCell {
    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var homeTitleLabel: UILabel!
    @IBOutlet weak var homeDescLabel: UILabel!
    let defaults:UserDefaults = UserDefaults.standard
    
    var eventType: String = ""
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 5
        layer.shadowOpacity = 0
        
        if defaults.bool(forKey: "FromHomeVC" )
        {
            updateViewColors()
        } else {
            updateColors()
        }
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected && isSelected != oldValue {
                UIView.animate(withDuration: TimeInterval(0.2), animations: { [unowned self] in
                    self.transform = CGAffineTransform.init(scaleX: 1.025, y: 1.025)
                    self.layer.shadowOpacity = 0.2
                    }, completion: { [unowned self] _ in
                        self.transform = CGAffineTransform.identity
                })
            } else if isSelected {
                layer.shadowOpacity = 0.2
            } else {
                layer.shadowOpacity = 0.0
            }
            if defaults.bool(forKey: "FromHomeVC" )
            {
                updateViewColors()
            } else {
                updateColors()
            }
            
        }
    }
    
    var event: WREvent? {
        didSet {
            if let event = event {
                titleLabel.text = event.title
                if defaults.bool(forKey: "FromHomeVC" ) {
                    titleLabel.isHidden = true
                    homeTitleLabel.isHidden = false
                    homeDescLabel.isHidden = false
                    homeTitleLabel.text = event.title
                    homeDescLabel.text = "location" + " " + event.location
                    if event.type == "visit" {
                        eventType = event.type
                        self.backgroundColor = UIColor(hexString: "4287C2")!
                        borderView.backgroundColor = UIColor(hexString: "4287C2")!
                        homeTitleLabel.textColor = UIColor.white
                        homeDescLabel.textColor = UIColor.white
                    }
                    else if event.type == "event" {
                        eventType = event.type
                        self.backgroundColor = UIColor(hexString: "EBEBEB")!
                        borderView.backgroundColor = UIColor(hexString: "EBEBEB")!
                        homeTitleLabel.textColor = UIColor.black
                        homeDescLabel.textColor = UIColor.black
                    }
                    else {
                        eventType = ""
                    }
                } else {
                    homeTitleLabel.isHidden = true
                    homeDescLabel.isHidden = true
                    titleLabel.isHidden = false
                    if event.type == "visit" {
                        eventType = event.type
                        borderView.backgroundColor = UIColor(hexString: "4287C2")!
                    }
                    else if event.type == "event" {
                        eventType = event.type
                        borderView.backgroundColor = UIColor(hexString: "FF9300")!
                    }
                    else {
                        eventType = ""
                    }
                }
            }
        }
    }
    
    func updateColors() {
        contentView.backgroundColor = backgroundColorHighlighted(isSelected)
        if eventType == "visit" {
            borderView.backgroundColor = UIColor(hexString: "4287C2")!
        }
        else if eventType == "event" {
            borderView.backgroundColor = UIColor(hexString: "FF9300")!
        }
        else {
            borderView.backgroundColor = borderColor()
        }
        titleLabel.textColor = textColorHighlighted(isSelected)
    }
    
    func updateViewColors() {
        if eventType == "visit" {
            self.backgroundColor = UIColor(hexString: "4287C2")!
            borderView.backgroundColor = UIColor(hexString: "4287C2")!
            homeTitleLabel.textColor = UIColor.white
            homeDescLabel.textColor = UIColor.white
        }
        else if eventType == "event" {
            self.backgroundColor = UIColor(hexString: "EBEBEB")!
            borderView.backgroundColor = UIColor(hexString: "EBEBEB")!
            homeTitleLabel.textColor = UIColor.black
            homeDescLabel.textColor = UIColor.black
            
        }
        else {
            borderView.backgroundColor = borderColor()
        }
        titleLabel.textColor = textColorHighlighted(isSelected)
    }
    
    func backgroundColorHighlighted(_ selected: Bool) -> UIColor {
        //        return selected ? UIColor(hexString: "35b1f1")! : UIColor(hexString: "35b1f1")!.withAlphaComponent(0.1)
        return UIColor(hexString: "F0F4F7")!
    }
    
    func textColorHighlighted(_ selected: Bool) -> UIColor {
        //        return selected ? UIColor.white : UIColor(hexString: "21729c")!
        return UIColor.black
    }
    
    func borderColor() -> UIColor {
        //        return self.backgroundColorHighlighted(false).withAlphaComponent(1.0)
        return UIColor(hexString: "4287C2")!
    }
}

