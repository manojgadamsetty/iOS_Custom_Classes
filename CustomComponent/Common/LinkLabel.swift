//
//  LinkLabel.swift
//  CustomComponent
//
//  Created by Manoj Gadamsetty on 12/02/21.
//

import UIKit

public class LinkLabel:UILabel {
    
    override public init(frame: CGRect) {
         super.init(frame: frame)
     }
     
     required public init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
     }
    
    private let normalAttributeStringProps = [
        NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),
        NSAttributedString.Key.foregroundColor: UIColor.black] as [NSAttributedString.Key : Any]
    
    private let underlineAttributeStringProps = [
        NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),
        NSAttributedString.Key.foregroundColor: UIColor.blue,
        NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue] as [NSAttributedString.Key : Any]
    
    private var titleString:String = ""
    private var selectString:String = ""

    var callbackForLinkTap: ((_ selectedText: String) -> Void)?

    public func configureLabel(_ title: String ,selectableString: String,_ normalAttribute:[NSAttributedString.Key : Any]? ,_ underlineAttribute:[NSAttributedString.Key : Any]?  ){
        
        titleString = title
        selectString = selectableString
        let normalAttributes = normalAttribute ?? normalAttributeStringProps
        let underlineAttributes = underlineAttribute ?? underlineAttributeStringProps
        
        let underlineAttriString = NSMutableAttributedString(string: title , attributes: normalAttributes)
        let selectableRange = (title as NSString).range(of: selectableString)
        underlineAttriString.addAttributes(underlineAttributes, range: selectableRange)
        self.attributedText = underlineAttriString
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(tapLabel(gesture:))))
    }
    
    @objc fileprivate func tapLabel(gesture: UITapGestureRecognizer) {
        let termsRange = (titleString as NSString).range(of: selectString)
    
       if gesture.didTapAttributedTextInLabel(label: self, inRange: termsRange) {
           print(selectString)
           self.callbackForLinkTap?(selectString)
       } else {
           print("Tapped none")
       }
    }
}

extension UITapGestureRecognizer {

    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
        // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let textStorage = NSTextStorage(attributedString: label.attributedText!)

        // Configure layoutManager and textStorage
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)

        // Configure textContainer
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize

        // Find the tapped character location and compare it to the specified range
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        //let textContainerOffset = CGPointMake((labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x,
                                              //(labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y);
        let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x, y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y)

        //let locationOfTouchInTextContainer = CGPointMake(locationOfTouchInLabel.x - textContainerOffset.x,
                                                        // locationOfTouchInLabel.y - textContainerOffset.y);
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x, y: locationOfTouchInLabel.y - textContainerOffset.y)
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        return NSLocationInRange(indexOfCharacter, targetRange)
    }

}
