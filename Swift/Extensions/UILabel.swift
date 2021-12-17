//
//  UILabel.swift
//
//  Created by Adil Umer on 16.12.2020.
//  Copyright © 2020. All rights reserved.
//

import UIKit

extension UILabel{
    
    func drawOutlineAroundText(stroke: UIColor, fill: UIColor, content: String = "", size: CGFloat = -1, shadow: UIColor? = nil){
        
        let sizeToSet = size == -1 ? self.font.pointSize : size
        let textToSet = content == "" ? (self.text ?? "") : content
        var strokeTextAttributes = [
            NSAttributedString.Key.strokeColor : stroke,
            NSAttributedString.Key.foregroundColor : fill,
            NSAttributedString.Key.strokeWidth : -1,
            NSAttributedString.Key.font : self.font.withSize(sizeToSet)
        ] as [NSAttributedString.Key : Any]
        if shadow != nil{
            let shadeBelow = NSShadow()
            shadeBelow.shadowBlurRadius = 5
            shadeBelow.shadowColor = shadow
            shadeBelow.shadowOffset = CGSize(width: 0, height: 0)
            strokeTextAttributes[NSAttributedString.Key.shadow] = shadeBelow
        }
        self.attributedText = NSMutableAttributedString(string: textToSet, attributes: strokeTextAttributes)
    }
    
    /// Strikes through diagonally
    /// - Parameters:
    /// - offsetPercent: Improve visual appearance or flip line completely by passing a value between 0 and 1
    func diagonalStrikeThrough(lColor: CGColor, offsetPercent: CGFloat = 0.1) -> CALayer{
        let linePath = UIBezierPath()
        linePath.move(to: CGPoint(x: 0, y: bounds.height * (1 - offsetPercent)))
        linePath.addLine(to: CGPoint(x: bounds.width, y: bounds.height * offsetPercent))

        let lineLayer = CAShapeLayer()
        lineLayer.path = linePath.cgPath
        lineLayer.lineWidth = 2
        lineLayer.strokeColor = lColor
        layer.addSublayer(lineLayer)
        return lineLayer
    }
    
    func removeSublayer(_ layr: CALayer){
        for anyLayr in layer.sublayers ?? []{
            if anyLayr == layr{
                layr.removeFromSuperlayer()
                break
            }
        }
    }
}
