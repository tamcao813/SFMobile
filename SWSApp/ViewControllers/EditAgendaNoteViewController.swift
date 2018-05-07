//
//  EditAgendaNote.swift
//  SWSApp
//
//  Created by vipin.vijay on 07/05/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation

class EditAgendaNoteViewController: UIViewController {
    
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var bgView: UIView!
    
    var editNotesText:String = ""
    
    override func viewDidLoad() {
    dropShadow(color: .lightGray, opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
    descriptionTextView.text = editNotesText

    }
    
    //MARK:- IBAction
    
    @IBAction func closeVC(sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func saveAndClose(sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    //MARK:- Custom Methods
    
    // OUTPUT 2
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        bgView.layer.masksToBounds = false
        bgView.layer.shadowColor = color.cgColor
        bgView.layer.shadowOpacity = opacity
        bgView.layer.shadowOffset = offSet
        bgView.layer.shadowRadius = radius
        
        bgView.layer.shadowPath = UIBezierPath(rect: bgView.bounds).cgPath
        bgView.layer.shouldRasterize = true
        bgView.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}
