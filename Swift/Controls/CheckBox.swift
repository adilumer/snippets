//
//  CheckBox.swiftcall prof
//
//  Created by Adil Umer on 5.10.2020.
//  Copyright © 2020 call prof. All rights reserved.
//

import UIKit

class CheckBox: UIButton {

    var isChecked: Bool = false {
        didSet {
            
            if isChecked{
                self.setImage(UIImage(named: "toggle-on")!, for: .normal)
            }else{
                self.setImage(UIImage(named: "toggle-off")!, for: .normal)
            }
        }
    }
    
    override func awakeFromNib() {
        self.addTarget(self, action: #selector(selfClicked(sender:)), for: .touchDown)
        self.isChecked = false
    }
    
    @objc func selfClicked(sender: UIButton){
        isChecked = !isChecked
    }
    
    func state()->Bool{
        return isChecked
    }

}
