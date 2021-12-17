//
//  UIImageView.swift
//
//  Created by Adil Umer on 9.09.2020.
//  Copyright © 2020. All rights reserved.
//

import UIKit
import SwiftIcons
import Kingfisher

extension UIImageView {
    
    func loadImg(withUrl url: URL) {
        self.kf.setImage(with: url, placeholder: placeholder)
        
        /*
         DispatchQueue.global().async { [weak self] in
            if let imageData = try? Data(contentsOf: url) {
                if let image = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }else{
                DispatchQueue.main.async {
                    self?.image =  UIImage(named: "introhead")!
                    
                }
            }
        }
         */
    }
    
    static func loadGif(frame: CGRect, resourceName: String) -> UIImageView? {
        guard let path = Bundle.main.path(forResource: resourceName, ofType: "gif") else {
            print("Gif does not exist at that path")
            return nil
        }
        let url = URL(fileURLWithPath: path)
        guard let gifData = try? Data(contentsOf: url),
              let source =  CGImageSourceCreateWithData(gifData as CFData, nil) else { return nil }
        var images = [UIImage]()
        let imageCount = CGImageSourceGetCount(source)
        for i in 0..< imageCount {
            if let image = CGImageSourceCreateImageAtIndex(source, i, nil) {
                images.append(UIImage(cgImage: image))
            }
        }
        let gifImageView = UIImageView(frame: frame)
        gifImageView.animationImages = images
        return gifImageView
    }
    
    
    
}
