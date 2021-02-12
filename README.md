# Swift Custom Classes
Some of the simple classes to make developer life easier 
  - LinkLabel

# LinkLabel!
  - Touchable area in specific word/sentense in label
  - Simply callback it with action

### Usage
Simply download LinkLabel file in common folder and drag drop it to your project
```sh
   let label = LinkLabel(frame: CGRect(x: 10, y: 50, width: self.view.bounds.width, height: 21))
       label.textAlignment = NSTextAlignment.center
       label.configureLabel("Please agree for Terms & Conditions.", selectableString: "Terms & Conditions.", nil, nil)
       label.callbackForLinkTap = { (selectedString) in
            print("Selected String \(selectedString)")
        }
       self.view.addSubview(label)
```
