//
//  Toast View.swift
//
//
//  Created by Manoj Gadamsetty on 03/08/21.
//  Copyright © 2021 Manoj. All rights reserved.
//

import Foundation
import UIKit

/// Available toast font sizes
enum ToastSize {
    /// Corresponds to UIFontTextStyle.body
    case small
    /// Corresponds to UIFontTextStyle.title2
    case normal
    /// Corresponds to UIFontTextStyle.title1
    case large
}
enum ToastDuration : TimeInterval {
    case short = 0.6, normal = 2.0, long = 3.5
}

fileprivate class ToastLabel : UILabel { }

extension UIView {
    /// Creates a toast message as a subview of a given UIView
    ///
    /// - parameter message: The text to display
    /// - parameter size: The text size
    /// - parameter duration: How long to display the toast message for
    func toast(_ message:String, size:ToastSize = .normal, duration: ToastDuration = .normal) {
        let lbl = ToastLabel()
        lbl.textColor = UIColor.white
        lbl.backgroundColor = UIColor.black
        lbl.text = message
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.alpha = 0
        lbl.numberOfLines = 0
        
        switch size {
        case .small:
            lbl.font = UIFont.preferredFont(forTextStyle: .body)
        case .normal:
            if #available(iOS 9.0, *) {
                lbl.font = UIFont.preferredFont(forTextStyle: .title2)
            } else {
                lbl.font = UIFont.preferredFont(forTextStyle: .headline)
            }
        case .large:
            if #available(iOS 9.0, *) {
                lbl.font = UIFont.preferredFont(forTextStyle: .title1)
            } else {
                lbl.font = UIFont.preferredFont(forTextStyle: .headline)
            }
        }
        
        lbl.clipsToBounds = true
        lbl.layer.cornerRadius = 10
        
        for subView in subviews {
            if let existingToast = subView as? ToastLabel {
                existingToast.removeFromSuperview() // multiple overlapping toasts in the same place don't look good
            }
        }
        
        addSubview(lbl)
        addConstraints([
            NSLayoutConstraint(item: self, attribute: .leadingMargin, relatedBy: .equal, toItem: lbl, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: self, attribute: .trailingMargin, relatedBy: .equal, toItem: lbl, attribute: .trailing, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: self, attribute: .bottomMargin, relatedBy: .equal, toItem: lbl, attribute: .bottom, multiplier: 1, constant: 0),
            ])
        
        UIView.animate(withDuration: 0.1, animations: { lbl.alpha = 0.7 }, completion: { f in
            UIView.animate(withDuration: 1.2, delay: duration.rawValue, options:.curveEaseOut, animations: { lbl.alpha = 0 }, completion: { f in
                lbl.removeFromSuperview() }) })
    }
}

/// Creates a toast message as a subview of the application's key window
///
/// - parameter message: The text to display
/// - parameter size: The text size
/// - parameter duration: How long to display the toast message for
func toast(_ message:String, size:ToastSize = .normal, duration: ToastDuration = .normal) {
    guard let window = UIApplication.shared.keyWindow else {
        return
    }
    window.toast(message, size: size, duration: duration)
}

/*
 usage:

     toast("a toast messsage appeared!")

 advanced usage:

     toast("a toast message appeared!", size: .large, duration: .long)
 */
