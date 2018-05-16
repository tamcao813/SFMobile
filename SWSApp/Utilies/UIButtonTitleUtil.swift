//
//  UIButtonTitleUtil.swift
//  SWSApp
//
//  Created by Thillaiganesh, C. on 16/05/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class UIButtonTitleUtil {

    static func displayAttributedTitle(_ displayButton: UIButton!, smallString: String, bigString: String) {
        let fullString = "\(smallString) \(bigString)"
        let attrString = NSMutableAttributedString(string: fullString,
                                                   attributes: [NSAttributedStringKey.foregroundColor : UIColor.white])
        
        let smallStringRange = NSRange(location: 0, length: smallString.count)
        let bigStringRange = NSRange(location: smallStringRange.length+1, length: bigString.count)
        
        let smallStringFontSize: CGFloat = 17
        let bigStringFontSize: CGFloat = 30
        
        attrString.beginEditing()
        
        attrString.addAttribute(.font, value: UIFont(name:"Ubuntu", size: smallStringFontSize)!, range: smallStringRange)
        attrString.addAttribute(.font, value: UIFont(name:"Ubuntu", size: bigStringFontSize)!, range: bigStringRange)
        attrString.addAttribute(.baselineOffset, value: (bigStringFontSize - smallStringFontSize) / 4, range: smallStringRange)
        
        attrString.endEditing()
        
        displayButton.setAttributedTitle(attrString, for: .normal)
    }
    
}
