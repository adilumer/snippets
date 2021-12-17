//
//  UIButton.swift
//
//  Created by Adil Umer on 23.11.2020.
//  Copyright © 2020. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

extension UIButton {
    func loadImg(withUrl url: URL) {
        self.kf.setImage(with: url, for: .normal, placeholder: placeholder)
        /*
        DispatchQueue.global().async { [weak self] in
            if let imageData = try? Data(contentsOf: url) {
                if let image = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        self?.setImage(image, for: .normal)
                        self?.imageView?.contentMode = .scaleAspectFill
                        self?.imageView?.clipsToBounds = true
                    }
                }else{
                    let image = UIImage.init(icon: .fontAwesomeSolid(.image), size: CGSize(width: 40, height: 40))
                    DispatchQueue.main.async {
                        self?.setImage(image, for: .normal)
                    }
                }
            }else{
                let image = UIImage.init(icon: .fontAwesomeSolid(.image), size: CGSize(width: 40, height: 40))
                DispatchQueue.main.async {
                    self?.setImage(image, for: .normal)
                }
            }
        }
         */
    }
    
    func centerVertically(padding: CGFloat = 6.0) {
        guard
            let imageViewSize = self.imageView?.frame.size,
            let titleLabelSize = self.titleLabel?.frame.size else {
            return
        }
        
        let totalHeight = imageViewSize.height + titleLabelSize.height + padding
        
        self.imageEdgeInsets = UIEdgeInsets(
            top: max(0, -(totalHeight - imageViewSize.height)),
            left: 0.0,
            bottom: 0.0,
            right: -titleLabelSize.width
        )
        
        self.titleEdgeInsets = UIEdgeInsets(
            top: 0.0,
            left: -imageViewSize.width,
            bottom: -(totalHeight - titleLabelSize.height),
            right: 0.0
        )
        
        self.contentEdgeInsets = UIEdgeInsets(
            top: 0.0,
            left: 0.0,
            bottom: titleLabelSize.height,
            right: 0.0
        )
    }
    
    
}
