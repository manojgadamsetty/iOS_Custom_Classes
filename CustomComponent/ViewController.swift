//
//  ViewController.swift
//  CustomComponent
//
//  Created by Manoj Gadamsetty on 12/02/21.
//


import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let label = LinkLabel(frame: CGRect(x: 10, y: 50, width: self.view.bounds.width, height: 21))
        label.textAlignment = NSTextAlignment.center
        label.configureLabel("Please agree for Terms & Conditions.", selectableString: "Terms & Conditions.", nil, nil)
        label.callbackForLinkTap = { (selectedString) in
            print("Selected String \(selectedString)")
        }
        self.view.addSubview(label)
        
        let button = UIButton(frame: CGRect(x: 10, y: 100, width: self.view.bounds.width, height: 21))
        button.setTitle("Toast Butto", for: .normal)
        button.addTarget(self, action: #selector(tapped), for: .touchUpInside)
        self.view.addSubview(button)
    }
    
    @objc func tapped(sender: UIButton?){
        showToast(message: "sample toast")
    }
    
    func showToast(message: String) {
        var toast = ToastMessageView()
        toast = ToastMessageView.getToastMessageView(toastMessage: message)!
        
        let bounds = UIScreen.main.bounds
        let height = bounds.size.height
        if let window = AppDelegate.delegate?.window {
            toast.center = CGPoint(x: window.frame.width/2,
                                   y: (height - 150))
            window.addSubview(toast)
        }
    }
}

