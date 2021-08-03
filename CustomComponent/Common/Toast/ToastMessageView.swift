import UIKit

class ToastMessageView: UIView {
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var toastLabel: UILabel!

    class func getToastMessageView(toastMessage: String) -> ToastMessageView? {
        if let customView =  UINib(nibName: ToastMessageView.identifier, bundle: nil).instantiate(withOwner: nil, options: nil)[0] as? ToastMessageView {
            customView.configureUI(toastMessage: toastMessage)
            let bounds = UIScreen.main.bounds
            let width = bounds.size.width
            customView.toastLabel.numberOfLines = 0
            customView.toastLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
            customView.toastLabel.text = toastMessage
            customView.toastLabel.sizeToFit()
            let labelHeight = customView.toastLabel.frame.height
            customView.frame = CGRect(x: 0, y: 0, width: width-10, height: labelHeight+16)
            self.animate(withDuration: 1.0, delay: 3.0, options: .curveEaseOut, animations: {
                customView.alpha = 0.0
            }, completion: { _ in
                customView.removeFromSuperview()
            })
            return customView
        }
        return nil
    }
}

extension ToastMessageView {
    func configureUI(toastMessage: String) {
        self.initializeLabel(message: toastMessage)
        self.initializeView()
    }

    func initializeLabel(message: String) {
        toastLabel.configure(text: message, color: UIColor.white , font: UIFont.systemFont(ofSize: 12, weight: .medium) )
    }

    func initializeView() {
        self.backgroundView.layer.cornerRadius = 8.0
        self.backgroundView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.6)
    }
}
extension UIView {
    
    @objc class public var identifier: String {
        return String(describing: self)
    }
}

extension UILabel {

    func configure(text: String, color: UIColor, font: UIFont, isMandatoryLabel: Bool = false) {

        self.text = text
        self.textColor = color
        self.font = font
        let starText = NSAttributedString(string: "*", attributes: [NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.font: font])
        let labelText = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.font: font])
        let combination = NSMutableAttributedString()
        combination.append(labelText)
        if isMandatoryLabel {
            combination.append(starText)
        }
        self.attributedText = combination
    }
    
    func assignImageToLabel(imageName: String, text: String) {
        let attachment = NSTextAttachment()
        attachment.image = UIImage(named: imageName)
        let attachmentString = NSAttributedString(attachment: attachment)
        let myString = NSMutableAttributedString(string: text)
        myString.append(attachmentString)
        self.attributedText = myString
    }
}

/*
 
 */
