//
//  UIView.swift
//
//  Created by Adil Umer on 8.09.2020.
//  Copyright © 2020. All rights reserved.
//

import UIKit

typealias GradientPoints = (startPoint: CGPoint, endPoint: CGPoint)

enum GradientOrientation {
    case topRightBottomLeft
    case topLeftBottomRight
    case horizontal
    case vertical
    
    var startPoint: CGPoint {
        return points.startPoint
    }
    
    var endPoint: CGPoint {
        return points.endPoint
    }
    
    var points: GradientPoints {
        switch self {
        case .topRightBottomLeft:
            return (CGPoint(x: 0.0, y: 1.0), CGPoint(x: 1.0, y: 0.0))
        case .topLeftBottomRight:
            return (CGPoint(x: 0.0, y: 0.0), CGPoint(x: 1, y: 1))
        case .horizontal:
            return (CGPoint(x: 0.0, y: 0.5), CGPoint(x: 1.0, y: 0.5))
        case .vertical:
            return (CGPoint(x: 0.0, y: 0.0), CGPoint(x: 0.0, y: 1.0))
        }
    }
}

enum BorderPos{
    case TopBorder
    case BottomBorder
}

extension UIView {
    // ADD TOP OR BOTTOM BORDER
    func addLine(position : BorderPos, color: UIColor, width: Double) {
        let lineView = UIView()
        lineView.backgroundColor = color
        lineView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(lineView)
        
        let metrics = ["width" : NSNumber(value: width)]
        let views = ["lineView" : lineView]
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[lineView]|", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:metrics, views:views))
        
        switch position {
        case .TopBorder:
            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[lineView(width)]", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:metrics, views:views))
            break
        case .BottomBorder:
            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[lineView(width)]|", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:metrics, views:views))
            break
        }
        
        
        var top : CGFloat{
            get{
                return self.frame.origin.y
            }
            set{
                var frame       = self.frame
                frame.origin.y  = newValue
                self.frame      = frame
            }
        }
        
        var bottom : CGFloat{
            get{
                return frame.origin.y + frame.size.height
            }
            set{
                var frame       = self.frame
                frame.origin.y  = newValue - self.frame.size.height
                self.frame      = frame
            }
        }
        
        var right : CGFloat{
            get{
                return self.frame.origin.x + self.frame.size.width
            }
            set{
                var frame       = self.frame
                frame.origin.x  = newValue - self.frame.size.width
                self.frame      = frame
            }
        }
        
        var left : CGFloat{
            get{
                return self.frame.origin.x
            }
            set{
                var frame       = self.frame
                frame.origin.x  = newValue
                self.frame      = frame
            }
        }
    }
    
    func makeRounded(borderW: CGFloat = 0, color: UIColor = .black) {
        self.layer.borderWidth = borderW
        self.layer.masksToBounds = false
        self.layer.borderColor = color.cgColor
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
    
    func addShadow(opacity: Float, offset: CGSize, radius: CGFloat, color: UIColor = .black){
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = radius
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: 10).cgPath

        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
    
    // SHADOW OUTPUT 1
    func dropShadow(drop: CGFloat = 4, radius: CGFloat = 4, margins: CGFloat = 0) {
        var relativeBounds = self.bounds
        relativeBounds.size.width = self.bounds.width.relativeToIphone8Width(margins: margins)
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: drop)
        self.layer.shadowRadius = radius
        self.layer.shadowPath = UIBezierPath(roundedRect: relativeBounds, cornerRadius: self.layer.cornerRadius).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }

    // SHADOW OUTPUT 2
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true, margins: CGFloat = 0) {
        var relativeBounds = self.bounds
        relativeBounds.size.width = self.bounds.width.relativeToIphone8Width(margins: margins)
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offSet
        self.layer.shadowRadius = radius

        self.layer.shadowPath = UIBezierPath(rect: relativeBounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    func applyGradient(withColours colours: [UIColor], locations: [NSNumber]? = nil) {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        self.layer.insertSublayer(gradient, at: 0)
        self.layer.setNeedsDisplay()
    }
    
    func applyGradient(withColours colours: [UIColor], gradientOrientation orientation: GradientOrientation) {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.startPoint = orientation.startPoint
        gradient.endPoint = orientation.endPoint
        self.layer.insertSublayer(gradient, at: 0)
        self.layer.setNeedsDisplay()
    }
    
    func addFadeLayers(fadePercentage: Double = 0.05){
        let transparent = UIColor.clear.cgColor
        let opaque = UIColor.black.cgColor

        let maskLayer = CALayer()
        maskLayer.frame = self.bounds

        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: self.bounds.origin.x, y: 0, width: self.bounds.size.width, height: self.bounds.size.height)
        gradientLayer.colors = [transparent, opaque, opaque, transparent]
        gradientLayer.locations = [0, NSNumber(floatLiteral: fadePercentage), NSNumber(floatLiteral: 1 - fadePercentage), 1]

        maskLayer.addSublayer(gradientLayer)
        self.layer.mask = maskLayer
    }
    
    func addBlurEffect(){
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurEffectView)
    }
}
