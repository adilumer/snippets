//
//  SmallUIElements.swift
//
//  Created by Adil Umer on 2.11.2020.
//  Copyright © 2020. All rights reserved.
//

import Foundation
import UIKit

class CircleSprite: UIView{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.makeRounded()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.makeRounded()
    }
    
}
