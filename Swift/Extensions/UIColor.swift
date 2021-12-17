//
//  UIColor.swift
//
//  Created by Adil Umer on 8.09.2020.
//  Copyright © 2020. All rights reserved.
//

import UIKit

extension UIColor {
    
    // HEX TO UI COLOR
    // let gold = UIColor(hex: "#ffe700ff")
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            var hexColor = String(hex[start...])
            
            if hexColor.count == 6 {
                hexColor += "ff"
            }
            
            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        
        return nil
    }
    
    public convenience init(_ rgb: [Int], alpha: Int = 100) {
        let r = CGFloat(rgb[0]/255)
        let g = CGFloat(rgb[1]/255)
        let b = CGFloat(rgb[2]/255)
        let a = CGFloat(alpha/100)
        self.init(red: r, green: g, blue: b, alpha: a)
        return
    }
    
}
