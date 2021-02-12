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
    }
    
    
}

