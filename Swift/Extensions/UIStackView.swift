//
//  UIStackView.swift
//
//  Created by Adil Umer on 2.11.2020.
//  Copyright © 2020. All rights reserved.
//

import Foundation
import UIKit

extension UIStackView {
    
    open override func awakeFromNib() {
        if self.axis == .horizontal {
            self.spacing = self.spacing.relativeToIphone8Width()
        } else {
            self.spacing = self.spacing.relativeToIphone8Height()
        }
        self.layoutIfNeeded()
    }
    
}
