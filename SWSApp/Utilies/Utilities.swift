//
//  Utilities.swift
//  MonthCalendar
//
//  Created by vipin.vijay on 11/05/18.
//  Copyright © 2018 vipin.vijay. All rights reserved.
//

import Foundation
import UIKit

//extension Date {
//    var weekday: Int {
//        return Calendar.current.component(.weekday, from: self)
//    }
//    var firstDayOfTheMonth: Date {
//        return Calendar.current.date(from: Calendar.current.dateComponents([.year,.month], from: self))!
//    }
//}
//extension String {
//    static var dateFormatter: DateFormatter = {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd"
//        return formatter
//    }()
//
//    var date: Date? {
//        return String.dateFormatter.date(from: self)
//    }
//}

extension UIStackView {
    
    func removeAllArrangedSubviews() {
        
        let removedSubviews = arrangedSubviews.reduce([]) { (allSubviews, subview) -> [UIView] in
            self.removeArrangedSubview(subview)
            return allSubviews + [subview]
        }
        
        // Deactivate all constraints
        NSLayoutConstraint.deactivate(removedSubviews.flatMap({ $0.constraints }))
        
        // Remove the views from self
        removedSubviews.forEach({ $0.removeFromSuperview() })
    }
}

//extension UILabel {
//    private struct AssociatedKeys {
//        static var padding = UIEdgeInsets()
//    }
//    
//    public var padding: UIEdgeInsets? {
//        get {
//            return objc_getAssociatedObject(self, &AssociatedKeys.padding) as? UIEdgeInsets
//        }
//        set {
//            if let newValue = newValue {
//                objc_setAssociatedObject(self, &AssociatedKeys.padding, newValue as UIEdgeInsets?, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//            }
//        }
//    }
//    
//    override open func draw(_ rect: CGRect) {
//        if let insets = padding {
//            self.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
//        } else {
//            self.drawText(in: rect)
//        }
//    }
//    
//    override open var intrinsicContentSize: CGSize {
//        guard let text = self.text else { return super.intrinsicContentSize }
//        
//        var contentSize = super.intrinsicContentSize
//        var textWidth: CGFloat = frame.size.width
//        var insetsHeight: CGFloat = 0.0
//        
//        if let insets = padding {
//            textWidth -= insets.left + insets.right
//            insetsHeight += insets.top + insets.bottom
//        }
//        
//        let newSize = text.boundingRect(with: CGSize(width: textWidth, height: CGFloat.greatestFiniteMagnitude),
//                                        options: NSStringDrawingOptions.usesLineFragmentOrigin,
//                                        attributes: [NSAttributedStringKey.font: self.font], context: nil)
//        
//        contentSize.height = ceil(newSize.size.height) + insetsHeight
//        
//        return contentSize
//    }
//}
//
//extension CGFloat {
//    static func random() -> CGFloat {
//        return CGFloat(arc4random()) / CGFloat(UInt32.max)
//    }
//}
//
//extension UIColor {
//    static func random() -> UIColor {
//        return UIColor(red:   .random(),
//                       green: .random(),
//                       blue:  .random(),
//                       alpha: 1.0)
//    }
//}

